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
