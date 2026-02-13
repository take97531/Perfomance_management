INSERT INTO part(part_name, active) VALUES ('1번 파트',TRUE),('2번 파트',TRUE),('3번 파트',TRUE),('4번 파트',TRUE),('5번 파트',TRUE),('6번 파트',TRUE),('7번 파트',TRUE) ON DUPLICATE KEY UPDATE active=VALUES(active);\n-- members (fresh DB 기준)\nINSERT INTO member(name, part_id, active) VALUES ('구성원01', (SELECT part_id FROM part WHERE part_name='1번 파트' LIMIT 1), TRUE),('구성원02', (SELECT part_id FROM part WHERE part_name='2번 파트' LIMIT 1), TRUE),('구성원03', (SELECT part_id FROM part WHERE part_name='3번 파트' LIMIT 1), TRUE),('구성원04', (SELECT part_id FROM part WHERE part_name='4번 파트' LIMIT 1), TRUE),('구성원05', (SELECT part_id FROM part WHERE part_name='5번 파트' LIMIT 1), TRUE),('구성원06', (SELECT part_id FROM part WHERE part_name='6번 파트' LIMIT 1), TRUE),('구성원07', (SELECT part_id FROM part WHERE part_name='7번 파트' LIMIT 1), TRUE),('구성원08', (SELECT part_id FROM part WHERE part_name='1번 파트' LIMIT 1), TRUE),('구성원09', (SELECT part_id FROM part WHERE part_name='2번 파트' LIMIT 1), TRUE),('구성원10', (SELECT part_id FROM part WHERE part_name='3번 파트' LIMIT 1), TRUE),('구성원11', (SELECT part_id FROM part WHERE part_name='4번 파트' LIMIT 1), TRUE),('구성원12', (SELECT part_id FROM part WHERE part_name='5번 파트' LIMIT 1), TRUE),('구성원13', (SELECT part_id FROM part WHERE part_name='6번 파트' LIMIT 1), TRUE),('구성원14', (SELECT part_id FROM part WHERE part_name='7번 파트' LIMIT 1), TRUE),('구성원15', (SELECT part_id FROM part WHERE part_name='1번 파트' LIMIT 1), TRUE),('구성원16', (SELECT part_id FROM part WHERE part_name='2번 파트' LIMIT 1), TRUE),('구성원17', (SELECT part_id FROM part WHERE part_name='3번 파트' LIMIT 1), TRUE),('구성원18', (SELECT part_id FROM part WHERE part_name='4번 파트' LIMIT 1), TRUE),('구성원19', (SELECT part_id FROM part WHERE part_name='5번 파트' LIMIT 1), TRUE);\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',130000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',330000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',110000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',12000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-100','분석',13.11,'근거: WBS 집계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-200','개발',8.99,'근거: WBS 집계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-300','테스트',5.74,'근거: WBS 집계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',450000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',550000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',167000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',153000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-100','분석',17.23,'근거: WBS 집계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-200','개발',10.44,'근거: WBS 집계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-300','테스트',6.66,'근거: WBS 집계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',330000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',330000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',149000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',147000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-100','분석',6.03,'근거: WBS 집계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-200','개발',0.58,'근거: WBS 집계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-300','테스트',6.31,'근거: WBS 집계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',590000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',440000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',35000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',126000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-100','분석',10.48,'근거: WBS 집계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-200','개발',0.06,'근거: WBS 집계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-300','테스트',4.66,'근거: WBS 집계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',480000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',290000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',70000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',86000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-100','분석',16.06,'근거: WBS 집계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-200','개발',14.4,'근거: WBS 집계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-300','테스트',0.91,'근거: WBS 집계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',560000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',590000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',58000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',51000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-100','분석',6.46,'근거: WBS 집계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-200','개발',9.82,'근거: WBS 집계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-300','테스트',0.52,'근거: WBS 집계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',320000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'REVENUE',650000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',87000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,5,part_id,'OP_PROFIT',177000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-100','분석',4.6,'근거: WBS 집계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-200','개발',5.34,'근거: WBS 집계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,5,part_id,'WBS-300','테스트',13.31,'근거: WBS 집계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원01'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원02'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원03'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,0,2,NULL,'admin' FROM member WHERE name='구성원04'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원05'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원06'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원07'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원08'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원09'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원10'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원11'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원12'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원13'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원14'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원15'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원16'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원17'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원18'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,5,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원19'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',470000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',370000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',124000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',45000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-100','분석',16.36,'근거: WBS 집계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-200','개발',1.31,'근거: WBS 집계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-300','테스트',7.83,'근거: WBS 집계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',180000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',120000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',70000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',17000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-100','분석',9.64,'근거: WBS 집계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-200','개발',9.25,'근거: WBS 집계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-300','테스트',11.49,'근거: WBS 집계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',320000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',420000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',148000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',114000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-100','분석',0.03,'근거: WBS 집계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-200','개발',15.04,'근거: WBS 집계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-300','테스트',13.86,'근거: WBS 집계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',400000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',230000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',38000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',143000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-100','분석',6.03,'근거: WBS 집계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-200','개발',4.32,'근거: WBS 집계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-300','테스트',9.45,'근거: WBS 집계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',490000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',420000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',138000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',144000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-100','분석',16.46,'근거: WBS 집계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-200','개발',12.11,'근거: WBS 집계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-300','테스트',11.6,'근거: WBS 집계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',300000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',260000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',41000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',115000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-100','분석',11.94,'근거: WBS 집계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-200','개발',16.06,'근거: WBS 집계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-300','테스트',15.91,'근거: WBS 집계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',200000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'REVENUE',290000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',74000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,6,part_id,'OP_PROFIT',65000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-100','분석',6.89,'근거: WBS 집계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-200','개발',0.91,'근거: WBS 집계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,6,part_id,'WBS-300','테스트',17.28,'근거: WBS 집계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원01'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원02'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원03'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,1,2,NULL,'admin' FROM member WHERE name='구성원04'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원05'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원06'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,0,2,NULL,'admin' FROM member WHERE name='구성원07'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,0,2,NULL,'admin' FROM member WHERE name='구성원08'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원09'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,1,2,NULL,'admin' FROM member WHERE name='구성원10'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,0,2,NULL,'admin' FROM member WHERE name='구성원11'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원12'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원13'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원14'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원15'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원16'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원17'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원18'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,6,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원19'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',210000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',200000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',153000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',151000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-100','분석',12.0,'근거: WBS 집계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-200','개발',16.72,'근거: WBS 집계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-300','테스트',8.87,'근거: WBS 집계','admin' FROM part WHERE part_name='1번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',390000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',490000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',136000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',59000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-100','분석',13.07,'근거: WBS 집계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-200','개발',1.73,'근거: WBS 집계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-300','테스트',2.99,'근거: WBS 집계','admin' FROM part WHERE part_name='2번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',240000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',690000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',119000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',126000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-100','분석',15.91,'근거: WBS 집계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-200','개발',1.24,'근거: WBS 집계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-300','테스트',0.64,'근거: WBS 집계','admin' FROM part WHERE part_name='3번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',160000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',190000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',97000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',116000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-100','분석',14.99,'근거: WBS 집계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-200','개발',10.61,'근거: WBS 집계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-300','테스트',11.92,'근거: WBS 집계','admin' FROM part WHERE part_name='4번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',100000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',590000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',92000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',111000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-100','분석',11.54,'근거: WBS 집계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-200','개발',7.48,'근거: WBS 집계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-300','테스트',4.69,'근거: WBS 집계','admin' FROM part WHERE part_name='5번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',130000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',570000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',132000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',157000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-100','분석',6.26,'근거: WBS 집계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-200','개발',3.13,'근거: WBS 집계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-300','테스트',15.22,'근거: WBS 집계','admin' FROM part WHERE part_name='6번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',510000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'REVENUE',580000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',42000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_finance_entry(year,week,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,7,part_id,'OP_PROFIT',134000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-100','분석',8.86,'근거: WBS 집계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-200','개발',8.03,'근거: WBS 집계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO part_gdc_wbs_entry(year,week,part_id,wbs_code,wbs_name,mm,comment,created_by)
SELECT 2026,7,part_id,'WBS-300','테스트',10.12,'근거: WBS 집계','admin' FROM part WHERE part_name='7번 파트';\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원01'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,2,NULL,'admin' FROM member WHERE name='구성원02'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원03'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원04'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원05'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원06'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,2,NULL,'admin' FROM member WHERE name='구성원07'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원08'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원09'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원10'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원11'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원12'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원13'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원14'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원15'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원16'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원17'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원18'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\nINSERT INTO member_weekly_perf(year,week,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,7,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원19'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);\n