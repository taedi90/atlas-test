#!/bin/bash

# 1. 설정 및 인자 처리
MIGRATION_DIR="sql/common"
mkdir -p "$MIGRATION_DIR"

VERSION=${1:-"v1.0.0"}
DESCRIPTION=${2:-"new-migration"}
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# 2. 파일명 생성 (네이밍 규칙: {Timestamp}_{Version}_{Description}.sql)
FILENAME="${MIGRATION_DIR}/${TIMESTAMP}_${VERSION}_${DESCRIPTION}.sql"

# 3. 더미 SQL 내용 생성 (버전에 따라 간단한 예시 쿼리 삽입)
echo "Generating new migration: $FILENAME"

cat <<EOF > "$FILENAME"
-- Migration: $DESCRIPTION ($VERSION)
-- Created at: $(date)

-- Example SQL (Replace with your own)
CREATE TABLE IF NOT EXISTS test_table_${TIMESTAMP} (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
EOF

# 4. atlas.sum 파일 갱신
echo "Updating atlas.sum..."
if command -v atlas &> /dev/null; then
    atlas migrate hash --dir "file://$MIGRATION_DIR"
    echo "Successfully updated atlas.sum"
else
    echo "Error: 'atlas' CLI not found. Please install Atlas to update atlas.sum."
    exit 1
fi

echo "Done! You can now commit the new files."
