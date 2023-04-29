# 생성자 (Constructors)
클래스와 동일한 이름을 가진 함수를 생성해서 `생성자` 를 선언합니다(선택적으로, 명명된 생성자(`Named Constructors`)에 설명된 추가 식별자 추가). 가장 일반적인 형태의 생성자는 클래스의 새 인스턴스를 만듭니다.
```dart
class Point {
  double x = 0;
  double y = 0;

  Point(double x, double y) {
    // 인스턴스 변수를 초기화하기 위한 더 나은 방법은
    // 형식 매개변수 초기화(Initializing Formal Parameters)를 참조하세요.
    this.x = x;
    this.y = y;
  }
}
```

`this` 키워드는 현재 인스턴스를 참조합니다.

> Note: `this` 는 이름이 충돌하는 경우에만 사용하세요. 그렇지 않으면 `Dart` 스타일은 `this` 를 생략합니다.

## 형식 매개변수 초기화 (Initializing Formal Parameters)
인스턴스 변수에 생셩자 인수를 할당하는 패텬은 매우 일반적이므로, `Dart` 는 이를 쉽게 하기 위해 `형식 매개변수 초기화` 를 합니다.

초기화 매개변수는 `null` 이 아닌 인스턴스 변수나 `final` 인스턴스 변수를 초기화하는 데도 사용할 수 있으며, 둘 다 초기화를 하거나 초기값을 지정해야 합니다.
```dart
class Point {
  final double x;
  final double y;

  // 생성자 본문이 실행되기 전에
  // 인스턴스 변수인 x 와 y 의 값을 설정합니다.
  Point(this.x, this.y);
}
```

형식 매개변수 초기화를 통해 초기화된 변수는 암시적으로 `final` 변수이며, 초기화 목록의 범위 내에서만 적용됩니다.

## 기본 생성자 (Default Constructors)
생성자를 선언하지 않으면 `기본 생성자` 가 제공됩니다. 기본 생성자는 인수가 없으며, 상위 클래스(`Superclass`)에서 인수가 없는 생성자를 호출합니다.

## 상속되지 않는 생성자 (Constructors aren't inherited)
하위 클래스(`Subclass`)는 상위 클래스에서 생성자를 상속하지 않습니다. 생성자를 선언하지 않는 하위 클래스에는 기본 생성자만 제공됩니다.

## 명명된 생성자 (Named Constructors)
`명명된 생성자` 를 사용해서 클래스에 대한 여러 생성자를 구현하거나 명확성을 제공합니다.
```dart
const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  // 명명된 생성자
  Point.origin()
      : x = xOrigin,
        y = yOrigin;
}
```

생성자는 상속되지 않는다는 것을 기억하세요. 즉, 상위 클래스의 명명된 생성자가 하위 클래스에 의해 상속되지 않는다는 것을 의미합니다. 상위 클래스에 정의된 명명된 생성자를 사용해서 하위 클래스를 만들기 위해서는 해당 생성자를 하위 클래스에서 구현해야 합니다.

## 기본이 아닌 상위 클래스 생성자 호출 (Invoking a Non-Default Superclass Constructor)
기본적으로 하위 클래스의 생성자는 상위 클래스의 `명명되지 않은 인수없는 생성자` 를 호출합니다. 상위 클래스의 생성자는 생성자 본문의 시작 부분에서 호출됩니다. 초기화 목록이 있는 경우, 상위 클래스가 호출되기 전에 실행됩니다. 요약하면 실행 순서는 다음과 같습니다.

- 초기화 목록 (`Initializer List`)
- 상위 클래스의 인수가 없는 생성자 (`Superclass's No-arg Constructor`)
- 해당 클래스의 인수가 없는 생성자 (`Main class's No-arg Constructor`)

상위 클래스에 명명되지 않은 인수없는 생성자가 없으면 상위 클래스의 생성자 중 하나를 수동으로 호출해야 합니다. 생성자 본문 바로 앞에 `: 상위 클래스 생성자` 를 지정합니다.

다음 예제에서 `Employee` 클래스의 생성자는 해당 상위 클래스인 `Person` 의 명명된 생성자를 호출합니다.
```dart
class Person {
  String? firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person 클래스는 기본 생성자가 없습니다.
  // super.fromJson() 생성자를 호출해야 합니다.
  Employee.fromJson(super.data) : super.fromJson() {
    print('in Employee');
  }
}

void main() {
  var employee = Employee.fromJson({});
  print(employee);
  // 출력:
  // in Person
  // in Employee
  // 'Employee' 인스턴스
}
```

상위 클래스 생성자에 대한 인수는 생성자를 호출하기 전에 평가되기 때문에, 인수는 함수 호출과 같은 표현식일 수 있습니다.
```dart
class Employee extends Person {
  Employee() : super.fromJson(fetchDefaultData());
  // ···
}
```

> 주의: 상위 클래스 생성자의 인수는 `this` 에 접근할 수 없습니다. 예를 들어, 인수는 정적 메서드를 호출할 수 있지만 인스턴스 메서드는 호출할 수 없습니다.

