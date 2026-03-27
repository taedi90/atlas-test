
## 개발 환경 및 요구사항
개발 결과물을 develop 브랜치에 병합하는 식으로 관리되고 있으며, develop merge 는 pr 을 통해서만 가능하다.
여러 사용자가 개발을 진행하면서 sql 변경 사항이 발생할 수 있는 구조이며, 이를 CI 단계에서 검증, 오류처리, (오류 해결) 이 되어야 한다.

## Atlas 구성
- 버전 기반 마이그레이션
- 선형 히스토리 유지

## 규칙
### 기본 규칙
- **SQL 파일은 절대 수정하거나 삭제하지 않고 항상 추가만 한다.** (Immutable Migrations)
- **네이밍 규칙**: `{Timestamp}_{Version}_{Description}.sql` 형식을 따른다.
  - 예: `20250320153000_v1.9.0_my-feature.sql`
- **Rollback 정책**: 기본적으로 기존 SQL의 롤백(삭제/수정)은 허용하지 않는다. 잘못된 변경이 발생한 경우, 이를 되돌리는 **새로운 SQL 마이그레이션을 추가**하여 해결한다. (Forward-only)
- **CI/CD 역할**: 파이프라인에서 데이터베이스에 직접 `apply`하지 않는다. 오직 마이그레이션 파일과 `atlas.sum`의 무결성을 검증하여 **Source of Truth**를 유지하는 역할만 수행한다.

### Conflict 해결
- 2개 이상의 PR이 동시에 진행되어 버전 충돌(Conflict)이 발생할 경우, **먼저 머지된 것을 기준**으로 한다.
- **Merge Queue 미사용 시 정책**:
  - GitHub 설정에서 **'Require branches to be up to date before merging'**을 강제한다.
  - `develop` 브랜치에 새로운 마이그레이션이 추가되면, 다른 PR 작성자는 반드시 자신의 브랜치에 최신 `develop`을 반영(Merge/Rebase)해야 한다.
  - 브랜치 업데이트 후 파일명 중복이나 순서 오류가 발견되면, 파일명을 수정하고 `./setup_test_data.sh` 또는 `atlas migrate hash`를 실행하여 `atlas.sum`을 반드시 갱신해야 한다.
  - 모든 수정을 마친 후 다시 CI 검증을 통과해야 머지가 가능하다.


## CI
### PR CI
- 기존 SQL 수정 / 삭제 | atlas.sum 만 단독 변경 등 기존 파일 수정 검사
- validate
- lint

### MERGE QUEUE
- validate
- lint


## 테스트 케이스
### 2개 PR 에서 동시에 sql 추가
merge queue 에서 conflict 발생 또는 변경 처리

### 기존 SQL 수정

### SQL - atlas.sum 무결정 검사 테스트


## 참고
- https://atlasgo.io/integrations/github-actions