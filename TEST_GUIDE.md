# Atlas 마이그레이션 CI/CD 테스트 가이드

이 문서는 원격 브랜치를 사용하여 동시에 여러 개의 마이그레이션 PR이 생성되었을 때의 충돌 해결 과정을 테스트하는 방법을 설명합니다.

## 테스트 시나리오: 2개 PR 동시 추가 및 충돌 해결

### 1단계: 초기 환경 설정 (Remote Push)
현재 로컬의 설정을 원격 저장소(`develop` 브랜치)에 반영합니다.
```bash
git checkout -b develop
git add .
git commit -m "docs: initial atlas setup and ci workflows"
git push origin develop
```

### 2단계: 첫 번째 작업자 (Feature A)
`feature/A` 브랜치에서 새로운 테이블을 추가하고 PR을 생성합니다.
```bash
git checkout develop
git checkout -b feature/A
./setup_test_data.sh v1.4.0 create-orders
git add .
git commit -m "feat: add orders table"
git push origin feature/A
```
*   **Action**: GitHub에서 `feature/A` -> `develop` PR을 생성합니다.

### 3단계: 두 번째 작업자 (Feature B)
`feature/B` 브랜치에서 (A의 존재를 모른 채) 다른 테이블을 추가하고 PR을 생성합니다.
```bash
git checkout develop
git checkout -b feature/B
./setup_test_data.sh v1.5.0 create-products
git add .
git commit -m "feat: add products table"
git push origin feature/B
```
*   **Action**: GitHub에서 `feature/B` -> `develop` PR을 생성합니다.

### 4단계: 첫 번째 PR 머지
*   **Action**: `feature/A` PR의 CI가 성공하면 `develop`으로 머지합니다.

### 5단계: 두 번째 PR의 충돌 확인 및 해결
`feature/A`가 머지된 후, `feature/B` PR은 `atlas.sum` 파일에서 Git 충돌이 발생하거나 "Out of date" 상태가 됩니다.

**해결 방법:**
1.  로컬에서 `develop`의 최신 상태를 가져옵니다.
    ```bash
    git checkout develop
    git pull origin develop
    ```
2.  `feature/B` 브랜치로 이동하여 `develop`을 머지합니다.
    ```bash
    git checkout feature/B
    git merge develop
    ```
3.  **Conflict 해결**: `atlas.sum` 파일의 충돌을 수동으로 해결(둘 다 남김)하거나, 아래 명령어로 해시를 재계산합니다.
    ```bash
    # 충돌 발생 시 atlas.sum을 무시하고 새로 생성하는 것이 가장 안전합니다.
    atlas migrate hash --dir "file://sql/common"
    ```
4.  갱신된 내용을 커밋하고 푸시합니다.
    ```bash
    git add .
    git commit -m "chore: resolve migration conflict and update hash"
    git push origin feature/B
    ```

### 6단계: 최종 확인
*   **Action**: `feature/B` PR의 CI가 다시 실행되어 성공하는지 확인한 후 머지합니다.
