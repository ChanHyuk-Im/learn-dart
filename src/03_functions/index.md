# Functions (함수)

`Dart` 는 진정한 객체지향 언어이기 때문에 `함수` 도 객체이며, 타입은 `Function` 입니다. 이것은 `함수` 가 변수에 할당되거나 다른 함수에 인수로 전달될 수 있음을 의미합니다. 또한 `Dart` 클래스의 인스턴스를 함수인 것처럼 호출할 수도 있습니다.

다음은 함수 구현 예시입니다.
```dart
bool isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
```

`Effective Dart` 는 공개 API에 대한 타입 주석을 권장하지만, 타입을 생략해도 `함수` 는 작동합니다.
```dart
isNoble(atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
```

하나의 표현식을 가지는 `함수` 는 간단한 구문을 사용할 수 있습니다.
```dart
bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
```

`=> expr` 구문은 `{ return expr; }` 의 축약입니다. `=>` 표기법은 `화살표 구문` 이라고도 합니다.

> Note: `=>` 와 `;` 사이에는 명령문이 아닌 표현식만 사용할 수 있습니다. 예를 들면, `if` 문은 넣을 수 없지만 조건식은 사용할 수 있습니다.
