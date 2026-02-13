import os
import pandas as pd
import streamlit as st
import plotly.express as px
from sqlalchemy import text
from dotenv import load_dotenv
from scripts.db import get_engine

load_dotenv()

st.set_page_config(page_title="Team Performance Dashboard", layout="wide")

@st.cache_data(ttl=60)
def get_available_weeks():
    engine = get_engine()
    q = """
    SELECT DISTINCT year, week FROM part_kpi_weekly
    UNION
    SELECT DISTINCT year, week FROM member_kpi_weekly
    ORDER BY year DESC, week DESC
    """
    with engine.begin() as con:
        rows = con.execute(text(q)).fetchall()
    if not rows:
        return [(2026, 1)]
    return [(int(r[0]), int(r[1])) for r in rows]

@st.cache_data(ttl=60)
def load_part_kpi(year:int, week:int):
    engine = get_engine()
    q = """
    SELECT p.part_id, p.part_name, k.revenue, k.op_profit,
           CASE WHEN k.revenue > 0 THEN (k.op_profit / k.revenue) ELSE NULL END AS op_margin
    FROM part_kpi_weekly k
    JOIN part p ON p.part_id = k.part_id
    WHERE k.year=:year AND k.week=:week
    ORDER BY p.part_id
    """
    return pd.read_sql(text(q), engine, params={"year":year, "week":week})

@st.cache_data(ttl=60)
def load_member_kpi(year:int, week:int):
    engine = get_engine()
    q = """
    SELECT m.member_id, m.name, p.part_id, p.part_name,
           w.weekly_report_done, w.gdc_used, w.gdc_mm, w.ai_used
    FROM member_kpi_weekly w
    JOIN member m ON m.member_id = w.member_id
    JOIN part p ON p.part_id = m.part_id
    WHERE w.year=:year AND w.week=:week AND m.active=TRUE
    ORDER BY p.part_id, m.name
    """
    return pd.read_sql(text(q), engine, params={"year":year, "week":week})

@st.cache_data(ttl=60)
def load_member_trend(year_from:int, week_from:int, year_to:int, week_to:int):
    engine = get_engine()
    q = """
    SELECT year, week, m.name, p.part_name,
           weekly_report_done, gdc_used, gdc_mm, ai_used
    FROM member_kpi_weekly w
    JOIN member m ON m.member_id = w.member_id
    JOIN part p ON p.part_id = m.part_id
    WHERE (year > :y_from OR (year = :y_from AND week >= :w_from))
      AND (year < :y_to   OR (year = :y_to   AND week <= :w_to))
      AND m.active=TRUE
    """
    return pd.read_sql(text(q), engine, params={"y_from":year_from,"w_from":week_from,"y_to":year_to,"w_to":week_to})

def kpi_cards(part_df, member_df):
    total_rev = int(part_df["revenue"].sum()) if not part_df.empty else 0
    total_op  = int(part_df["op_profit"].sum()) if not part_df.empty else 0
    margin = (total_op / total_rev) if total_rev else 0
    report_rate = float(member_df["weekly_report_done"].mean()) if not member_df.empty else 0
    gdc_mm_sum = float(member_df["gdc_mm"].sum()) if not member_df.empty else 0
    ai_rate = float(member_df["ai_used"].mean()) if not member_df.empty else 0

    c1,c2,c3,c4,c5,c6 = st.columns(6)
    c1.metric("총 매출(KRW)", f"{total_rev:,}")
    c2.metric("총 영업이익(KRW)", f"{total_op:,}")
    c3.metric("이익률", f"{margin*100:.1f}%")
    c4.metric("주간보고 완료율", f"{report_rate*100:.1f}%")
    c5.metric("GDC 총 MM", f"{gdc_mm_sum:.2f}")
    c6.metric("AI 사용률", f"{ai_rate*100:.1f}%")

