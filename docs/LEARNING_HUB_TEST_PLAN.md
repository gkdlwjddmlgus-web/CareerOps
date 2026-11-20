# Learning Hub 검증 계획

상태: Phase 0 계획. v0.2 구현/마이그레이션 테스트는 아직 NOT RUN.

## Unit

ISBN-10/13 체크섬·변환, DOI 접두/대소문자/URL 정규화,
제목 유사도 후보, 제공처 원본 보존, API 응답 누락·타입 오류,
commit/issue/PR 중복, 진도 단위·총량 없음, 학습 시간·주간 경계,
TTL·ETag·취소·타임아웃·401/403/404/429/5xx/JSON 실패,
Retry-After/backoff/지터/최대 재시도와 쓰기 멱등성.

## Widget

빈 자료실, 검색 부분 성공·오류·로딩·오프라인 캐시,
자료 상세/진도, 로컬 노트 편집·검색, GitHub 활동 유형,
미구성 API 안내, 미인증 Notion 상태, 출처·라이선스 표시,
큰 글자·작은 화면·다크 모드·뒤로 가기를 검증한다.
기능 UI는 저장 기술 없는 Repository 대역으로 실행한다.

## Integration

검색→저장→DB 재연결→조회, 과목 연결→노트,
GitHub 활동 캐시·중복, DOI 동일 자료 출처 통합,
네트워크 실패 시 캐시, 실제 v1 DB→v2 마이그레이션,
v0.1 JSON 복원 호환성과 원자성을 검증한다.

## 실제 API

공식 API의 소량 smoke 호출과 fixture/mock 테스트를 구분한다.
2026-11-20 감사: 공개 읽기 6개 제공처 200, Google Books 429, Notion NOT RUN.
이는 앱 Adapter·파싱·인증 성공을 뜻하지 않는다.
429를 유도하기 위한 부하 테스트는 하지 않는다.
Notion은 사용자에게 허가된 테스트 페이지에서 실제 내보내기와 external ID 재사용을 확인해야 PASS다.

## Device/Release

동일 applicationId·서명으로 v0.1→v0.2 업데이트 후 데이터 유지,
앱 강제 종료/재실행, 비행기 모드/복구, 알림·뒤로 가기·파일 선택,
OAuth 사용 시 인증 복귀, 큰 글자와 다크 모드.
실기기 미실행은 NOT RUN이며 APK 빌드만으로 PASS 처리하지 않는다.

## Phase별 커밋 게이트

`flutter pub get`, 코드 생성(스키마 변경 시), format check, analyze,
관련 테스트와 기존 전체 회귀, 민감정보 검사, diff 검토를 수행한다.
통과한 파일만 명시적으로 stage/commit하고 feature 원격 해시를 비교한다.
기존 v0.1 기준선이 미완성인 동안 Phase 1을 시작하지 않는다.
