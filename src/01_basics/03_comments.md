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