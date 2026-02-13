# 팀 성과관리 대시보드 v2 (MySQL + Python/Streamlit)

이 프로젝트는 **파트 성과**와 **개인 성과**를 분리하여 관리하고, Streamlit 대시보드로 시각화합니다.  
**관리자(Admin)만 데이터/마스터를 수정**할 수 있도록 (옵션 A: 관리자 비밀번호 로그인) 구현되어 있습니다.

## 관리 지표(요구사항 반영)

### 파트 성과(주간, ISO week)
- **매출**: 여러 건 입력 → 화면에서는 주차/파트별 **SUM**으로 집계  
  - 입력 시 **프로젝트명 + 출처/근거 코멘트 필수**
- **영업이익**: 여러 건 입력 → 화면에서는 주차/파트별 **SUM**으로 집계  
  - 입력 시 **프로젝트명 + 출처/근거 코멘트 필수**
- **GDC 사용량(MM)**: WBS 형태로 입력/표현  
  - 화면에서 **WBS × 파트** 피벗 테이블(엑셀표 느낌)

### 개인 성과(주간, ISO week)
- **AI 사용 여부**
- **개인 준비미흡 횟수**

## 기술 스택
- DB: MySQL
- Dashboard: Streamlit
- Visualization: Plotly
- DB access: SQLAlchemy + PyMySQL

## 빠른 시작

### 1) DB 생성 및 테이블 생성
```bash
mysql -u <user> -p -e "CREATE DATABASE IF NOT EXISTS perfdb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"
mysql -u <user> -p perfdb < schema.sql
```

### 2) (선택) 샘플 데이터 적재
```bash
mysql -u <user> -p perfdb < sample_data.sql
```

### 3) 환경 변수 설정
`.env.example`을 복사해 `.env`로 만들고 값 입력(권장)

### 4) 실행
```bash
python -m venv .venv
# Windows: .venv\Scripts\activate
# Mac/Linux: source .venv/bin/activate

pip install -r requirements.txt
streamlit run app.py
```

## 관리자 권한(옵션 A)
- `.env`에 `ADMIN_PASSWORD`를 설정합니다.
- 좌측 사이드바에서 관리자 비밀번호로 로그인하면 관리자 탭이 활성화됩니다.

## 프로젝트 구조
```
perf_dashboard_v2/
├─ app.py
├─ schema.sql
├─ sample_data.sql
├─ requirements.txt
├─ .env.example
├─ CHANGELOG.md
├─ templates/
│  └─ gdc_wbs.csv
└─ scripts/
   ├─ __init__.py
   └─ db.py
```
