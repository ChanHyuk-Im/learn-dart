# 연산자 (Operators)
`Dart` 는 아래 표에 있는 연산자들을 지원합니다. 이 표는 `Dart` 의 연산자 연관성(`associativity`)과 [연산자 우선순위](https://dart.dev/language/operators#operator-precedence-example)를 높은 것에서 낮은 것까지를 보여줍니다. 이러한 연산자 중 다수는 [클래스 멤버로 구현](https://dart.dev/language/methods#operators)할 수 있습니다.

|설명|연산자|연관성|
|---|---|---|
|단항 접미사|`expr++`, `expr--`, `()`, `[]`, `?[]`, `.`, `?.`, `!`|None|
|단항 접두사|`-expr`, `!expr`, `~expr`, `++expr`, `--expr`, `await expr`|None|
|곱하기 나누기|`*`, `/`, `%`, `~/`|Left|
|더하기 빼기|`+`, `-`|Left|
|쉬프트|`<<`, `>>`, `>>>`|Left|
|비트 AND|`&`|Left|
|비트 XOR|`^`|Left|
|비트 OR|`|`|Left|
|관계 및 타입 검사|`>=`, `>`, `<=`, `<`, `as`, `is`, `is!`|None|
|비교|`==`, `!=`|None|
|논리 AND|`&&`|Left|
|논리 OR|`||`|Left|
|if null|`??`|Left|
|조건|`expr1 ? expr2 : expr3`|Right|
|캐스케이드|`..`, `?..`|Left|
|할당|`=`, `*=`, `/=`, `+=`, `-=`, `&=`, `^=` etc.|Right|

연산자를 사용하면 표현식(`expression`)이 생성됩니다. 다음은 연산자 표현식의 몇 가지 예시입니다.
```dart
a++
a + b
a = b
a == b
c ? a : b
a is T
```