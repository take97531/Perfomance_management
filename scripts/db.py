import os
from dotenv import load_dotenv
from sqlalchemy import create_engine

# 로컬 개발에서는 .env 사용 가능
load_dotenv()

def _get_from_streamlit_secrets():
    """Streamlit Community Cloud에서는 st.secrets로 DB 설정을 주입합니다."""
    try:
        import streamlit as st  # type: ignore
        if "connections" in st.secrets and "mysql" in st.secrets["connections"]:
            cfg = st.secrets["connections"]["mysql"]
            return {
                "host": cfg.get("host"),
                "port": str(cfg.get("port", 4000)),
                "name": cfg.get("database", "perfdb"),
                "user": cfg.get("username"),
                "pwd": cfg.get("password"),
                "ssl_ca": cfg.get("ssl_ca", None),
            }
    except Exception:
        pass
    return None

def get_engine():
    cfg = _get_from_streamlit_secrets()
    if cfg:
        host = cfg["host"]
        port = cfg["port"]
        name = cfg["name"]
        user = cfg["user"]
        pwd  = cfg["pwd"]
        ssl_ca = cfg.get("ssl_ca")
    else:
        host = os.getenv("DB_HOST", "localhost")
        port = os.getenv("DB_PORT", "3306")
        name = os.getenv("DB_NAME", "perfdb")
        user = os.getenv("DB_USER", "root")
        pwd  = os.getenv("DB_PASSWORD", "")
        ssl_ca = os.getenv("DB_SSL_CA", None)

    # TiDB Serverless(공개 엔드포인트)는 TLS 연결이 필요할 수 있습니다.
    connect_args = {"ssl": {}}
    if ssl_ca:
        connect_args["ssl"] = {"ca": ssl_ca}

    url = f"mysql+pymysql://{user}:{pwd}@{host}:{port}/{name}?charset=utf8mb4"
    return create_engine(url, pool_pre_ping=True, connect_args=connect_args)
