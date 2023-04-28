# 클래스 (Classes)
`Dart` 는 `클래스` 와 `믹스인 기반 상속` 이 있는 객체지향 언어입니다. 모든 객체는 `클래스` 의 `인스턴스` 이며, `Null` 을 제외한 모든 클래스는 `Object` 에서 파생됩니다. `믹스인 기반 상속` 은 모든 클래스가 정확히 하나의 `수퍼클래스` 를 갖지만 클래스 본문은 여러 클래스 계층에서 재사용될 수 있다는 것을 의미합니다. `확장 메서드(Extension metnods)` 는 클래스를 변경하거나 하위 클래스를 만들지 않고 클래스에 기능을 추가하는 방법입니다.

## 클래스 멤버 사용하기
`객체` 는 `함수` 와 `데이터(메서드와 인스턴스 변수)` 로 구성된 `멤버` 를 가집니다. 메서드를 호출한다는 것은 객체에서 메서드를 호출하는 것입니다. 메서드는 객체의 함수와 데이터에 접근할 수 있습니다.

`.` 을 사용해서 인스턴스 변수 또는 메서드를 참조할 수 있습니다.
```dart
var p = Point(2, 2);

// y 의 값 접근
assert(p.y == 2);

// p 의 distanceTo() 를 호출합니다.
double distance = p.distanceTo(Point(4, 4));
```

`?.` 을 사용하면 객체가 `null` 인 경우의 예외를 방지할 수 있습니다.
```dart
// p 가 null 이 아니면 y 의 값을 a 에 대입합니다.
var a = p?.y;
```

## 생성자(Constructor) 사용하기
`생성자` 를 사용해서 객체를 만들 수 있습니다. 생성자 이름은 `ClassName` 또는 `ClassName.identifier` 일 수 있습니다. 예를 들면, 다음 코드는 `Point()` 및 `Point.fromJson()` 생성자를 사용해서 객체를 만듭니다.
```dart
var p1 = Point(2, 2);
var p2 = Point.fromJson({'x': 1, 'y': 2});
```

다음 코드는 같은 결과값을 가지지만 생성자 앞에 `new` 키워드를 사용합니다.
```dart
var p1 = new Point(2, 2);
var p2 = new Point.fromJson({'x': 1, 'y': 2});
```

일부 클래스는 `상수 생성자(constant constructor)` 를 제공합니다. 상수 생성자를 사용해서 컴파일타임 상수를 만들기 위해서는 생성자 앞에 `const` 키워드를 입력합니다.
```dart
var p = const ImmutablePoint(2, 2);
```

두 개의 동일한 컴파일타임 상수를 생성하면, 같은 인스턴스가 생성됩니다.
```dart
var a = const ImmutablePoint(1, 1);
var b = const ImmutablePoint(1, 1);

assert(identical(a, b)); // 두 인스턴스는 같습니다.
```

`상수 컨텍스트(constant context)` 내에서는 생성자 또는 리터럴 앞의 `const` 를 생략할 수 있습니다. 다음 예시는 상수 맵을 만드는 코드입니다.
```dart
// const 키워드가 많이 사용되었습니다.
const pointAndLine = const {
  'point': const [const ImmutablePoint(0, 0)],
  'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};
```

위 코드에서 첫 번째 `const` 를 제외하고 나머지는 모두 생략할 수 있습니다.
```dart
// 상수 컨텍스트를 사용하면 하나의 const만 있어도 됩니다.
const pointAndLine = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};
```

상수 생성자가 상수 컨텍스트 외부에 있고 `const` 없이 호출되면 `상수가 아닌(non-constant) 객체` 를 만듭니다.
```dart
var a = const ImmutablePoint(1, 1); // 상수를 생성합니다.
var b = ImmutablePoint(1, 1); // 상수를 생성하지 않습니다.

assert(!identical(a, b)); // 같은 인스턴스가 아닙니다.
```

