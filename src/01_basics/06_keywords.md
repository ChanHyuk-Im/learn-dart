# 키워드 (Keywords)
다음 표에는 `Dart` 언어가 특별히 취급하는 키워드 목록이 있습니다.
|||||
|---|---|---|---|
|[abstract](https://dart.dev/language/classes#abstract-classes)_2|[else](https://dart.dev/language/control-flow#if-and-else)|[import](https://dart.dev/language/libraries#using-libraries)_2|[show](https://dart.dev/language/libraries#importing-only-part-of-a-library)_1|
|[as](https://dart.dev/language/operators#type-test-operators)_2|[enum](https://dart.dev/language/enum)|[in](https://dart.dev/language/control-flow#for-loops)|[static](https://dart.dev/language/classes#class-variables-and-methods)_2|
|[assert](https://dart.dev/language/control-flow#assert)|[export](https://dart.dev/guides/libraries/create-library-packages)_2|[interface](https://dart.dev/language/classes#implicit-interfaces)_2|[super](https://dart.dev/language/extend)|
|[async](https://dart.dev/language/async)_1|[extends](https://dart.dev/language/extend)|[is](https://dart.dev/language/operators#type-test-operators)|[switch](https://dart.dev/language/control-flow#switch-and-case)|
|[await](https://dart.dev/language/async)_3|[extension](https://dart.dev/language/extension-methods)_2|[late](https://dart.dev/language/variables#late-variables)_2|[sync](https://dart.dev/language/functions#generators)_1|
|[break](https://dart.dev/language/control-flow#break-and-continue)|[external](https://spec.dart.dev/DartLangSpecDraft.pdf#External%20Functions)_2|[library](https://dart.dev/language/libraries)_2|[this](https://dart.dev/language/constructors)|
|[case](https://dart.dev/language/control-flow#switch-and-case)|[factory](https://dart.dev/language/constructors#factory-constructors)_2|[mixin](https://dart.dev/language/mixins)_2|[throw](https://dart.dev/language/error-handling#throw)|
|[catch](https://dart.dev/language/error-handling#catch)|[false](https://dart.dev/language/built-in-types#booleans)|[new](https://dart.dev/language/classes#using-constructors)|[true](https://dart.dev/language/built-in-types#booleans)|
|[class](https://dart.dev/language/classes#instance-variables)|[final](https://dart.dev/language/variables#final-and-const)|[null](https://dart.dev/language/variables#default-value)|[try](https://dart.dev/language/error-handling#catch)|
|[const](https://dart.dev/language/variables#final-and-const)|[finally](https://dart.dev/language/error-handling#finally)|[on](https://dart.dev/language/error-handling#catch)_1|[typedef](https://dart.dev/language/typedefs)_2|
|[continue](https://dart.dev/language/control-flow#break-and-continue)|[for](https://dart.dev/language/control-flow#for-loops)|[operator](https://dart.dev/language/methods#operators)_2|[var](https://dart.dev/language/variables)|
|[covariant](https://dart.dev/guides/language/sound-problems#the-covariant-keyword)_2|[Function](https://dart.dev/language/functions)_2|[part](https://dart.dev/guides/libraries/create-library-packages#organizing-a-library-package)_2|[void](https://dart.dev/language/built-in-types)|
|[default](https://dart.dev/language/control-flow#switch-and-case)|[get](https://dart.dev/language/methods#getters-and-setters)_2|[required](https://dart.dev/language/functions#named-parameters)_2|[while](https://dart.dev/language/control-flow#while-and-do-while)|
|[deferred](https://dart.dev/language/libraries#lazily-loading-a-library)_2|[hide](https://dart.dev/language/libraries#importing-only-part-of-a-library)_1|[rethrow](https://dart.dev/language/error-handling#catch)|[with](https://dart.dev/language/mixins)|
|[do](https://dart.dev/language/control-flow#while-and-do-while)|[if](https://dart.dev/language/control-flow#if-and-else)|[return](https://dart.dev/language/functions#return-values)|[yield](https://dart.dev/language/functions#generators)_3|
|[dynamic](https://dart.dev/language#important-concepts)_2|[implements](https://dart.dev/language/classes#implicit-interfaces)_2|[set](https://dart.dev/language/methods#getters-and-setters)_2||

위의 키워드를 식별자로 사용하지 마세요. 하지만 필요한 경우 `_숫자` 로 표시된 키워드는 식별자가 될 수 있습니다.

- `_1`: 특정 위치에서만 의미가 있는 문맥 키워드입니다. 모든 곳에서 유효한 식별자입니다.
- `_2`: 내장 식별자입니다. 이 키워드는 대부분의 위치에서 유효한 식별자이지만 클래스 또는 타입 이름이나 import 접두사로 사용할 수 없습니다.
- `_3`: [비동기 지원](https://dart.dev/language/async)과 관련된 제한된 예약어입니다. `async`, `async*` 또는 `sync*` 로 표시된 함수 본문에서 `await` 또는 `yield` 를 식별자로 사용할 수 없습니다.

나머지 다른 모든 키워드는 식별자가 될 수 없는 예약어입니다.