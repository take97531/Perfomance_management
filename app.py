import os
import pandas as pd
import streamlit as st
import plotly.express as px
from sqlalchemy import text
from dotenv import load_dotenv
from scripts.db import get_engine

load_dotenv()
st.set_page_config(page_title="팀 성과관리 대시보드", layout="wide")

TARGET_YEAR = int(os.getenv("TARGET_YEAR", "2026"))
ADMIN_PASSWORD = os.getenv("ADMIN_PASSWORD", "")

def is_admin() -> bool:
    return bool(st.session_state.get("is_admin", False))

def admin_login_ui():
    st.sidebar.markdown("### 관리자 로그인")
    if is_admin():
        st.sidebar.success("관리자 로그인됨")
        if st.sidebar.button("로그아웃"):
            st.session_state["is_admin"] = False
            st.rerun()
        return

    pw = st.sidebar.text_input("관리자 비밀번호", type="password")
    if st.sidebar.button("로그인"):
        if ADMIN_PASSWORD and pw == ADMIN_PASSWORD:
            st.session_state["is_admin"] = True
            st.sidebar.success("로그인 성공")
            st.rerun()
        else:
            st.sidebar.error("비밀번호가 올바르지 않습니다.")

@st.cache_data(ttl=60)
def load_parts():
    engine = get_engine()
    return pd.read_sql(text("SELECT part_id, part_name, active FROM part ORDER BY part_id"), engine)

@st.cache_data(ttl=60)
def load_members():
    engine = get_engine()
    q = """
    SELECT m.member_id, m.name, m.active, p.part_id, p.part_name
    FROM member m JOIN part p ON p.part_id=m.part_id
    ORDER BY p.part_id, m.name
    """
    return pd.read_sql(text(q), engine)

def part_filter_ui():
    parts = load_parts()
    active = parts.query("active==1")["part_name"].tolist()
    st.sidebar.markdown("### 파트 필터")
    return st.sidebar.multiselect("파트", active, default=active)

def query_finance_monthly(year:int, part_names:list[str]):
    engine = get_engine()
    q = """
    SELECT p.part_name, f.month,
           SUM(CASE WHEN f.kpi_type='REVENUE' THEN f.amount ELSE 0 END) AS revenue_sum,
           SUM(CASE WHEN f.kpi_type='OP_PROFIT' THEN f.amount ELSE 0 END) AS op_profit_sum
    FROM part_finance_entry f
    JOIN part p ON p.part_id=f.part_id
    WHERE f.year=:year AND p.part_name IN :parts
    GROUP BY p.part_name, f.month
    ORDER BY p.part_name, f.month
    """
    return pd.read_sql(text(q), engine, params={"year":year, "parts":tuple(part_names)})

def query_finance_total(year:int, part_names:list[str]):
    engine = get_engine()
    q = """
    SELECT p.part_name,
           SUM(CASE WHEN f.kpi_type='REVENUE' THEN f.amount ELSE 0 END) AS revenue_sum,
           SUM(CASE WHEN f.kpi_type='OP_PROFIT' THEN f.amount ELSE 0 END) AS op_profit_sum
    FROM part_finance_entry f
    JOIN part p ON p.part_id=f.part_id
    WHERE f.year=:year AND p.part_name IN :parts
    GROUP BY p.part_name
    ORDER BY p.part_name
    """
    return pd.read_sql(text(q), engine, params={"year":year, "parts":tuple(part_names)})

def query_finance_details(year:int, part_name:str, kpi_type:str):
    engine = get_engine()
    q = """
    SELECT f.created_at, f.month, f.amount, f.project_name, f.source_comment, f.created_by
    FROM part_finance_entry f
    JOIN part p ON p.part_id=f.part_id
    WHERE f.year=:year AND p.part_name=:part_name AND f.kpi_type=:kpi_type
    ORDER BY f.created_at DESC
    """
    return pd.read_sql(text(q), engine, params={"year":year, "part_name":part_name, "kpi_type":kpi_type})

