-- Create DB (optional)
-- CREATE DATABASE perfdb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- USE perfdb;

CREATE TABLE IF NOT EXISTS part (
  part_id TINYINT PRIMARY KEY,
  part_name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member (
  member_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  part_id TINYINT NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  FOREIGN KEY (part_id) REFERENCES part(part_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS part_kpi_weekly (
  year SMALLINT NOT NULL,
  week TINYINT NOT NULL,
  part_id TINYINT NOT NULL,
  revenue BIGINT NOT NULL DEFAULT 0,
  op_profit BIGINT NOT NULL DEFAULT 0,
  PRIMARY KEY (year, week, part_id),
  FOREIGN KEY (part_id) REFERENCES part(part_id),
  INDEX idx_part_kpi_weekly_part (part_id),
  INDEX idx_part_kpi_weekly_yw (year, week)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member_kpi_weekly (
  year SMALLINT NOT NULL,
  week TINYINT NOT NULL,
  member_id INT NOT NULL,
  weekly_report_done BOOLEAN NOT NULL DEFAULT FALSE,
  gdc_used BOOLEAN NOT NULL DEFAULT FALSE,
  gdc_mm DECIMAL(6,2) NOT NULL DEFAULT 0.00,
  ai_used BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (year, week, member_id),
  FOREIGN KEY (member_id) REFERENCES member(member_id),
  INDEX idx_member_kpi_weekly_member (member_id),
  INDEX idx_member_kpi_weekly_yw (year, week)
) ENGINE=InnoDB;
