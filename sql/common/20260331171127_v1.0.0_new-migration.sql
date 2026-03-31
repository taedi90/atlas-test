-- Migration: new-migration (v1.0.0)
-- Created at: Tue Mar 31 17:11:27 KST 2026

-- Example SQL (Replace with your own)
CREATE TABLE IF NOT EXISTS test_table_20260331171127 (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
