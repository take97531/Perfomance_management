# 팀 성과관리 대시보드 v3 (MySQL + Python/Streamlit)

요구사항 반영:
1) **주차(YYYY-Wxx) 필터 제거**: 2026년 데이터를 **누적**으로 보여줍니다.  
2) **GDC 표 변경**: 행=파트, 열=월(1~12월) 형태로 MM을 입력/조회합니다.  
3) 매출/영업이익은 화면에서 **한글 표기**로 표시합니다.  
4) GDC는 **CSV 업로드 기능 제거**했습니다.  
5) 개인성과에서 **AI**와 **준비미흡**을 분리해서 보여줍니다.

## 빠른 시작
```bash
mysql -u <user> -p -e "CREATE DATABASE IF NOT EXISTS perfdb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"
mysql -u <user> -p perfdb < schema.sql
# (선택) 샘플 데이터
mysql -u <user> -p perfdb < sample_data.sql
```

```bash
python -m venv .venv
# Windows: .venv\Scripts\activate
# Mac/Linux: source .venv/bin/activate
pip install -r requirements.txt
streamlit run app.py
```

## 관리자 로그인(옵션 A)
- `.env`에 `ADMIN_PASSWORD` 설정
- 좌측 사이드바에서 비밀번호 로그인 시 관리자 기능(파트/인원/성과 입력)이 활성화됩니다.
