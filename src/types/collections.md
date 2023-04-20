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