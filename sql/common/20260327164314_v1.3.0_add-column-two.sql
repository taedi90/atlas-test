-- Migration: add-column-two (v1.3.0)
-- Created at: Fri Mar 27 16:43:14 KST 2026

-- Example SQL (Replace with your own)
CREATE TABLE IF NOT EXISTS test_table_20260327164314 (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
