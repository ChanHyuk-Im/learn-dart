# 에러 핸들링 (Error Handling)

## 예외 (Exceptions)
`Dart` 는 `예외` 를 `발생(throw)` 시키고 `포착(catch)` 할 수 있습니다. `예외` 는 예상치 못한 일이 발생했음을 나타내는 에러입니다. 예외가 `catch` 되지 않으면 예외를 발생시킨 코드가 중단되고 해당 프로그램이 종료됩니다.

`Java` 와 다르게, `Dart` 의 모든 예외 는 `확인되지 않은 예외` 입니다. 메서드는 어떤 예외를 `throw` 하는지 선언하지 않고, 예외를 `catch` 할 필요가 없습니다.

`Dart` 는 `Exception` 과 `Error` 타입뿐만 아니라 사전 정의된 수많은 하위타입을 제공합니다. 또한, `커스텀 예외` 를 정의할 수 있습니다. 하지만 `Dart` 프로그램은 `Exception` 및 `Error` 객체뿐만 아니라 `null` 이 아닌 모든 객체를 예외로 `throw` 할 수 있습니다.

### Throw
다음은 `예외` 를 발생(`throw` 또는 `raise`)시키는 예시입니다.
```dart
throw FormatException('Expected at least 1 section');
```

또한 임의 객체를 `throw` 할 수도 있습니다.
```dart
throw 'Out of llamas!';
```

> Note: `프로덕션` 용도의 코드는 일반적으로 `Error` 또는 `Exception` 을 구현하는 타입을 `throw` 합니다.

`예외` 를 `throw` 하는 것은 표현식이기 때문에 `=>` 문 뿐만 하니라 표현식을 사용할 수 있는 다른 모든 곳에서 `예외` 를 `throw` 할 수 있습니다.
```dart
void distanceTo(Point other) => throw UnimplementedError();
```

### Catch
`예외` 를 `catch` 하거나 `capture` 하면 예외를 다시 발생시키지 않는 한 전파되지 않습니다. 예외를 `catch` 하면 예외를 처리할 수 있게 됩니다.
```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  buyMoreLlamas();
}
```

하나 이상의 예외 타입을 `throw` 하는 코드를 처리하려면 여러 `catch` 절을 명시할 수 있습니다. `throw` 된 객체의 타입과 일치하는 첫 번째 `catch` 절이 예외를 처리합니다. `catch` 절이 타입을 명시하지 않으면, 해당 절은 모든 타입의 `throw` 된 객체를 처리할 수 있습니다.
```dart
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // 예외 명시
  buyMoreLlamas();
} on Exception catch (e) {
  // 기타 예외 타입
  print('Unknown exception: $e');
} catch (e) {
  // 타입을 명시하지 않으면 모든 예외를 처리합니다.
  print('Something really unknown: $e');
}
```

위 코드에서 볼 수 있듯이 `on` 또는 `catch` 를 사용하거나 둘 다 사용할 수 있습니다. 예외 타입을 명시해야하는 경우 `on` 을 사용합니다. 예외 핸들러에 예외 객체가 필요한 경우에 `catch` 를 사용합니다.

`catch()` 에 하나 또는 두 개의 파라미터를 명시할 수 있습니다. 첫 번째는 `throw` 된 예외이고, 두 번째는 스택추적(`StackTrace`) 객체입니다.
```dart
try {
  // ···
} on Exception catch (e) {
  print('Exception details:\n $e');
} catch (e, s) {
  print('Exception details:\n $e');
  print('Stack trace:\n $s');
}
```

`rethrow` 키워드를 사용하면 예외를 처리하고 전파할 수 있습니다.
```dart
void misbehave() {
  try {
    dynamic foo = true;
    print(foo++); // 런타임 에러
  } catch (e) {
    print('misbehave() partially handled ${e.runtimeType}.');
    rethrow; // caller 가 예외를 볼 수 있도록 허용합니다.
  }
}

void main() {
  try {
    misbehave();
  } catch (e) {
    print('main() finished handling ${e.runtimeType}.');
  }
}
```

### Finally
예외 발생 여부에 상관없이 일부 코드가 실행되도록 하려면 `finally` 절을 사용하면 됩니다. 예외와 일치하는 `catch` 절이 없으면 `finnaly` 절이 실행된 후 예외가 전파됩니다.
```dart
try {
  breedMoreLlamas();
} finally {
  // 예외가 발생되어도 항상 실행됩니다.
  cleanLlamaStalls();
}
```

`finally` 절은 일치하는 `catch` 절 다음에 실행됩니다.
```dart
try {
  breedMoreLlamas();
} catch (e) {
  print('Error: $e'); // 예외를 먼저 처리합니다.
} finally {
  cleanLlamaStalls(); // 그 다음에 실행됩니다.
}
```