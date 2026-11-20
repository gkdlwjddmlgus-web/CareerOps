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

진행 상태와 실제 검증 결과는 docs/DEVELOPMENT_LOG.md에 기록한다.
요구사항·아키텍처·검증 계획은 docs/를 참고한다.
현재 Phase 1 개발 중이며 설치 가능한 릴리스는 아직 제공하지 않는다.
기존 저장소의 date 파일을 보존한다.
