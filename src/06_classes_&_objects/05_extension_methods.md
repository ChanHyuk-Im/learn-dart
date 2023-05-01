# 확장 메서드 (Extension Methods)
`확장 메서드` 는 기존 라이브러리에 기능을 추가합니다. 인지하지 못한 사이에 확장 메서드를 사용할 수도 있습니다. 예를 들어, IDE에서 코드 자동완성을 사용하면 일반 메서드와 함께 확장 메서드를 제안합니다.

## 개요 (Overview)
다른 개발자의 API를 사용하거나 일반적으로 사용되는 라이브러리를 구현할 때 API를 변경하는 것이 실용적이지 않거나 불가능한 경우가 많습니다. 그러나 일부 기능을 추가하고 싶을 수도 있습니다.

예를 들어, 다음은 문자열을 정수로 변환하는 코드입니다.
```dart
int.parse('42')
```

같은 기능을 `String` 기반으로 구현하는 방법도 있을 수 있습니다.
```dart
'42'.parseInt()
```

해당 코드를 사용하려면, `String` 클래스의 확장이 포함된 라이브러리를 `import` 할 수 있습니다.
```dart
import 'string_apis.dart';
// ···
print('42'.parseInt()); // 확장 메서드를 사용합니다.
```

확장은 `메서드` 뿐만 아니라 `Getter`, `Setter` 및 `연산자` 와 같은 다른 멤버도 정의할 수 있습니다. 또한 확장은 이름이 있을 수 있고, 이 것은 API 충돌이 발생가는 경우에 유용합니다. 다음은 문자열에서 작동하는 확장(`NumberParsing`)을 사용하여 확장 메서드 `parseInt()` 를 구현하는 방법입니다.
```dart
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
  // ···
}
```

다음 섹션에서는 확장 메서드를 사용하는 방법에 대해 알아보겠습니다. 그 다음에는 확장 메서드의 구현에 대한 섹션이 있습니다.

## 확장 메서드 사용하기 (Using Extension Methods)
모든 `Dart` 코드와 마찬가지로, 확장 메서드도 라이브러리에 있습니다. 확장 메서드를 사용하는 방법은 이전 예제에서 확인했습니다. 확장 메서드가 있는 라이브러리를 `import` 하고 일반 메서드처럼 사용하면 됩니다.
```dart
// String 확장이 포함된 라이브러리를 불러옵니다.
import 'string_apis.dart';
// ···
print('42'.padLeft(5)); // String 메서드를 사용합니다.
print('42'.parseInt()); // 확장 메서드를 사용합니다.
```

이것이 확장 메서드를 사용하기 위해 알아야 할 전부입니다. 코드를 작성할 때, 확장 메서드가 정적 타입(`dynamic`과 다름)에 의존하는 방식과 API 충돌을 해결하는 방법을 알아야 하는 경우가 있습니다.

### 정적 타입과 dynamic (Static types and dynamic)
`dynamic` 타입의 변수에 대해 확장 메서드를 호출할 수 없습니다. 예를 들어, 다음 코드는 런타임 예외를 발생시킵니다.
```dart
dynamic d = '2';
print(d.parseInt()); // 런타임 예외: NoSuchMethodError
```

확장 메서드는 `Dart` 의 타입 추론과 함께 작동합니다. 다음 코드는 변수 `v` 가 문자열 타입을 갖는 것으로 유추되기 때문에 잘 동작합니다.
```dart
var v = '2';
print(v.parseInt()); // 출력: 2
```

`dynamic` 에서 동작하지 않는 이유는, 확장 메서드는 수신자의 정적 타입에 대해 실행되기 때문입니다. 확장 메서드는 정적으로 실행되기 때문에 정적 함수를 호출하는 것만큼 빠릅니다.

