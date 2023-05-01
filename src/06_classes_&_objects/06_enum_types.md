# 열거형 (Enumerated Types)
`enumerations` 또는 `enums` 라고 불리는 `열거형` 은 고정된 수의 상수값을 나타내는 데 사용되는 특별한 종류의 클래스입니다.

> Note: 모든 열거형은 자동으로 `Enum` 클래스를 `extend` 합니다.
> 
> 추상 클래스의 믹스인은 `Enum` 을 명시적으로 구현하거나 `extend` 할 수 있지만 enum 선언에 의해 구현되거나 믹스인되지 않는 한 어떤 객체도 해당 클래스 또는 믹스인의 타입을 실제로 구현할 수 없습니다.

## 간단한 열거형 선언 (Declaring Simple Enums)
`간단한 열거형` 을 선언하려면 `enum` 키워드와 함께 열거하려는 값들의 목록을 사용합니다.
```dart
enum Color { red, green, blue }
```

> Tip: 복사-붙여넣기 에러를 방지하기 위해 열거형을 선언할 때 후행 쉼표(`trailing commas`)를 사용할 수 있습니다.

## 향상된 열거형 선언 (Declaring Enhanced Enums)
`Dart` 는 열거형 선언이 상수 인스턴스의 고정된 수로 제한되는 필드, 메서드 및 `const` 생성자로 클래스를 선언하도록 허용합니다.

`향상된 열거형` 을 선언하려면 일반 클래스와 유사한 구문을 사용하면 되지만, 몇 가지 확인해야할 추가 사항이 있습니다.

- 믹스인에 의해 추가된 변수를 포함해서 인스턴스 변수는 `final` 변수여야 합니다.
- 모든 만들어진 생성자는 상수여야 합니다.
- 팩토리 생성자는 고정된 또는 알려진 열거형 인스턴스 중 하나만 반환할 수 있습니다.
- `Enum` 은 자동으로 `extend` 되므로 다른 클래스는 `extend` 할 수 없습니다.
- `index`, `hashCode`, `==` 에 대한 오버라이드를 할 수 없습니다.
- `values` 로 불리는 멤버는 자동으로 생성된 정적 `values Getter` 와 충돌하므로 열거형에서 선언할 수 없습니다.
- 열거형의 모든 인스턴스는 선언부 시작부분에 선언되어야하며, 적어도 하나의 인스턴스가 선언되어야 합니다.

향상된 열거형의 인스턴스 메서드는 `this` 를 사용해서 현재 열거형 값을 참조할 수 잇습니다.

다음은 `여러 인스턴스`, `인스턴스 변수`, `Getter` 및 `구현된 인터페이스` 로 향상된 열거형을 선언하는 예시입니다.
```dart
enum Vehicle implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });

  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == Vehicle.bicycle;

  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}
```

> Version note: 향상된 열거형을 사용하려면 언어 버전이 2.17 이상이어야 합니다.

## 열거형 사용하기 (Using Enums)
다른 정적 변수와 마찬가지로 열거된 값에 접근합니다.
```dart
final favoriteColor = Color.blue;
if (favoriteColor == Color.blue) {
  print('Your favorite color is blue!');
}
```

열거형의 각 값에는 0부터 시작하는 위치를 반환하는 `index Getter` 가 있습니다. 예를 들어, 첫 번째 값의 index는 0이고 두 번째 값의 index는 1입니다.
```dart
assert(Color.red.index == 0);
assert(Color.green.index == 1);
assert(Color.blue.index == 2);
```

열거형의 모든 값의 목록을 얻으려면 열거형의 `values` 상수를 사용하면 됩니다.
```dart
List<Color> colors = Color.values;
assert(colors[2] == Color.blue);
```

`switch` 문에서 열거형을 사용할 수 있으며, 열거형의 모든 값을 처리하지 않으면 경고(`warning`)가 발생됩니다.
```dart
var aColor = Color.blue;

switch (aColor) {
  case Color.red:
    print('Red as roses!');
    break;
  case Color.green:
    print('Green as grass!');
    break;
  default: // 이 부분이 없으면 경고가 표시됩니다.
    print(aColor); // 'Color.blue'
}
```

`Color.blue` 에서 `'blue'` 와 같은 열거형 값의 이름에 접근해야하는 경우, `.name` 속성을 사용합니다.
```dart
print(Color.blue.name); // 'blue'
```

열거형 값의 멤버에 접근해야하는 경우, 일반 객체처럼 사용하면 됩니다.
```dart
print(Vehicle.car.carbonFootprint);
```