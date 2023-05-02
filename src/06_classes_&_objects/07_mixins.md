# 믹스인 (Mixins)
`믹스인` 은 여러 클래스 계층 구조에서 클래스 코드를 재사용하는 방법입니다.

믹스인을 사용하려면 `with` 키워드와 하나 이상의 믹스인 이름을 사용합니다. 다음 예제는 믹스인을 사용하는 두 클래스입니다.
```dart
class Musician extends Performer with Musical {
  // ···
}

class Maestro extends Person with Musical, Aggressive, Demented {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}
```

믹스인을 구현하려면 `Object` 를 확장하고 생성자를 선언하지 않는 클래스를 만듭니다. 믹스인을 일반 클래스로 사용하지 않으려면 `class` 대신에 `mixin` 키워드를 사용합니다.
```dart
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}
```

때때로 믹스인을 사용할 수 있는 타입을 제한하려는 경우가 있습니다. 예를 들어, 믹스인은 믹스인이 정의하지 않은 메서드를 호출할 수 있는지 여부에 따라 달라질 수 있습니다. 다음 예시에서 볼 수 있듯이 `on` 키워드를 사용하여 필요한 상위 클래스를 지정함으로써 믹스인의 사용을 제한할 수 있습니다.
```dart
class Musician {
  // ...
}
mixin MusicalPerformer on Musician {
  // ...
}
class SingerDancer extends Musician with MusicalPerformer {
  // ...
}
```

위 코드에서 `Musician` 클래스를 `extend` 하거나 구현하는 클래스만 `MusicalPerformer` 믹스인을 사용할 수 있습니다. `SingerDancer` 는 `Musician` 을 `extend` 하기 때문에 `SingerDancer` 는 `MusicalPerformer` 믹스인을 사용할 수 있습니다.