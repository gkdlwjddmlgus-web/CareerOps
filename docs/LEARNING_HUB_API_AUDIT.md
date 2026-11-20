# 8개 API 감사

확인일: 2026-11-20, Asia/Seoul. 문서 확인과 HTTP 호출은 구분한다.
기본 UA: `CareerOps/0.2.0 (+https://github.com/gkdlwjddmlgus-web/CareerOps)`.
기존 Git 인증정보는 앱 API 호출에 사용하지 않았다. 계정 생성·결제·Notion 쓰기는 하지 않았다.
공개 메타데이터의 소량 읽기 호출만 수행했다. 아래는 앱 Adapter 구현 성공을 의미하지 않는다.

| API | 실제 읽기 호출 | HTTP | 앱 구현 | 인증 테스트 |
|---|---|---:|---|---|
| Open Library | search.json, 1개 결과 | 200 | NOT STARTED | 공개 조회 무인증 |
| Google Books | volumes ISBN 조회, 1개 | 429 | NOT STARTED | 프로젝트 키 없음 |
| GitHub | 현재 공개 저장소 메타데이터 | 200 | NOT STARTED | 공개 조회 무인증 |
| Stack Exchange | Stack Overflow 질문 검색, 1개 | 200 | NOT STARTED | 공개 조회 무인증 |
| PyPI | requests 정확한 이름 JSON | 200 | NOT STARTED | 공개 조회 무인증 |
| Crossref | 논문 검색, 1개 | 200 | NOT STARTED | 공개 조회 무인증 |
| OpenAlex | works 검색, 1개 | 200 | NOT STARTED | 공개 조회 무인증 |
| Notion | 실행하지 않음 | NOT RUN | NOT STARTED | BLOCKED: 사용자 토큰/공유 페이지 미확보 |

실제 호출 시각: 약 14:54 KST. 토큰/노트/개인 검색어는 요청하지 않았다.

## Open Library

