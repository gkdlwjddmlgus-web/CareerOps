# Learning Hub 아키텍처 계획

상태: Phase 0 설계. Learning Hub 실행 코드·네트워크 호출·DB 확장은 아직 추가하지 않는다.

## 기존 앱 경계

기능별 domain 모델과 Repository 계약은 SQLite/HTTP 타입을 노출하지 않는다.
presentation은 Riverpod이 제공하는 계약만 사용한다.
data의 Local*Repository가 Drift 저장과 도메인 모델 매핑을 담당한다.
구체 구현 선택은 app/providers.dart의 composition root에서 수행한다.
테스트는 인터페이스 대역 주입과 실제 로컬 구현 계약 검증을 분리한다.

## 추가할 모듈

```text
features/learning_hub/
  domain/models/
  domain/repositories/
  domain/services/
  data/adapters/
  data/repositories/
  data/local/
  application/
  presentation/screens/
  presentation/widgets/
  presentation/providers/
core/api/       # v0.2 Phase 1에서 실제 사용 시 도입
core/security/  # 인증을 구현할 때 도입
```

ResourceSearchProvider, ResourceRepository, LearningNoteRepository,
DevelopmentActivityProvider, PackageMetadataProvider, TechnicalQuestionProvider,
NoteExportProvider를 책임별로 분리한다. 지원 capability와 오류를 명시한다.

도서/논문 검색 application 서비스는 제공처별 결과와 오류를 함께 반환한다.
한 제공처 실패로 다른 결과를 버리지 않는다. 오래된 검색 응답은 취소·세대 번호로 무시한다.
정규화와 중복 후보 판단은 순수 domain 서비스로 둔다.

## 네트워크·캐시

허용된 HTTPS 제공처별 Adapter만 요청을 만든다. UI에서 HTTP 클라이언트를 사용하지 않는다.
타임아웃·취소·응답 크기 제한, status별 오류, JSON 파싱 실패를 구분한다.
GET 등 멱등 요청만 제한적으로 재시도한다. Retry-After/Stack Exchange backoff와
GitHub reset 헤더를 우선한다. 지수 백오프+지터와 최대 시도 횟수를 적용한다.
Notion POST는 네트워크 불명확 실패 시 무작정 재시도하지 않고 외부 ID/콘텐츠 해시로 재조정한다.

캐시 키는 제공처+버전+정규화 질의. 토큰은 키/본문/로그/백업에서 제외한다.
TTL, 마지막 성공 시각, 오류, stale 표시를 분리한다. 화면 진입은 캐시 우선이며 전체 자동 재조회하지 않는다.
오프라인에서는 자료·진도·노트·기존 MVP 전부 로컬에서 동작한다.

## 인증

현재 GitHub 공개 API는 무인증. Git push 자격증명과 앱 API 인증은 별개다.
Google Books는 사용자의 프로젝트 설정과 제한된 키를 준비해야 한다.
Notion 개인 사용은 사용자 소유 internal connection 토큰+명시적으로 공유한 페이지를 우선 검토한다.
Android Keystore를 사용하는 안전한 저장소에 토큰을 보관하고 로그·JSON 백업에는 넣지 않는다.
공개 앱 OAuth의 client secret을 APK에 넣지 않는다. 백엔드가 필요한 방식을 구현하기 전 별도 구성을 확인한다.

## 데이터와 호환성

기존 스키마 1의 8개 테이블을 유지하고 onUpgrade에서 신규 테이블만 추가한다.
마이그레이션/복원은 원자적으로 처리하고 실패 시 기존 DB를 보존한다.
백업 format 버전과 DB schemaVersion을 분리하며 v0.1 JSON을 변환해 받아들일 계획이다.
Learning Hub가 기존 과목을 참조하더라도 study presentation이나 로컬 구현에 의존하지 않는다.

## 검증되지 않은 사항

Notion 실제 계정·페이지 권한, Google Books 키/할당량, Android 실기기 업데이트/알림은
별도 검증이 필요하다. 문서 검토·무인증 HTTP 성공을 인증·기기 테스트 성공으로 보지 않는다.
