# 호출가능한 클래스 (Callable Classes)
`Dart` 클래스의 인스턴스가 함수처럼 호출되도록 하려면 `call()` 메서드를 구현하면 됩니다.

`call()` 메서드를 사용하면 이를 정의하는 모든 클래스가 함수를 할당할 수 있습니다. 이 메서드는 파라미터 및 반환 타입과 같은 일반 함수와 동일한 기능을 지원합니다.

다음 예제에서 `WannabeFunction` 클래스는 3개의 문자열을 받아와 연결하고 각 문자열을 공백으로 구분한 후 느낌표를 추가하는 `call()` 함수를 정의합니다.
```dart
class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}

var wf = WannabeFunction();
var out = wf('Hi', 'there,', 'gang');

void main() => print(out);
```