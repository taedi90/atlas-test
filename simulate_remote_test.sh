#!/bin/bash

# 시나리오 시뮬레이션: 두 개의 피처 브랜치 동시 생성
set -e

echo "=== Starting Test Simulation ==="

# 1. develop 브랜치 베이스 커밋 (기존 변경사항 포함)
echo "Setting up 'develop' branch..."
git checkout -b develop || git checkout develop
git add .
git commit -m "initial setup for atlas test" --allow-empty
# git push origin develop  # (필요 시 주석 해제)

# 2. feature/A 브랜치 생성 및 마이그레이션 추가
echo "Creating 'feature/A'..."
git checkout develop
git checkout -b feature/A
./setup_test_data.sh v1.4.0 create-orders
git add .
git commit -m "feat: add orders table"
# git push origin feature/A # (필요 시 주석 해제)

# 3. feature/B 브랜치 생성 및 마이그레이션 추가
echo "Creating 'feature/B'..."
git checkout develop
git checkout -b feature/B
sleep 2 # 타임스탬프 중복 방지
./setup_test_data.sh v1.5.0 create-products
git add .
git commit -m "feat: add products table"
# git push origin feature/B # (필요 시 주석 해제)

echo "=== Test Branches Created! ==="
echo "Branches: feature/A, feature/B"
echo "Instructions:"
echo "1. Push both branches to your remote."
echo "2. Create PRs for both to 'develop'."
echo "3. Follow the steps in TEST_GUIDE.md to resolve conflicts."
