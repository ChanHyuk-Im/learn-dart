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