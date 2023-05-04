# 라이브러리와 import (Libraries & imports)
`import` 및 `library` 키워드는 모듈식 및 공유 가능한 코드 기반을 만드는 데 도움이 될 수 있습니다. 라이브러리는 API를 제공할 뿐만 아니라 `privacy` 단위입니다. `_` 로 시작하는 식별자는 라이브러리 내에서만 사용할 수 있습니다. [library](https://dart.dev/language/libraries#library-directive) 키워드를 사용하지 않더라도 모든 `Dart` 앱은 라이브러리입니다.

라이브러리는 [패키지](https://dart.dev/guides/packages)로 배포할 수 있습니다.

> `Dart` 가 `public` 또는 `private` 키워드 대신 `_` 을 사용하는 이유가 궁금하다면 [SDK 이슈 33383](https://github.com/dart-lang/sdk/issues/33383)을 확인하세요.

## 라이브러리 사용하기 (Using libraries)
`import` 키워드를 사용해서 한 라이브러리의 네임스페이스가 다른 라이브러리의 스코프 범위에서 사용되는 방식을 지정합니다.

예를 들어, `Dart` 웹 앱은 일반적으로 다음과 같이 `import` 할 수 있는 [dart.html](https://api.dart.dev/stable/2.19.6/dart-html/dart-html-library.html) 라이브러리를 사용합니다.
```dart
import 'dart:html';
```

`import` 를 위한 유일한 인수는 라이브러리를 특정할 수 있는 URI입니다. 내장 라이브러리의 경우 URI에 특별히 `dart:` 체계가 있습니다. 다른 라이브러리의 경우 파일 스시템 경로 또는 `package:` 체계를 사용할 수 있습니다. `package:` 체계는 `pub 도구(pub tool)` 와 같은 패키지 관리자가 제공하는 라이브러리를 지정합니다.
```dart
import 'package:test/test.dart';
```

> Note: URI는 `Uniform Resource Identifier` 의 약자입니다. URL(`Uniform Resource Locators`)은 URI의 일반적인 형태입니다.

### 라이브러리 접두사 지정 (Specifying a library prefix)
충돌하는(`conflicting`) 식별자가 있는 두 개의 라이브러리를 가져오는 경우, 하나 또는 두 라이브러리 모두에 대한 접두사를 지정할 수 있습니다. 예를 들어, `library1` 과 `library2` 모두에 `Element` 클래스가 있을 때 다음과 같이 코드를 작성할 수 있습니다.
```dart
import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;

// lib1의 Element를 사용합니다.
Element element1 = Element();

// lib2의 Element를 사용합니다.
lib2.Element element2 = lib2.Element();
```

### 라이브러리의 일부만 가져오기 (Importing only part of a library)
라이브러리의 일부만 사용하려는 경우, 라이브러리를 선택적으로 가져올 수 있습니다.
```dart
// foo만 가져옵니다.
import 'package:lib1/lib1.dart' show foo;

// foo를 제외하고 모두 가져옵니다.
import 'package:lib2/lib2.dart' hide foo;
```

#### 라이브러리 천천히 가져오기 (Lazily loading a library)
지연 로딩(`deferred loading 또는 lazy loading`)을 사용하면 라이브러리가 필요한 경우 웹 앱이 필요에 따라 라이브러리를 가져올 수 있습니다. 다음은 지연 로딩을 사용할 수 있는 몇 가지 경우입니다.

- 웹 앱의 초기 시작 시간을 줄이기 위한 경우에 사용할 수 있습니다.
- A/B 테스트를 수행하는 경우에 사용할 수 있습니다.
- 선택적으로 사용되는 화면 및 대화상자와 같이 거의 사용되지 않는 기능을 불러오는 경우에 사용할 수 있습니다.

> `dart compile js` 만 지연 로딩을 지원합니다. `Flutter` 와 `Dart VM` 은 지연 로딩을 지원하지 않습니다. 자세한 내용은 [이슈 #33188](https://github.com/dart-lang/sdk/issues/33118) 및 [이슈 #27776](https://github.com/dart-lang/sdk/issues/27776)를 참고하세요.

라이브러리를 느리게 가져오려면 먼저 `deferred as` 를 사용해야합니다.
```dart
import 'package:greetings/hello.dart' deferred as hello;
```

라이브러리가 필요한 경우, 라이브러리 식별자를 사용해서 `loadLibrary()` 를 호출합니다.
```dart
Future<void> greet() async {
  await hello.loadLibrary();
  hello.printGreeting();
}
```

위 코드에서 `await` 키워드는 라이브러리가 가져와질 때까지 코드 진행을 일시중지합니다. `async` 및 `await` 에 대한 자세한 내용은 [비동기 지원](https://dart.dev/language/async)을 참고하세요.

라이브러리에서 `loadLibrary()` 를 여러 번 호출해도 문제가 없습니다. 라이브러리는 한 번만 가져와집니다.

지연 로딩을 사용할 때 다음 사항에 유의하세요.

- 지연된 라이브러리의 상수는 가져오는 파일의 상수가 아닙니다. 이러한 상수는 지연 로딩이 완료될 때까지 존재하지 않는다는 것을 기억하세요.
- 가져오는 파일에서는 지연된 라이브러리의 타입을 사용할 수 없습니다. 대신, 지연된 라이브러리와 가져오는 파일 모두에서 사용되는 라이브러리로 인터페이스 타입을 이동시키는 것을 고려하세요.
- `Dart` 는 `deffered as namespace` 로 정의한 네임스페이스에 `loadLibrary()` 를 암시적으로 추가합니다. `loadLibrary()` 함수는 [Future](https://dart.dev/guides/libraries/library-tour#future)를 반환합니다.

### library 키워드 (The library directive)
라이브러리 수준에서 [문서화 주석](https://dart.dev/guides/language/effective-dart/documentation#consider-writing-a-library-level-doc-comment) 또는 [메타데이터 주석](https://dart.dev/language/metadata)을 명시하려면 파일 시작 시 라이브러리 선언에 작성합니다.
```dart
/// A really great test library.
@TestOn('browser')
library;
```

## 라이브러리 구현 (Implementing libraries)
다음을 포함한 라이브러리 패키지를 구현하는 방법은 [라이브러리 패키지 만들기](https://dart.dev/guides/libraries/create-library-packages)를 참고하세요.

- 라이브러리 소스코드 구성방법
- `export` 키워드 사용방법
- `part` 키워드를 사용하는 경우
- 멀티 플랫폼을 지원하는 라이브러리를 구현하기 위해 조건부 가져오기 및 내보내기를 사용하는 방법