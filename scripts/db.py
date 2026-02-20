import os
import time
from pathlib import Path

from dotenv import load_dotenv, find_dotenv
from sqlalchemy import create_engine

# --- .env 로딩(로컬용) ---
# Streamlit로 실행하면 작업 디렉토리가 달라져 .env를 못 읽는 경우가 많아서,
# find_dotenv로 상위 경로까지 탐색해서 로드합니다.
_DOTENV_FOUND = False
try:
    env_path = find_dotenv(usecwd=True)
    if env_path:
        load_dotenv(env_path, override=False)
        _DOTENV_FOUND = True
    else:
        # 그래도 못 찾으면 현재 파일 기준으로 한 번 더 시도
        here = Path(__file__).resolve()
        candidate = here.parents[1] / ".env"  # scripts/db.py 기준 프로젝트 루트
        if candidate.exists():
            load_dotenv(str(candidate), override=False)
            _DOTENV_FOUND = True
except Exception:
    pass


def _as_dict(obj):
    """Streamlit Secrets의 중첩 객체가 dict가 아닐 때 최대한 dict로 변환."""
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
    """가능한 모든 패턴으로 Streamlit Secrets에서 MySQL 설정을 찾는다."""
    import streamlit as st  # type: ignore

    top = _as_dict(st.secrets)
    if top and "mysql" in top:
        return _as_dict(top.get("mysql"))

    conns = st.secrets.get("connections", None)
    conns_d = _as_dict(conns)

    if conns_d:
        if "mysql" in conns_d:
            return _as_dict(conns_d.get("mysql"))
        if all(k in conns_d for k in ("host", "username", "password")):
            return conns_d

    flat = _as_dict(st.secrets)
    if flat and "connections.mysql" in flat:
        return _as_dict(flat.get("connections.mysql"))

    return None


def _ca_path_from_cfg(cfg: dict) -> str | None:
    """ssl_ca_pem(PEM 문자열) 또는 ssl_ca(경로) 또는 certifi 번들을 사용."""
    import tempfile

    ssl_ca = cfg.get("ssl_ca")
    if ssl_ca and str(ssl_ca).strip():
        return str(ssl_ca).strip()

    pem = cfg.get("ssl_ca_pem")
    if pem and str(pem).strip():
        ca_file = Path(tempfile.gettempdir()) / "tidb_ca.pem"
        ca_file.write_text(str(pem).strip(), encoding="utf-8")
        return str(ca_file)

    # ⚠️ TiDB Cloud는 보통 공개 CA를 쓰지만, 로컬 MySQL은 self-signed인 경우가 많습니다.
    # certifi를 기본값으로 반환하면 "self-signed certificate" 검증 실패를 유발할 수 있어
    # 여기서는 secrets에 CA가 명시된 경우에만 CA를 사용하도록 합니다.
    return None


def _bool_env(name: str, default: bool = False) -> bool:
    v = os.getenv(name)
    if v is None:
        return default
    return str(v).strip().lower() in ("1", "true", "yes", "y", "on")


def _should_prefer_env_over_secrets() -> bool:
    """로컬 실행일 때(= .env를 찾았을 때) Streamlit secrets보다 env를 우선한다.

    로컬에서 `streamlit run`을 하면 st.secrets가 로컬의 `.streamlit/secrets.toml`을 읽는데,
    여기에 TiDB 설정이 남아 있으면 로컬에서도 '서버 분기'를 타서 TLS 검증 오류가 납니다.

    - 기본: .env를 찾으면(env가 로드되면) env 우선
    - 예외: USE_STREAMLIT_SECRETS=1 로 강제로 secrets 우선
    """
    if _bool_env("USE_STREAMLIT_SECRETS", default=False):
        return False
    return _DOTENV_FOUND


def get_engine():
    """DB 엔진 생성: Streamlit Cloud에서는 Secrets 우선, 로컬에서는 env(.env) 우선."""

    # 0) 로컬이면 env(.env) 우선
    if _should_prefer_env_over_secrets():
        return _get_local_engine_from_env()

    # 1) Streamlit 환경이면 secrets에서 먼저 읽어본다
    cfg = None
    try:
        import streamlit as st  # type: ignore

        for _ in range(5):
            cfg = _read_mysql_cfg_from_secrets()
            if cfg:
                break
            time.sleep(0.8)
    except Exception:
        cfg = None

    # 2) secrets에 mysql 설정이 있을 때만 "서버(TiDB)" 분기를 탄다
    if cfg:
        host = cfg.get("host")
        port = int(cfg.get("port", 4000))
        name = cfg.get("database", cfg.get("name", "perfdb"))
        user = cfg.get("username", cfg.get("user"))
        pwd = cfg.get("password", cfg.get("pwd"))

        if not host or not user or not pwd:
            raise RuntimeError("Secrets에 host/username/password 값이 비어있습니다.")

        ca_path = _ca_path_from_cfg(cfg)

        # PyMySQL + TLS (TiDB Cloud)
        url = f"mysql+pymysql://{user}:{pwd}@{host}:{port}/{name}?charset=utf8mb4"
        connect_args = {"ssl": {"ca": ca_path}} if ca_path else {}

        return create_engine(
            url,
            pool_pre_ping=True,
            pool_recycle=1800,
            pool_size=5,
            max_overflow=10,
            connect_args=connect_args,
        )

    # 3) secrets가 없으면 로컬(env)로
    return _get_local_engine_from_env()


def _get_local_engine_from_env():
    host = os.getenv("DB_HOST", "localhost")
    port = int(os.getenv("DB_PORT", "3306"))
    name = os.getenv("DB_NAME", "perfdb")
    user = os.getenv("DB_USER", "root")
    pwd = os.getenv("DB_PASSWORD", "")

    # 로컬에서 SSL을 강제하지 않겠다는 의미: DB_SSL=0 이면 TLS 자체를 꺼버림
    use_ssl = _bool_env("DB_SSL", default=False)

    # MySQL 8 로컬은 mysql-connector-python이 가장 안정적
    url = f"mysql+pymysql://{user}:{pwd}@{host}:{port}/{name}?charset=utf8mb4"

    connect_args = {}
    if not use_ssl:
        # 로컬 MySQL에서 self-signed cert가 켜져 있어도, 여기서 SSL을 꺼서 오류를 방지
        connect_args["ssl_disabled"] = True
    else:
        ca = os.getenv("DB_SSL_CA", "").strip() or None
        if ca:
            connect_args["ssl_ca"] = ca

    connect_args = {"ssl_disabled": True}
    return create_engine(url, pool_pre_ping=True, connect_args=connect_args)
