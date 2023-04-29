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
생성자를 선언하지 않으면 `기본 생성자` 가 제공됩니다. 기본 생성자는 인수가 없으며, 수퍼클래스에서 인수가 없는 생성자를 호출합니다.