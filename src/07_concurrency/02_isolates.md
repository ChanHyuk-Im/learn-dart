# Dart의 동시성 (Concurrency in Dart)
`Dart` 는 `async-await`, `isolate` 및 `Future` 와 `Stream` 과 같은 클래스를 사용한 동시(`concurrent`) 프로그래밍을 지원합니다.

앱 내에서 모든 `Dart` 코드는 분리된(`isolate`) 상태로 실행됩니다. 각 isolate에는 단일 실행 스레드가 있으며, 다른 isolate와 변경 가능한 객체를 공유하지 않습니다. 서로 통신하기 위해 isolate는 메세지 전달을 사용합니다. 많은 `Dart` 앱은 하나의 isolate인 `main isolate` 만 사용합니다. 멀티 프로세서 코어에서 병렬 코드 실행을 활성화하기 위해 추가 isolate를 생성할 수 있습니다.

`Dart` 의 isolate 모델은 운영체제가 제공하는 프로세스 및 스레드와 같은 기본 원시체계(`primitives`)로 구축되지만 `Dart VM` 의 이러한 원시체계 사용은 이 페이지에서 논의하지 않는 구현 세부사항입니다.