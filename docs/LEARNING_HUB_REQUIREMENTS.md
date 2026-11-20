# Learning Hub 0.2.0 요구사항 및 선행 조건

확인일: 2026-11-20 (Asia/Seoul).

## 저장소 감사 기준

실제 origin: https://github.com/gkdlwjddmlgus-web/CareerOps.git

- Phase 0 감사 시작 시 develop: `35d9a664751088d6a9220d9fc142c48086b6c3c6`.
- main: `47119f8c456722d216c82bccce4ae05a344f3bfa`.
- 감사 시 릴리스 태그 없음, 기존 릴리스 APK 없음.
- 작업 트리의 미커밋 변경은 이번 대화에서 작성한 v0.1 리포트·Repository 구조 변경·릴리스 설정이다. 삭제하거나 덮어쓰지 않는다.
- v0.1 최종 분석/회귀/서명 빌드와 Android 검증 상태를 기준선 로그에 먼저 확정한다.
- v0.1이 미완성인 동안 Learning Hub 구현 및 스키마 변경을 시작하지 않는다.

감사 후 보존한 v0.1 후보 기준 커밋: `72321ea4d9145c220bc2db5bf843a8da05db96b9`.
분석·11개 테스트·릴리스 빌드·서명 검증은 PASS. 설치/업데이트/실제 알림 등 기기 검증은 NOT RUN.
v0.1 정식 안정 태그와 main 반영을 보류하고, 이 feature 브랜치에서는 Phase 0 문서만 작성한다.
APK: versionName=0.1.0, code=1, minSdk=24, targetSdk=36, applicationId=com.careerops.planner.

## 유지할 기능

홈, 과목/단원, 재시작 가능한 타이머, 학습 기록, 기업/지원 이력,
캘린더, 알림, 주간 리포트, JSON 백업/복원과 하단 5개 탭을 보존한다.
applicationId `com.careerops.planner`와 전용 릴리스 서명키를 유지한다.

## v0.2 범위

학습 탭 하위 Learning Hub: 자료 검색/개인 자료실/읽기 상태·진도,
로컬 노트 CRUD와 검색, 공개 GitHub 활동 캐시, Stack Overflow 질문,
PyPI 정확한 패키지 조회, 논문 탐색, Notion 단방향 내보내기.

검색 API: Open Library·Google Books·Crossref·OpenAlex.
별도 책임 API: GitHub·Stack Exchange·PyPI·Notion.
검색 결과에는 제공처·원본 ID·유형·제목·저자·ISBN·DOI·URL·발행일·설명·표지를 보존한다.

DOI 정규화 일치 또는 ISBN-13 일치만 강한 중복 키로 사용한다.
ISBN-10은 검증 후 978 ISBN-13으로 변환한다. 제목/저자 유사도는 후보 표시만 한다.
판본과 제공처별 원본 출처는 보존한다.

읽기 상태: PLANNED/IN_PROGRESS/COMPLETED/ON_HOLD/DROPPED.
총 페이지가 없어도 등록할 수 있다. 진행 단위는 페이지/챕터/사용자 지정.
자료 삭제는 노트를 삭제하지 않고 연결만 해제한다.

GitHub commit/issue/PR은 별도 유형. Issue 응답의 pull_request 항목은 Issue 집계에서 제외한다.
활동 건수를 학습 시간·실력으로 변환하지 않는다. 공개 저장소만 지원한다.

Notion 미연결 상태에서도 모든 로컬 노트 기능이 동작해야 한다.
인증 성공·동기화 성공을 가짜 화면이나 빈 결과로 표현하지 않는다.

## 진행 순서와 검증 게이트

0. 저장소·기준선·API 감사와 문서. v0.1 미완성 항목 명시.
1. v0.1 안정 기준선 확보 후 feature/learning-hub-v0.2.0에서 HTTP/캐시/오류·스키마 마이그레이션.
2. 도서·자료실. 한 제공처 실패 시 부분 성공 보존.
3. 공개 GitHub 활동과 캐시·중복 방지.
4. Stack Exchange backoff와 PyPI 정확한 이름 조회.
5. Crossref/OpenAlex 논문·DOI 정규화와 출처 보존.
6. 사용자 인증이 확보된 Notion 내보내기. 미확보 시 BLOCKED/NOT RUN.
7. 실제 DB 기반 통합 리포트·오프라인·회귀.
8. 필수 검증 후 0.2.0 버전·서명 APK·브랜치 통합·태그/릴리스.

각 Phase의 포맷·분석·관련 테스트·기존 회귀를 통과한 파일만 명시적으로 커밋한다.
푸시 후 로컬/원격 해시를 비교한다. 보호 규칙 우회·강제 푸시·기존 태그 이동은 금지한다.
