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

## late 변수 (Late variables)
`late` 키워드는 두 가지 사용방법이 있습니다.

- 선언 후에 초기화되는 non-nullable 변수를 선언합니다.
- 변수를 느리게 초기화합니다.

종종 `Dart` 의 제어흐름 분석은 null을 허용하지 않는 변수가 사용되기 전에 null이 아닌 값으로 설정되는 경우를 감지할 수 있지만 때로는 분석에 실패합니다. 두 가지의 일반적인 경우는 top-level 변수와 인스턴스 변수입니다. `Dart` 는 종종 설정 여부를 결정할 수 없으므로 시도하지 않습니다.

변수가 사용되기 전에 값이 할당되었지만 `Dart` 가 에러를 발생시키는 경우, 변수를 `late` 로 표시하여 에러를 수정할 수 있습니다.
```dart
late String description;

void main() {
  description = 'Feijoada!';
  print(description);
}
```

> `late` 변수를 초기화하지 못하면, 변수를 사용할 때 런타임 에러가 발생합니다.

변수를 `late` 로 표시했지만 선언할 때 초기화하면 변수가 처음 사용될 때 `초기화 프로그램(initializer)` 이 실행됩니다. 이 `지연 초기화(lazy initialization)` 는 몇 가지 경우에 유용합니다.

- 변수가 필요하지 않을 수 있으며, 초기화하는 데 비용이 많이 듭니다.
- 인스턴스 변수를 초기화하고, 그 인스턴스 변수의 initializer는 `this` 에 접근할 필요가 있습니다.

다음 예시에서 `temperature` 변수가 사용되지 않으면, 비용이 많이 드는 `readThermometer()` 함수가 호출되지 않습니다.
```dart
// readThermometer() 함수만을 호출하는 프로그램입니다.
late String temperature = readThermometer(); // Lazily initialized.
```