import os
import pandas as pd
import streamlit as st
import plotly.express as px
from sqlalchemy import text
from dotenv import load_dotenv
from scripts.db import get_engine

load_dotenv()

st.set_page_config(page_title="팀 성과관리 대시보드 v2", layout="wide")

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

@st.cache_data(ttl=60)
def available_year_weeks():
    engine = get_engine()
    q = """
    SELECT DISTINCT year, week FROM part_finance_entry
    UNION SELECT DISTINCT year, week FROM part_gdc_wbs_entry
    UNION SELECT DISTINCT year, week FROM member_weekly_perf
    ORDER BY year DESC, week DESC
    """
    with engine.begin() as con:
        rows = con.execute(text(q)).fetchall()
    if not rows:
        return [(2026,1)]
    return [(int(r[0]), int(r[1])) for r in rows]

def get_filters():
    parts = load_parts()
    part_names = parts.loc[parts["active"]==1, "part_name"].tolist()

    weeks = available_year_weeks()
    labels = [f"{y}-W{w:02d}" for y,w in weeks]

    st.sidebar.markdown("### 조회 필터")
    sel = st.sidebar.selectbox("주차", labels, index=0)
    y,w = weeks[labels.index(sel)]
    sel_parts = st.sidebar.multiselect("파트", part_names, default=part_names)
    return y,w,sel_parts

def query_part_finance_summary(year:int, week:int, part_names:list[str]):
    engine = get_engine()
    q = """
    SELECT p.part_name,
           SUM(CASE WHEN f.kpi_type='REVENUE' THEN f.amount ELSE 0 END) AS revenue_sum,
           SUM(CASE WHEN f.kpi_type='OP_PROFIT' THEN f.amount ELSE 0 END) AS op_profit_sum
    FROM part_finance_entry f
    JOIN part p ON p.part_id=f.part_id
    WHERE f.year=:year AND f.week=:week
      AND p.part_name IN :parts
    GROUP BY p.part_name
    ORDER BY p.part_name
    """
    return pd.read_sql(text(q), engine, params={"year":year,"week":week,"parts":tuple(part_names)})

def query_finance_details(year:int, week:int, part_name:str, kpi_type:str):
    engine = get_engine()
    q = """
    SELECT f.created_at, f.kpi_type, f.amount, f.project_name, f.source_comment, f.created_by
    FROM part_finance_entry f
    JOIN part p ON p.part_id=f.part_id
    WHERE f.year=:year AND f.week=:week AND p.part_name=:part_name AND f.kpi_type=:kpi_type
    ORDER BY f.created_at DESC
    """
    return pd.read_sql(text(q), engine, params={"year":year,"week":week,"part_name":part_name,"kpi_type":kpi_type})

def query_gdc_wbs(year:int, week:int, part_names:list[str]):
    engine = get_engine()
    q = """
    SELECT p.part_name, g.wbs_code, g.wbs_name, g.mm
    FROM part_gdc_wbs_entry g
    JOIN part p ON p.part_id=g.part_id
    WHERE g.year=:year AND g.week=:week
      AND p.part_name IN :parts
    """
    return pd.read_sql(text(q), engine, params={"year":year,"week":week,"parts":tuple(part_names)})

def query_member_perf(year:int, week:int, part_names:list[str]):
    engine = get_engine()
    q = """
    SELECT p.part_name, m.name,
           w.ai_used, w.prep_lack_count
    FROM member_weekly_perf w
    JOIN member m ON m.member_id=w.member_id
    JOIN part p ON p.part_id=m.part_id
    WHERE w.year=:year AND w.week=:week
      AND p.part_name IN :parts
      AND m.active=TRUE
    ORDER BY p.part_name, m.name
    """
    return pd.read_sql(text(q), engine, params={"year":year,"week":week,"parts":tuple(part_names)})

def kpi_cards(fin_df, gdc_df, mem_df):
    total_rev = int(fin_df["revenue_sum"].sum()) if not fin_df.empty else 0
    total_op = int(fin_df["op_profit_sum"].sum()) if not fin_df.empty else 0
    margin = (total_op/total_rev) if total_rev else 0
    total_mm = float(gdc_df["mm"].sum()) if not gdc_df.empty else 0.0
    ai_rate = float(mem_df["ai_used"].mean()) if not mem_df.empty else 0.0
    prep_sum = int(mem_df["prep_lack_count"].sum()) if not mem_df.empty else 0

    c1,c2,c3,c4,c5,c6 = st.columns(6)
    c1.metric("총 매출(KRW)", f"{total_rev:,}")
    c2.metric("총 영업이익(KRW)", f"{total_op:,}")
    c3.metric("이익률", f"{margin*100:.1f}%")
    c4.metric("GDC 총 MM", f"{total_mm:.2f}")
    c5.metric("AI 사용률(개인)", f"{ai_rate*100:.1f}%")
    c6.metric("준비미흡 합계", f"{prep_sum:,}")

