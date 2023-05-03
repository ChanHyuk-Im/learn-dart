# 변수 (Variables)
다음은 `변수` 를 생성하고 초기화하는 코드입니다.
```dart
var name = 'Bob';
```

변수는 `참조(reference)`를 저장합니다. `name` 이라는 변수에는 값이 `'Bob'` 인 `String` 객체에 대한 참조가 포함되어 있습니다.

`name` 변수의 타입은 `String` 으로 유추되지만, 타입을 지정할 수 있습니다. 객체가 단일 타입으로 제한되지 않는 경우, `Object` 타입을 지정합니다.
```dart
Object name = 'Bob';
```

다른 옵션으로는, 유추할 형식을 명시적으로 선언하는 것입니다.
```dart
String name = 'Bob';
```

> Note: 이 페이지는 로컬 변수에 `타입 annotation` 대신 `var` 를 사용하는 [스타일가이드 권장사항](https://dart.dev/guides/language/effective-dart/design#types)을 따릅니다.

## 기본값 (Default value)
`nullable` 타입이 있는 초기화되지 않은 변수의 초기값은 `null` 입니다. `Dart` 의 다른 모든 것과 마찬가지로 숫자도 객체이기 때문에 숫자 타입의 변수도 처음에는 null입니다.
```dart
int? lineCount;
assert(lineCount == null);
```

> Note: 프로덕션 코드는 `assert()` 호출을 무시합니다. 반면 개발환경에서 `assert(condition)` 는 `condition` 이 `false` 인 경우 예외를 발생시킵니다. 자세한 내용은 [Assert](https://dart.dev/language/control-flow#assert)를 확인하세요.

`null safety` 를 활성화하면, `null을 허용하지 않는(non-nullable)` 변수를 사용하기 전에 초기화를 해야합니다.
```dart
int lineCount = 0;
```

선언된 지역변수를 초기화할 필요는 없지만, 사용하기 전에 값을 할당해야 합니다. 예를 들어 다음 코드는 `print()` 에 `lineCount` 변수가 전달될 때, `Dart` 는 해당 변수가 null이 아님을 감지할 수 있기 때문에 유효합니다.
```dart
int lineCount;

if (weLikeToCount) {
  lineCount = countLines();
} else {
  lineCount = 0;
}

print(lineCount);
```

`최상위(top-level) 변수` 및 `클래스 변수` 는 느리게(`lazily`) 초기화됩니다. 초기화 코드는 변수가 처음 사용될 때 실행됩니다.