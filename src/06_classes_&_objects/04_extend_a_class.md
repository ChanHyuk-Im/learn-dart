# 클래스 확장 (Extend a Class)

`extends` 키워드를 사용해서 하위 클래스를 생성하고, `super` 키워드를 사용해서 상위 클래스를 참조할 수 있습니다.
```dart
class Television {
  void turnOn() {
    _illuminateDisplay();
    _activateIrSensor();
  }
  // ···
}

class SmartTelevision extends Television {
  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }
  // ···
}
```

`extends` 의 다른 사용법은 [파라미터화된 타입](https://dart.dev/language/generics#restricting-the-parameterized-type)의 설명을 참조하세요.

## 멤버 오버라이딩 (Overriding Members)
하위 클래스는 `연산자` 를 포함한 `인스턴스 메서드`, `Getter` 및 `Setter` 를 재정의(`오버라이딩`)할 수 있습니다. `@override` 를 사용해서 의도적으로 오버라이딩하고 있다는 것을 나타낼 수 있습니다.
```dart
class Television {
  // ···
  set contrast(int value) {...}
}

class SmartTelevision extends Television {
  @override
  set contrast(num value) {...}
  // ···
}
```

오버라이딩 메서드 선언은 여러 방면으로 오버라이딩된 메서드와 일치해야 합니다.

- 반환(`return`) 타입은 오버라이딩된 메서드의 반환 타입과 동일해야 합니다.
- 인수 타입은 오버라이딩된 메서드와 동일한 타입이어야 합니다. 위 예시에서, `SmartTelevision` 의 `contrast Setter` 는 인수 타입을 `int` 에서 상위 타입인 `num` 으로 변경합니다.
- 오버라이딩된 메서드가 `n 위치 파라미터(n positional parameters)` 를 허용하는 경우, 오버라이딩 메서드는 n 위치 파라미터 도 허용해야 합니다.
- [제네릭 메서드](https://dart.dev/language/generics#using-generic-methods)는 제네릭이 아닌 메서드로 오버라이딩할 수 없고, 제네릭이 아닌 메서드는 제네릭 메서드로 오버라이딩할 수 없습니다.

경우에 따라 메서드 파라미터 또는 인스턴스 변수의 타입을 좁힐(`narrow`) 수 있습니다. 이것은 런타임에 타입 에러를 발생할 수 있다는 점에서 `다운캐스트` 와 비슷합니다. 그래도 코드가 타입 에러를 발생하지 않는다는 것을 보장할 수 있다면 타입을 좁힐 수 있습니다. 이 경우, 파라미터 선언에 [covariant 키워드](https://dart.dev/guides/language/sound-problems#the-covariant-keyword)를 사용하면 됩니다. 자세한 사항은 [Dart 언어 명세](https://dart.dev/guides/language/spec)를 확인하세요.

> 주의: `==` 를 오버라이딩하려면 객체의 `hashCode getter` 도 오버라이딩해야 합니다. `==` 및 `hashCode` 오버라이딩 예시는 [맵 키 구현](https://dart.dev/guides/libraries/library-tour#implementing-map-keys)을 참조하세요.

## noSuchMetnod()
존재하지 않는 메서드나 인스턴스 변수를 사용하려고 시도할 때마다 감지하거나 대응하려면 `noSuchMetnod()` 를 오버라이딩하면 됩니다.
```dart
class A {
  // noSuchMethod를 오버라이딩 하지 않으면
  // 존재하지 않는 멤버는 NoSuchMethodError 에러를 발생시킵니다.
  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: '
        '${invocation.memberName}');
  }
}
```

다음 중 하나에 해당하지 않는 한 구현되지 않는 메서드는 호출할 수 없습니다.

- 수신자(`The receiver`)가 `dynamic` 정적 타입을 가집니다.
- 수신자는 구현되지 않은 메서드(추상(`abstract`)은 제외)를 정의하는 정적 타입을 가지며, 수신자의 동적 타입은 `Object` 클래스의 구현과 다른 `noSuchMethod()` 구현을 가집니다.

자세한 정보는 비공식 [noSuchMethod 전달 명세](https://github.com/dart-lang/language/blob/main/archive/feature-specifications/nosuchmethod-forwarding.md)을 참조하세요.