def main():
    st.title("팀 성과관리 대시보드")

    weeks = get_available_weeks()
    default = 0
    year_week_labels = [f"{y}-W{w:02d}" for y,w in weeks]
    selected = st.sidebar.selectbox("주차 선택", year_week_labels, index=default)
    sel_idx = year_week_labels.index(selected)
    year, week = weeks[sel_idx]

    part_filter = st.sidebar.multiselect("파트 필터", [f"{i}번 파트" for i in range(1,8)], default=[f"{i}번 파트" for i in range(1,8)])
    tab1, tab2, tab3 = st.tabs(["파트 요약", "개인 요약", "추이/히트맵"])

    part_df = load_part_kpi(year, week)
    member_df = load_member_kpi(year, week)

    if part_filter:
        part_df = part_df[part_df["part_name"].isin(part_filter)]
        member_df = member_df[member_df["part_name"].isin(part_filter)]

    with tab1:
        st.subheader(f"파트 KPI 요약 — {year}-W{week:02d}")
        kpi_cards(part_df, member_df)

        colA, colB = st.columns(2)
        with colA:
            fig_rev = px.bar(part_df, x="part_name", y="revenue", title="파트별 매출", hover_data=["op_profit","op_margin"])
            st.plotly_chart(fig_rev, use_container_width=True)
        with colB:
            fig_op = px.bar(part_df, x="part_name", y="op_profit", title="파트별 영업이익", hover_data=["revenue","op_margin"])
            st.plotly_chart(fig_op, use_container_width=True)

        # Revenue vs OP scatter
        fig_sc = px.scatter(part_df, x="revenue", y="op_profit", text="part_name", title="매출 vs 영업이익 (파트 포지션)")
        fig_sc.update_traces(textposition="top center")
        st.plotly_chart(fig_sc, use_container_width=True)

        # Weekly report rate by part
        if not member_df.empty:
            rr = (member_df.groupby("part_name")["weekly_report_done"].mean().reset_index(name="weekly_report_rate"))
            fig_rr = px.bar(rr, x="part_name", y="weekly_report_rate", title="파트별 주간보고 완료율")
            fig_rr.update_yaxes(tickformat=".0%")
            st.plotly_chart(fig_rr, use_container_width=True)

    with tab2:
        st.subheader(f"개인 KPI — {year}-W{week:02d}")
        if member_df.empty:
            st.info("해당 주차에 개인 KPI 데이터가 없습니다. sample_data.sql을 넣거나 CSV import를 실행해 주세요.")
        else:
            # Summary table
            show = member_df.copy()
            show["weekly_report_done"] = show["weekly_report_done"].map({0:"N",1:"Y",False:"N",True:"Y"})
            show["gdc_used"] = show["gdc_used"].map({0:"N",1:"Y",False:"N",True:"Y"})
            show["ai_used"] = show["ai_used"].map({0:"N",1:"Y",False:"N",True:"Y"})
            st.dataframe(show[["part_name","name","weekly_report_done","gdc_used","gdc_mm","ai_used"]], use_container_width=True, hide_index=True)

            col1, col2 = st.columns(2)
            with col1:
                fig_box = px.box(member_df, x="part_name", y="gdc_mm", title="파트별 GDC MM 분포(개인)")
                st.plotly_chart(fig_box, use_container_width=True)
            with col2:
                # AI usage rate by part
                ai = (member_df.groupby("part_name")["ai_used"].mean().reset_index(name="ai_used_rate"))
                fig_ai = px.bar(ai, x="part_name", y="ai_used_rate", title="파트별 AI 사용률")
                fig_ai.update_yaxes(tickformat=".0%")
                st.plotly_chart(fig_ai, use_container_width=True)

    with tab3:
        st.subheader("주차별 추이 / 히트맵")
        st.caption("현재 DB에 적재된 주차 범위 내에서 히트맵을 그립니다.")
        if len(weeks) < 2:
            st.info("추이를 보려면 최소 2주치 데이터가 필요합니다.")
        else:
            # pick range
            labels = year_week_labels[::-1]  # oldest -> newest? Actually reversed; let's compute properly
            # build sorted ascending for range slider
            asc = sorted(weeks)
            asc_labels = [f"{y}-W{w:02d}" for y,w in asc]
            start_label, end_label = st.select_slider("기간 선택", options=asc_labels, value=(asc_labels[0], asc_labels[-1]))
            y_from, w_from = asc[asc_labels.index(start_label)]
            y_to, w_to = asc[asc_labels.index(end_label)]

            trend = load_member_trend(y_from, w_from, y_to, w_to)
            if trend.empty:
                st.info("선택 기간에 데이터가 없습니다.")
            else:
                trend["yw"] = trend.apply(lambda r: f"{int(r['year'])}-W{int(r['week']):02d}", axis=1)

                # Heatmap: part x week report rate
                rr = trend.groupby(["part_name","yw"])["weekly_report_done"].mean().reset_index()
                piv = rr.pivot(index="part_name", columns="yw", values="weekly_report_done").fillna(0)
                fig_hm = px.imshow(piv, aspect="auto", title="파트별 주간보고 완료율 히트맵", labels=dict(x="주차", y="파트", color="완료율"))
                st.plotly_chart(fig_hm, use_container_width=True)

                # Trend lines: total report/ai/gdc
                agg = trend.groupby("yw").agg(
                    report_rate=("weekly_report_done","mean"),
                    ai_rate=("ai_used","mean"),
                    gdc_mm_sum=("gdc_mm","sum"),
                ).reset_index()
                col1, col2 = st.columns(2)
                with col1:
                    fig_line = px.line(agg, x="yw", y=["report_rate","ai_rate"], title="주차별 주간보고율 & AI 사용률")
                    fig_line.update_yaxes(tickformat=".0%")
                    st.plotly_chart(fig_line, use_container_width=True)
                with col2:
                    fig_gdc = px.line(agg, x="yw", y="gdc_mm_sum", title="주차별 GDC 총 MM")
                    st.plotly_chart(fig_gdc, use_container_width=True)

if __name__ == "__main__":
    main()
