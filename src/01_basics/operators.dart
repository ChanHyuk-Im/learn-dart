// operator precedence
// following two lines execute the same way.
if ((n % i == 0) && (d % i == 0)) {}
if (n % i == 0 && d % i == 0) {}

// arithmetic
2 + 3 == 5;
2 - 3 == -1;
2 * 3 == 6;
5 / 2 == 2.5; // double
5 ~/ 2 == 2;  // int
5 % 2 == 1; // remainder
'5/2 = ${5 ~/ 2} r ${5 % 2}' == '5/2 = 2 r 1';

int a;
int b;

a = 0;
b = ++a;
a == b; // 1 == 1

a = 0;
b = a++;
a != b; // 1 != 0

// type test
(employee as Person).firstName = 'Bob';

if (employee is Person) {
  exployee.firstName = 'Bob';
}

// assignment
a = value;
b ??= value;  // assign value if b is null. otherwise, b keeps the same value.

// cascade notation
var paint = Paint()
  ..color = Colors.black
  ..strokeCap = StrokeCap.round
  ..strokeWidth = 5.0;

var paint = Paint();    // same with above.
paint.color = Colors.black;
paint.strokeCap = StrokeCap.round;
paint.strokeWidth = 5.0;

querySelector('#confirm')
  ?..text = 'Confirm'   // null-shorting cascase: if object of cascade is null, skip next prcesses.
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'))
  ..scrollIntoView();

var button = querySelector('#confirm');   // same with above.
button?.text = 'Confirm';
button?.classes.add('important');
button?.onClick.listen((e) => window.alert('Confirmed!'));
button?.scrollIntoView();

final addressBook = (AddressBookBuilder() // nested cascade do working.
  ..name = 'jenny'
  ..email = 'jenny@example.com'
  ..phone = (PhoneNumberBuilder()
    ..number = '415-555-0100'
    ..label = 'home')
  .build())
.build();