[API·호출 제한](https://openlibrary.org/developers/api), [라이선스](https://openlibrary.org/developers/licensing).
공개 검색·메타데이터는 인증 없이 조회한다. 기본 1req/s, 연락처를 포함해 식별한 요청은 3req/s 규칙.
앱은 UA를 보내고 기본 1req/s 이하, 캐시 우선으로 설계한다. 대량 수집/HTML 스크래핑은 구현하지 않는다.
Internet Archive가 신규 독점권을 주장하지 않더라도 표지·설명에 제3자 권리가 있을 수 있다.
출처/원문 링크를 보존하고 불필요한 본문 복제를 피한다.
검색어·IP가 외부 제공처에 전달된다. 유료 기능·결제를 추가하지 않는다.
상태: 소량 읽기 200. 앱 파서/캐시/오프라인 테스트 NOT RUN.

## Google Books

[이용·식별 방식](https://developers.google.com/books/docs/v1/using), [약관](https://developers.google.com/books/terms).
공개 데이터에도 공식 지침상 프로젝트 식별용 API key 또는 OAuth token이 필요하다.
개인 사용 MVP는 공개 volumes 읽기만 계획하며 사용자 서재 OAuth는 범위 밖이다.
이번 무키 호출은 429. 이를 200이나 지원 불가 빈 목록으로 처리하지 않는다.
프로젝트별 할당량은 키가 없어 확인하지 못했다. 키·제한·API 활성화 확인 후 실호출을 다시 검증한다.
책 제목/저자/ISBN 질의와 IP가 전송된다. 출처·링크·콘텐츠 삭제 요청 및 Google 약관을 준수한다.
비용/할당량은 사용자 프로젝트 설정으로 관리하며 과금 활성화나 계정 생성은 하지 않는다.
상태: 429 확인, 키 기반 검증 BLOCKED. Open Library 부분 성공을 보존할 설계.

## GitHub REST

[호출 제한](https://docs.github.com/en/rest/using-the-rest-api/rate-limits-for-the-rest-api),
[버전](https://docs.github.com/en/rest/about-the-rest-api/api-versions),
[API 약관](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service#h-api-terms).
공개 저장소 읽기는 무인증. 기본 IP당 60req/h, 검색은 별도 제한.
UA, `Accept: application/vnd.github+json`, 검증할 명시 버전 `X-GitHub-Api-Version: 2026-03-10`을 사용한다.
실호출 200, 응답의 remaining=59를 확인했다. 기존 호출은 기본 버전이며 새 명시 버전 파서 검증은 별도다.
reset/remaining·Retry-After 및 403/429를 처리하고 캐시/조건부 요청을 적용한다.
Issue 응답에 PR이 포함될 수 있어 분리해야 한다. 작성자·내용·원본 링크를 보존하고 저장소 라이선스와 API 약관을 구분한다.
저장소 식별자/IP가 전송되며 커밋 이메일 등 불필요한 개인정보는 저장하지 않는다.
앱 토큰/유료 기능/비공개 접근 없음. Git push 자격증명과 완전히 별개다.

## Stack Exchange

[API](https://api.stackexchange.com/docs), [throttle](https://api.stackexchange.com/docs/throttle),
[콘텐츠 라이선스](https://stackoverflow.com/help/licensing).
공개 질문 검색은 무인증 가능. 키·사용자 토큰 구성에 따라 quota가 달라지므로 quota_remaining을 읽는다.
동일 의미 질의는 1분보다 자주 반복하지 않고 모든 응답의 backoff 초를 준수한다.
IP당 30req/s 초과는 금지 수준으로 취급하며 앱은 훨씬 보수적으로 제한한다.
Accept JSON과 식별 UA, site=stackoverflow. 질문 메타데이터만 저장하고 전체 답변을 대량 복제하지 않는다.
질문 작성자·원문 링크·출처를 표시한다. 기여 시기에 따라 CC BY-SA 2.5/3.0/4.0이 적용된다.
검색어/IP 외 전송 없음. 유료 서비스 연동 없음.
상태: 무인증 200. backoff/429는 mock으로 검증할 예정이며 유도 호출은 하지 않았다.

## PyPI

[JSON API](https://docs.pypi.org/api/json/), [캐시/정책](https://docs.pypi.org/api/).
`GET /pypi/{project}/json` 정확한 이름 조회를 사용하며 범용 검색 API를 가정하지 않는다.
프로젝트 summary/version/requires_python/URLs와 릴리스 메타데이터를 사용한다.
공식 정책은 JSON/Index CDN 캐시와 ETag 존중을 권장한다. 숫자형 공통 JSON 제한을 임의로 정하지 않는다.
식별 UA/Accept JSON, 순차 요청·ETag·TTL을 사용하고 HTML 스크래핑을 구현하지 않는다.
프로젝트별 설명/코드/배포물 라이선스는 서로 다르다. 설명 전문·배포물은 저장하지 않고 공식 프로젝트 링크를 표시한다.
정확한 패키지명/IP가 전송된다. 패키지를 설치하거나 사용자 프로젝트 버전을 읽지 않는다.
상태: requests 조회 200. 설치 버전과 원격 최신 버전을 별개로 표시할 계획.

## Crossref

[REST](https://www.crossref.org/documentation/retrieve-metadata/rest-api/),
[접근·제한](https://www.crossref.org/documentation/retrieve-metadata/rest-api/access-and-authentication).
공개 메타데이터 조회는 회원가입/토큰 없이 가능. 연락처를 제공하는 polite pool과 유료 Plus를 구분한다.
검색·단건 등 요청 유형별 한도가 달라질 수 있어 헤더를 우선한다.
이번 공개 목록 호출의 실제 헤더: limit=1, interval=1s, concurrency=1. 고정 5req/s로 가정하지 않는다.
UA/Accept JSON, 선택적 실제 mailto만 허용한다. 연락처를 임의로 만들어 보내지 않았다.
대부분 메타데이터는 자유 이용 가능하지만 초록은 별도 저작권이 있을 수 있어 전문 복제를 피한다.
DOI/출처/URL을 보존한다. 검색어/IP가 전송되며 유료 Plus·과금은 도입하지 않는다.
상태: 검색/소량 목록 200. DOI 중복·파싱은 구현 후 검증.

## OpenAlex

[API](https://help.openalex.org/api/), [인증·호출 제한](https://help.openalex.org/api/authentication/).
현재 문서는 기본 조회의 무키 사용을 허용하고, 무료 키로 예산·처리량을 늘리는 방식을 설명한다.
키 없는 현재 제한은 IP 기준이며 문서상 기본 10req/s, 복잡한 검색에는 더 낮은 제한이 있다.
실제 앱은 1req/s 이하로 보수적으로 시작하고 남은 예산·Retry-After·일일 제한을 처리한다.
유료/선불 사용은 자동 활성화하지 않는다. 키는 사용자 설정 없이는 생성하지 않는다.
Accept JSON/UA를 사용하며 도입 시 조건별 API key/Bearer 지원을 안전한 저장소와 연결한다.
메타데이터 CC0이며 외부 링크의 논문 전문 권리와 별개다. 인용 수를 품질 점수로 바꾸지 않는다.
상태: 무키 검색 200, remaining=990 관찰. 이 값을 보편적 일일 한도로 해석하지 않는다.

## Notion

[인증](https://developers.notion.com/guides/authorization/overview),
[호출 제한](https://developers.notion.com/reference/request-limits).
개인 사용은 사용자가 소유한 internal connection 토큰과 명시적으로 공유한 페이지를 우선 검토한다.
공개 OAuth의 client secret은 APK에 넣지 않는다. 토큰은 Android Keystore 기반 저장소에 보관하고 백업/로그에서 제외한다.
`Authorization: Bearer …`, `Notion-Version: 2026-03-11`, JSON Content-Type을 공식 문서와 함께 검증한다.
현재 문서는 일반 플랜 connection당 180req/min, Business/Enterprise 600req/min 및 별도 workspace/endpoint 제한을 설명한다.
429/529의 Retry-After를 존중하고 비멱등 쓰기의 자동 재시도를 피한다.
사용자 노트가 외부 계정에 전송되므로 사용자가 내보낼 노트/대상을 명시한다. 무료 workspace 제한·계정 요금은 별도로 확인한다.
상태: 토큰/페이지 권한 미확보, 실제 인증/내보내기 NOT RUN/BLOCKED. 연결 성공을 표시하지 않는다.
