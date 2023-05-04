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

> `late` 변수를 초기화하지 못하면, 변수를 사용할 때 런타임(`run-time`) 에러가 발생합니다.

변수를 `late` 로 표시했지만 선언할 때 초기화하면 변수가 처음 사용될 때 `초기화 프로그램(initializer)` 이 실행됩니다. 이 `지연 초기화(lazy initialization)` 는 몇 가지 경우에 유용합니다.

- 변수가 필요하지 않을 수 있으며, 초기화하는 데 비용이 많이 듭니다.
- 인스턴스 변수를 초기화하고, 그 인스턴스 변수의 initializer는 `this` 에 접근할 필요가 있습니다.

다음 예시에서 `temperature` 변수가 사용되지 않으면, 비용이 많이 드는 `readThermometer()` 함수가 호출되지 않습니다.
```dart
// readThermometer() 함수만을 호출하는 프로그램입니다.
late String temperature = readThermometer(); // Lazily initialized.
```

## final과 const (Final and const)
변수를 앞으로 변경할 일이 없는 경우에 `var` 대신에 `final` 또는 `const` 를 사용하세요. final 변수는 한 번만 값을 할당할 수 있고, const 변수는 컴파일타임(`compile-time`) 상수입니다. const 변수는 암시적으로 final 변수입니다.

> Note: [인스턴스 변수](https://dart.dev/language/classes#instance-variables)는 `final`은 될 수 있지만 `const` 는 될 수 없습니다.

다음은 `final` 변수를 선언하고 값을 할당하는 예시입니다.
```dart
final name = 'Bob'; // 타입 annotation 없이 선언하는 경우
final String nickname = 'Bobby';
```

`final` 변수의 값은 수정할 수 없습니다.
```dart
name = 'Alice'; // 에러: final 변수는 한 번만 값을 할당할 수 있습니다.
```

컴파일타임 상수로 사용할 변수에는 `const` 를 사용하세요. const 변수가 클래스 수준에 있는 경우, `static const` 로 표시합니다. 변수를 선언하는 위치에서 값을 숫자나 문자열 리터럴, const 변수 또는 상수에 대한 산술 연산 결과와 같은 컴파일타임 상수로 설정합니다.
```dart
const bar = 1000000; // 압력의 단위 (dynes/cm2)
const double atm = 1.01325 * bar; // 표준 대기
```

`const` 키워드는 상수 변수를 선언하기 위한 것만이 아닙니다. `const` 를 사용해서 상수 값을 생성하고 상수 값을 생성하는 `생성자(constructor)` 를 선언할 수도 있습니다. 모든 변수는 상수 값을 가질 수 있습니다.
```dart
var foo = const [];
final bar = const [];
const baz = []; // `const []` 와 같습니다.
```

위 코드의 `baz` 와 같이 `const` 선언의 초기화 식에서 `const` 를 생략할 수 있습니다. 자세한 내용은 [const를 불필요하게 사용하지 마세요.](https://dart.dev/guides/language/effective-dart/usage#dont-use-const-redundantly) 섹션을 참고하세요.

`const` 값을 가지고 있더라도 non-final, non-const 변수의 값을 변경할 수 있습니다.
```dart
foo = [1, 2, 3]; // 위 코드에서 const [] 값을 가지고 있었습니다.
```

`const` 변수의 값을 변경할 수 없습니다.
```dart
baz = [42]; // 에러: constant 변수는 값을 할당할 수 없습니다.
```

[타입 체크와 캐스트](https://dart.dev/language/operators#type-test-operators)(`is` 및 `as`), [컬렉션 if](https://dart.dev/language/collections#control-flow-operators) 및 [스프레드 연산자](https://dart.dev/language/collections#spread-operators)(`...` 및 `...?`)를 사용하는 상수를 정의할 수 있습니다.
```dart
const Object i = 3; // i 는 int 값을 가진 const Object 입니다.
const list = [i as int]; // 타입 캐스트를 사용한 경우
const map = {if (i is int) i: 'int'}; // is 와 collection if를 사용한 경우
const set = {if (list is List<int>) ...list}; // 스프레드 연산자를 사용한 경우
```

> Note: `final` 객체는 수정할 수 없지만, 해당 필드는 변경할 수 있습니다. 반면 `const` 객체는 해당 객체와 필드를 변경할 수 없습니다. `const` 는 `immutable` 입니다.

`const` 를 사용해서 상수 값을 만드는 방법에 대한 자세한 내용은 [Lists](https://dart.dev/language/collections#lists), [Maps](https://dart.dev/language/collections#maps), 및 [Classes](https://dart.dev/language/classes) 를 참고하세요.