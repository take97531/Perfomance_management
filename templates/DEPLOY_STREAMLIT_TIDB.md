# Streamlit Community Cloud + TiDB Cloud(Serverless/Starter) 배포 가이드

## 1) TiDB Cloud
1. Starter(Serverless) 클러스터 생성
2. SQL Editor에서 DB 생성:
```sql
CREATE DATABASE IF NOT EXISTS perfdb;
```
3. 프로젝트의 `schema.sql`을 SQL Editor에 붙여넣고 실행(테이블 생성)

## 2) GitHub
- 이 폴더를 그대로 GitHub Repo에 push
- 비밀번호는 절대 repo에 올리지 마세요.

## 3) Streamlit Community Cloud
1. https://share.streamlit.io 접속 → GitHub로 로그인
2. New app → Repo/Branch 선택 → Main file: `app.py` → Deploy

## 4) Secrets 설정(가장 중요)
Streamlit 앱 → Settings → Secrets에 아래 TOML을 입력 후 Save:

```toml
[connections.mysql]
host = "gateway01.ap-northeast-1.prod.aws.tidbcloud.com"
port = 4000
database = "perfdb"
username = "YOUR_TIDB_USER"
password = "YOUR_TIDB_PASSWORD"
```

## 5) 이번 패치(v2)의 핵심
- Streamlit Cloud에서는 Secrets가 없으면 더 이상 localhost로 fallback하지 않습니다.
- Secrets를 못 읽으면 즉시 에러 메시지로 알려줍니다.
- 실제 접속 대상(host/port/db/user)을 화면에 DEBUG로 표시합니다(비밀번호 제외).
  문제 해결 후 `scripts/db.py`의 DEBUG 출력(st.write)을 지우는 것을 권장합니다.
