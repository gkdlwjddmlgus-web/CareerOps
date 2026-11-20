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

## Phase 5 — 알림 및 백업 구현/자동 검증 완료

- Android 권한 요청, UTC 절대 시각 알림(inexactAllowWhileIdle), 예약/취소/재예약, 부팅 수신기, 상세 경로 탭 이동.
- 시작 시 DB 스트림 감시로 일정 완료/삭제·기업 종료 상태와 플랫폼 예약을 동기화. 알림 작업은 순차 처리.
- 권한 거부/플랫폼 예약 실패는 알림 행을 미예약으로 유지하고 원본 계획을 보존한다.
- JSON 버전/타입/UTC 시각/유효 날짜/참조 검사. 전체 복원은 트랜잭션, 실패 시 롤백.
- 앱 복원 전 내부 안전 백업 생성. 파일 선택기로 백업 저장 및 복원.
- 신규: core/backup/*, core/notifications/*, features/settings/*, test/database/backup_test.dart, notification_test.dart, Android 알림 아이콘.
- 수정: main/router, tasks/jobs UI, pubspec 및 lock, Android manifest/Gradle, 위젯 테스트. 삭제 없음.
- file_picker 13 API 변경과 deprecated 저장 인자를 수정.
- pub get PASS. format PASS(27개). flutter analyze PASS(No issues found, 7.7초).
- flutter test PASS(8개): 왕복 복원, 손상 JSON/버전/날짜/고아 FK 거부, 원본 보존, 알림 권한 거부/예약 실패/삭제 취소.
- 실제 Android 알림/파일 선택/탭 동작은 아직 NOT RUN. Phase 6에서 에뮬레이터 검증 시도.

## Phase 6 — 리포트·모듈형 구조·릴리스 후보

- SQL로 일/주간·과목별 학습 시간, 예정일 기준 계획 완료율, 최초 지원일 기준 지원 건수,
  전체 지원 단계 및 단원 완료율을 집계한다. 기간은 지역 월요일 시작, 저장은 UTC이다.
- 홈에서 오늘 계획/추가 버튼을 먼저 표시하고 테마 색상·한국어 오류 안내를 정리했다.
- 추가 요구사항에 따라 tasks/study/jobs/reports를 domain/data/presentation으로 분리.
  순수 모델·Repository 인터페이스와 Local 구현을 분리하고 app/providers.dart에서 주입한다.
- UI의 직접 SQL·Drift 모델·QueryRow 의존 제거. 백업/안전 복원도 Repository로 분리.
- BackupRepository·ReminderRepository 역시 대체 가능. 직전 복원 되돌리기를 제공한다.
- 기존 스키마 1 및 데이터는 변경하지 않았다. 외부 HTTP/API/서버/인증 기능은 앱에 추가하지 않았다.
- 원본 screen/widgets 파일은 presentation/으로 이동했고, data/domain/Repository 매핑과 계약 테스트를 추가했다.
- 리포트 스트림 테스트 초기 timeout은 명시적 구독 수명 관리로 해결했다.
- 자동 수정과 소스 편집이 겹쳐 알림 파일 문법 오류가 발생한 실행은 FAIL로 기록.
  검증된 HEAD 구현에서 계약을 다시 적용하고 이후 순차 검증했다.
- 최종 flutter pub get PASS. cupertino_icons 1.0.9 추가로 보조 폰트 경고 보완.
- 최종 flutter analyze PASS(No issues found, 113.4초). flutter test PASS(11개, 29초).
  실제 DB 무결성·재시작·트랜잭션·백업·집계·로컬 Repository 계약,
  SQLite 없는 대역 UI와 아키텍처 경계 포함. 권한 철회 원본 보존 회귀도 PASS.
- format 무변경 검사 PASS(55개). git diff --check PASS. 추적된 키/DB/APK 및 인증정보 패턴 없음.
- Android SDK 37 요구를 확인. SDK 실제 패키지명 android-37.0을 Gradle이 설치했다.
  compile SDK 37 / target SDK 36 / min SDK 24 / Java 17. 프로젝트 전용 설정으로 공용 Flutter 설정 보존.
- 전용 RSA 서명키 생성, 비밀정보는 저장소 밖에 저장. release에서 debug 키 자동 사용 제거.
- `flutter build apk --release`: PASS, 793초, 60.1MB. 보조 폰트/최종 안내 문구를 포함한 증분 재빌드와 서명 검증은 후속 기록한다.
- Android 실기기 및 에뮬레이터 온라인 확보 실패: 기기 테스트 NOT RUN. 상세는 KNOWN_ISSUES.md.
- main/릴리스 태그/Release는 아직 생성·변경하지 않았다.

### 최종 APK 검증

- `flutter build apk --release --no-pub`: PASS, 207.7초. Cupertino/Material 폰트 포함 확인.
- `apksigner verify --verbose --print-certs`: PASS, APK v2 서명, RSA 3072, signer 1개.
- 인증서 SHA-256: `0d7dd7b854496a73bcdb40a8f9d9037af5048b77b82ae8063ebcf9d8cd3167d1`.
- `aapt2 dump badging`: applicationId=com.careerops.planner, versionName=0.1.0, versionCode=1,
  compileSdk=37, targetSdk=36, arm64-v8a/armeabi-v7a/x86_64 포함.
- 공개 산출물: outputs/CareerOps-v0.1.0-candidate.apk(저장소 밖).
- APK SHA-256: `73C510DA0A5F035312F2B32DA1B4F8E53F69513ED9413B422885F60BC91304ED`.
- 설치·실행·업데이트·실제 알림은 NOT RUN이므로 정식 안정 릴리스로 태그하지 않는다.
