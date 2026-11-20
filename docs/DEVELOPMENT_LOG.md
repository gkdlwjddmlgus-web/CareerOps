# 개발 로그

## 2026-11-20 — Phase 1 진행 중

- 저장소 복제, 기존 main의 `date` 파일 보존. 기준 커밋 `47119f8`.
- 로컬 develop 생성, origin URL 확인.
- GitHub 연결 도구: pull/push/admin 권한 확인.
- 초기 셸 DNS 실패 후 네트워크 승인으로 clone 성공.
- 로컬 gh 인증 상태 실패. Git credential manager를 사용한 develop push dry-run은 성공.
- Flutter/Dart/Java PATH 미검출, Android SDK 기본 경로 미검출.
- 공식 Flutter stable 3.50.1 / Dart 3.14.0 확인, 작업 폴더에 SDK 설치 진행.
- SDK checkout 긴 경로 오류: 해당 SDK 저장소에 core.longpaths 설정 후 restore.
- 검증 명령 및 결과는 실제 실행 후 추가한다. 현재 분석/테스트/APK: NOT RUN.

### Phase 1 검증 완료

- Flutter 3.50.1 / Dart 3.14.0 실제 실행 확인.
- Flutter doctor: Android toolchain PASS. 실기기 없음. Visual Studio 미설치(Windows 앱은 범위 밖).
- Flutter 초기화 시 전체 태그 조회 지연을 진단하고 해당 조회 프로세스만 중단, --no-version-check 사용.
- `flutter create --platforms android --org com.careerops --project-name careerops --no-pub .`: PASS.
- applicationId/namespace: com.careerops.planner.
- `flutter pub get`: PASS. pubspec.lock 포함.
- `dart run build_runner build`: PASS, 223초, 생성 출력 16개.
- 최초 테스트는 생성 완료 전 실행해 FAIL. 생성 완료 후 재실행 PASS.
- 최초 analyze: Material deprecated 및 Drift DSL recursive getter 안내. Material 공식 권장 패키지로 전환하고 Drift DSL 경고 사유 명시.
- `dart format --output=none --set-exit-if-changed lib test`: PASS, 8개 파일 변경 없음.
- `flutter analyze`: PASS, No issues found (35.7초).
- `flutter test`: PASS, 3개(DB 초기화/외래키·CHECK 제약/5개 탭과 설정 이동).
- `git diff --check`: PASS.
- APK 및 실기기 검증: NOT RUN (후속 Phase).

## Phase 2 — 할 일 및 일정 완료

- 할 일 CRUD, 유형·우선순위·예정일·마감 시각, 완료 토글 구현.
- 홈의 오늘 목록/이전 날짜 미완료, 완료 수, 우선순위 정렬.
- 월간 캘린더 선택 날짜 조회, 사용자 지정 날짜로 명시적 이월.
- 홈과 캘린더는 동일 tasks 스트림을 사용한다.
- 신규: core/utils/dates.dart, core/widgets/common.dart, features/tasks/*, features/home/home_screen.dart, features/calendar/calendar_screen.dart, test/database/task_test.dart.
- 수정: app/router.dart, test/widget/navigation_test.dart. 삭제 없음.
- 최초 analyze 스타일 안내 3건을 수정.
- dart format: PASS. flutter analyze: PASS(No issues found, 27.6초).
- flutter test: PASS(4개). 파일 DB 재연결·정렬·날짜 보존·명시적 이월·홈/캘린더 데이터 일치 검증.
- 주간 학습 시간/채용 마감 목록은 해당 데이터 기능이 추가되는 Phase 3/4에서 홈에 연결한다.

## Phase 3 — 학습 관리 완료

- 과목/단원 CRUD, 단원 완료 수, 목표·누적 시간, 최근 학습 기록, 수동 기록.
- Idle → Running → Paused → Completed → 저장. active_timers의 단일 행으로 재시작 복구.
- Running은 저장된 구간 시작 시각과 경과 초를 합산. Paused 시간은 제외.
- Completed의 running_since는 종료 시각으로 고정해 저장 지연을 기록에 포함하지 않는다.
- 세션 삽입과 타이머 삭제는 트랜잭션. 중복 저장은 추가 세션을 만들지 않는다.
- 학습 이력이 있는 과목 삭제는 FK RESTRICT로 차단한다.
- 홈에 이번 주 누적 학습 시간 연결(지역 주간 경계, 월요일 시작).
- 신규: features/study/study_repository.dart, study_screen.dart, test/database/study_test.dart.
- 수정: router.dart, home_screen.dart, navigation_test.dart. 삭제 없음.
- analyze의 비동기 BuildContext 검사 1건 수정 후 PASS(No issues found, 26.1초).
- format 무변경 PASS(18개). flutter test PASS(5개), DB 재시작·pause/resume·100초 경과·정지 시각 고정·중복 저장 방지 검증.
- 실기기 백그라운드 및 강제 종료 동작: NOT RUN.

## Phase 4 — 취업 관리 완료

- 기업 CRUD(직무·지역·URL·마감일·메모·생성/수정 시각), 9개 지원 상태와 별도 변경 이력.
- 상태 변경+이력 삽입 트랜잭션. 처음 APPLIED로 전환할 때 최초 지원일을 기록하고 이후 유지.
- 홈의 7일 이내 마감 목록, 캘린더의 선택 날짜 채용 마감 연동.
- 신규: features/jobs/job_repository.dart, jobs_screen.dart, test/database/job_test.dart.
- 수정: router.dart, home_screen.dart, calendar_screen.dart, navigation_test.dart. 삭제 없음.
- 최초 UI 회귀 테스트는 화면 아래 항목을 스크롤하지 않아 FAIL. 스크롤로 동일 일정 표시를 확인하도록 수정.
- format PASS. flutter analyze PASS(No issues found, 16.0초).
- flutter test PASS(6개). 마감일 경계, 최초 지원일 유지, 이력 INSERT 실패 시 회사 상태까지 롤백 검증.
