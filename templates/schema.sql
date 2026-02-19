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

-- Finance ledger (누적 입력) : 월 단위로 관리(집계는 연 누적)
CREATE TABLE IF NOT EXISTS part_finance_entry (
  entry_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  year SMALLINT NOT NULL,
  month TINYINT NOT NULL, -- 1~12
  part_id INT NOT NULL,
  kpi_type ENUM('REVENUE','OP_PROFIT') NOT NULL,
  amount BIGINT NOT NULL,
  project_name VARCHAR(100) NOT NULL,
  source_comment VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(50) NOT NULL,
  FOREIGN KEY (part_id) REFERENCES part(part_id),
  INDEX idx_fin_ym_part (year, month, part_id),
  INDEX idx_fin_type (kpi_type)
) ENGINE=InnoDB;

-- GDC: 파트×월 MM (업서트)
CREATE TABLE IF NOT EXISTS part_gdc_monthly (
  year SMALLINT NOT NULL,
  month TINYINT NOT NULL, -- 1~12
  part_id INT NOT NULL,
  mm DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  comment VARCHAR(255) NOT NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by VARCHAR(50) NOT NULL,
  PRIMARY KEY (year, month, part_id),
  FOREIGN KEY (part_id) REFERENCES part(part_id),
  INDEX idx_gdc_y_part (year, part_id)
) ENGINE=InnoDB;

-- 개인성과: 월 단위 (업서트)
CREATE TABLE IF NOT EXISTS member_monthly_perf (
  year SMALLINT NOT NULL,
  month TINYINT NOT NULL, -- 1~12
  member_id INT NOT NULL,
  ai_used BOOLEAN NOT NULL DEFAULT FALSE,
  prep_lack_count INT NOT NULL DEFAULT 0,
  comment VARCHAR(255) NULL,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updated_by VARCHAR(50) NOT NULL,
  PRIMARY KEY (year, month, member_id),
  FOREIGN KEY (member_id) REFERENCES member(member_id),
  INDEX idx_mem_y (year, member_id)
) ENGINE=InnoDB;