## 객체 타입 추정 (Getting an Object's Type)
`런타임` 에 객체의 타입을 추정하기 위해서는 `Object` 의 `runtimeType` 속성을 사용하면 됩니다. 이 속성은 `Type` 객체를 반환합니다.
```dart
print('The type of a is ${a.runtimeType}');
```

> 객체 타입을 테스트할 때 `runtimeType` 보다는 `type test operator(as, is, is!)` 를 사용하세요. 프로덕션 환경에서, `object is Type` 이 `object.runtimeType == Type` 보다 안정적입니다.

여기까지 `클래스` 를 사용하는 방법에 대해 알아보았습니다. 이 다음부터는 클래스를 구현하는 방법을 알아보겠습니다.

## 인스턴스 변수 (Instance Variables)
다음은 `인스턴스 변수` 를 선언하는 방법입니다.
```dart
class Point {
  double? x; // 인스턴스 변수 x 선언, 초기값은 null 입니다.
  double? y; // 인스턴스 변수 y 선언, 초기값은 null 입니다.
  double z = 0; // 인스턴스 변수 z 선언, 초기값은 0 입니다.
}
```

초기화되지 않은 모든 인스턴스 변수의 초기값은 `null` 입니다.

모든 인스턴스 변수는 암시적으로 `getter` 메서드를 생성합니다. `final` 이 아닌 인스턴스 변수와 초기화가 없는 `late final` 인스턴스 변수도 암시적으로 `setter` 메서드를 생성합니다. 자세한 내용은 [`Getter 와 Setter`](https://dart.dev/language/methods#getters-and-setters) 를 확인하세요.

`late` 가 아닌 인스턴스 변수를 초기화(`initialize`)하는 경우, 인스턴스가 생성될 때 값이 설정됩니다. 이 값은 생성자와 `초기화 목록(initializer list)` 이 시행되기 전에 설정됩니다. 결과적으로, `late` 가 아닌 인스턴스 변수의 초기화 단계에서 `this` 에 접근할 수 없습니다.
```dart
class Point {
  double? x; // 인스턴스 변수 x 선언, 초기값은 null 입니다.
  double? y; // 인스턴스 변수 y 선언, 초기값은 null 입니다.
}

void main() {
  var point = Point();
  point.x = 4; // x 의 setter 메서드를 사용합니다.
  assert(point.x == 4); // x 의 getter 메서드를 사용합니다.
  assert(point.y == null); // 변수의 초기값은 null 입니다.
}
```

인스턴스 변수는 `final` 이 될 수 있으며, 이 경우에는 정확히 한 번만 설정해야 합니다. 생성자 파라미터를 사용하거나 생성자의 초기화 목록을 사용을 사용해서 `late` 가 아닌 `final` 인스턴스 변수를 초기화합니다.
```dart
class ProfileMark {
  final String name;
  final DateTime start = DateTime.now();

  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}
```

생성자 본문이 시작된 후 `final` 인스턴스 변수의 값을 할당해야 하는 경우, 다음 중 하나를 사용할 수 있습니다.

- `팩토리 생성자(factory constructor)` 사용
- `late final` 사용 (주의: 초기화가 없는 late final은 API에 setter를 추가합니다.)

## 추상 클래스 (Abstract Classes)
`abstract` 한정자를 사용해서 인스턴스화할 수 없는 `추상 클래스` 를 정의합니다. 추상 클래스는 인터페이스를 정의하는 데 유용합니다. 추상 클래스를 인스턴스화할 수 있는 것처럼 보이게 하려면 `팩토리 생성자` 를 정의하면 됩니다.

추상 클래스에는 종종 `추상 메서드 (Abstract Methods)` 가 있습니다. 다음은 추상 메서드가 있는 추상 클래스를 선언하는 예시 코드입니다.
```dart
// 추상 클래스로 선언된 클래스입니다.
// 이 클래스는 인스턴스화할 수 없습니다.
abstract class AbstractContainer {
  // 생성자, 필드, 메서드 등등 정의 ...

  void updateChildren(); // 추상 메서드
}
```