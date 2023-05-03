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

## isolate 동작 방식 (How isolates work)
대부분의 최신 디바이스에는 멀티코어 CPU가 있습니다. 모든 코어를 활용하기 위해 개발자는 때때로 동시에 실행되는 `공유 메모리 스레드(shared-memoty threads)` 를 사용합니다. 그러나 `공유 상태 동시성(shared-state concurrency)` 은 [에러](https://en.wikipedia.org/wiki/Race_condition#In_software)가 발생하기 쉽고 복잡한 코드로 이어질 수 있습니다.

스레드 대신, 모든 `Dart` 코드는 isolate 내부에서 실행됩니다. 각 isolate에는 고유한 `메모리 힙(memory heap)` 이 있으므로 isolate의 어떤 상태도 다른 isolate에서 접근(`access`)할 수 없습니다. 공유 메모리가 없기 때문에 [mutex 또는 lock](https://en.wikipedia.org/wiki/Lock_(computer_science))에 대해 걱정할 필요가 없습니다.

isolate를 사용하면 `Dart` 코드가 사용가능한 경우 추가 프로세서 코어를 사용해서 한 번에 여러 개의 독립적인 작업을 수행할 수 있습니다. isolate는 스레드 또는 프로세스와 비슷하지만 각 isolate에는 고유한 메모리와 이벤트 루프를 실행하는 단일 스레드가 있습니다.

> Platform note: `Dart Native 플랫폼` 만 isolate를 구현합니다. `Dart 웹 플랫폼` 에 대한 자세한 내용은 [웹에서의 동시성(Concurrency on the web)](https://dart.dev/language/concurrency#concurrency-on-the-web) 섹션을 확인하세요.

### main isolate (The main isolate)
isolate에 대해 전혀 생각할 필요가 없는 경우가 많습니다. `Dart` 프로그램은 기본적으로 `main isolate` 에서 실행됩니다. `main isolate` 는 다음 그림과 같이 프로그램이 실행되고 동작하는 스레드입니다.

![main-isolate](https://dart.dev/language/concurrency/images/basics-main-isolate.png)

`단일 isolate(single-isolate)` 프로그램도 `async-await` 을 사용해서 비동기 작업이 완료될 때까지 기다렸다가 다음 코드를 진행하면 원활하게 실행할 수 있습니다. `제대로 작동하는 앱(well-behaved app)` 은 빠르게 시작해서 가능한 한 빨리 이벤트 루프에 도달합니다. 그 후 앱은 필요에 따라 비동기 작업을 사용해서 대기중인 각 이벤트에 즉시 응답합니다.

### isolate 생명주기 (The isolate life cycle)
다음 그림에서 볼 수 있듯이, 모든 isolate는 `main()` 함수와 같은 일부 `Dart` 코드를 실행함으로써 시작됩니다. 이 `Dart` 코드는 예를 들어 사용자 입력 또는 파일 I/O에 응답하기 위해 일부 이벤트 리스너를 등록할 수 있습니다. isolate의 초기 함수가 반환되면 isolate는 이벤트를 처리해야 하는 경우 종료되지 않고 남아있다가 이벤트를 처리한 후 종료됩니다.

![isolate](https://dart.dev/language/concurrency/images/basics-isolate.png)

### 이벤트 다루기 (Event handling)
클라이언트 앱에서 main isolate의 `이벤트 큐(event queue)` 에는 `탭(tap)` 및 기타 UI 이벤트에 대한 `다시 그리기(repaint)` 요청 및 `알림(notification)` 이 포함될 수 있습니다. 예를 들어, 다음 그림은 repaint 이벤트, 탭 이벤트, 두 개의 repaint 이벤트를 보여줍니다. 이벤트 루프는 큐에서 이벤트를 `선입선출(first in, first out)` 순서로 가져옵니다.

![event-loop](https://dart.dev/language/concurrency/images/event-loop.png)

이벤트 처리는 `main()` 이 종료된 후 main isolate에서 발생합니다. 다음 그림에서 `main()` 이 종료된 후 main isolate는 첫 번째 repaint 이벤트를 처리합니다. 그런 다음 main isolate가 탭 이벤트를 처리한 다음 다시 repaint 이벤트를 처리합니다.

![event-handling](https://dart.dev/language/concurrency/images/event-handling.png)

동기 작업에 너무 많은 시간이 소요되면 앱이 응답하지 않을 수 있습니다. 다음 그림에서 탭 처리 코드는 너무 오래 걸리므로 후속 이벤트가 너무 늦게 처리되게 됩니다. 따라서 앱이 정지된 것처럼 보일 수 있으며, 수행하는 모든 애니메이션이 불안정할 수 있습니다.

![event-jank](https://dart.dev/language/concurrency/images/event-jank.png)

클라이언트 앱에서 너무 긴 동기 작업의 결과는 종종 버벅거리는(부드럽지 않은) UI 문제를 발생시킵니다. 최악의 상황은 UI가 완전히 응답하지 않을 수 있습니다.

### 백그라운드 워커 (Background workers)
시간이 많이 걸리는 연산([대용량 JSON 파일 파싱](https://docs.flutter.dev/cookbook/networking/background-parsing) 등)으로 인해 앱의 UI가 응답하지 않는 경우, 해당 연산을 종종 `백그라운드 워커` 라고 불리는 worker isolate로 위임하는 것이 좋습니다. 다음 그림에서 볼 수 있듯이 일반적인 경우는 연산을 수행한 다음 종료하는 simple worker isolate를 생성하는 것입니다. worker isolate는 worker가 종료될 때 결과를 반환합니다.

![isolate-bg-worker](https://dart.dev/language/concurrency/images/isolate-bg-worker.png)

각 isolate 메세지는 해당 객체에서 도달할 수 있는 모든 것을 포함하는 하나의 객체를 전달할 수 있습니다. 모든 객체 타입을 보낼 수 있는 것은 아니고, 도달할 수 있는 객체를 보낼 수 없는 경우 실패합니다. 예를 들어, `List<Object>` 에 보낼 수 없는 객체가 없는 경우에만 `List` 타입의 객체를 보낼 수 있습니다. 객체 중 하나가 `Socket` 이라면 소켓을 보낼 수 없기 때문에 전달에 실패합니다.

메세지로 보낼 수 있는 객체 종류에 대한 자세한 내용은 [send() 메서드](https://api.dart.dev/stable/2.19.6/dart-isolate/SendPort/send.html)에 대한 API 문서를 참조하세요.

worker isolate는 I/O를 수행하고 타이머를 설정하는 등의 작업을 수행할 수 있습니다. 자체 메모리가 있으며 main isolate와 상태를 공유하지 않습니다. worker isolate는 다른 isolate에 영향을 주지 않고 코드 실행을 멈출 수 있습니다.

## 예제 코드 (Code examples)
이 섹션에서는 `Isolate` API를 사용해서 isolate를 구현하는 몇 가지 예시를 설명합니다.

### simple worker isolate 구현 (Implementing a simple worker isolate)
이 예제는 simple worker isolate를 생성하는 main isolate를 구현합니다. `Isolate.run()` 은 worker isolate 설정 및 관리 이후의 단계를 단순화합니다.

1. isolate를 생성합니다.
2. 생성된 isolate에서 함수를 실행합니다.
3. 결과값을 저장합니다.
4. 결과값을 main isolate로 반환합니다.
5. 작업이 완료되면 isolate를 종료합니다.
6. 예외 및 에러를 체크, 포착하고 main isolate로 반환합니다.

> Flutter note: Flutter를 사용하는 경우, `Isolate.run()` 대신 [Flutter의 compute() 함수](https://api.flutter.dev/flutter/foundation/compute-constant.html)를 사용하는 것이 좋습니다. `compute` 함수를 사용하면 코드가 [네이티브 및 비네이티브 플랫폼(native and non-native platforms)](https://dart.dev/overview#platform) 모두에서 작동될 수 있습니다. 보다 인체공학적(`ergonomic`) API를 위한 네이티브 플랫폼만을 대상으로 할 때 `Isolate.run()` 을 사용하세요.

#### 새로운 isolate에서 기존의 메서드 실행하기 (Running an existing method in a new isolate)
main isolate에는 새로운 isolate를 생성하는 코드가 포함되어 있습니다.
```dart
void main() async {
  // data를 읽어옵니다.
  final jsonData = await Isolate.run(_readAndParseJson);

  // data를 사용합니다.
  print('Number of JSON keys: ${jsonData.length}');
}
```

생성된 isolate는 첫 번째 인수로 전달된 `_readAndParseJson` 함수를 실행합니다.
```dart
Future<Map<String, dynamic>> _readAndParseJson() async {
  final fileData = await File(filename).readAsString();
  final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
  return jsonData;
}
```

1. `Isolate.run()` 은 background worker인 isolate를 생성하고 `main()` 은 결과를 기다립니다.
2. 생성된 isolate는 `run()` 에 전달된 인수인 `_readAndParseJson()` 함수를 실행합니다.
3. `Isolate.run()` 은 `return` 에서 결과를 가져오고, 값을 main isolate로 다시 전달한 후 worker isolate를 종료합니다.
4. worker isolate는 결과를 보관하는 메모리를 main isolate로 전송합니다(데이터를 복사하지 않습니다). worker isolate는 유효성 검사를 수행해서 객체를 전송할 수 있는지 확인합니다.

`_readAndParseJson()` 은 main isolate에서 직접 쉽게 실행할 수 있는 기존의(`existing`) 비동기 함수입니다. 대신 `Isolate.run()` 을 사용해서 실행하면 동시성이 활성화됩니다. worker isolate는 `_readAndParseJson()` 의 연산을 완전히 추상화합니다. main isolate를 멈춰두지 않고 작업을 완료할 수 있습니다.

`Isolate.run()` 의 결과는 항상 `Future` 입니다. main isolate의 코드가 계속 실행되기 때문입니다. worker isolate가 실행하는 연산이 동기식이든 비동기식이든 동시에 실행되기 때문에 main isolate에 영향을 끼치지 않습니다.

전체 프로그램은 [send_and_receive.dart](https://github.com/dart-lang/samples/blob/main/isolates/bin/send_and_receive.dart) 예제를 확인해보세요.

#### isolate로 클로저 전송하기 (Sending closures with isolates)
main isolate에서 직접 `함수 리터럴` 또는 `클로저` 를 사용해서 `run()` 으로 simple worker isolate를 만들 수도 있습니다.
```dart
void main() async {
  // data를 읽어옵니다.
  final jsonData = await Isolate.run(() async {
    final fileData = await File(filename).readAsString();
    final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
    return jsonData;
  });

  // data를 사용합니다.
  print('Number of JSON keys: ${jsonData.length}');
}
```

위 코드는 이전 코드와 동일하게 동작합니다. 새로운 isolate가 생성되고 특정 연산을 수행한 후 결과를 반환합니다.

하지만 이제 isolate는 [클로저](https://dart.dev/language/functions#anonymous-functions)를 전송합니다. 클로저는 작동 방식과 작성 방식 모두에서 일반적인 명명된 함수보다 덜 제한적입니다. 위 코드에서 `Isolate.run()` 은 로컬 코드처럼 보이는 것을 동시에 실행합니다. 그런 의미에서 `run()` 이 `병렬실행(run in parallel)` 을 위한 [제어흐름 연산자](https://dart.dev/language/control-flow)처럼 작동한다고 상상할 수 있습니다. 

### isolate 간에 여러 메세지 보내기 (Sending multiple messages between isolates)
`Isolate.run()` 은 isolate 관리를 단순화하기 위해 `하위 수준 격리 관련(lower-level, isolate-related)` API를 추상화합니다.

- [Isolate.spawn()](https://api.dart.dev/stable/2.19.6/dart-isolate/Isolate/spawn.html) 및 [Isolate.exit()](https://api.dart.dev/stable/2.19.6/dart-isolate/Isolate/exit.html)
- [ReceivePort](https://api.dart.dev/stable/2.19.6/dart-isolate/ReceivePort-class.html) 및 [SendPort](https://api.dart.dev/stable/2.19.6/dart-isolate/SendPort-class.html)

isolate 기능을 보다 세부적으로 제어하기위해 이러한 프리미티브(`primitive`)를 직접 사용할 수 있습니다. 예를 들어, `run()` 은 단일 메세지를 반환한 후 isolate를 종료합니다. isolate 사이에 여러 베세지가 전달되도록 하려면 어떻게 해야할까요? 조금 다른 방식으로, `SendPort` 의 [send() 메서드](https://api.dart.dev/stable/2.19.6/dart-isolate/SendPort/send.html)를 활용해서 `run()` 이 구현되는 것과 거의 동일한 방식으로 자체 isolate를 설정할 수 있습니다.

다음 그림에서 볼 수 있듯이, 일반적인 패턴 중 하나는 main isolate가 worker isolate에 요청 메세지를 보낸다음 하나 이상의 응답 메세지를 보내는 것입니다.

![isolate-custom-bg-worker](https://dart.dev/language/concurrency/images/isolate-custom-bg-worker.png)

[long_running_isolate.dart](https://github.com/dart-lang/samples/blob/main/isolates/bin/long_running_isolate.dart) 예제를 확인해보세요. 이 예제는 isolate 사이에서 여러 번 메세지를 주고받는 `장기 실행(long-running)` isolate를 생성하는 방법을 보여줍니다.

## 성능 및 isolate 그룹 (Performance and isolate groups)
isolate가 `Isolate.spawn()` 을 호출하면 두 isolate는 동일한 실행 코드를 가지며 동일한 isolate 그룹에 있습니다. isolate 그룹은 코드 공유와 같은 성능 최적화를 가능하게 합니다. 새로운 isolate는 isolate 그룹이 소유한 코드를 즉시 실행합니다. 또한 `Isolate.exit()` 은 isolate가 동일한 isolate 그룹에 있는 경우에만 동작합니다.

일부 특수한 경우에, 지정된 URI에 있는 코드의 복사본으로 새로운 isolate를 설정하는 `Isolate.spawnUri()` 를 사용해야 할 수 있습니다. 그러나 `spawnUri()` 는 `spawn()` 보다 훨씬 느리고, 새로운 isolate는 생성자의 isolate 그룹에 없습니다. 또 다른 성능 결과는, isolate가 다른 그룹에 있을 때 메세지 전달이 느려진다는 것입니다.

> Flutter note: Flutter는 `Isolate.spawnUri()` 를 지원하지 않습니다.

## 웹에서의 동시성 (Concurrency on the web)
모든 `Dart` 앱은 `non-bloking`, `인터리브 연산(interleaved computation)` 을 위해 `async-await`, `Future` 및 `Stream` 을 사용할 수 있습니다. 그러나 `Dart` 웹 플랫폼은 isolate를 지원하지 않습니다. `Dart` 웹앱은 isolate와 유사한 백그라운드 스레드에서 스크립트를 실행하기 위해 [web worker](https://developer.mozilla.org/ko/docs/Web/API/Web_Workers_API/Using_web_workers)를 사용할 수 있습니다. 그러나 web worker의 기능은 isolate와 다소 다릅니다.

예를 들어, web worker가 스레드 간에 데이터를 보낼 때 데이터를 앞뒤로(`back and forth`) 복사합니다. 그러나 특히 대용량 메세지의 경우 데이터 복사 속도가 매우 느릴 수 있습니다. isolate는 동일한 작업을 수행하지만 대신에 메세지를 보관하는 메모리를 보다 효율적으로 전송할 수 있는 API를 제공합니다.

web worker 및 isolate 생성도 다릅니다. 별도의 프로그램 진입점을 선언하고 별도로 컴파일해야지만 web worker를 생성할 수 있습니다. web worker를 시작하는 것은 `Isolate.spawnUri` 를 사용해서 isolate를 시작하는 것과 유사합니다. `Isolate.spawn` 을 사용해서 isolate를 시작할 수도 있습니다. 이 경우, isolate를 생성하는 것과 [동일한 코드 및 데이터 중 일부를 재사용](https://dart.dev/language/concurrency#performance-and-isolate-groups)하기 때문에 더 적은 리소스가 필요합니다. web worker에게는 같은 기능을 하는 API가 없습니다.