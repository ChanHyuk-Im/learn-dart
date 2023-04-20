# Collections

`Dart` 는 내장 타입으로 `list`, `set` 그리고 `map` 을 제공합니다.

### List
`Dart` 에서의 배열은 `List` 라고 불립니다. 리스트 리터럴은 `,` 로 구분된 표현식 또는 값을 `[]` 로 묶은 객체입니다.
```dart
var list [1, 2, 3];
```

> Note: `Dart` 에서 리스트는 `List<int>` 타입이라고 추론합니다. 정수가 아닌 객체를 이 리스트에 추가하려고 하면 `analyzer` 또는 `runtime` 에서 에러가 발생합니다.

콜렉션 리스트 아이템 마지막에 `,` 를 추가할 수 있습니다. 이 쉼표는 콜렉션에 영향을 미치지는 않지만, 복사-붙여넣기 에러를 방지하는 데에 도움이 될 수 있습니다.
```dart
var list = [
  'Car',
  'Boat',
  'Plane',
];
```

리스트는 0부터 시작하는 인덱스를 가집니다. `0` 은 리스트의 첫번째 값이고, `list.length - 1` 은 리스트의 마지막 값입니다. 리스트의 길이는 `.length` 속성으로 구할 수 있고, `[]` 연산자를 사용하여 값에 접근할 수 있습니다.
```dart
var list = [1, 2, 3];
assert(list.length == 3);
assert(list[1] == 2);

list[1] = 1;
assert(list[1] == 1);
```

컴파일타임 상수 리스트를 만들려면 리스트 리터럴 앞에 `const` 키워드를 붙이면 됩니다.
```dart
var constantList = const [1, 2, 3];
// constantList[1] = 1; // 에러 발생
```

### Sets
`Dart` 의 셋은 고유한 아이템들의 정렬되지 않은 콜렉션입니다. 셋은 셋 리터럴과 `Set` 타입이 제공됩니다.
```dart
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
```

> Note: `Dart` 는 `halogens` 변수가 셋 타입이라고 추론합니다. 잘못된 타입의 변수를 추가하려고 하면 `analyzer` 또는 `runtime` 에서 에러가 발생합니다.

빈 셋을 만드려면 `{}` 앞에 타입 인수를 사용하거나 `{}` 를 `Set` 타입 변수에 할당합니다.
```dart
var names = <String>{};
// Set<String> names = {}; // 이렇게 선언해도 됩니다.

// var names = {}; // set이 아닌 map을 만듭니다.
```

> `Set` 또는 `Map`? 맵 리터럴과 셋 리터럴은 문법적으로 유사합니다. 맵 리터럴이 먼저 정의되었기 때문에 `{}` 는 `Map` 타입으로 추론됩니다. 따라서 `{}` 앞에 타입 인수를 추가하지 않으면 `Dart` 에서는 `Map<dynamic, dynamic>` 타입의 객체가 생성됩니다.

셋에 이이템을 추가하려면 `add()` 또는 `addAll()` 메소드를 사용합니다.
```dart
var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);
```

`.length` 속성으로 셋 아이템의 갯수를 구할 수 있습니다.
```dart
var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);
assert(elements.length == 5);
```

컴파일타임 상수 셋을 만들려면 셋 리터럴 앞에 `const` 키워드를 붙이면 됩니다.
```dart
final constantSet = const {
  'fluorine',
  'chlorine',
  'bromine',
  'iodine',
  'astatine',
};
// constantSet.add('helium'); // 에러 발생
```

### Maps
일반적으로 맵은 키와 값을 연결하는 객체입니다. 키와 값은 어떤 타입의 객체가 될 수 있습니다. 키는 하나만 존재할 수 있지만, 값은 같은 값이 중복될 수 있습니다. 맵은 맵 리터럴과 `Map` 타입이 제공됩니다.

`Dart` 에서 맵을 만드는 방법은 아래와 같습니다.
```dart
var gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings'
};

var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};
```

> Note: `Dart` 는 `gifts` 변수의 타입을 `Map<String, String>` 으로 추론하고, `nobleGases` 변수의 타입을 `Map<int, String>` 으로 추론합니다.

`Map` 생성자를 이용해서 같은 객체를 만들 수 있습니다.
```dart
var gifts = Map<String, String>();
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var nobleGases = Map<int, String>();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';
```

> Note: 다른 객체지향 언어에 익숙한 경우에는 `Map()` 대신에 `new Map()` 을 사용하고 싶을 수 있습니다. `Dart` 에서 `new` 키워드는 선택사항입니다.

새로운 키-값 쌍을 추가하고싶으면, `[]=` 연산자를 사용합니다.
```dart
var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds'; // 키-값 쌍 추가
```

값에 접근할 때에는 `[]` 연산자를 사용합니다.
```dart
var gifts = {'first': 'partridge'};
assert(gifts['first'] == 'partridge');
```

맵에 키에 해당하는 값이 없는 경우에는 `null` 을 반환합니다.
```dart
var gifts = {'first': 'partridge'};
assert(gifts['fifth'] == null);
```

`.length` 속성으로 맵의 키-값 쌍의 갯수를 구할 수 있습니다.
```dart
var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds';
assert(gifts.length == 2);
```

컴파일타임 상수 맵을 만들려면 맵 리터럴 앞에 `const` 키워드를 붙이면 됩니다.
```dart
final constantMap = const {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};

// constantMap[2] = 'Helium'; // 에러 발생
```