# Generics (제네릭)

기본 배열 타입인 `List` 의 API 문서를 보면, 실제로는 `List<E>` 타입으로 되어있습니다. `<...>` 표기법은 리스트를 일반 유형, 즉 형식 매개변수가 있는 타입으로 표시합니다. 컨벤션에 따르면, 대부분의 타입 변수는 `E`, `T`, `S`, `K` 그리고 `V` 처럼 단일 문자를 사용합니다.

## 제네릭을 사용하는 이유
`제네릭` 은 타입 안전성을 위해 종종 필요하지만 코드가 실행되게 하는 것보다 더 많은 이점이 있습니다.

- `제네릭` 타입을 올바르게 지정하면 코드가 더 잘 생성됩니다.
- `제네릭` 을 사용해서 코드 중복을 줄일 수 있습니다.

리스트에 문자열만 포함하려면 `List<String>` 으로 선언할 수 있습니다. 이렇게 해두면 다른 개발자들이나 개발도구가 리스트에 문자열이 아닌 것을 할당하는 것이 실수일 수 있다는 것을 인식할 수 있습니다. 예시는 다음과 같습니다.
```dart
var names = <String>[];
names.addAll(['Seth', 'Kathy', 'Lars']);
names.add(42); // Error
```

`제네릭` 을 사용하는 또 다른 이유는 코드 중복을 줄이기 위해서입니다. `제네릭` 을 사용하면 정적 분석을 활용하면서 여러 타입간에 단일 인터페이스 및 구현을 공유할 수 있습니다. 예를 들어서, 객체를 캐싱하기 위한 인터페이스를 만든다고 생각해보겠습니다.
```dart
abstract class ObjectCache {
  Object getByKey(String key);
  void setByKey(String key, Object value);
}
```

이 인터페이스의 문자열 버전을 원하는 경우에, 다른 인터페이스를 만듭니다.
```dart
abstract class StringCache {
  String getByKey(String key);
  void setByKey(String key, String value);
}
```

시간이 지난 후에 이 인터페이스의 숫자 버전이 필요해졌습니다... 이제 이해할 수 있을 것입니다.

`제네릭` 타입을 사용하면 이런 모든 인터페이스를 만드는 수고를 덜어줍니다. 대신에, 타입 매개변수를 사용하는 단일 인터페이스를 만들 수 있습니다.
```dart
abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}
```

이 코드에서 `T` 는 대체 타입입니다. 이것은 개발자가 나중에 정의할 수 있는 유형입니다.

## 컬렉션 리터럴 사용
리스트, 셋 그리고 맵 리터럴을 매개변수화할 수 있습니다. 매개변수화 리터럴은 시작 괄호 앞에 `<type>(리스트 또는 셋)` 또는 `<keyType, valueType>(맵)` 을 추가한다는 점을 제외하고는 이미 봐왔던 리터럴의 경우와 같습니다. 다음은 지정된 리터럴을 사용하는 예제입니다.
```dart
var names = <String>['Seth', 'Kathy', 'Lars'];
var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
var pages = <String, String>{
  'index.html': 'Homepage',
  'robots.txt': 'Hints for web robots',
  'humans.txt': 'We are people, not machines'
};
```

## 생성자에 매개변수화된 타입 사용
생성자를 사용할 때 하나 이상의 타입을 지정하려면 클래스 이름 바로 뒤에 `<...>` 를 추가합니다.
```dart
var nameSet = Set<String>.from(names);
```

다음은 정수형 키와 `View` 타입 값을 가지는 맵을 만드는 코드입니다.
```dart
var views = Map<int, View>();
```

## 제네릭 컬렉션과 컬렉션에 포함된 타입
`Dart` 의 `제네릭` 타입은 구체화되어 런타임시에 유형 정보를 전달합니다. 예를 들어, 컬렉션의 타입을 테스트할 수 있습니다.
```dart
var names = <String>[];
names.addAll(['Seth', 'Kathy', 'Lars']);
print(names is List<String>); // true
```

> Note: `Dart` 와는 대조적으로, `Java` 의 `제네릭` 은 소거를 사용합니다. 이는 `제네릭` 타입 매개변수가 런타임에 제거됨을 의미합니다. `Java` 에서 객체가 `List` 인지는 테스트할 수 있지만, `List<String>` 인지는 테스트할 수 없습니다.

## 매개변수화된 타입 제한
`제네릭` 타입을 구현할 때, 인수로 제공되는 타입을 제한하여 인수가 특정 타입의 하위타입이어야 하고, `extends` 키워드를 사용하여 구현할 수 있습니다.
일반적인 유즈케이스는 기본값인 `Object?` 대신 `Object` 의 하위타입을 사용하여 null을 허용하지 않도록 하는 것입니다.
```dart
class Foo<T extends Object> {
  // Any type provided to Foo for T must be non-nullable.
}
```

`Object` 외에 다른 타입으로 `extends` 를 사용할 수 있습니다. 다음은 `SomeBaseClass` 를 확장하여 `SomeBaseClass` 의 멤버를 `T` 타입 객체에서 호출할 수 있도록 하는 예시입니다.
```dart
class Foo<T extends SomeBaseClass> {
  // Implementation goes here...
  String toString() => "Instance of 'Foo<$T>'";
}

class Extender extends SomeBaseClass {...}
```

`SomeBaseClass` 또는 해당 하위타입을 `제네릭` 인수로 하용해도 됩니다.
```dart
var someBaseClassFoo = Foo<SomeBaseClass>();
var extenderFoo = Foo<Extender>();
```

`제네릭` 인수를 지정하지 않아도 괜찮습니다.
```dart
var foo = Foo();
print(foo); // Instance of 'Foo<SomeBaseClass>'
```

`SomeBaseClass` 가 아닌 타입을 지정하면 에러가 발생합니다.
```dart
var foo = Foo<Object>();  // Error
```

## 제네릭 메서드 사용
메서드와 함수도 타입 인수를 허용합니다.
```dart
T first<T>(List<T> ts) {
  // Do some initial work or error checking, then...
  T tmp = ts[0];
  // Do some additional checking or processing...
  return tmp;
}
```

`first(<T>)` 에서 제네릭 타입 인수를 사용하면 다음과 같은 여러 위치에서 타입 매개변수 `T` 를 사용할 수 있습니다.

- 함수 반환 타입 (`T`)
- 인수 타입 (`List<T>`)
- 지역 변수 타입 (`T tmp`)