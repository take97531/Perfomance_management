import os
import time
from pathlib import Path
from dotenv import load_dotenv, find_dotenv
from sqlalchemy import create_engine

# ---------------------------------------------------------------------
# Local(.env) vs Streamlit Cloud(Secrets) 를 "완전히 분리"해서 동작하도록 구성
#
# 원칙
# - Streamlit Secrets에 connections.mysql 가 있으면 => 그 값만 사용 (TiDB Cloud/TLS)
# - Secrets가 없으면 => .env / 환경변수만 사용 (로컬 MySQL)
# - Streamlit Cloud에서 Secrets를 안 넣은 상태로 배포되면, localhost 기본값으로
#   접속을 시도하지 않고 즉시 친절한 에러를 발생시킴 (로그에서 원인 파악 가능)
# ---------------------------------------------------------------------

def _load_local_env() -> None:
    """프로젝트 루트의 .env를 확실히 로드 (작업 디렉토리와 무관하게)."""
    try:
        env_path = find_dotenv(usecwd=True)  # 실행 위치 기준 탐색
    except Exception:
        env_path = ""
    if not env_path:
        # db.py 기준으로 상위에서 .env 탐색
        here = Path(__file__).resolve()
        for p in [here.parent, here.parent.parent, here.parent.parent.parent]:
            cand = p / ".env"
            if cand.exists():
                env_path = str(cand)
                break
    if env_path:
        load_dotenv(env_path, override=False)
    else:
        # 그래도 못 찾으면 기본 load_dotenv (현재 cwd)
        load_dotenv(override=False)

_load_local_env()


def _as_dict(obj):
    if obj is None:
        return None
    if isinstance(obj, dict):
        return obj
    try:
        return dict(obj)
    except Exception:
        pass
    try:
        keys = getattr(obj, "keys", None)
        get = getattr(obj, "get", None)
        if callable(keys) and callable(get):
            return {k: get(k) for k in keys()}
    except Exception:
        pass
    return None


def _read_mysql_cfg_from_secrets():
    """Streamlit Secrets에서 connections.mysql 를 최대한 안정적으로 읽는다."""
    import streamlit as st  # type: ignore

    top = _as_dict(st.secrets)
    if not top:
        return None

    conns = st.secrets.get("connections", None)
    conns_d = _as_dict(conns)
    if conns_d and "mysql" in conns_d:
        return _as_dict(conns_d.get("mysql"))

    # 일부 케이스 방어: flat key
    if "connections.mysql" in top:
        return _as_dict(top.get("connections.mysql"))

    return None


def _write_ca_pem_to_tmp(pem: str) -> str:
    import tempfile
    tmp = Path(tempfile.gettempdir()) / "tidb_ca.pem"
    tmp.write_text(pem.strip(), encoding="utf-8")
    return str(tmp)


def _cloud_engine_from_secrets():
    """TiDB Cloud(또는 Cloud MySQL)용: Secrets 기반 + TLS."""
    import streamlit as st  # type: ignore

    cfg = None
    for _ in range(5):  # secrets 로딩 타이밍 이슈 방어
        cfg = _read_mysql_cfg_from_secrets()
        if cfg:
            break
        time.sleep(0.6)

    if not cfg:
        raise RuntimeError(
            "Streamlit Secrets에 DB 설정이 없습니다.\n"
            "Settings → Secrets 에 아래처럼 [connections.mysql] 를 반드시 추가하세요.\n\n"
            "[connections]\n"
            "[connections.mysql]\n"
            "host = \"...\"\n"
            "port = 4000\n"
            "database = \"perfdb\"\n"
            "username = \"...\"\n"
            "password = \"...\"\n"
            "ssl_ca_pem = \"\"\"-----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----\"\"\"\n"
        )

    host = cfg.get("host")
    port = int(cfg.get("port", 4000))
    name = cfg.get("database", cfg.get("name", "perfdb"))
    user = cfg.get("username", cfg.get("user"))
    pwd = cfg.get("password", cfg.get("pwd"))

    if not host or not user or not pwd:
        raise RuntimeError("Secrets의 host/username/password 값이 비어있습니다.")

    # TLS CA
    ca_path = None
    if cfg.get("ssl_ca_pem"):
        ca_path = _write_ca_pem_to_tmp(str(cfg.get("ssl_ca_pem")))
    elif cfg.get("ssl_ca"):
        ca_path = str(cfg.get("ssl_ca"))

    url = f"mysql+pymysql://{user}:{pwd}@{host}:{port}/{name}?charset=utf8mb4"
    connect_args = {"ssl": {"ca": ca_path}} if ca_path else {}

    # (중요) Cloud에서는 기본값 localhost로 떨어지면 안됨 → 여기서만 엔진 생성
    return create_engine(
        url,
        pool_pre_ping=True,
        pool_recycle=1800,
        pool_size=5,
        max_overflow=10,
        connect_args=connect_args,
    )


