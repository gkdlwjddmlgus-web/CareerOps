# 아키텍처

Flutter Material 3 + go_router ShellRoute로 5개 탭을 구성한다.
Riverpod이 앱 수명의 DB와 기능별 스트림을 소유한다.
`features/`는 화면과 비즈니스 로직, `core/database/`는 Drift 스키마와 연결을 담당한다.

SQLite 파일은 앱 전용 application support 디렉터리에 저장한다.
스키마 버전 1, 생성 시 인덱스 구성, 연결마다 외래키 활성화.
향후 버전 변경은 onUpgrade와 이전 버전 데이터 보존 테스트를 함께 추가한다.

시각: UTC ISO 8601 텍스트. 날짜: 지역 날짜 YYYY-MM-DD. 시간량: 정수 초.
완료 기록과 진행 타이머는 별도 테이블이며 타이머는 단일 행(id=1)이다.

## 삭제 정책

- 과목: 학습 기록/진행 타이머가 있으면 삭제 거부. 단원은 cascade, 할 일 연결은 null.
- 단원: 학습 기록/타이머 연결만 null로 전환한다.
- 기업: 이력/알림 cascade, 할 일 연결 null.
- 할 일: 관련 알림 cascade. 플랫폼 예약 취소도 서비스에서 처리한다.

기업 상태 변경+이력과 백업 복원은 트랜잭션 단위로 처리해야 한다.
알림 실패는 원본 할 일/기업 데이터를 삭제하지 않아야 한다.

## 배포

Application ID `com.careerops.planner`는 유지한다. 배포용 개인 서명키는 저장소 밖에서 관리한다.
APK, SDK, 개인 DB, 백업, 인증 정보는 저장소에 포함하지 않는다.
