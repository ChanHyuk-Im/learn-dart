# Built-in types (내장 타입)

`Dart` 는 아래와 같은 타입을 지원합니다.

- Numbers (`int`, `double`)
- Strings (`String`)
- Booleans (`bool`)
- Lists (`List`, 배열)
- Sets (`Set`)
- Maps (`Map`)
- Runes (`Runes`, 때로 characters API로 대체)
- Symbols (`Symbol`)
- null (`Null`)

리터럴을 사용하여 객체를 만들 수 있습니다. 예를 들면, 'this is a string' 은 `String` 리터럴이고 `true` 는 `bool` 리터럴입니다.

`Dart` 의 모든 변수는 객체(클래스의 인스턴스)를 참조하기 때문에 일반적인 생성자를 사용해서 변수를 초기화할 수 있습니다. 내장 타입 중 일부는 고유한 생성자가 있습니다. 예를 들면, `Map()` 생성자를 사용해서 맵을 만들 수 있습니다.

일부 다른 타입들은 특별한 역할을 합니다.

- Object: `Null` 을 제외한 모든 `Dart` 클래스의 수퍼클래스입니다.
- Enum: 모든 열거형의 수퍼클래스입니다.
- Future 과 Stream: 비동기 지원에서 사용됩니다.
- Iterable: `for-in` 루프 및 동기 생성 함수에서 사용됩니다.
- Never: 표현식이 평가될 수 없음을 나타냅니다. 항상 예외를 발생시키는 함수에서 자주 사용됩니다.
- dynamic: 정적 검사를 비활성화함을 나타냅니다. 보통 `Object` 또는 `Object?` 대신에 사용됩니다.
- void: 사용되지 않는 값을 나타냅니다. 함수 반환 유형으로 주로 사용됩니다.

`Object`, `Object?`, `Null` 그리고 `Never` 클래스는 `null safety` 에서 특별한 역할을 합니다.

## Numbers
`Dart` 에서 `Numbers` 타입은 두가지가 있습니다.

`int`: 플랫폼에 따라 다르지만, 64비트 이하의 값을 가집니다. 네이티브 플랫폼에서는 -2^63 부터 2^63 - 1 사이의 값을 가질 수 있습니다. 웹에서는 `JavaScript` 숫자로 표시되며 -2^53 부터 2^53 - 1 사이의 값을 가질 수 있습니다.

`double`: IEEE 754 표준에 명시되어있는 64비트 부동소수점 숫자입니다.

`int` 와 `double` 은 `num` 의 하위 타입입니다. `num` 타입은 +, -, * 및 / 연산자가 포함되며 abs(), ceil() 및 floor() 등의 메소드도 있습니다. (>>와 같은 비트연산자는 `int` 클래스에 정의되어있습니다.) 연산에 관련된 추가적인 기능이 필요한 경우에는 `dart:math` 라이브러리에서 찾아볼 수 있습니다.

`int` 는 소수점이 없는 숫자입니다. 다음은 정수 리터럴을 정의하는 예시입니다.
```dart
var x = 1;
var hex = 0xDEADBEEF;
```

숫자에 소수점이 있으면 `double` 입니다. 다음은 소수 리터럴을 정의하는 예시입니다.
```dart
var y = 1.1;
var exponents = 1.42e5;
```

변수 타입을 `num` 으로 선언할 수도 있습니다. 이렇게 선언한 경우에 변수는 `int` 와 `double` 타입을 둘 다 가질 수 있습니다.
```dart
num x = 1;  // 변수 x 는 int 와 double 값을 둘 다 가질 수 있습니다.

x += 2.5;
```

정수 리터럴은 필요할 때 자동으로 `double` 타입으로 변환됩니다.
```dart
double z = 1;  // double z = 1.0; 과 같습니다.
```

문자열을 숫자로 변환하거나 그 반대의 경우에는 다음과 같이 할 수 있습니다.
```dart
// String -> int
var one = int.parse('1');
assert(one == 1);

// String -> double
var onePointOne = double.parse('1.1');
assert(onePointOne == 1.1);

// int -> String
String oneAsString = 1.toString();
assert(oneAsString == '1');

// double -> String
String piAsString = 3.141592.toStringAsFixed(2);
assert(piAsString == '3.14');
```