def query_gdc_monthly(year:int, part_names:list[str]):
    engine = get_engine()
    # 모든 파트와 1-12월을 결합하여 누락된 월도 0으로 표시
    q = """
    SELECT p.part_name, m.month, COALESCE(g.mm, 0) AS mm
    FROM part p
    CROSS JOIN (SELECT 1 AS month UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
                UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 
                UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12) m
    LEFT JOIN part_gdc_monthly g ON g.part_id=p.part_id AND g.year=:year AND g.month=m.month
    WHERE p.part_name IN :parts
    ORDER BY p.part_name, m.month
    """
    return pd.read_sql(text(q), engine, params={"year":year, "parts":tuple(part_names)})

def query_member_monthly(year:int, part_names:list[str]):
    engine = get_engine()
    q = """
    SELECT p.part_name, m.name, w.month, w.ai_used, w.prep_lack_count
    FROM member_monthly_perf w
    JOIN member m ON m.member_id=w.member_id
    JOIN part p ON p.part_id=m.part_id
    WHERE w.year=:year AND p.part_name IN :parts AND m.active=TRUE
    ORDER BY p.part_name, m.name, w.month
    """
    return pd.read_sql(text(q), engine, params={"year":year, "parts":tuple(part_names)})

def kpi_cards(fin_total, gdc_df, mem_df):
    total_rev = int(fin_total["revenue_sum"].sum()) if not fin_total.empty else 0
    total_op = int(fin_total["op_profit_sum"].sum()) if not fin_total.empty else 0
    margin = (total_op/total_rev) if total_rev else 0
    total_mm = float(gdc_df["mm"].sum()) if not gdc_df.empty else 0.0
    ai_rate = float(mem_df["ai_used"].mean()) if not mem_df.empty else 0.0
    prep_sum = int(mem_df["prep_lack_count"].sum()) if not mem_df.empty else 0

    c1,c2,c3,c4,c5,c6 = st.columns(6)
    c1.metric("총 매출(누적, KRW)", f"{total_rev:,}")
    c2.metric("총 영업이익(누적, KRW)", f"{total_op:,}")
    c3.metric("이익률", f"{margin*100:.1f}%")
    c4.metric("GDC 총 MM(연누적)", f"{total_mm:.2f}")
    c5.metric("AI 사용률(개인)", f"{ai_rate*100:.1f}%")
    c6.metric("준비미흡 합계", f"{prep_sum:,}")

