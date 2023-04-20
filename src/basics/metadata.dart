class Television {
  /// use [turnOn] to turn the power on instaed.
  @Deprecated('use turnOn instead') // can use three anotations(@Deprecated, @deprecated and @override).
  void activate() {
    turnOn();
  }

  /// turns the tv's power on.
  void turnOn() {
    // ...
  }
}

// custom annotation
class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}

void main() {
  Television tv = Television();

  tv.activate();

  @Todo('dash', 'implement this function')
  void doSomething() {
    print('do something');
  }

  doSomething();
}
