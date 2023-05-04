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