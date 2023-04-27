# 제어 흐름 구문 (Control Flow Statements)

다음 중 하나를 사용해서 `Dart` 코드의 흐름을 제어할 수 있습니다.

- `if` 와 `else`
- `for` 루프
- `while` 과 `do-while` 루프
- `break` 와 `continue`
- `switch` 와 `case`
- `assert`

또한 `try-catch` 와 `throw` 를 사용해서 `제어 흐름` 에 영향을 줄 수도 있습니다.

## if 와 else
아래 예제코드에서 볼 수 있듯이 `Dart` 는 `if` 문을 지원하고, 추가로 선택적으로 `else` 를 사용할 수 있습니다.
```dart
if (isRaining()) {
  you.bringRainCoat();
} else if (isSnowing()) {
  you.wearJacket();
} else {
  car.putTopDown();
}
```

구문 조건은 `bool` 값으로 평가할 수 있는 표현식이어야 합니다.

## for 루프
표준 `for` 로 반복적인 동작을 할 수 있습니다.
```dart
var message = StringBuffer('Dart is fun');
for (var i = 0; i < 5; i++) {
  message.write('!');
}
```

`Dart` 의 `for` 루프 내부의 `클로저` 는 인덱스의 값을 저장하기 때문에 `JavaScript` 에서의 일반적인 `클로저` 함정을 피할 수 있습니다.
```dart
var callbacks = [];
for (var i = 0; i < 2; i++) {
  callbacks.add(() => print(i));
}

for (final c in callbacks) {
  c();
}
```

출력은 예상대로 `0` 과 `1` 입니다. 반면에, `JavaScript` 에서는 `2` 와 `2` 를 출력합니다.

반복하려는 객체가 `Iterable(리스트 또는 셋 같은)` 이고 현재 반복중인 횟수(count)를 알 필요가 없는 경우에는 `for-in` 형식의 반복을 사용할 수 있습니다.
```dart
for (final candidate in candidates) {
  candidate.interview();
}
```

`Iterable` 클래스는 또 다른 옵션으로 `forEach()` 메서드를 제공합니다.
```dart
var collection = [1, 2, 3];
collection.forEach(print); // 1 2 3
```

## while 과 do-while
`while` 루프는 루프를 `실행하기 전` 에 조건을 평가합니다.
```dart
while (!isDone()) {
  doSomething();
}
```

`do-while` 루프는 루프를 `실행하고 난 후` 에 조건을 평가합니다.
```dart
do {
  printLine();
} while (!atEndOfPage());
```

## break 와 continue
`break` 를 사용하면 루프를 탈출할 수 있습니다.
```dart
while (true) {
  if (shutDownRequested()) break;
  processIncomingRequests();
}
```

`continue` 를 사용하면 다음 루프 반복으로 건너뜁니다.
```dart
for (int i = 0; i < candidates.length; i++) {
  var candidate = candidates[i];
  if (candidate.yearsExperience < 5) {
    continue;
  }
  candidate.interview();
}
```

리스트나 셋 같은 `Iterable` 을 사용하는 경우에는 위 예제코드를 다르게 작성할 수 있습니다.
```dart
candidates
  .where((c) => c.yearsExperience >= 5)
  .forEach((c) => c.interview());
```

## switch 와 case
`Dart` 의 `switch` 문은 `==` 를 사용해서 정수, 문자열 또는 컴파일타임 상수를 비교합니다. 비교 대상은 모두 동일한 클래스의 인스턴스여야 하며, 클래스는 `==` 를 재정의하지 않아야 합니다. `Enum` 타입은 `switch` 문에서 잘 작동합니다.

비어있지 않은 각각의 `case` 절은 일반적으로 `break` 문으로 끝납니다. 비어있지 않은 `case` 절을 종료하는 다른 방법은 `continue`, `throw` 또는 `return` 문이 있습니다.

일치하는 `case` 절이 없을 경우에는 `default` 절을 사용해서 코드를 실행할 수 있습니다.
```dart
var command = 'OPEN';
switch (command) {
  case 'CLOSED':
    executeClosed();
    break;
  case 'PENDING':
    executePending();
    break;
  case 'APPROVED':
    executeApproved();
    break;
  case 'DENIED':
    executeDenied();
    break;
  case 'OPEN':
    executeOpen();
    break;
  default:
    executeUnknown();
}
```

다음 예제코드는 `break` 문이 없어서 `case` 절에서 에러가 발생합니다.
```dart
var command = 'OPEN';
switch (command) {
  case 'OPEN':
    executeOpen();
    // ERROR: Missing break

  case 'CLOSED':
    executeClosed();
    break;
}
```

하지만 `Dart` 는 비어있는 `case` 절을 지원하므로 아래와 같이 코드를 작성할 수 있습니다.
```dart
var command = 'CLOSED';
switch (command) {
  case 'CLOSED': // 비어있는 case 절은 아래의 case 절이 실행됩니다.
  case 'NOW_CLOSED':
    // CLOSED 와 NOW_CLOSED 둘 다 실행됩니다.
    executeNowClosed();
    break;
}
```

`case` 절을 통과시키려면 `continue` 와 `label` 을 사용하면 됩니다.
```dart
var command = 'CLOSED';
switch (command) {
  case 'CLOSED':
    executeClosed();
    continue nowClosed;
  // nowClosed label 로 이동합니다.

  nowClosed:
  case 'NOW_CLOSED':
    // CLOSED 와 NOW_CLOSED 둘 다 실행됩니다.
    executeNowClosed();
    break;
}
```

`case` 절은 스코프 내부에서만 사용할 수 있는 지역변수를 가질 수 있습니다.