def admin_tab():
    st.subheader("관리자 기능")
    st.caption("파트/인원 관리, 매출/영업이익 누적 입력(근거 필수), GDC WBS 입력/업로드, 개인 성과 입력")
    engine = get_engine()

    st.markdown("#### 파트 관리")
    parts = load_parts()
    c1,c2 = st.columns([1,1])
    with c1:
        with st.form("add_part"):
            new_name = st.text_input("파트명(신규)")
            ok = st.form_submit_button("파트 추가")
            if ok:
                if not new_name.strip():
                    st.error("파트명을 입력해 주세요.")
                else:
                    with engine.begin() as con:
                        con.execute(text("INSERT INTO part(part_name, active) VALUES (:n, TRUE)"), {"n": new_name.strip()})
                    st.cache_data.clear()
                    st.success("추가 완료")
                    st.rerun()
    with c2:
        st.dataframe(parts, use_container_width=True, hide_index=True)

    st.markdown("파트 수정/비활성화")
    with st.form("update_part"):
        part_sel = st.selectbox("대상 파트", parts["part_name"].tolist() if not parts.empty else [])
        new_part_name = st.text_input("새 파트명(변경 시)")
        active_flag = st.selectbox("활성 여부", ["TRUE","FALSE"])
        ok = st.form_submit_button("적용")
        if ok and part_sel:
            with engine.begin() as con:
                if new_part_name.strip():
                    con.execute(text("UPDATE part SET part_name=:nn WHERE part_name=:pn"), {"nn": new_part_name.strip(), "pn": part_sel})
                    part_sel = new_part_name.strip()
                con.execute(text("UPDATE part SET active=:a WHERE part_name=:pn"), {"a": 1 if active_flag=="TRUE" else 0, "pn": part_sel})
            st.cache_data.clear()
            st.success("적용 완료")
            st.rerun()

    st.markdown("#### 인원 관리")
    members = load_members()
    cA,cB = st.columns([1,1])
    with cA:
        with st.form("add_member"):
            m_name = st.text_input("이름(신규)")
            parts_active = load_parts().query("active==1")["part_name"].tolist()
            m_part = st.selectbox("소속 파트", parts_active)
            ok = st.form_submit_button("인원 추가")
            if ok:
                if not m_name.strip():
                    st.error("이름을 입력해 주세요.")
                else:
                    with engine.begin() as con:
                        con.execute(text("""
                        INSERT INTO member(name, part_id, active)
                        SELECT :n, part_id, TRUE FROM part WHERE part_name=:pn
                        """), {"n": m_name.strip(), "pn": m_part})
                    st.cache_data.clear()
                    st.success("추가 완료")
                    st.rerun()
    with cB:
        st.dataframe(members, use_container_width=True, hide_index=True)

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
            ok = st.form_submit_button("적용(인원)")
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
        y = st.number_input("연도", min_value=2000, max_value=2100, value=2026)
        w = st.number_input("주차(ISO week)", min_value=1, max_value=53, value=1)
        parts_active = load_parts().query("active==1")["part_name"].tolist()
        p = st.selectbox("파트", parts_active)
        kpi = st.selectbox("유형", ["REVENUE","OP_PROFIT"])
        amt = st.number_input("금액(KRW)", min_value=0, value=0, step=1000000)
        proj = st.text_input("프로젝트명(필수)")
        src = st.text_input("출처/근거 코멘트(필수)")
        ok = st.form_submit_button("추가(누적)")
        if ok:
            if not proj.strip() or not src.strip():
                st.error("프로젝트명과 출처/근거 코멘트는 필수입니다.")
            else:
                with engine.begin() as con:
                    con.execute(text("""
                    INSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
                    SELECT :y,:w,part_id,:k,:amt,:proj,:src,'admin'
                    FROM part WHERE part_name=:pn
                    """), {"y":int(y),"w":int(w),"pn":p,"k":kpi,"amt":int(amt),"proj":proj.strip(),"src":src.strip()})
                st.cache_data.clear()
                st.success("추가 완료")
                st.rerun()

    st.markdown("#### GDC WBS 입력")
    with st.form("gdc_entry"):
        y = st.number_input("연도(GDC)", min_value=2000, max_value=2100, value=2026, key="gdc_y")
        w = st.number_input("주차(GDC)", min_value=1, max_value=53, value=1, key="gdc_w")
        parts_active = load_parts().query("active==1")["part_name"].tolist()
        p = st.selectbox("파트(GDC)", parts_active, key="gdc_part")
        wbs_code = st.text_input("WBS 코드", key="wbs_code")
        wbs_name = st.text_input("WBS 명", key="wbs_name")
        mm = st.number_input("MM", min_value=0.0, value=0.0, step=0.5, key="wbs_mm")
        cmt = st.text_input("코멘트(필수)", key="wbs_cmt")
        ok = st.form_submit_button("추가")
        if ok:
            if not wbs_code.strip() or not wbs_name.strip() or not cmt.strip():
                st.error("WBS 코드/명/코멘트는 필수입니다.")
            else:
                with engine.begin() as con:
                    con.execute(text("""
                    INSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
                    SELECT :y,:w,part_id,:code,:name,:mm,:cmt,'admin'
                    FROM part WHERE part_name=:pn
                    """), {"y":int(y),"w":int(w),"pn":p,"code":wbs_code.strip(),"name":wbs_name.strip(),"mm":float(mm),"cmt":cmt.strip()})
                st.cache_data.clear()
                st.success("추가 완료")
                st.rerun()

    st.markdown("GDC WBS CSV 업로드")
    up = st.file_uploader("gdc_wbs.csv 업로드", type=["csv"])
    if up is not None:
        df = pd.read_csv(up)
        needed = {"year","week","part_name","wbs_code","wbs_name","mm","comment"}
        if not needed.issubset(set(df.columns)):
            st.error(f"컬럼이 부족합니다. 필요: {sorted(needed)}")
        else:
            if st.button("CSV 반영"):
                with engine.begin() as con:
                    for _,r in df.iterrows():
                        con.execute(text("""
                        INSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
                        SELECT :y,:w,part_id,:code,:name,:mm,:cmt,'admin'
                        FROM part WHERE part_name=:pn
                        """), {
                            "y":int(r["year"]), "w":int(r["week"]), "pn":str(r["part_name"]),
                            "code":str(r["wbs_code"]), "name":str(r["wbs_name"]),
                            "mm":float(r["mm"]), "cmt":str(r["comment"])
                        })
                st.cache_data.clear()
                st.success("업로드 반영 완료")
                st.rerun()

    st.divider()

    st.markdown("#### 개인 성과 입력(AI/준비미흡)")
    mem = load_members().query("active==1")
    if mem.empty:
        st.info("활성 멤버가 없습니다.")
    else:
        with st.form("member_perf"):
            y = st.number_input("연도(개인)", min_value=2000, max_value=2100, value=2026, key="mp_y")
            w = st.number_input("주차(개인)", min_value=1, max_value=53, value=1, key="mp_w")
            person = st.selectbox("대상 인원", mem["name"].tolist(), key="mp_name")
            ai = st.checkbox("AI 사용", value=False, key="mp_ai")
            prep = st.number_input("준비미흡 횟수", min_value=0, value=0, step=1, key="mp_prep")
            cmt = st.text_input("코멘트(선택)", key="mp_cmt")
            ok = st.form_submit_button("저장/갱신")
            if ok:
                with engine.begin() as con:
                    con.execute(text("""
                    INSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
                    SELECT :y,:w,member_id,:ai,:prep,:cmt,'admin'
                    FROM member WHERE name=:n
                    ON DUPLICATE KEY UPDATE
                      ai_used=VALUES(ai_used),
                      prep_lack_count=VALUES(prep_lack_count),
                      comment=VALUES(comment),
                      updated_by=VALUES(updated_by)
                    """), {"y":int(y),"w":int(w),"n":person,"ai":1 if ai else 0,"prep":int(prep),"cmt":cmt.strip() if cmt.strip() else None})
                st.cache_data.clear()
                st.success("저장 완료")
                st.rerun()

