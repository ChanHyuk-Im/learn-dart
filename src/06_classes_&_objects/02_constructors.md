# 생성자 (Constructors)
클래스와 동일한 이름을 가진 함수를 생성해서 `생성자` 를 선언합니다(선택적으로, 명명된 생성자(`Named Constructors`)에 설명된 추가 식별자 추가). 가장 일반적인 형태의 생성자는 클래스의 새 인스턴스를 만듭니다.
```dart
class Point {
  double x = 0;
  double y = 0;

  Point(double x, double y) {
    // 인스턴스 변수를 초기화하기 위한 더 나은 방법은
    // 형식 매개변수 초기화(Initializing Formal Parameter)를 참조하세요.
    this.x = x;
    this.y = y;
  }
}
```

`this` 키워드는 현재 인스턴스를 참조합니다.

> Note: `this` 는 이름이 충돌하는 경우에만 사용하세요. 그렇지 않으면 `Dart` 스타일은 `this` 를 생략합니다.