정적 타입과 `dynamic` 에 대한 자세한 내용은 [Dart 타입 시스템](https://dart.dev/language/type-system)을 참조하세요.

### API 충돌 (API Conflicts)
확장 멤버가 인터페이스 또는 다른 확장 멤버와 충돌하는 경우, 몇 가지 옵션이 있습니다.

한 가지 옵션은, 충돌되는 API를 제한하기 위해 `show` 또는 `hide` 를 사용해서 `import` 하는 방법을 변경하는 것입니다.
```dart
// String 확장 메서드 parseInt()가 정의되어 있습니다.
import 'string_apis.dart';

// 마찬가지로 parseInt()가 정의되어있지만, NumberParsing2를 숨깁니다.
import 'string_apis_2.dart' hide NumberParsing2;

// ···
// 'string_apis.dart'에 정의되어있는 parseInt()를 사용합니다.
print('42'.parseInt());
```

다른 옵션은, 확장을 명시적으로 적용하는 것입니다. 그렇게 하면 확장이 래퍼 클래스(`Wrapper Class`)인것처럼 보이게 됩니다.
```dart
// String 확장 parseInt()가 라이브러리 둘 다에 정의되어 있고,
// 각 확장은 다른 이름을 가지고 있습니다.
import 'string_apis.dart'; // NumberParsing 확장.
import 'string_apis_2.dart'; // NumberParsing2 확장.

// ···
// print('42'.parseInt()); // 동작하지 않습니다.
print(NumberParsing('42').parseInt());
print(NumberParsing2('42').parseInt());
```

두 확장의 이름이 같으면 접두사(`Prefix`)를 사용해서 `import` 할 수 있습니다.
```dart
// 확장 메서드 parseInt()를 포함한 NumberParsing 확장이 라이브러리 둘 다에 정의되어있습니다.
// 'string_apis_3.dart'는 parseNum 확장도 정의합니다.
import 'string_apis.dart';
import 'string_apis_3.dart' as rad;

// ···
// print('42'.parseInt()); // 동작하지 않습니다.

// string_apis.dart의 ParseNumbers 확장을 사용합니다.
print(NumberParsing('42').parseInt());

// string_apis_3.dart의 ParseNumbers 확장을 사용합니다.
print(rad.NumberParsing('42').parseInt());

// string_apis_3.dart의 parseNum() 확장을 사용합니다.
print('42'.parseNum());
```

위 코드에서 볼 수 있듯이 접두사를 사용해서 `import` 하는 경우에도 암시적으로 확장 메서드를 호출할 수 있습니다. 접두사를 사용해야 하는 유일한 경우는 확장을 명시적으로 호출할 때 이름 충돌을 방지하는 것입니다.

## 확장 메서드 구현 (Implementing Extension Methods)
아래의 문법을 사용해서 확장을 구현할 수 있습니다.
```dart
extension <extension name>? on <type> {
  (<member definition>)*
}
```

예를 들어, `String` 클래스에서 확장을 구현하는 방법은 다음과 같습니다.
```dart
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }
}
```

확장의 멤버는 `메서드`, `Getter`, `Setter` 또는 `연산자` 일 수 있습니다. 확장에는 `정적 필드` 와 `정적 헬퍼 메서드` 도 있을 수 있습니다.

### 이름없는 확장 (Unnamed Extensions)
확장을 선언할 때 이름을 생략할 수 있습니다. 이름없는 확장은 선언된 라이브러리에서만 사용할 수 있고, 이름이 없기 때문에 API 충돌을 해결하기 위한 명시적 확장을 사용할 수 없습니다.
```dart
extension on String {
  bool get isBlank => trim().isEmpty;
}
```

> Note: 확장 선언 내에서만 이름없는 확장의 정적 멤버를 호출할 수 있습니다.

## 제네릭 확장 구현 (Implementing Generic Extensions)
확장은 제네릭 타입 파라미터를 가질 수 있습니다. 예를 들어, 다음은 `Getter`, `연산자` 그리고 `메서드`를 사용해서 `List<T>` 타입을 확장하는 코드입니다.
```dart
extension MyFancyList<T> on List<T> {
  int get doubleLength => length * 2;
  List<T> operator -() => reversed.toList();
  List<List<T>> split(int at) => [sublist(0, at), sublist(at)];
}
```

타입 `T` 는 메서드가 호출되는 `List` 의 정적 타입을 기반으로 바인딩됩니다.

## 추가정보
확장 메서드에 대해 더 자세히 알아보려면 다음 목록을 참고하세요.

- [Article: Dart Extension Methods Fundamentals](https://medium.com/dartlang/extension-methods-2d466cd8b308)
- [Feature specification](https://github.com/dart-lang/language/blob/main/accepted/2.7/static-extension-methods/feature-specification.md#dart-static-extension-methods-design)
- [Extension methods sample](https://github.com/dart-lang/samples/tree/main/extension_methods)