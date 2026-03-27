-- Add email column
ALTER TABLE users ADD COLUMN email VARCHAR(255) AFTER name;
