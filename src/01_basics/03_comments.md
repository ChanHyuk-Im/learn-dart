# 주석 (Comments)
`Dart` 는 `한 줄 주석(single-line)`, `여러 줄 주석(multi-line)` 및 `문서화 주석(documentation)`을 지원합니다.

## 한 줄 주석 (Single-line comments)
한 줄 주석은 `//` 로 시작합니다. `//` 와 줄 끝 사이의 모든 내용은 `Dart` 컴파일러에서 무시됩니다.
```dart
void main() {
  // TODO: refactor into an AbstractLlamaGreetingFactory?
  print('Welcome to my Llama farm!');
}
```

## 여러 줄 주석 (Multi-line comments)
여러 줄 주석은 `/*` 로 시작해서 `/*` 로 끝납니다. `/*` 와 `*/` 사이의 모든 내용은 문서 주석이 아닌 경우에 `Dart` 컴파일러에서 무시됩니다. 여러 줄 주석은 중첩해서 사용할 수 있습니다.
```dart
void main() {
  /*
   * This is a lot of work. Consider raising chickens.

  Llama larry = Llama();
  larry.feed();
  larry.exercise();
  larry.clean();
   */
}
```

## 문서화 주석 (Documentation comments)
문서화 주석은 `///` 또는 `/**` 로 시작하는 한 줄 또는 여러 줄 주석입니다. 연속된 줄에 `///` 를 사용하면 여러 줄 문서화 주석과 같은 효과가 있습니다.

문서화 주석 내에서 대괄호로 묶이지 않은 모든 텍스트를 무시합니다. 대괄호를 사용해서 클래스, 메서드, 필드, top-level 변수, 함수 및 파라미터를 참조할 수 있습니다. 괄호 안의 이름은 문서화된 프로그램 요소 범위에서 해석됩니다.

다음은 다른 클래스 및 인수에 대한 참조가 있는 문서화 주석의 예시입니다.
```dart
/// A domesticated South American camelid (Lama glama).
///
/// Andean cultures have used llamas as meat and pack
/// animals since pre-Hispanic times.
///
/// Just like any other animal, llamas need to eat,
/// so don't forget to [feed] them some [Food].
class Llama {
  String? name;

  /// Feeds your llama [food].
  ///
  /// The typical llama eats one bale of hay per week.
  void feed(Food food) {
    // ...
  }

  /// Exercises your llama with an [activity] for
  /// [timeLimit] minutes.
  void exercise(Activity activity, int timeLimit) {
    // ...
  }
}
```

생성된 클래스의 문서에서 `[feed]` 는 `feed` 메서드에 대한 문서가 링크되고, `[Food]` 는 `Food` 클래스에 대한 문서가 링크됩니다.

`Dart` 코드를 파싱하고 HTML 문서를 생성하려면 `Dart` 의 문서 생성 도구인 [dart doc](https://dart.dev/tools/dart-doc)을 사용할 수 있습니다. 생성된 문서의 예는 [Dart API 문서](https://api.dart.dev/stable/2.19.6/index.html)를 참조하세요. 주석 구조에 대한 더 자세한 내용은 [이펙티브 Dart: 문서화](https://dart.dev/guides/language/effective-dart/documentation)를 참조하세요.