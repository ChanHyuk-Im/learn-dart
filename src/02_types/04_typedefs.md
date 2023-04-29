# Typedefs

타입 별칭(`typedef` 키워드로 선언되기 때문에 `typedef` 라고도 합니다.)은 타입을 참조하는 간단한 방법입니다. 다음은 `IntList` 라는 타입 별칭을 선언하고 사용하는 예시입니다.
```dart
typedef IntList = List<int>;
IntList il = [1, 2, 3];
```

타입 별칭은 타입 매개변수를 가질 수 있습니다.
```dart
typedef ListMapper<X> = Map<X, List<X>>;
Map<String, List<String>> m1 = {}; // 가독성이 떨어집니다.
ListMapper<String> m2 = {}; // 코드가 짧아져 가독성이 좋습니다.
```

> Version note: 2.13 이전에 `typedef` 는 함수 타입으로 제한되었습니다. 새로운 `typedef` 를 사용하려면 최소 2.13 이상 버전의 `Dart` 를 사용해야합니다.

대부분의 경우에는 함수에 대해 `typedef` 대신 `inline` 함수 타입을 사용하는 것이 권장됩니다. 하지만 함수 `typedef` 는 여전히 유용할 수 있습니다.
```dart
typedef Compare<T> = int Function(T a, T b);

int sort(int a, int b) => a - b;

void main() {
  assert(sort is Compare<int>); // True
}
```
