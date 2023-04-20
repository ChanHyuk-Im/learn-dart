// creating and initializing.
var name = 'Bob';

// variables store references.
// variable's type is inferred.

// can specify type.
Object name1 = 'Bob';
String name2 = 'Bob';

// initial value of nullable variable is null.
int? lineCount;   // lineCount == null;

// null safety variable must have initial value.
int lineCount1 = 0;

// local variable not have to initialized, but need to assign value before it used.
void localVariable() {
  int count;

  count = 0;

  print(count);
}

// nullable variable with late modifier can be created without initial value.
late String description;

void main() {
  description = 'Feijoada!';
  print(description);
}

// lazily initializing
String readThermometer() {
  return '30';
}

late String temperature = readThermometer();

// final and const variable can't be changed
final name3 = 'Bob';
final String nickname = 'Bob';

nickname = 'Allice'; // error

const baz = [];

baz = [42]; // error

