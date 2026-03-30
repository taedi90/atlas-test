-- Migration: new-migration (v1.0.0)
-- Created at: Mon Mar 30 16:40:30 KST 2026

-- Example SQL (Replace with your own)
CREATE TABLE IF NOT EXISTS test_table_20260330164030 (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
