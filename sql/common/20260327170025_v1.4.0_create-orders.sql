-- Migration: create-orders (v1.4.0)
-- Created at: Fri Mar 27 17:00:25 KST 2026

-- Example SQL (Replace with your own)
CREATE TABLE IF NOT EXISTS test_table_20260327170025 (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
