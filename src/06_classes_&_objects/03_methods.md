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

## Getter 와 Setter (Getter and Setter)
`Getter` 와 `Setter` 는 객체의 속성에 대한 읽기 및 쓰기 기능을 제공하는 특수한 메서드입니다. 각 인스턴스 변수에는 암시적으로 `Getter` 가 있고, 경우에 따라 `Setter` 가 있습니다. `get` 및 `set` 키워드를 사용해서 `Getter` 와 `Setter` 를 추가적으로 구현할 수 있습니다.
```dart
class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // 연산되는 속성 right 와 bottom 을 정의합니다.
  double get right => left + width;
  set right(double value) => left = value - width;
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

void main() {
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}
```

`Getter` 와 `Setter` 를 사용하면 인스턴스 변수로 시작해서 나중에 메서드로 래핑하기 쉽습니다.

> Note: `++` 같은 연산자는 `Getter` 와 상관없이 기존대로 동작합니다. 예상치 못한 부작용을 피하기 위해 연산자는 `Getter` 를 정확히 한 번만 호출해서 해당 값을 임시 변수에 저장합니다.