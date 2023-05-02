# 비동기 지원 (Asynchrony Support)
`Dart` 는 `Future` 또는 `Stream` 객체를 반환(`return`)하는 많은 함수 및 라이브러리를 제공합니다. 이런 함수는 `비동기적` 으로 동작합니다. 시간이 많이 소요될 수 있는 작업(`I/O` 등등)을 설정한 후 해당 작업이 완료될 때까지 기다리지 않고 반환합니다.

`async` 및 `await` 키워드는 비동기 프로그래밍을 지원하므로 동기(`Synchronous`) 코드와 유사하게 비동기 코드를 작성할 수 있습니다.

## Future 다루기 (Handling Futures)
완료된 `Future` 의 결과값이 필요한 경우, 두 가지 옵션이 있습니다.

- 이 문서와 [비동기 프로그래밍 코드랩](https://dart.dev/codelabs/async-await)에 설명된 대료, `async` 및 `await` 을 사용하세요.
- [라이브러리 둘러보기](https://dart.dev/guides/libraries/library-tour#future)에 설명된 대로, `Future API` 를 사용하세요.

`async` 및 `await` 을 사용하는 코드는 비동기식이지만 동기식 코드와 매우 유사합니다. 예를 들어, 다음은 `await` 을 사용하여 비동기 함수의 결과를 기다리는 코드입니다.
```dart
await lookUpVersion();
```

`await` 을 사용하려면, 코드가 `async` 로 표시된 `async` 함수 안에 있어야합니다.
```dart
Future<void> checkVersion() async {
  var version = await lookUpVersion();
  // version에 데이터가 받아와집니다.
}
```

> Note: 비동기 함수는 시간이 많이 걸리는 작업을 수행할 수 있지만, 이러한 작업들 기다리지는 않습니다. 대신 `async` 함수는 첫 `await` 표현식을 만날 때까지만 실행됩니다. 그런 다음 `Future` 객체를 반환하고 `awiat` 표현식이 완료된 후에 실행이 재개됩니다.

`try`, `catch` 및 `finally` 를 사용해서 `await` 을 사용하는 코드에서 에러를 처리할 수 있습니다.
```dart
try {
  version = await lookUpVersion();
} catch (e) {
  // lookUpVersion()에서 에러가 발생한 경우 실행됩니다.
}
```

`async` 함수에서 `await` 을 여러 번 사용할 수 있습니다. 다음 코드는 함수 결과를 세 번 기다리는 예시입니다.
```dart
var entrypoint = await findEntryPoint();
var exitCode = await runExecutable(entrypoint, args);
await flushThenExit(exitCode);
```

`await` 표현식에서 표현식의 값은 일반적으로 `Future` 입니다. 그렇지 않은 경우에 값은 자동으로 `Future` 에 래핑됩니다. 이 `Future` 객체는 객체를 반환하겠다는 약속(`Promise`)을 나타냅니다. `await` 표현식의 값은 반환된 객체입니다. `await` 표현식은 해당 객체를 사용할 수 있을때까지 실행을 일시중지합니다.

`await` 을 사용할 때 컴파일타임 에러가 발생한다면, `await` 이 `async` 함수 안에 있는지 확인해보세요. 예를 들어, 앱의 `main()` 함수에서 `await` 을 사용하려면 `main()` 의 본문을 `async` 로 표시해야 합니다.
```dart
void main() async {
  checkVersion();
  print('In main: version is ${await lookUpVersion()}');
}
```

> Note: 위 코드에서는 결과를 기다리지 않고 비동기 함수 `checkVersion()` 을 사용합니다. 코드에서 함수 실행이 완료되었다고 가정하면 문제가 발생할 수 있습니다. 이 문제를 방지하려면 [unawaited_futures linter 규칙](https://dart.dev/tools/linter-rules#unawaited_futures)을 사용하세요.

`Futures`, `async` 및 `await` 사용에 대한 소개는 [비동기 프로그래밍 코드랩](https://dart.dev/codelabs/async-await)을 참조하세요.

## async 함수 선언 (Declaring async Functions)
`async` 함수는 함수 본문이 `async` 로 표기된 함수입니다.

함수에 `async` 키워드를 추가하면 `Future` 를 반환합니다. 다음 코드는 문자열을 반환하는 동기 함수입니다.
```dart
String lookUpVersion() => '1.0.0';
```

위 코드를 `async` 함수로 바꾸면 반환되는 값은 `Future` 입니다.
```dart
Future<String> lookUpVersion() async => '1.0.0';
```

함수 본문은 `Future API` 를 사용할 필요가 없습니다. `Dart` 는 필요한 경우 `Future` 객체를 생성합니다. 함수가 의미있는 값을 반환하지 않는다면 반환 타입을 `Future<void>` 로 만드세요.

`Futures`, `async` 및 `await` 사용에 대한 소개는 [비동기 프로그래밍 코드랩](https://dart.dev/codelabs/async-await)을 참조하세요.