def main():
    admin_login_ui()
    year, week, part_names = get_filters()

    if not part_names:
        st.warning("선택된 파트가 없습니다.")
        return

    fin = query_part_finance_summary(year, week, part_names)
    gdc = query_gdc_wbs(year, week, part_names)
    mem = query_member_perf(year, week, part_names)

    st.title("팀 성과관리 대시보드 v2")
    st.caption(f"조회 기준: {year}-W{week:02d} / 파트: {', '.join(part_names)}")
    kpi_cards(fin, gdc, mem)

    tab1, tab2, tab3 = st.tabs(["파트 성과", "개인 성과", "관리자"])
    with tab1:
        st.subheader("파트 성과(매출/영업이익/GDC)")

        c1,c2 = st.columns(2)
        with c1:
            st.plotly_chart(px.bar(fin, x="part_name", y="revenue_sum", title="파트별 매출(SUM)"), use_container_width=True)
        with c2:
            st.plotly_chart(px.bar(fin, x="part_name", y="op_profit_sum", title="파트별 영업이익(SUM)"), use_container_width=True)

        if not fin.empty:
            tmp = fin.copy()
            tmp["margin"] = tmp.apply(lambda r: (r["op_profit_sum"]/r["revenue_sum"]) if r["revenue_sum"] else 0, axis=1)
            fig = px.scatter(tmp, x="revenue_sum", y="op_profit_sum", text="part_name", title="매출 vs 영업이익 (파트 포지션)", hover_data=["margin"])
            fig.update_traces(textposition="top center")
            st.plotly_chart(fig, use_container_width=True)

        st.markdown("#### GDC WBS 표(엑셀형)")
        if gdc.empty:
            st.info("해당 주차에 GDC 데이터가 없습니다.")
        else:
            piv = gdc.pivot_table(index=["wbs_code","wbs_name"], columns="part_name", values="mm", aggfunc="sum", fill_value=0).reset_index()
            st.dataframe(piv, use_container_width=True, hide_index=True)

            pt = gdc.groupby("part_name")["mm"].sum().reset_index(name="mm_sum")
            total = float(pt["mm_sum"].sum()) if not pt.empty else 0.0
            pt["mm_share"] = pt["mm_sum"].apply(lambda x: (x/total) if total else 0.0)

            c1,c2 = st.columns(2)
            with c1:
                st.plotly_chart(px.bar(pt, x="part_name", y="mm_sum", title="파트별 GDC 총 MM"), use_container_width=True)
            with c2:
                fig = px.bar(pt, x="part_name", y="mm_share", title="파트별 GDC 사용률(전체 대비 %)")
                fig.update_yaxes(tickformat=".0%")
                st.plotly_chart(fig, use_container_width=True)

        st.markdown("#### (드릴다운) 매출/영업이익 상세 내역")
        if not fin.empty:
            psel = st.selectbox("파트 선택(상세)", fin["part_name"].tolist())
            ksel = st.radio("유형 선택", ["REVENUE","OP_PROFIT"], horizontal=True)
            detail = query_finance_details(year, week, psel, ksel)
            st.dataframe(detail, use_container_width=True, hide_index=True)

    with tab2:
        st.subheader("개인 성과(AI/준비미흡)")
        if mem.empty:
            st.info("해당 주차에 개인 성과 데이터가 없습니다.")
        else:
            show = mem.copy()
            show["ai_used"] = show["ai_used"].map({0:"N",1:"Y",False:"N",True:"Y"})
            st.dataframe(show, use_container_width=True, hide_index=True)

            ai = mem.groupby("part_name")["ai_used"].mean().reset_index(name="ai_rate")
            prep = mem.groupby("part_name")["prep_lack_count"].sum().reset_index(name="prep_sum")

            c1,c2 = st.columns(2)
            with c1:
                fig = px.bar(ai, x="part_name", y="ai_rate", title="파트별 AI 사용률(개인)")
                fig.update_yaxes(tickformat=".0%")
                st.plotly_chart(fig, use_container_width=True)
            with c2:
                st.plotly_chart(px.bar(prep, x="part_name", y="prep_sum", title="파트별 준비미흡 총합"), use_container_width=True)

            topn = mem.sort_values("prep_lack_count", ascending=False).head(10)
            st.plotly_chart(px.bar(topn, x="name", y="prep_lack_count", title="준비미흡 TOP 10(개인)"), use_container_width=True)

    with tab3:
        if not is_admin():
            st.info("관리자 로그인 후 사용 가능합니다.")
        else:
            admin_tab()

if __name__ == "__main__":
    main()
