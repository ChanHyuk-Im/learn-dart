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