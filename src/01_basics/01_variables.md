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