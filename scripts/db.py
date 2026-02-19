import os
from dotenv import load_dotenv
from sqlalchemy import create_engine

# 로컬 개발에서는 .env 사용 가능
load_dotenv()

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
    from pathlib import Path

    ssl_ca = cfg.get("ssl_ca")
    if ssl_ca and str(ssl_ca).strip():
        return str(ssl_ca).strip()

    pem = cfg.get("ssl_ca_pem")
    if pem and str(pem).strip():
        tmp_dir = Path(tempfile.gettempdir())
        ca_file = tmp_dir / "tidb_ca.pem"
        ca_file.write_text(str(pem).strip(), encoding="utf-8")
        return str(ca_file)

    try:
        import certifi  # type: ignore
        return certifi.where()
    except Exception:
        return None


def get_engine():
    """DB 엔진 생성: Streamlit Cloud에서는 Secrets 우선, 없으면 env(.env)로 fallback."""
    try:
        import streamlit as st  # type: ignore
        _ = st.secrets
        in_streamlit = True
    except Exception:
        in_streamlit = False

    if in_streamlit:
        import streamlit as st  # type: ignore

        import time

        # (중요) Streamlit Cloud에서 가끔 초기화 타이밍에 secrets가 늦게 잡힘 → 재시도
        cfg = None
        for i in range(5):  # 최대 5번
            cfg = _read_mysql_cfg_from_secrets()
            if cfg is not None:
                break
            time.sleep(0.8)

        if cfg is None:
            # 이때는 진짜로 못 읽는 상황 → 디버그 더 출력
            raise RuntimeError("Streamlit Secrets에서 MySQL 설정을 찾지 못했습니다. ...")

        host = cfg.get("host")
        port = int(cfg.get("port", 4000))
        name = cfg.get("database", cfg.get("name", "perfdb"))
        user = cfg.get("username", cfg.get("user"))
        pwd = cfg.get("password", cfg.get("pwd"))

        if not host or not user or not pwd:
            raise RuntimeError("Secrets에 host/username/password 값이 비어있습니다.")

        ca_path = _ca_path_from_cfg(cfg)

        # PyMySQL + TLS 방식 (TiDB Cloud 안정 버전)
        url = f"mysql+pymysql://{user}:{pwd}@{host}:{port}/{name}?charset=utf8mb4"

        connect_args = {}
        if ca_path:
            connect_args = {
                "ssl": {
                    "ca": ca_path
                }
            }

        return create_engine(url, pool_pre_ping=True, connect_args=connect_args)

    # 로컬(.env)
    host = os.getenv("DB_HOST", "localhost")
    port = os.getenv("DB_PORT", "3306")
    name = os.getenv("DB_NAME", "perfdb")
    user = os.getenv("DB_USER", "root")
    pwd = os.getenv("DB_PASSWORD", "")

    url = f"mysql+pymysql://{user}:{pwd}@{host}:{port}/{name}?charset=utf8mb4"
    return create_engine(url, pool_pre_ping=True)
