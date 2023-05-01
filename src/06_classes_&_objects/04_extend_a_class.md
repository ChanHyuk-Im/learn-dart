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