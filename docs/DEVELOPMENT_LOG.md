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
