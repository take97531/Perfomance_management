-- USE perfdb;

CREATE TABLE IF NOT EXISTS part (
  part_id INT AUTO_INCREMENT PRIMARY KEY,
  part_name VARCHAR(50) NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member (
  member_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  part_id INT NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  FOREIGN KEY (part_id) REFERENCES part(part_id),
  INDEX idx_member_part (part_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS part_finance_entry (
  entry_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  year SMALLINT NOT NULL,
  week TINYINT NOT NULL,
  part_id INT NOT NULL,
  kpi_type ENUM('REVENUE','OP_PROFIT') NOT NULL,
  amount BIGINT NOT NULL,
  project_name VARCHAR(100) NOT NULL,
  source_comment VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(50) NOT NULL,
  FOREIGN KEY (part_id) REFERENCES part(part_id),
  INDEX idx_fin_yw_part (year, week, part_id),
  INDEX idx_fin_type (kpi_type)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS part_gdc_wbs_entry (
  entry_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  year SMALLINT NOT NULL,
  week TINYINT NOT NULL,
  part_id INT NOT NULL,
  wbs_code VARCHAR(50) NOT NULL,
  wbs_name VARCHAR(100) NOT NULL,
  mm DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  comment VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(50) NOT NULL,
  FOREIGN KEY (part_id) REFERENCES part(part_id),
  INDEX idx_gdc_yw_part (year, week, part_id),
  INDEX idx_gdc_wbs (wbs_code)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS member_weekly_perf (
  year SMALLINT NOT NULL,
  week TINYINT NOT NULL,
  member_id INT NOT NULL,
  ai_used BOOLEAN NOT NULL DEFAULT FALSE,
  prep_lack_count INT NOT NULL DEFAULT 0,
  comment VARCHAR(255) NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by VARCHAR(50) NOT NULL,
  PRIMARY KEY (year, week, member_id),
  FOREIGN KEY (member_id) REFERENCES member(member_id),
  INDEX idx_mem_yw (year, week)
) ENGINE=InnoDB;
