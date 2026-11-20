# CareerOps

공부와 취업 준비를 관리하는 한국어 Android 앱. 버전 0.1.0 개발 중.

Flutter stable 3.50.1 / Dart 3.14.0, Material 3, Riverpod, Drift/SQLite, go_router.
Application ID: `com.careerops.planner`.

```sh
flutter pub get
dart run build_runner build
flutter analyze
flutter test
flutter run
```

홈·할 일·과목/단원·재시작 가능한 타이머·학습 기록·기업/지원 이력·캘린더·알림·백업/복원·주간 리포트를 구현한다.
각 기능은 domain/data/presentation으로 분리하며 화면은 저장 기술과 독립된 Repository 계약을 사용한다.
앱의 MVP 기능은 외부 API·서버·로그인 없이 동작한다. 기존 저장소의 date 파일을 보존한다.

진행 상태와 실제 검증 결과는 docs/DEVELOPMENT_LOG.md, 요구사항·설계·검증 계획은 docs/를 참고한다.
Android 실기기에서 미검증된 사항은 NOT RUN으로 기록하며 빌드 성공과 구분한다.

## Android 릴리스 빌드

compile SDK 37, target SDK 36, 최소 Android API 24, Java 17을 사용한다.
전용 서명키를 저장소 밖에 보관하고 아래 환경변수로 properties 경로를 전달한다.

```powershell
$env:CAREEROPS_KEY_PROPERTIES = 'C:/private/careerops/signing.properties'
flutter build apk --release
```

properties 필드: storeFile, storePassword, keyPassword, keyAlias.
비밀번호·키·개인 DB·백업은 Git에 넣지 않는다. 같은 설치본 업데이트에는 동일한 키가 필요하다.
키가 없을 때 release 빌드는 실패하도록 구성하며 debug 키로 자동 배포하지 않는다.

Learning Hub 0.2.0은 v0.1 기준선 검증을 선행 조건으로 별도 feature 브랜치에서 진행한다.
