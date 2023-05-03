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