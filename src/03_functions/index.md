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

## 파라미터
`함수` 는 필수 위치 파라미터(`Required Positional Parameters`)를 몇 개든 가질 수 있습니다. `필수 위치 파라미터` 뒤에는 이름이 지정된 파라미터(`Named Parameters`) 또는 선택적 위치 파라미터(`Optional Positional Parameters`)가 올 수 있습니다.

> Note: 일부 API(특히 Flutter 위젯 생성자)는 `필수 파라미터` 의 경우에도 `이름이 지정된 파라미터` 만 사용합니다.

함수에 인수를 전달하거나 파라미터를 정의할 때 후행 쉼표(`,`)를 사용할 수 있습니다.

### 이름이 지정된 파라미터 (Named Parameters)
`이름이 지정된 파라미터` 는 명시적으로 `required` 라고 표시되지 않는 한 선택사항입니다.
`함수` 를 정의할 때 `{ param1, param2 }` 를 사용하여 `이름이 지정된 파라미터` 를 지정합니다. 기본값을 제공하지 않거나 `이름이 지정된 파라미터` 를 `required` 로 표시하지 않으면 기본값이 `null` 이므로, 파라미터는 null을 허용해야 합니다.
```dart
/// [bold] 와 [hidden] flag를 설정하세요. ...
void enableFlags({bool? bold, bool? hidden}) {...}
```

`함수` 를 호출할 때 `paramName: value` 를 사용하여 `이름이 지정된 파라미터` 를 지정할 수 있습니다.
```dart
enableFlags(bold: true, hidden: false);
```

`null` 이외의 `이름이 지정된 파라미터` 에 대한 기본값을 정의하려면 `=` 를 사용합니다. 지정된 값은 컴파일타임 상수여야 합니다.
```dart
/// [bold] 와 [hidden] flag를 설정하세요. ...
void enableFlags({bool bold = false, bool hidden = false}) {...}

// bold는 true, hidden은 false가 됩니다.
enableFlags(bold: true);
```

`함수` 호출자가 파라미터에 대한 값을 필수로 지정하게 하려면 `required` 키워드를 추가합니다.
```dart
const Scrollbar({super.key, required Widget child});
```

누군가가 `child` 인수를 명시하지 않고 `Scrollbar` 인스턴스를 만들때, analyzer는 문제가 있다고 인지합니다.

> Note: `required` 로 표시된 파라미터는 `null` 이 될 수 있습니다.
> ```dart
> const Scrollbar({super.key, required Widget? child});
> ```

위치가 지정된 인수를 먼저 추가하고 싶을 수 있지만 `Dart` 에서는 필수가 아닙니다. `Dart` 는 `이름이 지정된 파라미터` 를 아무 위치에 추가할 수 있습니다.
```dart
repeat(times: 2, () {
  ...
});
```

### 선택적 위치 파라미터 (Optional Positional Parameters)
`함수` 파라미터 세트를 `[]` 로 감싸면 `선택적 위치 파라미터` 로 표시됩니다. 기본값을 제공하지 않으면 기본값이 `null` 이 되므로, `null` 을 허용해야 합니다.
```dart
String say(String from, String msg, [String? device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
```

다음은 `선택적 파라미터` 없이 이 `함수` 를 호출하는 예시입니다.
```dart
assert(say('Bob', 'Howdy') == 'Bob says Howdy');
```

다음은 세 번째 파라미터를 사용하여 이 `함수` 를 호출하는 예시입니다.
```dart
assert(say('Bob', 'Howdy', 'smoke signal') ==
    'Bob says Howdy with a smoke signal');
```

`null` 이외의 `선택적 위치 파라미터` 에 대한 기본값을 정의하려면 `=` 를 사용합니다. 지정된 값은 컴파일타임 상수여야 합니다.
```dart
String say(String from, String msg, [String device = 'carrier pigeon']) {
  var result = '$from says $msg with a $device';
  return result;
}

assert(say('Bob', 'Howdy') == 'Bob says Howdy with a carrier pigeon');
```