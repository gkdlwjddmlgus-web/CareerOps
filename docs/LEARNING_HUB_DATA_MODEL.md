# Learning Hub 데이터 모델 계획

기존 DB: Drift schemaVersion=1. 기존 8개 테이블은 변경/삭제하지 않는다.
추가 스키마 버전은 실제 구현 시 2로 올리고 onUpgrade에서 추가 테이블만 생성한다.
이 문서는 계획이며 아직 스키마를 변경하지 않았다.

| 테이블 | 주요 키·제약 | 보존 정책 |
|---|---|---|
| learning_resources | id PK, type/title/authors/normalized_isbn13/normalized_doi, reading_status, progress_unit, optional total | 노트와 분리 |
| resource_sources | id PK, resource_id FK CASCADE, UNIQUE(provider,external_id), original_url, 원본 ISBN/DOI | 동일 자료의 복수 제공처 |
| resource_progress | resource_id FK CASCADE, amount>=0, optional total, updated_at | 총량 없는 진도 허용 |
| resource_subject_links | 복합 PK(resource_id,subject_id), FK CASCADE | 기존 과목 삭제 시 연결만 해제 |
| learning_notes | id PK, nullable resource_id/subject_id FK SET NULL, title/body, created_at/updated_at | 자료·과목 삭제 후 노트 유지 |
| dev_projects | id PK, provider, normalized_owner/name, canonical_url, UNIQUE(provider,owner,name) | 공개 저장소만 |
| dev_activity_cache | id PK, project_id FK CASCADE, event_type, provider_event_id, occurred_at, UNIQUE(project_id,event_type,provider_event_id) | commit/issue/PR 분리 |
| api_cache | provider+request_key PK/UNIQUE, response_json, fetched_at, expires_at, etag | 토큰/개인 노트 제외 |
| api_sync_state | provider+scope PK, last_success_at, last_error_kind, next_allowed_at | 오류와 성공 시각 분리 |
| external_exports | note_id FK, provider, external_page_id, content_hash, exported_at, UNIQUE(note_id,provider) | 중복 외부 생성 방지 |

DOI/ISBN 고유 제약은 유효·정규화된 값에만 적용한다. NULL과 빈 문자열을 구분하고
제목 유사도만으로 UNIQUE를 만들지 않는다. 병합 시 출처 행을 옮기는 트랜잭션을 사용한다.
다른 판본/표현형은 정책에 따라 별도 자료로 유지한다.

자료 유형/상태/시간량 CHECK, 외래키, 날짜/UTC 시각 구분과 검색·최근 수정일 인덱스를 추가한다.
캐시는 영구 개인 데이터와 구분해 삭제할 수 있게 한다.

## 마이그레이션 검증

실제 v1 DB를 생성하고 과목·단원·세션·기업·이력·할 일·알림·타이머를 넣은 후 닫는다.
v2 코드로 다시 열어 모든 기존 값·FK·인덱스·신규 테이블을 확인한다.
재연결/재실행, 실패 롤백, 잘못된 참조 거부를 검증한다.
DB 삭제 후 재생성으로 테스트를 통과시키지 않는다.

## 백업 호환성

v0.1 JSON format version=1, schemaVersion=1, 8개 테이블을 지원한다.
v0.2 importer는 이전 백업을 별도 DTO로 검증하고 새 테이블 기본 상태로 변환한다.
기존 백업이 새 사용자 데이터를 덮는 범위는 복원 전에 명확히 표시한다.
안전 백업 후 트랜잭션 교체와 실패 롤백을 유지한다.
토큰·client secret·HTTP 인증 헤더는 JSON 백업에 포함하지 않는다.