### 수퍼 파라미터 (Super Parameters)
각 파라미터를 생성자의 수퍼 호출에 수동으로 전달하지 않으려면, `super 초기화 파라미터(super-initializer parameters)`를 사용해서 지정된 또는 기본 상위 클래스 생성자로 파라미터를 전달할 수 있습니다. 이 기능은 생성자 리디렉션(`Redirecting Constructors`)과 함께 사용할 수 없습니다. super 초기화 파라미터는 [형식 파라미터를 초기화](https://dart.dev/language/constructors#initializing-formal-parameters)하는 것과 유사한 구문 및 의미를 가집니다.
```dart
class Vector2d {
  final double x;
  final double y;

  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;

  // x 와 y 파라미터를 다음과 같이 기본 super 생성자로 전달합니다.
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  Vector3d(super.x, super.y, this.z);
}
```

super 생성자 호출에 이미 위치 인수(`Positional Arguments`)가 있는 경우, super 초기화 파라미터는 위치가 될 수 없지만 항상 다음과 같이 이름을 지정할 수 있습니다.
```dart
class Vector2d {
  // ...

  Vector2d.named({required this.x, required this.y});
}

class Vector3d extends Vector2d {
  // ...

  // y 파라미터를 다음과 같이 명명된 수퍼 생성자로 전달합니다.
  // Vector3d.yzPlane({required double y, required this.z})
  //       : super.named(x: 0, y: y);
  Vector3d.yzPlane({required super.y, required this.z}) : super.named(x: 0);
}
```

> Version Note: super 초기화 파라미터를 사용하려면 언어 버전이 2.17 이상이어야 합니다. 이전 언어 버전을 사용하는 경우에는 모든 super 생성자 파라미터를 수동으로 전달해야 합니다.

## 초기화 목록 (Initializer List)
상위 클래스 생성자를 호출하는 것 외에도 생성자 본문이 실행되기 전에 인스턴스 변수를 초기화할 수도 있습니다. `,` 로 구분합니다.
```dart
// 초기화 목록은 생성자 본문이 실행되기 전에
// 인스턴스 변수를 설정합니다.
Point.fromJson(Map<String, double> json)
    : x = json['x']!,
      y = json['y']! {
  print('In Point.fromJson(): ($x, $y)');
}
```

> 주의: 초기화 목록의 오른쪽 부분은 `this` 에 접근할 수 없습니다.

개발 중에, 초기화 목록에서 `assert` 를 사용하여 입력의 유효성(`valication`)을 검사할 수 있습니다.
```dart
Point.withAssert(this.x, this.y) : assert(x >= 0) {
  print('In Point.withAssert(): ($x, $y)');
}
```

초기화 목록은 `final` 필드를 설정할 때 편리하게 사용할 수 있습니다. 다음 예시는 초기화 목록에서 세 개의 `final` 필드를 초기화합니다.
```dart
import 'dart:math';

class Point {
  final double x;
  final double y;
  final double distanceFromOrigin;

  Point(double x, double y)
      : x = x,
        y = y,
        distanceFromOrigin = sqrt(x * x + y * y);
}

void main() {
  var p = Point(2, 3);
  print(p.distanceFromOrigin);
}
```

## 생성자 리디렉션 (Redirecting Constructors)
때때로 동일한 클래스의 다른 생성자로 리디렉션하는 기능만을 가진 생성자가 있을 수 있습니다. `리디렉션 생성자` 의 본문은 비어있으며, 생성자 호출은 `:` 뒤에서 합니다.
```dart
class Point {
  double x, y;

  // 이 클래스의 메인 생성자입니다.
  Point(this.x, this.y);

  // 메인 생성자로 리디렉션합니다.
  Point.alongXAxis(double x) : this(x, 0);
}
```

## 상수 생성자 (Constant Constructors)
클래스가 절대 변경되지 않는 객체를 생성하는 경우에는 이런 객체를 컴파일타임 상수로 만들 수 있습니다. 이렇게 하려면 `const` 생성자를 정의하고 모든 인스턴스 변수가 `final` 인지 확인합니다.
```dart
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);

  final double x, y;

  const ImmutablePoint(this.x, this.y);
}
```

`상수 생성자` 가 항상 상수를 생성하는 것은 아닙니다. 자세한 내용은 [생성자 사용하기](https://dart.dev/language/classes#using-constructors) 를 확인하세요.

## 팩토리 생성자 (Factory Constructors)
항상 새로운 인스턴스를 생성하지 않는 생성자를 구현할 때 `factory` 키워드를 사용합니다. 예를 들어, `팩토리 생성자` 는 캐시(`cache`)에서 인스턴스를 반환하거나 하위 타입의 인스턴스를 반환할 수 있습니다. 팩토리 생성자의 또 다른 사용 사례는 초기화 목록에서 처리할 수 없는 로직을 사용하여 `final` 변수를 초기화하는 것입니다.

> Tip: `final` 변수의 `늦은 초기화(late initialization)` 를 처리하는 또 다른 방법은 `late final` 을 사용하는 것입니다. ([주의하세요.](https://dart.dev/guides/language/effective-dart/design#avoid-public-late-final-fields-without-initializers))

다음 예제에서는 `Logger` 팩토리 생성자가 캐시에서 객체를 반환하고, `Logger.fromJson` 팩토리 생성자가 JSON 객체에서 `final` 변수를 초기화합니다.
```dart
class Logger {
  final String name;
  bool mute = false;

  // _cache는 클래스 내부에서만 사용됩니다.
  // 이름 앞에 '_' 를 붙이면 private이 됩니다.
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}
```

> Note: 팩토리 생성자는 `this` 에 접근할 수 없습니다.

팩토리 생성자는 다른 생성자를 호출하는 것과 동일한 방식으로 호출합니다.
```dart
var logger = Logger('UI');
logger.log('Button clicked');

var logMap = {'name': 'UI'};
var loggerJson = Logger.fromJson(logMap);
```