def _local_engine_from_env():
    """로컬 MySQL용: .env / 환경변수 기반. 기본은 SSL 사용 안 함."""
    host = os.getenv("DB_HOST", "").strip()
    port = os.getenv("DB_PORT", "").strip()
    name = os.getenv("DB_NAME", "").strip()
    user = os.getenv("DB_USER", "").strip()
    pwd = os.getenv("DB_PASSWORD", "")

    # 로컬은 "기본값 localhost"를 허용하되, 포트/DB/유저는 .env가 없으면 빈 값일 수 있어
    if not host:
        host = "localhost"
    if not port:
        port = "3306"
    if not name:
        name = "perfdb"
    if not user:
        user = "root"

    # 로컬 SSL 옵션 (기본 OFF)
    # DB_SSL=1 이고, DB_SSL_CA(=CA 파일 경로) 또는 DB_SSL_CA_PEM(문자열) 있을 때만 ssl 적용
    db_ssl = os.getenv("DB_SSL", "0").strip() == "1"
    ca_path = os.getenv("DB_SSL_CA", "").strip() or None
    ca_pem = os.getenv("DB_SSL_CA_PEM", "").strip() or None
    if db_ssl and not ca_path and ca_pem:
        ca_path = _write_ca_pem_to_tmp(ca_pem)

    url = f"mysql+pymysql://{user}:{pwd}@{host}:{int(port)}/{name}?charset=utf8mb4"
    connect_args = {"ssl": {"ca": ca_path}} if (db_ssl and ca_path) else {}

    return create_engine(
        url,
        pool_pre_ping=True,
        pool_recycle=1800,
        pool_size=5,
        max_overflow=10,
        connect_args=connect_args,
    )


def get_engine():
    """
    엔진 선택 규칙
    1) Streamlit Secrets에 connections.mysql 가 존재하면 => Cloud 엔진(Secrets/TLS) 사용
    2) 아니면 => Local 엔진(.env) 사용
       단, Streamlit Cloud에서 Secrets가 비어 있고, DB_HOST 같은 환경변수도 없으면
       localhost로 접속 시도하지 않고 에러로 멈춤 (원인 파악 용이)
    """
    try:
        import streamlit as st  # type: ignore
        secrets_top = _as_dict(st.secrets) or {}
        cfg = _read_mysql_cfg_from_secrets()
        if cfg:
            return _cloud_engine_from_secrets()

        # Streamlit 런타임인데 secrets가 비어있고, env에도 명시가 없으면 → 에러
        # (Cloud에서 localhost로 붙는 실수를 방지)
        if len(secrets_top) == 0:
            if not os.getenv("DB_HOST"):
                raise RuntimeError(
                    "Streamlit 환경에서 Secrets가 비어있습니다.\n"
                    "Cloud 배포라면 Settings → Secrets에 [connections.mysql] 를 넣어주세요.\n"
                    "로컬 실행이라면 프로젝트 루트에 .env(DB_HOST 등)가 있는지 확인하세요."
                )

        return _local_engine_from_env()

    except Exception:
        # streamlit import 자체가 안 되면 로컬
        return _local_engine_from_env()
