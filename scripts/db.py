import os
import ssl
import tempfile
from pathlib import Path as _Path

from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

# NOTE:
# - Streamlit Cloud: use st.secrets["connections"]["mysql"] (TiDB Cloud/MySQL) + TLS CA
# - Local: use .env (DB_HOST/DB_PORT/DB_NAME/DB_USER/DB_PASSWORD) and DO NOT enable TLS unless DB_SSL=1

# 로컬 개발에서는 .env 사용 가능 (Streamlit Cloud에는 보통 .env 없음)
load_dotenv(override=False)


def _write_ca_pem_to_tmp(pem: str) -> str:
    """Secrets에 넣은 PEM 문자열을 임시 파일로 저장하고 경로 반환"""
    tmp_dir = _Path(tempfile.gettempdir())
    ca_file = tmp_dir / "tidb_ca.pem"
    ca_file.write_text(pem.strip(), encoding="utf-8")
    return str(ca_file)


def _try_read_streamlit_mysql_secrets() -> dict | None:
    """Streamlit Cloud(또는 local streamlit)에서 secrets에 설정된 MySQL/TiDB 연결정보 읽기"""
    try:
        import streamlit as st  # type: ignore
    except Exception:
        return None

    try:
        # 가장 표준: [connections.mysql]
        conns = st.secrets.get("connections", None)
        if conns and "mysql" in conns:
            cfg = conns["mysql"]
            # cfg는 streamlit의 Secrets 객체일 수 있어 dict로 캐스팅
            try:
                cfg = dict(cfg)
            except Exception:
                pass
            return cfg

        # 혹시 flat 형태로 저장된 경우(드묾)
        if "connections.mysql" in st.secrets:
            cfg = st.secrets["connections.mysql"]
            try:
                cfg = dict(cfg)
            except Exception:
                pass
            return cfg

        return None
    except Exception:
        return None


def get_engine():
    """SQLAlchemy Engine 생성.
    우선순위:
      1) Streamlit Secrets의 connections.mysql (서버/클라우드)
      2) 로컬 .env (DB_*)
    """

    # 1) Streamlit secrets 우선 (있으면 무조건 이걸 사용)
    cfg = _try_read_streamlit_mysql_secrets()
    if cfg:
        host = cfg.get("host")
        port = int(cfg.get("port", 4000))
        db = cfg.get("database", "perfdb")
        user = cfg.get("username")
        pwd = cfg.get("password")

        if not host or not user or not pwd:
            raise RuntimeError("Streamlit Secrets의 [connections.mysql]에 host/username/password 값이 비어있습니다.")

        # TiDB Cloud는 TLS가 필요한 경우가 많음
        ca_path = None
        pem = cfg.get("ssl_ca_pem")
        if pem and str(pem).strip():
            ca_path = _write_ca_pem_to_tmp(str(pem))
        else:
            # 경로로 주는 케이스도 지원
            ca = cfg.get("ssl_ca")
            if ca and str(ca).strip():
                ca_path = str(ca).strip()

        connect_args = {}
        if ca_path:
            connect_args = {
                "ssl": {
                    "ca": ca_path,
                    "cert_reqs": ssl.CERT_REQUIRED,
                    "check_hostname": True,
                }
            }

        url = URL.create(
            drivername="mysql+pymysql",
            username=user,
            password=pwd,
            host=host,
            port=port,
            database=db,
            query={"charset": "utf8mb4"},
        )

        return create_engine(
            url,
            pool_pre_ping=True,
            pool_recycle=1800,
            pool_size=5,
            max_overflow=10,
            connect_args=connect_args,
        )

    # 2) 로컬 .env
    host = os.getenv("DB_HOST", "localhost")
    port = int(os.getenv("DB_PORT", "3306"))
    db = os.getenv("DB_NAME", "perfdb")
    user = os.getenv("DB_USER", "root")
    pwd = os.getenv("DB_PASSWORD", "")

    # 로컬은 기본적으로 SSL 사용 안 함 (원하면 DB_SSL=1로 켜고 CA를 지정)
    use_ssl = os.getenv("DB_SSL", "0").strip() in ("1", "true", "True", "YES", "yes")
    ssl_ca = os.getenv("DB_SSL_CA", "").strip()

    connect_args = {}
    if use_ssl:
        ssl_kwargs = {}
        if ssl_ca:
            ssl_kwargs["ca"] = ssl_ca
            ssl_kwargs["cert_reqs"] = ssl.CERT_REQUIRED
            ssl_kwargs["check_hostname"] = False  # 로컬은 호스트네임 검증이 불필요한 경우가 많음
        else:
            # CA 없이 SSL만 강제하면 인증서 검증 실패 가능성이 큼.
            # 정말 필요한 경우에만 쓰세요.
            ssl_kwargs["cert_reqs"] = ssl.CERT_NONE
        connect_args = {"ssl": ssl_kwargs}

    url = URL.create(
        drivername="mysql+pymysql",
        username=user,
        password=pwd,
        host=host,
        port=port,
        database=db,
        query={"charset": "utf8mb4"},
    )

    return create_engine(url, pool_pre_ping=True, connect_args=connect_args)
