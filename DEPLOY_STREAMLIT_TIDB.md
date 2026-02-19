# Streamlit Community Cloud + TiDB Cloud(Serverless/Starter) 배포 가이드

## 1) TiDB Cloud
1. Starter(Serverless) 클러스터 생성
2. SQL Editor에서 DB 생성:
```sql
CREATE DATABASE IF NOT EXISTS perfdb;
```
3. 프로젝트의 `schema.sql`을 SQL Editor에 붙여넣고 실행(테이블 생성)

## 2) GitHub
- 이 폴더를 그대로 GitHub Repo에 push (비밀번호는 절대 올리지 말 것)

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

## 5) 흔한 오류
- 로컬은 되는데 서버에서만 실패: `.env` 대신 Secrets를 써야 함 (이 패치 적용)
- TLS/SSL 에러: TiDB Serverless는 TLS가 필요할 수 있어 `connect_args={"ssl":{}}` 사용 (이 패치 적용)
