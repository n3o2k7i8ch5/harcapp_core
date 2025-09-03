import 'dart:async';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class PersonFieldGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    final buffer = StringBuffer();

    final topLevelPeople = library.element.topLevelElements
        .whereType<TopLevelVariableElement>()
        .where((element) =>
    element.isConst &&
        element.type.getDisplayString(withNullability: false) == 'Person')
        .toList();

    if (topLevelPeople.isEmpty) {
      throw StateError('No top-level const Person values found.');
    }

    // Add import of the original library file (to access Person and const vars)
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln('');
    buffer.writeln("import '${buildStep.inputId.uri}';");
    buffer.writeln('');
    buffer.writeln('const List<Person> allPeople = [');
    for (final person in topLevelPeople) {
      buffer.writeln('  ${person.name},');
    }
    buffer.writeln('];');

    return buffer.toString();
  }
}