def admin_tab():
    st.subheader("관리자 기능")
    engine = get_engine()

    st.markdown("#### 파트 관리")
    parts = load_parts()
    c1,c2 = st.columns([1,1])
    with c1:
        with st.form("add_part"):
            n = st.text_input("파트명(신규)")
            ok = st.form_submit_button("추가")
            if ok:
                if not n.strip():
                    st.error("파트명을 입력해 주세요.")
                else:
                    with engine.begin() as con:
                        con.execute(text("INSERT INTO part(part_name, active) VALUES (:n, TRUE)"), {"n": n.strip()})
                    st.cache_data.clear()
                    st.success("추가 완료")
                    st.rerun()
    with c2:
        st.dataframe(parts.rename(columns={"part_id":"파트ID","part_name":"파트명","active":"활성"}), use_container_width=True, hide_index=True)

    st.markdown("파트 수정/비활성화")
    with st.form("update_part"):
        sel = st.selectbox("대상 파트", parts["part_name"].tolist() if not parts.empty else [])
        new_name = st.text_input("새 파트명(변경 시)")
        active_flag = st.selectbox("활성 여부", ["TRUE","FALSE"])
        ok = st.form_submit_button("적용")
        if ok and sel:
            with engine.begin() as con:
                if new_name.strip():
                    con.execute(text("UPDATE part SET part_name=:nn WHERE part_name=:pn"), {"nn": new_name.strip(), "pn": sel})
                    sel = new_name.strip()
                con.execute(text("UPDATE part SET active=:a WHERE part_name=:pn"), {"a": 1 if active_flag=="TRUE" else 0, "pn": sel})
            st.cache_data.clear()
            st.success("적용 완료")
            st.rerun()

    st.markdown("#### 인원 관리")
    members = load_members()
    cA,cB = st.columns([1,1])
    with cA:
        with st.form("add_member"):
            n = st.text_input("이름(신규)")
            parts_active = load_parts().query("active==1")["part_name"].tolist()
            p = st.selectbox("소속 파트", parts_active)
            ok = st.form_submit_button("추가")
            if ok:
                if not n.strip():
                    st.error("이름을 입력해 주세요.")
                else:
                    with engine.begin() as con:
                        con.execute(text("""
                        INSERT INTO member(name, part_id, active)
                        SELECT :n, part_id, TRUE FROM part WHERE part_name=:pn
                        """), {"n": n.strip(), "pn": p})
                    st.cache_data.clear()
                    st.success("추가 완료")
                    st.rerun()
    with cB:
        st.dataframe(members.rename(columns={"member_id":"멤버ID","name":"이름","active":"활성","part_id":"파트ID","part_name":"파트명"}), use_container_width=True, hide_index=True)

    st.markdown("인원 수정/비활성화")
    with st.form("update_member"):
        if members.empty:
            st.info("멤버가 없습니다.")
        else:
            sel = st.selectbox("대상 인원", members["name"].tolist())
            new_name = st.text_input("새 이름(변경 시)")
            parts_active = load_parts().query("active==1")["part_name"].tolist()
            new_part = st.selectbox("새 파트", parts_active)
            active_flag = st.selectbox("활성 여부(인원)", ["TRUE","FALSE"])
            ok = st.form_submit_button("적용")
            if ok:
                with engine.begin() as con:
                    if new_name.strip():
                        con.execute(text("UPDATE member SET name=:nn WHERE name=:n"), {"nn": new_name.strip(), "n": sel})
                        sel = new_name.strip()
                    con.execute(text("""
                    UPDATE member
                    SET part_id = (SELECT part_id FROM part WHERE part_name=:pn),
                        active = :a
                    WHERE name=:n
                    """), {"pn": new_part, "a": 1 if active_flag=="TRUE" else 0, "n": sel})
                st.cache_data.clear()
                st.success("적용 완료")
                st.rerun()

    st.divider()
    st.markdown("#### 매출/영업이익 입력(누적)")
    with st.form("finance_entry"):
        y = st.number_input("연도", min_value=2000, max_value=2100, value=TARGET_YEAR)
        m = st.number_input("월(1~12)", min_value=1, max_value=12, value=1)
        parts_active = load_parts().query("active==1")["part_name"].tolist()
        p = st.selectbox("파트", parts_active)
        kpi = st.selectbox("구분", ["매출", "영업이익"])
        amt = st.number_input("금액(KRW)", min_value=0, value=0, step=1000000)
        proj = st.text_input("프로젝트명(필수)")
        src = st.text_input("출처/근거 코멘트(필수)")
        ok = st.form_submit_button("추가(누적)")
        if ok:
            if not proj.strip() or not src.strip():
                st.error("프로젝트명과 출처/근거 코멘트는 필수입니다.")
            else:
                kpi_type = "REVENUE" if kpi=="매출" else "OP_PROFIT"
                with engine.begin() as con:
                    con.execute(text("""
                    INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
                    SELECT :y,:m,part_id,:k,:amt,:proj,:src,'admin'
                    FROM part WHERE part_name=:pn
                    """), {"y":int(y),"m":int(m),"pn":p,"k":kpi_type,"amt":int(amt),
                           "proj":proj.strip(),"src":src.strip()})
                st.cache_data.clear()
                st.success("추가 완료")
                st.rerun()

    st.markdown("#### GDC 입력(파트×월)")
    with st.form("gdc_monthly"):
        y = st.number_input("연도(GDC)", min_value=2000, max_value=2100, value=TARGET_YEAR, key="gdc_y")
        m = st.number_input("월(GDC, 1~12)", min_value=1, max_value=12, value=1, key="gdc_m")
        parts_active = load_parts().query("active==1")["part_name"].tolist()
        p = st.selectbox("파트(GDC)", parts_active, key="gdc_p")
        mm = st.number_input("MM", min_value=0.0, value=0.0, step=0.5, key="gdc_mm")
        cmt = st.text_input("코멘트(필수)", key="gdc_cmt")
        ok = st.form_submit_button("저장/갱신")
        if ok:
            if not cmt.strip():
                st.error("코멘트는 필수입니다.")
            else:
                with engine.begin() as con:
                    con.execute(text("""
                    INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
                    SELECT :y,:m,part_id,:mm,:cmt,'admin'
                    FROM part WHERE part_name=:pn
                    ON DUPLICATE KEY UPDATE
                      mm=VALUES(mm),
                      comment=VALUES(comment),
                      updated_by=VALUES(updated_by)
                    """), {"y":int(y),"m":int(m),"pn":p,"mm":float(mm),"cmt":cmt.strip()})
                st.cache_data.clear()
                st.success("저장 완료")
                st.rerun()

    st.markdown("#### GDC 표 편집(파트 × 월)")
    y_edit = st.number_input("연도(표 편집)", min_value=2000, max_value=2100, value=TARGET_YEAR, key="gdc_edit_y")
    parts_active = load_parts().query("active==1")["part_name"].tolist()
    
    if parts_active:
        # 모든 월(1-12)을 포함한 GDC 데이터 조회
        q_edit = """
        SELECT p.part_id, p.part_name, m.month, COALESCE(g.mm, 0) AS mm, COALESCE(g.comment, '') AS comment
        FROM part p
        CROSS JOIN (SELECT 1 AS month UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
                    UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 
                    UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12) m
        LEFT JOIN part_gdc_monthly g ON g.part_id=p.part_id AND g.year=:year AND g.month=m.month
        WHERE p.part_name IN :parts AND p.active=TRUE
        ORDER BY p.part_name, m.month
        """
        gdc_edit = pd.read_sql(text(q_edit), engine, params={"year": int(y_edit), "parts": tuple(parts_active)})
        
        # 피벗 테이블 생성 (파트별 행, 월별 열)
        gdc_pivot = gdc_edit.pivot_table(index="part_name", columns="month", values="mm", aggfunc="first", fill_value=0)
        all_months = list(range(1, 13))
        gdc_pivot = gdc_pivot.reindex(all_months, axis=1, fill_value=0)
        # 한글 컬럼명으로 변경(예: '1월', '2월', ...)
        month_cols = [f"{int(c)}월" for c in gdc_pivot.columns]
        gdc_pivot.columns = month_cols
        
        # 편집 가능한 데이터 프레임: 'part_name' -> '파트'
        df_edit = gdc_pivot.reset_index().rename(columns={"part_name": "파트"})
        df_edit = df_edit.rename(columns={c: c for c in df_edit.columns})

        edited_gdc = st.data_editor(
            df_edit,
            use_container_width=True,
            hide_index=True,
            key="gdc_editor"
        )
        
        # 저장 버튼
        if st.button("GDC 표 저장", key="save_gdc_table"):
            with engine.begin() as con:
                # 기존 데이터 삭제 (선택된 활성 파트만)
                con.execute(text("DELETE FROM part_gdc_monthly WHERE year=:y AND part_id IN (SELECT part_id FROM part WHERE part_name IN :parts)"),
                           {"y": int(y_edit), "parts": tuple(parts_active)})
                
                # 새로운 데이터 삽입 (한글 컬럼명을 월 숫자로 역매핑)
                for _, row in edited_gdc.iterrows():
                    part_name = row['파트']
                    for col in edited_gdc.columns:
                        if col == '파트':
                            continue
                        # 컬럼명이 'N월' 형태인 경우 월 숫자 추출
                        try:
                            month = int(str(col).replace('월',''))
                        except Exception:
                            continue
                        mm_value = float(row[col]) if pd.notna(row[col]) else 0.0
                        if mm_value > 0:
                            con.execute(text("""
                            INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
                            SELECT :y,:m,part_id,:mm,'관리자 표 수정','admin'
                            FROM part WHERE part_name=:pn
                            ON DUPLICATE KEY UPDATE
                              mm=VALUES(mm),
                              comment=VALUES(comment),
                              updated_by=VALUES(updated_by)
                            """), {"y": int(y_edit), "m": month, "pn": part_name, "mm": mm_value})
            
            st.cache_data.clear()
            st.success("GDC 데이터가 저장되었습니다!")
            st.rerun()

    st.markdown("#### 개인 성과 입력(월)")
    mem = load_members().query("active==1")
    if mem.empty:
        st.info("활성 멤버가 없습니다.")
    else:
        with st.form("member_monthly"):
            y = st.number_input("연도(개인)", min_value=2000, max_value=2100, value=TARGET_YEAR, key="mp_y")
            m = st.number_input("월(개인)", min_value=1, max_value=12, value=1, key="mp_m")
            person = st.selectbox("대상 인원", mem["name"].tolist(), key="mp_name")
            ai = st.checkbox("AI 사용", value=False, key="mp_ai")
            prep = st.number_input("준비미흡 횟수", min_value=0, value=0, step=1, key="mp_prep")
            cmt = st.text_input("코멘트(선택)", key="mp_cmt")
            ok = st.form_submit_button("저장/갱신")
            if ok:
                with engine.begin() as con:
                    con.execute(text("""
                    INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
                    SELECT :y,:m,member_id,:ai,:prep,:cmt,'admin'
                    FROM member WHERE name=:n
                    ON DUPLICATE KEY UPDATE
                      ai_used=VALUES(ai_used),
                      prep_lack_count=VALUES(prep_lack_count),
                      comment=VALUES(comment),
                      updated_by=VALUES(updated_by)
                    """), {"y":int(y),"m":int(m),"n":person,"ai":1 if ai else 0,
                           "prep":int(prep),"cmt":cmt.strip() if cmt.strip() else None})
                st.cache_data.clear()
                st.success("저장 완료")
                st.rerun()

