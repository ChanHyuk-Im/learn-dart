# 메타데이터 (Metadata)
메타데이터를 사용해서 코드에 대한 추가 정보를 제공합니다. 메타데이터 주석은 `@` 문자로 시작하고, 컴파일타임 상수에 대한 참조 또는 상수 생성자에 대한 호출이 뒤따릅니다.

모든 `Dart` 코드에서는 `@Deprecated`, `@deprecated` 및 `@override` 세 가지 메타데이터 주석을 사용할 수 있습니다. `@override` 사용 예제는 [클래스 확장](https://dart.dev/language/extend)을 참조하세요. 다음은 `@Deprecated` 메타데이터 주석을 사용하는 예시입니다.
```dart
class Television {
  /// 대신에 [turnOn]을 사용하세요.
  @Deprecated('Use turnOn instead')
  void activate() {
    turnOn();
  }

  /// TV의 전원을 켭니다.
  void turnOn() {...}
  // ···
}
```

커스텀 메타데이터 주석을 정의할 수도 있습니다. 다음은 두 개의 인수를 사용하는 `@Todo` 주석을 정의하는 예시입니다.
```dart
class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}
```

다음 코드는 `@Todo` 주석을 사용하는 예시입니다.
```dart
@Todo('Dash', 'Implement this function')
void doSomething() {
  print('Do something');
}
```

메타데이터는 라이브러리, 클래스, typedef, 타입 파라미터, 생성자, 팩토리 함수, 필드, 파라미터 또는 변수 선언 앞과 import 또는 export 지시문 앞에 사용할 수 있습니다. `리플렉션(reflection)` 을 사용해서 런타임에 메타데이터를 검색할 수 있습니다.