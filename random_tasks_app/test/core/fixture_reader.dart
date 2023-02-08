import 'dart:io';

String fixture(String name) => File('test/core/$name').readAsStringSync();