def main():
    admin_login_ui()
    parts_selected = part_filter_ui()

    st.title("팀 성과관리 대시보드 v3")
    st.caption(f"{TARGET_YEAR}년 누적 기준 (주차 필터 없음)")

    if not parts_selected:
        st.warning("선택된 파트가 없습니다.")
        return

    fin_total = query_finance_total(TARGET_YEAR, parts_selected)
    fin_monthly = query_finance_monthly(TARGET_YEAR, parts_selected)
    gdc = query_gdc_monthly(TARGET_YEAR, parts_selected)
    mem = query_member_monthly(TARGET_YEAR, parts_selected)

    kpi_cards(fin_total, gdc, mem)

    tab1, tab2, tab3 = st.tabs(["파트 성과", "개인 성과", "관리자"])

    with tab1:
        st.subheader("파트 성과")

        c1,c2 = st.columns(2)
        # 표시용으로 컬럼 이름을 한글로 변환한 복사본 생성
        fin_total_disp = fin_total.rename(columns={"part_name":"파트","revenue_sum":"매출","op_profit_sum":"영업이익"})
        with c1:
            st.plotly_chart(px.bar(fin_total_disp, x="파트", y="매출", title="파트별 매출(누적)"), use_container_width=True)
        with c2:
            st.plotly_chart(px.bar(fin_total_disp, x="파트", y="영업이익", title="파트별 영업이익(누적)"), use_container_width=True)

        if not fin_total.empty:
            tmp = fin_total.copy()
            tmp["이익률"] = tmp.apply(lambda r: (r["op_profit_sum"]/r["revenue_sum"]) if r["revenue_sum"] else 0, axis=1)
            tmp_disp = tmp.rename(columns={"part_name":"파트","revenue_sum":"매출","op_profit_sum":"영업이익"})
            fig = px.scatter(tmp_disp, x="매출", y="영업이익", text="파트", title="매출 vs 영업이익(누적)", hover_data=["이익률"])
            fig.update_traces(textposition="top center")
            st.plotly_chart(fig, use_container_width=True)

        st.markdown("#### 월별 추이(선택 파트 합산)")
        if not fin_monthly.empty:
            agg = fin_monthly.groupby("month").agg(매출=("revenue_sum","sum"), 영업이익=("op_profit_sum","sum")).reset_index()
            st.plotly_chart(px.line(agg, x="month", y=["매출","영업이익"], title="월별 매출/영업이익 추이"), use_container_width=True)
        else:
            st.info("매출/영업이익 데이터가 없습니다.")

        st.markdown("#### GDC (파트 × 월) 표")
        if gdc.empty:
            st.info("GDC 데이터가 없습니다.")
        else:
            piv = gdc.pivot_table(index="part_name", columns="month", values="mm", aggfunc="sum", fill_value=0)
            # 1월부터 12월까지 모두 포함하도록 정렬
            all_months = list(range(1, 13))
            piv = piv.reindex(all_months, axis=1, fill_value=0)
            piv.columns = [f"{int(c)}월" for c in piv.columns]
            df_piv = piv.reset_index().rename(columns={"part_name":"파트"})
            st.dataframe(df_piv, use_container_width=True, hide_index=True)

            pt = gdc.groupby("part_name")["mm"].sum().reset_index(name="mm_sum")
            total = float(pt["mm_sum"].sum()) if not pt.empty else 0.0
            pt["mm_share"] = pt["mm_sum"].apply(lambda x: (x/total) if total else 0.0)
            c1,c2 = st.columns(2)
            pt_disp = pt.rename(columns={"part_name":"파트","mm_sum":"MM_합계"})
            pt_disp["비중"] = pt_disp["MM_합계"].apply(lambda x: (x/total) if total else 0.0)
            with c1:
                st.plotly_chart(px.bar(pt_disp, x="파트", y="MM_합계", title="파트별 GDC 총 MM(연누적)"), use_container_width=True)
            with c2:
                fig = px.bar(pt_disp, x="파트", y="비중", title="파트별 GDC 사용률(전체 대비 %)")
                fig.update_yaxes(tickformat=".0%")
                st.plotly_chart(fig, use_container_width=True)

        st.markdown("#### (드릴다운) 매출/영업이익 상세 내역")
        if not fin_total.empty:
            psel = st.selectbox("파트 선택(상세)", fin_total["part_name"].tolist())
            ksel = st.radio("구분", ["매출", "영업이익"], horizontal=True)
            ktype = "REVENUE" if ksel=="매출" else "OP_PROFIT"
            detail = query_finance_details(TARGET_YEAR, psel, ktype)
            if not detail.empty:
                detail = detail.rename(columns={"month":"월","amount":"금액","project_name":"프로젝트명","source_comment":"근거","created_by":"입력자"})
            st.dataframe(detail, use_container_width=True, hide_index=True)

    with tab2:
        st.subheader("개인 성과")
        if mem.empty:
            st.info("개인 성과 데이터가 없습니다.")
        else:
            ai_tab, prep_tab = st.tabs(["AI", "준비미흡"])

            with ai_tab:
                st.markdown("#### AI 사용 현황(월 단위)")
                ai_df = mem[["part_name","name","month","ai_used"]].copy()
                ai_df["ai_used"] = ai_df["ai_used"].map({0:"N",1:"Y",False:"N",True:"Y"})
                ai_df = ai_df.rename(columns={"part_name":"파트","name":"이름","month":"월","ai_used":"AI 사용"})
                st.dataframe(ai_df, use_container_width=True, hide_index=True)

                ai_rate = mem.groupby("part_name")["ai_used"].mean().reset_index(name="ai_rate")
                ai_rate_disp = ai_rate.rename(columns={"part_name":"파트","ai_rate":"AI_사용률"})
                fig = px.bar(ai_rate_disp, x="파트", y="AI_사용률", title="파트별 AI 사용률(연누적)")
                fig.update_yaxes(tickformat=".0%")
                st.plotly_chart(fig, use_container_width=True)

            with prep_tab:
                st.markdown("#### 준비미흡 현황(월 단위)")
                prep_df = mem[["part_name","name","month","prep_lack_count"]].copy()
                prep_df = prep_df.rename(columns={"part_name":"파트","name":"이름","month":"월","prep_lack_count":"준비미흡"})
                st.dataframe(prep_df, use_container_width=True, hide_index=True)

                prep_part = mem.groupby("part_name")["prep_lack_count"].sum().reset_index(name="prep_sum")
                prep_part_disp = prep_part.rename(columns={"part_name":"파트","prep_sum":"준비미흡_합계"})
                st.plotly_chart(px.bar(prep_part_disp, x="파트", y="준비미흡_합계", title="파트별 준비미흡 총합(연누적)"), use_container_width=True)

                topn = mem.groupby("name")["prep_lack_count"].sum().reset_index(name="prep_sum").sort_values("prep_sum", ascending=False).head(10)
                topn_disp = topn.rename(columns={"name":"이름","prep_sum":"준비미흡_합계"})
                st.plotly_chart(px.bar(topn_disp, x="이름", y="준비미흡_합계", title="준비미흡 TOP 10(연누적)"), use_container_width=True)

    with tab3:
        if not is_admin():
            st.info("관리자 로그인 후 사용 가능합니다.")
        else:
            admin_tab()

if __name__ == "__main__":
    main()
