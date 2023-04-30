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

## 연산자 (Operators)
`연산자` 는 특별한 이름을 가진 인스턴스 메서드입니다. `Dart` 는 다음 이름들로 연산자를 정의할 수 있습니다.
| | | | |
|---|---|---|---|
| < | + | \| | >>> |
| > | / | ^ | [] |
| <= | ~/ | & | []= |
| >= | * | << | ~ |
| - | % | >> | == |

> Note: `!=` 와 같은 연산자는 목록에 없습니다. 그것들은 단지 `문법적 설탕(Syntatic Sugar)` 이기 때문입니다. 예를 들어, `e1 != e2`  표현식은 `!(e1 == e2)` 의 문법적 설탕입니다.

연산자 선언은 내장 `operator` 식별자를 통해 식별됩니다. 다음 예시에서는 벡터 더하기(`+`), 빼기(`-`), 같음(`==`)을 정의합니다.
```dart
class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  @override
  bool operator ==(Object other) =>
      other is Vector && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}

void main() {
  final v = Vector(2, 3);
  final w = Vector(2, 2);

  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));
}
```