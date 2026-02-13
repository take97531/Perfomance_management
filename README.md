# Team Performance Dashboard (MySQL + Python/Streamlit)
팀 단위 성과를 주차 기준으로 관리하고 시각화하는 간단한 성과관리 시스템입니다.  
19명, 7개 파트를 기준으로 설계되었습니다.

---

## 시스템 개요
다음 성과 지표를 관리합니다.

### 파트 단위 지표 (주간)
- 파트 매출
- 파트 영업이익

### 개인 단위 지표 (주간)
- 주간보고 작성 여부
- GDC 사용 여부 및 MM
- AI 사용 여부

---

## 기술 스택
- **DB**: MySQL
- **백엔드/대시보드**: Python + Streamlit
- **시각화**: Plotly
- **DB 연결**: SQLAlchemy + PyMySQL

---

## 프로젝트 구조
```
perf_dashboard/
│
├─ app.py                  # Streamlit 대시보드 메인
├─ schema.sql              # DB 테이블 생성 스크립트
├─ sample_data.sql         # 샘플 데이터(테스트용)
├─ requirements.txt        # 파이썬 패키지 목록
├─ README.md
├─ .env.example            # DB 환경변수 예시
│
├─ templates/
│   ├─ part_kpi_weekly.csv
│   └─ member_kpi_weekly.csv
│
└─ scripts/
    ├─ db.py
    └─ import_csv.py       # CSV → DB 업로드 스크립트
```

---

## 빠른 실행 방법

### 1) DB 생성 및 테이블 생성
MySQL에서 실행:

```bash
mysql -u <user> -p < schema.sql
```

---

### 2) (선택) 샘플 데이터 적재
테스트용 데이터 삽입:

```bash
mysql -u <user> -p < sample_data.sql
```

---

### 3) 환경 변수 설정
환경 변수 설정(권장):

#### Linux / Mac
```bash
export DB_HOST=localhost
export DB_PORT=3306
export DB_NAME=perfdb
export DB_USER=root
export DB_PASSWORD=yourpassword
```

#### Windows (PowerShell)
```powershell
$env:DB_HOST="localhost"
$env:DB_PORT="3306"
$env:DB_NAME="perfdb"
$env:DB_USER="root"
$env:DB_PASSWORD="yourpassword"
```

또는 `.env.example`을 복사해서 `.env` 파일로 사용 가능

---

### 4) 파이썬 환경 구성 및 실행
```bash
python -m venv .venv

# Linux / Mac
source .venv/bin/activate

# Windows
.venv\Scripts\activate

pip install -r requirements.txt
streamlit run app.py
```

브라우저에서 자동으로 대시보드가 열립니다.

---

## CSV 업로드 기능 (선택)
주간 성과를 CSV로 입력 후 DB에 반영할 수 있습니다.

### 템플릿 파일
- `templates/part_kpi_weekly.csv`
- `templates/member_kpi_weekly.csv`

---

### 업로드 실행
```bash
python scripts/import_csv.py   --year 2026   --week 7   --part templates/part_kpi_weekly.csv   --member templates/member_kpi_weekly.csv
```

---

## 데이터 기준
- 주차 기준: **ISO 주차 (year + week)**
- 매출/영업이익 단위: **원 단위 정수**
- GDC MM: 소수점 가능 (예: 12.50 MM)

---

## 주요 화면 구성
### 1) 파트 요약
- 총 매출, 총 이익, 이익률
- 주간보고 완료율
- GDC 총 MM
- AI 사용률
- 파트별 매출/이익 그래프

### 2) 개인 요약
- 개인별 주간 KPI 테이블
- 파트별 GDC MM 분포
- 파트별 AI 사용률

### 3) 추이/히트맵
- 주차별 주간보고 완료율 히트맵
- 주차별 AI 사용률 추이
- 주차별 GDC 총 MM 추이

---

## 참고 사항
- 팀 내부 간이 성과관리용으로 설계된 MVP 버전입니다.
- 추후 아래 기능 확장 가능:
  - 로그인/권한 관리
  - 팀원 직접 입력 화면
  - 자동 데이터 연동(Git, Jira 등)
  - 월간/분기 리포트 자동 생성