`int` 타입은 비트연산자(<<, >>, >>>, ~, &, |, ^)를 사용할 수 있습니다.
```dart
assert((3 << 1) == 6);  // 0011 << 1 == 0110
assert((3 | 4) == 7);  // 0011 | 0100 == 0111
assert((3 & 4) == 0);  // 0011 & 0100 == 0000
```

숫자 리터럴은 컴파일타임 상수입니다. 피연산자가 컴파일타임 상수로 이루어진 수식은 모두 컴파일타임 상수입니다.
```dart
const msPerSecond = 1000;
const secondsUtilRetry = 5;
const msUntilRetry = secondsUtilRetry * msPerSecond;
```

## Strings
`Dart` 의 `String` 타입은 UTF-16 코드 단위 시퀀스를 가지고 있습니다. 작은 따옴표 또는 큰 따옴표를 사용해서 문자열을 만들 수 있습니다.
```dart
var s1 = 'Single quotes work well for string literals.';
var s2 = "Double quotes work just as well.";
var s3 = 'It\'s easy to escape the string delimiter.';
var s4 = "It's even easier to use the other delimiter.";
```

`${expression}` 을 사용하면 문자열 안에 표현식 값을 넣을 수 있습니다. 표현식이 식별자인 경우에 `{}` 를 생략할 수 있습니다. `toString()` 메서드를 사용하면 객체에 해당하는 문자열을 얻을 수 있습니다.
```dart
var s = 'string interpolation';

assert('Dart has $s, which is very handy.' ==
    'Dart has string interpolation, '
        'which is very handy.');
assert('That deserves all caps. '
        '${s.toUpperCase()} is very handy!' ==
    'That deserves all caps. '
        'STRING INTERPOLATION is very handy!');
```

> Note: `==` 연산자는 두 객체가 동일한지 비교합니다. 동일한 코드 단위 시퀀스를 포함하고있는 두 문자열은 동일합니다.

인접한 문자열 리터럴 또는 `+` 연산자를 이용해서 문자열들을 붙일 수 있습니다.
```dart
var s1 = 'String '
    'concatenation'
    " works even over line breaks.";
assert(s1 ==
    'String concatenation works even over '
        'line breaks.');

var s2 = 'The + operator ' + 'works, as well.';
assert(s2 == 'The + operator works, as well.');
```

작은 따옴표 또는 큰 따옴표를 삼중으로 사용하면 여러 줄 문자열을 만들 수 있습니다.
```dart
var s1 = '''
You can create
multi-line strings like this one.
''';

var s2 = """This is also a
multi-line string.""";
```

`r` 접두어를 사용하면 raw 문자열을 만들 수 있습니다.
```dart
var s = r'In a raw string, not even \n gets special treatment.';
```

컴파일타임 상수인 null, 숫자, 문자열 또는 boolean 값으로 이루어진 문자열은 컴파일타임 상수입니다.
```dart
// const 문자열에서 사용할 수 있습니다.
const aConstNum = 0;
const aConstBool = true;
const aConstString = 'a constant string';

// const 문자열에서 사용할 수 없습니다.
var aNum = 0;
var aBool = true;
var aString = 'a string';
const aConstList = [1, 2, 3];

const validConstString = '$aConstNum $aConstBool $aConstString';
// const invalidConstString = '$aNum $aBool $aString $aConstList';
```

## Booleans
`boolean` 값의 타입은 `bool` 입니다. `true` 와 `false` 두 객체만이 `boolean` 타입을 표현할 수 있고, 둘 다 컴파일타임 상수입니다.
```dart
// 빈 문자열 체크
var fullName = '';
assert(fullName.isEmpty);

// 0 체크
var hitPoints = 0;
assert(hitPoints <= 0);

// null 체크
var unicorn = null;
assert(unicorn == null);

// NaN 체크
var iMeantToDoThis = 0 / 0;
assert(iMeantToDoThis.isNaN);
```