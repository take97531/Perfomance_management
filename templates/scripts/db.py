import os
from dotenv import load_dotenv
from sqlalchemy import create_engine

# 로컬 개발에서는 .env 사용 가능
load_dotenv()

def _read_mysql_secrets():
    """Streamlit Community Cloud에서는 Secrets(TOML)를 통해 DB 설정을 주입합니다."""
    import streamlit as st  # type: ignore

    # 1) 권장 형태: [connections.mysql]
    conn = st.secrets.get("connections", {})
    if isinstance(conn, dict) and "mysql" in conn:
        return conn["mysql"]

    # 2) 혹시 [mysql]로 넣은 경우도 지원
    if "mysql" in st.secrets:
        return st.secrets["mysql"]

    return None

def get_engine():
    """엔진 생성.
    - Streamlit Cloud: Secrets 필수 (없으면 즉시 에러)
    - 로컬: .env/환경변수 사용
    """
    # Streamlit 런타임 여부 확인
    in_streamlit = os.getenv("STREAMLIT_RUNTIME") == "1"
    try:
        import streamlit as st  # type: ignore
        # streamlit 모듈이 import되면 런타임으로 간주
        in_streamlit = True
    except Exception:
        pass

    if in_streamlit:
        import streamlit as st  # type: ignore
        cfg = _read_mysql_secrets()
        if cfg is None:
            raise RuntimeError(
                "Streamlit Secrets에서 MySQL 설정을 찾지 못했습니다. "
                "Settings → Secrets에 [connections.mysql] 섹션을 추가하세요."
            )

        host = cfg.get("host")
        port = str(cfg.get("port", 4000))
        name = cfg.get("database", "perfdb")
        user = cfg.get("username")
        pwd  = cfg.get("password")
        ssl_ca = cfg.get("ssl_ca", None)

        if not host or not user or not pwd:
            raise RuntimeError("Secrets에 host/username/password 값이 비어있습니다.")

        # TiDB Serverless는 TLS가 필요할 수 있음
        connect_args = {"ssl": {}}
        if ssl_ca:
            connect_args["ssl"] = {"ca": ssl_ca}

        # 디버그: 실제 타겟을 확인 (비밀번호는 출력하지 않음)
        st.write(f"DEBUG DB target: {host}:{port}/{name} (user={user})")

        url = f"mysql+pymysql://{user}:{pwd}@{host}:{port}/{name}?charset=utf8mb4"
        return create_engine(url, pool_pre_ping=True, connect_args=connect_args)

    # 로컬 실행(.env)
    host = os.getenv("DB_HOST", "localhost")
    port = os.getenv("DB_PORT", "3306")
    name = os.getenv("DB_NAME", "perfdb")
    user = os.getenv("DB_USER", "root")
    pwd  = os.getenv("DB_PASSWORD", "")
    ssl_ca = os.getenv("DB_SSL_CA", None)

    connect_args = {}
    if ssl_ca:
        connect_args["ssl"] = {"ca": ssl_ca}

    url = f"mysql+pymysql://{user}:{pwd}@{host}:{port}/{name}?charset=utf8mb4"
    return create_engine(url, pool_pre_ping=True, connect_args=connect_args)
