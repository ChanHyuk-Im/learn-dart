# 메서드 (Methods)
`메서드` 는 객체의 동작을 제공하는 함수입니다.

## 인스턴스 메서드 (Instance Methods)
객체의 `인스턴스 메서드` 는 인스턴스 변수 및 `this` 에 접근할 수 있습니다. 다음 코드의 `distanceTo()` 메서드는 인스턴스 메서드의 예시입니다.
```dart
import 'dart:math';

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}
```

