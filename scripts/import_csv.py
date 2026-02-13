import argparse
import pandas as pd
from sqlalchemy import text
from db import get_engine

def upsert_part(engine, year:int, week:int, csv_path:str):
    df = pd.read_csv(csv_path)
    required = {"part_id","revenue","op_profit"}
    if not required.issubset(set(df.columns)):
        raise ValueError(f"part csv must contain columns: {sorted(required)}")
    sql = text("""
    INSERT INTO part_kpi_weekly(year,week,part_id,revenue,op_profit)
    VALUES (:year,:week,:part_id,:revenue,:op_profit)
    ON DUPLICATE KEY UPDATE
      revenue=VALUES(revenue),
      op_profit=VALUES(op_profit)
    """)
    with engine.begin() as con:
        for _,r in df.iterrows():
            con.execute(sql, dict(year=year, week=week,
                                  part_id=int(r["part_id"]),
                                  revenue=int(r["revenue"]),
                                  op_profit=int(r["op_profit"])))

def upsert_member(engine, year:int, week:int, csv_path:str):
    df = pd.read_csv(csv_path)
    required = {"member_name","weekly_report_done","gdc_used","gdc_mm","ai_used"}
    if not required.issubset(set(df.columns)):
        raise ValueError(f"member csv must contain columns: {sorted(required)}")
    sql = text("""
    INSERT INTO member_kpi_weekly(year,week,member_id,weekly_report_done,gdc_used,gdc_mm,ai_used)
    SELECT :year,:week,m.member_id,:weekly_report_done,:gdc_used,:gdc_mm,:ai_used
    FROM member m
    WHERE m.name=:member_name
    ON DUPLICATE KEY UPDATE
      weekly_report_done=VALUES(weekly_report_done),
      gdc_used=VALUES(gdc_used),
      gdc_mm=VALUES(gdc_mm),
      ai_used=VALUES(ai_used)
    """)
    with engine.begin() as con:
        for _,r in df.iterrows():
            con.execute(sql, dict(
                year=year, week=week,
                member_name=str(r["member_name"]),
                weekly_report_done=int(r["weekly_report_done"]),
                gdc_used=int(r["gdc_used"]),
                gdc_mm=float(r["gdc_mm"]),
                ai_used=int(r["ai_used"]),
            ))

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--year", type=int, required=True)
    ap.add_argument("--week", type=int, required=True)
    ap.add_argument("--part", type=str, required=False)
    ap.add_argument("--member", type=str, required=False)
    args = ap.parse_args()

    engine = get_engine()
    if args.part:
        upsert_part(engine, args.year, args.week, args.part)
        print(f"Imported part KPI for {args.year}-W{args.week} from {args.part}")
    if args.member:
        upsert_member(engine, args.year, args.week, args.member)
        print(f"Imported member KPI for {args.year}-W{args.week} from {args.member}")

if __name__ == "__main__":
    main()
