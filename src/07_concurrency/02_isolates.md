# Dart의 동시성 (Concurrency in Dart)
`Dart` 는 `async-await`, `isolate` 및 `Future` 와 `Stream` 과 같은 클래스를 사용한 동시(`concurrent`) 프로그래밍을 지원합니다.

앱 내에서 모든 `Dart` 코드는 분리된(`isolate`) 상태로 실행됩니다. 각 isolate에는 단일 실행 스레드가 있으며, 다른 isolate와 변경 가능한 객체를 공유하지 않습니다. 서로 통신하기 위해 isolate는 메세지 전달을 사용합니다. 많은 `Dart` 앱은 하나의 isolate인 `main isolate` 만 사용합니다. 멀티 프로세서 코어에서 병렬 코드 실행을 활성화하기 위해 추가 isolate를 생성할 수 있습니다.

`Dart` 의 isolate 모델은 운영체제가 제공하는 프로세스 및 스레드와 같은 기본 원시체계(`primitives`)로 구축되지만 `Dart VM` 의 이러한 원시체계 사용은 이 페이지에서 논의하지 않는 구현 세부사항입니다.

## 비동기 타입 및 구문 (Asynchrony types and syntax)
`Future`, `Stream` 및 `async-await` 에 익숙하다면, [isolates 섹션](https://dart.dev/language/concurrency#how-isolates-work)으로 건너뛸 수 있습니다.

### Future와 Stream 타입 (Future and Stream types)
`Dart` 언어 및 라이브러리는 `Future` 및 `Stream` 객체를 사용해서 미래에 재공될 값을 나타냅니다. 예를 들어, 미래에 `int` 값을 제공하겠다는 `promise` 는 `Future<int>` 타입으로 나타냅니다. 일련의 `int` 값을 제공하겠다는 `promise` 는 `Stream<int>` 타입으로 나타냅니다.

다른 예시로, 파일을 읽기 위한 `dart:io` 메서드가 있습니다. 동기 `File` 메서드인 `readAsStringSync()` 는 파일을 동기적으로 읽고 파일이 완전히 읽히거나 오류가 발생할 때까지 코드 블록을 멈춥니다. 그런 다음 메서드는 `String` 객체를 반환하거나 예외(`exception`)를 발생시킵니다. 같은 기능을 하는 비동기 함수인 `readAsString()` 은 `Future` 타입의 객체를 즉시 반환합니다. 미래의 어느 시점에서 `Future` 는 문자열 값이나 에러를 반환합니다.

#### 비동기 코드가 중요한 이유 (Why asynchronous code matters)
대부분의 앱은 한 번에 둘 이상의 작업을 수행해야 하므로 메서드가 동기식인지 비동기식인지가 중요합니다.

비동기 연산은 현재 `Dart` 코드 외부에서 수행한 결과값인 경우가 있습니다. 이런 연산은 즉시 완료되지 않는 연산과 결과를 기다리는 `Dart` 코드를 멈추지 않으려는 연산을 포함합니다. 예를 들어, 앱이 HTTP 요청을 시작할 수 있지만 HTTP 요청이 완료되기 전에 디스플레이를 업데이트하거나 사용자 입력에 응답해야 합니다. 비동기 코드는 앱이 응답성을 유지하는 데 도움이 됩니다.

이런 시나리오에는 non-bloking I/O, HTTP 요청 수행 또는 브라우저와의 통신과 같은 운영체제 호출(`call`)이 포함됩니다. 다른 시나리오에는 아래에 설명된대로 다른 `Dart` isolate에서 수행되는 연산을 기다리거나 타이머가 트리거되기를 기다리는 것이 포함됩니다. 이러한 모든 프로세스는 다른 스레드에서 실행되거나 운영체제 또는 `Dart` 런타임에서 처리되어 `Dart` 코드가 연산과 동시에 실행될 수 있습니다.

### async-await 구문 (The async-await syntax)
`async` 및 `await` 키워드는 비동기 함수를 정의하고 해당 결과를 사용하는 선언적 방법을 제공합니다.

다음은 파일 I/O를 기다리는 동안 대기하는 일부 동기 코드의 예시입니다.
```dart
void main() {
  // 데이터를 읽습니다.
  final fileData = _readFileSync();
  final jsonData = jsonDecode(fileData);

  // 데이터를 사용합니다.
  print('Number of JSON keys: ${jsonData.length}');
}

String _readFileSync() {
  final file = File(filename);
  final contents = file.readAsStringSync();
  return contents.trim();
}
```

다음은 위와 비슷한 코드이지만, 비동기화가 되어있습니다.
```dart
void main() async {
  // 데이터를 읽습니다.
  final fileData = await _readFileAsync();
  final jsonData = jsonDecode(fileData);

  // 데이터를 사용합니다.
  print('Number of JSON keys: ${jsonData.length}');
}

Future<String> _readFileAsync() async {
  final file = File(filename);
  final contents = await file.readAsString();
  return contents.trim();
}
```

`main()` 함수는 `_readFileAsync()` 앞에 `awiat` 키워드를 사용해서 파일 I/O가 실행되는 동안 다른 `Dart` 코드(이벤트 핸들러 등등)가 CPU를 사용하도록 합니다. `await` 을 사용하면 `_readFileAsync()` 에서 반환된 `Future<String>` 를 문자열로 변환하는 효과도 있습니다. 결과적으로 `contents` 변수는 암시적 `String` 타입을 가집니다.

> Note: `await` 키워드는 함수 본문 앞에 `async` 가 있는 함수에서만 작동합니다.

다음 그림에서 볼 수 있듯이 `Dart` 코드는 `readAsString()` 이 `Dart VM` 또는 운영체제(OS)에서 `비 Dart(Non-Dart)` 코드를 실행하는 동안 일시중지됩니다. `readAsString()` 이 값을 반환하면 `Dart` 코드 실행이 재개됩니다.

![basics-await](https://dart.dev/language/concurrency/images/basics-await.png)

`async`, `await` 그리고 `Future` 에 대해 자세히 알아보려면 [비동기 프로그래밍 코드랩](https://dart.dev/codelabs/async-await)을 참고하세요.