# 검증 계획

각 Phase: 의존성 해결, Drift 생성, 포맷, 정적 분석, 해당 테스트, 전체 테스트.

```sh
flutter pub get
dart run build_runner build
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build apk --release
```

- Phase 1: DB 초기화·외래키·인덱스, 다섯 탭 및 설정 이동.
- Phase 2: 날짜 경계·우선순위·완료 유지·홈/캘린더 일치.
- Phase 3: 타이머 재시작·pause/resume·중복 저장 방지·학습 FK.
- Phase 4: 상태와 이력 원자성·최초 지원일 유지·마감일 경계.
- Phase 5: 손상/잘못된 버전/참조 오류 복원 거부·롤백.
- Phase 6: DB 기반 통계·전체 회귀·릴리스 빌드.

실기기 별도: 알림 허용/거부·앱 종료/재부팅 후 알림·탭 이동·백그라운드 타이머·파일 선택·APK 업데이트 데이터 유지.
실행하지 않은 검증은 NOT RUN이며 빌드 성공과 실기기 PASS를 구분한다.
