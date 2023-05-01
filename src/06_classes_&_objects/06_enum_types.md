# 열거형 (Enumerated Types)
`enumerations` 또는 `enums` 라고 불리는 `열거형` 은 고정된 수의 상수값을 나타내는 데 사용되는 특별한 종류의 클래스입니다.

> Note: 모든 열거형은 자동으로 `Enum` 클래스를 `extend` 합니다.
> 
> 추상 클래스의 믹스인은 `Enum` 을 명시적으로 구현하거나 `extend` 할 수 있지만 enum 선언에 의해 구현되거나 믹스인되지 않는 한 어떤 객체도 해당 클래스 또는 믹스인의 타입을 실제로 구현할 수 없습니다.

## 간단한 열거형 선언 (Declaring Simple Enums)
간단한 열거형 타입을 선언하려면 `enum` 키워드와 함께 열거하려는 값들의 목록을 사용합니다.
```dart
enum Color { red, green, blue }
```

> Tip: 복사-붙여넣기 에러를 방지하기 위해 열거형을 선언할 때 후행 쉼표(`trailing commas`)를 사용할 수 있습니다.