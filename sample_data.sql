INSERT INTO part(part_name, active) VALUES ('1번 파트',TRUE),('2번 파트',TRUE),('3번 파트',TRUE),('4번 파트',TRUE),('5번 파트',TRUE),('6번 파트',TRUE),('7번 파트',TRUE) ON DUPLICATE KEY UPDATE active=VALUES(active);
INSERT INTO member(name, part_id, active) VALUES ('구성원01', (SELECT part_id FROM part WHERE part_name='1번 파트' LIMIT 1), TRUE),('구성원02', (SELECT part_id FROM part WHERE part_name='2번 파트' LIMIT 1), TRUE),('구성원03', (SELECT part_id FROM part WHERE part_name='3번 파트' LIMIT 1), TRUE),('구성원04', (SELECT part_id FROM part WHERE part_name='4번 파트' LIMIT 1), TRUE),('구성원05', (SELECT part_id FROM part WHERE part_name='5번 파트' LIMIT 1), TRUE),('구성원06', (SELECT part_id FROM part WHERE part_name='6번 파트' LIMIT 1), TRUE),('구성원07', (SELECT part_id FROM part WHERE part_name='7번 파트' LIMIT 1), TRUE),('구성원08', (SELECT part_id FROM part WHERE part_name='1번 파트' LIMIT 1), TRUE),('구성원09', (SELECT part_id FROM part WHERE part_name='2번 파트' LIMIT 1), TRUE),('구성원10', (SELECT part_id FROM part WHERE part_name='3번 파트' LIMIT 1), TRUE),('구성원11', (SELECT part_id FROM part WHERE part_name='4번 파트' LIMIT 1), TRUE),('구성원12', (SELECT part_id FROM part WHERE part_name='5번 파트' LIMIT 1), TRUE),('구성원13', (SELECT part_id FROM part WHERE part_name='6번 파트' LIMIT 1), TRUE),('구성원14', (SELECT part_id FROM part WHERE part_name='7번 파트' LIMIT 1), TRUE),('구성원15', (SELECT part_id FROM part WHERE part_name='1번 파트' LIMIT 1), TRUE),('구성원16', (SELECT part_id FROM part WHERE part_name='2번 파트' LIMIT 1), TRUE),('구성원17', (SELECT part_id FROM part WHERE part_name='3번 파트' LIMIT 1), TRUE),('구성원18', (SELECT part_id FROM part WHERE part_name='4번 파트' LIMIT 1), TRUE),('구성원19', (SELECT part_id FROM part WHERE part_name='5번 파트' LIMIT 1), TRUE);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',160000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='1번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',300000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='1번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',61000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='1번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',61000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='1번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,1,part_id,13.64,'근거: 월간집계','admin' FROM part WHERE part_name='1번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',470000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='2번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',580000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='2번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',133000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='2번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',113000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='2번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,1,part_id,27.24,'근거: 월간집계','admin' FROM part WHERE part_name='2번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',320000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='3번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',510000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='3번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',75000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='3번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',39000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='3번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,1,part_id,2.58,'근거: 월간집계','admin' FROM part WHERE part_name='3번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',360000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='4번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',270000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='4번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',143000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='4번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',12000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='4번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,1,part_id,15.71,'근거: 월간집계','admin' FROM part WHERE part_name='4번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',490000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='5번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',130000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='5번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',62000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='5번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',45000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='5번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,1,part_id,26.39,'근거: 월간집계','admin' FROM part WHERE part_name='5번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',590000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='6번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',490000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='6번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',76000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='6번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',100000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='6번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,1,part_id,38.84,'근거: 월간집계','admin' FROM part WHERE part_name='6번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',290000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='7번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'REVENUE',190000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='7번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',51000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='7번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,1,part_id,'OP_PROFIT',78000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='7번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,1,part_id,28.0,'근거: 월간집계','admin' FROM part WHERE part_name='7번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원01'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원02'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원03'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원04'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원05'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원06'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원07'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원08'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원09'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원10'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원11'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,0,2,NULL,'admin' FROM member WHERE name='구성원12'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원13'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원14'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,0,2,NULL,'admin' FROM member WHERE name='구성원15'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,0,2,NULL,'admin' FROM member WHERE name='구성원16'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원17'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원18'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,1,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원19'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',290000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='1번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',350000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='1번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',112000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='1번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',96000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='1번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,2,part_id,4.16,'근거: 월간집계','admin' FROM part WHERE part_name='1번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',200000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='2번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',390000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='2번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',142000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='2번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',94000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='2번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,2,part_id,39.91,'근거: 월간집계','admin' FROM part WHERE part_name='2번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',540000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='3번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',330000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='3번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',95000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='3번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',48000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='3번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,2,part_id,32.53,'근거: 월간집계','admin' FROM part WHERE part_name='3번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',350000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='4번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',330000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='4번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',86000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='4번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',145000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='4번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,2,part_id,3.06,'근거: 월간집계','admin' FROM part WHERE part_name='4번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',470000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='5번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',530000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='5번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',14000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='5번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',45000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='5번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,2,part_id,39.22,'근거: 월간집계','admin' FROM part WHERE part_name='5번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',360000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='6번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',410000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='6번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',18000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='6번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',38000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='6번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,2,part_id,14.93,'근거: 월간집계','admin' FROM part WHERE part_name='6번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',260000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='7번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'REVENUE',120000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='7번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',119000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='7번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,2,part_id,'OP_PROFIT',99000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='7번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,2,part_id,18.76,'근거: 월간집계','admin' FROM part WHERE part_name='7번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원01'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원02'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,0,1,NULL,'admin' FROM member WHERE name='구성원03'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원04'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,0,2,NULL,'admin' FROM member WHERE name='구성원05'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원06'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,1,3,NULL,'admin' FROM member WHERE name='구성원07'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,0,3,NULL,'admin' FROM member WHERE name='구성원08'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,1,3,NULL,'admin' FROM member WHERE name='구성원09'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원10'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원11'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,0,2,NULL,'admin' FROM member WHERE name='구성원12'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원13'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원14'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원15'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원16'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,0,3,NULL,'admin' FROM member WHERE name='구성원17'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,0,2,NULL,'admin' FROM member WHERE name='구성원18'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,2,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원19'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',190000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='1번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',150000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='1번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',83000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='1번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',112000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='1번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,3,part_id,37.12,'근거: 월간집계','admin' FROM part WHERE part_name='1번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',260000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='2번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',340000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='2번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',141000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='2번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',108000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='2번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,3,part_id,8.87,'근거: 월간집계','admin' FROM part WHERE part_name='2번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',410000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='3번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',370000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='3번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',147000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='3번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',136000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='3번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,3,part_id,24.97,'근거: 월간집계','admin' FROM part WHERE part_name='3번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',490000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='4번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',330000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='4번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',78000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='4번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',108000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='4번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,3,part_id,31.25,'근거: 월간집계','admin' FROM part WHERE part_name='4번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',170000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='5번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',340000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='5번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',40000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='5번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',45000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='5번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,3,part_id,16.33,'근거: 월간집계','admin' FROM part WHERE part_name='5번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',510000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='6번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',560000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='6번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',24000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='6번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',43000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='6번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,3,part_id,38.7,'근거: 월간집계','admin' FROM part WHERE part_name='6번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',400000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='7번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'REVENUE',360000000,'프로젝트A','근거: 계약/정산','admin' FROM part WHERE part_name='7번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',105000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='7번 파트';
INSERT INTO part_finance_entry(year,month,part_id,kpi_type,amount,project_name,source_comment,created_by)
SELECT 2026,3,part_id,'OP_PROFIT',121000000,'프로젝트A','근거: 손익계','admin' FROM part WHERE part_name='7번 파트';
INSERT INTO part_gdc_monthly(year,month,part_id,mm,comment,updated_by)
SELECT 2026,3,part_id,34.02,'근거: 월간집계','admin' FROM part WHERE part_name='7번 파트'
ON DUPLICATE KEY UPDATE mm=VALUES(mm), comment=VALUES(comment), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,1,2,NULL,'admin' FROM member WHERE name='구성원01'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원02'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원03'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,1,3,NULL,'admin' FROM member WHERE name='구성원04'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,0,2,NULL,'admin' FROM member WHERE name='구성원05'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원06'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원07'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원08'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원09'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원10'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,0,3,NULL,'admin' FROM member WHERE name='구성원11'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,0,2,NULL,'admin' FROM member WHERE name='구성원12'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,1,3,NULL,'admin' FROM member WHERE name='구성원13'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원14'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원15'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,1,3,NULL,'admin' FROM member WHERE name='구성원16'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,1,1,NULL,'admin' FROM member WHERE name='구성원17'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,1,0,NULL,'admin' FROM member WHERE name='구성원18'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
INSERT INTO member_monthly_perf(year,month,member_id,ai_used,prep_lack_count,comment,updated_by)
SELECT 2026,3,member_id,0,0,NULL,'admin' FROM member WHERE name='구성원19'
ON DUPLICATE KEY UPDATE ai_used=VALUES(ai_used), prep_lack_count=VALUES(prep_lack_count), updated_by=VALUES(updated_by);
