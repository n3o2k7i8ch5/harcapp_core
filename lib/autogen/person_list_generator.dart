import 'dart:async';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element2.dart';

class PersonFieldGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    final buffer = StringBuffer();

    final topLevelPeople = library.allElements
        .whereType<TopLevelVariableElement2>()
        .where((element) {
          if (!element.isConst) return false;

          // Prefer reliable name-based check on the resolved type element.
          final typeElemName = element.type.element3?.name3;
          if (typeElemName == 'Person') return true;

          // Fallback: if type element is not directly available, try the
          // computed constant value's type element name.
          final constTypeElemName = element.computeConstantValue()?.type?.element3?.name3;
          return constTypeElemName == 'Person';
        })
        .toList();

    if (topLevelPeople.isEmpty)
      throw StateError('No top-level const Person values found.');

    // Add import of the original library file (to access Person and const vars)
    Uri uri = buildStep.inputId.uri;
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln('');
    buffer.writeln("import '${uri}';");
    buffer.writeln("import 'package:${uri.pathSegments.sublist(0, uri.pathSegments.length - 1).join('/')}/person.dart';");
    buffer.writeln('');
    buffer.writeln('const List<Person> allPeople = [');
    for (final person in topLevelPeople) {
      buffer.writeln('  ${person.name3},');
    }
    buffer.writeln('];');

    return buffer.toString();
  }
}
