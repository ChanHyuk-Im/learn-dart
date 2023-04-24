import 'dart:html';
import 'package:test/test.dart';

// specifying a library prefix
import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;

Element element1 = Element(); // uses Element from lib1.
lib2.Element element2 = lib2.Element(); // uses Element from lib2.

// importing only part of library
import 'package:lib1/lib1.dart' show foo; // import only foo.
import 'package:lib2/lib2.dart' hide foo; // import all except foo.