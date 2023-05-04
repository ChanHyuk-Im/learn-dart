# 연산자 (Operators)
`Dart` 는 아래 표에 있는 연산자들을 지원합니다. 이 표는 `Dart` 의 연산자 연관성(`associativity`)과 [연산자 우선순위](https://dart.dev/language/operators#operator-precedence-example)를 높은 것에서 낮은 것까지를 보여줍니다. 이러한 연산자 중 다수는 [클래스 멤버로 구현](https://dart.dev/language/methods#operators)할 수 있습니다.

|설명|연산자|연관성|
|---|---|---|
|단항 접미사(unary postfix)|`expr++`, `expr--`, `()`, `[]`, `?[]`, `.`, `?.`, `!`|None|
|단항 접두사(unary prefix)|`-expr`, `!expr`, `~expr`, `++expr`, `--expr`, `await expr`|None|
|곱하기 나누기(multiplicative)|`*`, `/`, `%`, `~/`|Left|
|더하기 빼기(additive)|`+`, `-`|Left|
|쉬프트(shift)|`<<`, `>>`, `>>>`|Left|
|비트 AND(bitwise AND)|`&`|Left|
|비트 XOR(bitwise XOR)|`^`|Left|
|비트 OR(bitwise OR)|`|`|Left|
|관계 및 타입 검사()relational and type test|`>=`, `>`, `<=`, `<`, `as`, `is`, `is!`|None|
|비교(equality)|`==`, `!=`|None|
|논리 AND(logical AND)|`&&`|Left|
|논리 OR(logical OR)|`||`|Left|
|if null|`??`|Left|
|조건(conditional)|`expr1 ? expr2 : expr3`|Right|
|캐스케이드(cascade)|`..`, `?..`|Left|
|할당(assignment)|`=`, `*=`, `/=`, `+=`, `-=`, `&=`, `^=` etc.|Right|

연산자를 사용하면 표현식(`expression`)이 생성됩니다. 다음은 연산자 표현식의 몇 가지 예시입니다.
```dart
a++
a + b
a = b
a == b
c ? a : b
a is T
```

## 연산자 우선순위 예시 (Operator precedence example)
[연산자 테이블](https://dart.dev/language/operators#operators)에서 각 연산자는 뒤에 오는 행의 연산자보다 우선순위가 높습니다. 예를 들어, 곱셈 연산자 `%` 는 논리 AND 연산자 `&&` 보다 우선위가 높습니다. 따라서 곱셈 연산자가 먼저 실행됩니다. 이러한 우선순위는 다음 두 줄의 코드가 동일한 방식으로 실행됨을 의미합니다.
```dart
// 괄호는 가독성을 높여줍니다.
if ((n % i == 0) && (d % i == 0)) ...

// 같은 동작이지만 코드를 읽기 힘듭니다.
if (n % i == 0 && d % i == 0) ...
```

> 주의: 두 개의 피연산자를 사용하는 연산자의 경우, 가장 왼쪽 피연산자가 사용할 메서드를 결정합니다. 예를 들어 `Vector` 객체와 `Point` 객체가 있는 경우, `aVector + aPoint` 는 `Vector` 의 `+` 를 사용합니다.

## 산술 연산자 (Arithmetic operators)
`Dart` 는 다음 표와 같이 일반적인 산술 연산자를 지원합니다.

|연산자|의미|
|---|---|
|`+`|더하기|
|`-`|빼기|
|`-expr`|수식의 부호 반전|
|`*`|곱하기|
|`/`|나누기|
|`~/`|정수 결과를 반환하는 나누기|
|`%`|나누기의 나머지|

예시:
```dart
assert(2 + 3 == 5);
assert(2 - 3 == -1);
assert(2 * 3 == 6);
assert(5 / 2 == 2.5); // 소수 결과값
assert(5 ~/ 2 == 2); // 정수 결과값
assert(5 % 2 == 1); // 나머지

assert('5/2 = ${5 ~/ 2} r ${5 % 2}' == '5/2 = 2 r 1');
```

`Dart` 는 또한 접두사 및 접미사 증감 연산자를 모두 지원합니다.

|연산자|의미|
|---|---|
|`++var`|`var = var + 1`(표현식 결과값은 `var + 1`)|
|`var++`|`var = var + 1`(표현식 결과값은 `var`)|
|`--var`|`var = var - 1`(표현식 결과값은 `var - 1`)|
|`var--`|`var = var - 1`(표현식 결과값은 `var`)|

예시:
```dart
int a;
int b;

a = 0;
b = ++a; // b에 값을 할당하기 전에 a를 증가시킵니다.
assert(a == b); // 1 == 1

a = 0;
b = a++; // b에 값을 할당한 후에 a를 증가시킵니다.
assert(a != b); // 1 != 0

a = 0;
b = --a; // b에 값을 할당하기 전에 a를 감소시킵니다.
assert(a == b); // -1 == -1

a = 0;
b = a--; // b에 값을 할당한 후에 a를 감소시킵니다.
assert(a != b); // -1 != 0
```

## 비교 연산자 (Equality and relational operators)
다음 표에는 비교연산자 목록이 있습니다.

|연산자|의미|
|---|---|
|`==`|같다.|
|`!=`|같지 않다.|
|`>`|보다 크다.|
|`<`|보다 작다.|
|`>=`|보다 크거나 같다.|
|`<=`|보다 작거나 같다.|

두 객체 x와 y가 같은지 테스트하려면 `==` 연산자를 사용하세요. 두 객체가 정확히 같은 객체인지 알아야 하는 경우에는 `==` 대신에 `same()` 함수를 사용합니다. `==` 연산자의 작동방식은 다음과 같습니다.

1. x 또는 y가 null인 경우, 둘 다 null이면 true를 반환하고 하나만 null이면 false를 반환합니다.
2. 인수 y를 사용해서 x에 대해 `==` 메서드를 호출한 결과를 반환합니다. `==` 와 같은 연산자는 첫 번째 피연산자에서 호출되는 메서드이기 때문입니다. 자세한 내용은 [연산자](https://dart.dev/language/methods#operators)를 참조하세요.

다음은 비교 연산자를 각각 사용하는 예시입니다.
```dart
assert(2 == 2);
assert(2 != 3);
assert(3 > 2);
assert(2 < 3);
assert(3 >= 3);
assert(2 <= 3);
```

## 타입 테스트 연산자 (Type test operators)
`as`, `is` 및 `is!` 연산자는 런타임에 타입을 체크하는 데 유용합니다.

|연산자|의미|
|---|---|
|`as`|타입 변환(`typecast`) - [라이브러리 접두사](https://dart.dev/language/libraries#specifying-a-library-prefix) 명시에도 사용됩니다.|
|`is`|객체가 특정 타입이면 `true` 를 반환합니다.|
|`is!`|객체가 특정 타입이 아니면 `true` 를 반환합니다.|

`obj` 가 `T` 의 인터페이스륵 구현하는 경우, `obj is T` 는 `true` 입니다. 예를 들어, `obj is Object?` 는 항상 `true` 입니다.

객체가 특정 타입인지 확신하는 경우에만 `as` 연산자르 사용해서 객체를 특정 타입으로 변환하세요.

예시:
```dart
(employee as Person).firstName = 'Bob';
```

객체가 `T` 타입인지 확실하지 않은 경우, `is T` 를 사용해서 객체를 사용하기 전에 타입을 체크하세요.
```dart
if (employee is Person) {
  // 타입 체크
  employee.firstName = 'Bob';
}
```

> Note: 위의 두 코드는 동일하지 않습니다. `employee` 가 null이거나 `Person` 이 아닌 경우에 첫 번째 코드에서 예외가 발생합니다. 하지만 두 번째 코드에서는 아무 일도 일어나지 않습니다.

## 할당 연산자 (Assignment operators)
이미 본 것처럼 `=` 연산자를 사용해서 값을 할당할 수 있습니다. 할당 대상 변수가 null인 경우에만 할당하려면 `??=` 연산자를 사용합니다.
```dart
// a 변수에 value를 할당합니다.
a = value;
// b 변수가 null이면 value를 할당합니다. null이 아니면 b의 값은 유지됩니다.
b ??= value;
```

`+=` 연산자와 같은 복합대입(`compound assignment`) 연산자는 연산과 대입을 결합합니다.

||||||
|---|---|---|---|---|
|`=`|`*=`|`%=`|`>>>=`|`^=`|
|`+=`|`/=`|`<<=`|`&=`|`|=`|
|`-=`|`~/=`|`>>=`|||

복합대입 연산자의 작동방식은 다음과 같습니다.

||복합대입|동일한 표현식|
|---|---|---|
|연산자 `op`의 경우|`a op= b`|`a = a op b`|
|예시|`a += b`|`a = a + b`|

다음 코드는 할당 및 복합할당 연산자를 사용하는 예시입니다.
```dart
var a = 2; // = 연산자를 사용한 할당
a *= 3; // 할당 및 곱하기: a = a * 3
assert(a == 6);
```

## 논리 연산자 (Logical operators)
논리 연산자를 사용해서 boolean 표현식을 반전하거나 결합할 수 있습니다.

|연산자|의미|
|---|---|
|`!expr`|표현식을 반전시킵니다. (true를 false로, false를 true로 변경)|
|`||`|논리 OR|
|`&&`|논리 AND|

다음은 논리 연산자를 사용하는 예시입니다.
```dart
if (!done && (col == 0 || col == 3)) {
  // 코드 작성...
}
```

## 비트 및 시프트 연산자 (Bitwise and shift operators)
`Dart` 에서는 숫자의 개별 비트를 다룰 수 있습니다. 일반적으로 이러한 비트 및 시프트 연산자는 정수와 함께 사용합니다.

|연산자|의미|
|`&`|AND|
|`|`|OR|
|`^`|XOR|
|`~expr`|단항 비트 보수 (0은 1로, 1은 0으로 변경)|
|`<<`|왼쪽으로 시프트|
|`>>`|오른쪽으로 시프트|
|`>>>`|부호없는(`unsigned`) 오른쪽으로 시프트|

다음은 비트 및 시프트 연산자를 사용하는 예시입니다.
```dart
final value = 0x22;
final bitmask = 0x0f;

assert((value & bitmask) == 0x02); // AND
assert((value & ~bitmask) == 0x20); // AND NOT
assert((value | bitmask) == 0x2f); // OR
assert((value ^ bitmask) == 0x2d); // XOR
assert((value << 4) == 0x220); // 왼쪽으로 시프트
assert((value >> 4) == 0x02); // 오른쪽으로 시프트
assert((value >>> 4) == 0x02); // 부호없는 오른쪽으로 시프트
assert((-value >> 4) == -0x03); // 오른쪽으로 시프트
assert((-value >>> 4) > 0); // 부호없는 오른쪽으로 시프트
```

> Version note: `>>>` 연산자(`트리플 시프트(triple-shift)` 또는 `무부호 시프트(unsigned shift)` 라고 부릅니다.)를 사용하려면 `Dart` 2.14 이상의 버전이 필요합니다.

## 조건 표현식 (Conditional expressions)
`Dart` 에는 `if-else` 문을 간결하게 작성할 수 있는 두 개의 연산자가 있습니다.

`condition ? expr1 : expr2`   
`condition` 이 `true` 면 `expr1` 을 반환하고, `false` 면 `expr2` 를 반환합니다.

`expr1 ?? expr2`   
`expr1` 이 non-null이면 `expr1` 을 반환하고, null이면 `expr2` 를 반환합니다.

boolean 표현식을 기반으로 값을 할당해야하는 경우 `? :` 를 사용해보세요.
```dart
var visibility = isPublic ? 'public' : 'private';
```

boolean 표현식이 null을 검사하는 경우 `??` 를 사용하는 것이 좋습니다.
```dart
String playerName(String? name) => name ?? 'Guest';
```

위 코드는 적어도 두 가지 다른 방법으로도 구현할 수 있지만 간결하지 않습니다.
```dart
// ? : 연산자를 사용하면 조금 더 길어집니다.
String playerName(String? name) => name != null ? name : 'Guest';

// if-else문을 사용하면 많이 길어집니다.
String playerName(String? name) {
  if (name != null) {
    return name;
  } else {
    return 'Guest';
  }
}
```

## 캐스케이드 표기법 (Cascade notation)
`캐스케이드(.., ?..)` 를 사용하면 동일한 객체에 대해 일련의 작업을 수행할 수 있습니다. 인스턴스 멤버에 접근하는 것과 동시에 동일한 객체에서 인스턴스 메서드를 호출할 수도 있습니다. 이렇게 하면 종종 임시 변수를 만드는 단계가 줄어들고 더 유동적인 코드를 작성할 수 있습니다.

아래 코드를 확인해보세요.
```dart
var paint = Paint()
  ..color = Colors.black
  ..strokeCap = StrokeCap.round
  ..strokeWidth = 5.0;
```

생성자 `Paint()` 는 `Paint` 객체를 반환합니다. 캐스케이드 표기법을 따르는 코드는 반환될 수 있는 모든 값을 무시하고 이 객체에서 작동합니다.

위 코드는 다음 코드와 동일하게 작동합니다.
```dart
var paint = Paint();
paint.color = Colors.black;
paint.strokeCap = StrokeCap.round;
paint.strokeWidth = 5.0;
```

캐스케이드가 작동하는 객체가 null일 수 있는 경우, 첫 번째 로직에 `null-shorting 캐스케이드(?..)` 를 사용합니다. `?..` 로 시작하면 해당 객체가 null일때 추가 작업이 실행되지 않습니다.
```dart
querySelector('#confirm') // 객체를 받아옵니다.
  ?..text = 'Confirm' // 받아온 객체의 멤버를 사용합니다.
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'))
  ..scrollIntoView();
```

> Version note: `?..` 구문은 `Dart` 버전 2.12 이상이 필요합니다.

위 코드는 다음 코드와 동일하게 작동합니다.
```dart
var button = querySelector('#confirm');
button?.text = 'Confirm';
button?.classes.add('important');
button?.onClick.listen((e) => window.alert('Confirmed!'));
button?.scrollIntoView();
```

캐스케이드를 중첩해서 사용할 수도 있습니다.
```dart
final addressBook = (AddressBookBuilder()
  ..name = 'jenny'
  ..email = 'jenny@example.com'
  ..phone = (PhoneNumberBuilder()
    ..number = '415-555-0100'
    ..label = 'home')
  .build())
.build();
```

실제 객체를 반환하는 함수에서 캐스케이드를 구성하는 것을 주의하세요. 예를 들면, 다음 코드는 에러가 발생합니다.
```dart
var sb = StringBuffer();
sb.write('foo')
  ..write('bar'); // 에러: `write` 메서드가 `void` 에 대해 정의되지 않았습니다.
```

`sb.write()` 는 `void` 를 반환하고, `void` 로는 캐스케이드를 사용할 수 없습니다.

> Note: 엄밀하게 말하면, 캐스케이드에 사용하는 `..` 표기법은 연산자가 아니고 `Dart` 구문의 일부입니다.

## 그 외의 연산자 (Other operators)
다른 예제에서 남은 연산자들의 대부분을 봤습니다.

|연산자|의미|
|---|---|
|`()`|함수를 호출합니다.|
|`[]`|오버라이딩 가능한 `[]` 연산자에 대한 호출입니다. 예를 들어, `fooList[1]` 은 정수 `1` 을 `fooList` 에 전달해서 `index` 가 `1` 인 요소에 접근합니다.|
|`?[]`|`[]` 와 비슷하지만 왼쪽 피연산자는 null일 수 있습니다. 예를 들어, `fooList?[1]` 은 `fooList` 가 null이 아닌 경우에 정수 `1` 을 `fooList` 에 전달해서 `index` 가 `1` 인 요소에 접근합니다. `fooList` 가 null인 경우에 `fooList?[1]` 은 null입니다.|
|`.`|표현식의 속성을 나타냅니다. 예를 들어, `foo.bar` 는 `foo` 표현식에서 `bar` 속성을 선택합니다.|
|`?.`|`.` 와 비슷하지만 왼쪽 피연산자는 null일 수 있습니다. 예를 들어, `foo?.bar` 는 `foo` 가 null이 아닌 경우에 `foo` 표현식에서 `bar` 속성을 선택합니다. `foo` 가 null인 경우에 `foo?.bar` 는 null입니다.|
|`!`|왼쪽 피연산자를 non-nullable 타입으로 변환합니다. 예를 들어, `foo!.bar` 는 `foo` 가 null이 아니라는 것을 보장할 때 사용합니다. 만약에 `foo` 가 null인 경우에는 런타임 예외가 발생합니다.|

`.`, `?.` 및  `..` 연산자에 대한 자세한 내용은 [클래스](https://dart.dev/language/classes)를 참조하세요.