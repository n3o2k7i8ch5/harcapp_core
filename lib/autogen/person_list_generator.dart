import 'dart:async';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class PersonFieldGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    final buffer = StringBuffer();

    final topLevelPeople = library.allElements
        .whereType<TopLevelVariableElement>()
        .where((element) {
          if (!element.isConst) return false;

          final typeElemName = element.type.element?.name;
          if (typeElemName == 'Person') return true;

          final constTypeElemName = element.computeConstantValue()?.type?.element?.name;
          return constTypeElemName == 'Person';
        })
        .toList();

    if (topLevelPeople.isEmpty)
      throw StateError('No top-level const Person values found.');

    Uri uri = buildStep.inputId.uri;
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln('');
    buffer.writeln("import '${uri}';");
    buffer.writeln("import 'package:${uri.pathSegments.sublist(0, uri.pathSegments.length - 1).join('/')}/person.dart';");
    buffer.writeln('');
    buffer.writeln('const List<Person> allPeople = [');
    for (final person in topLevelPeople) {
      buffer.writeln('  ${person.name},');
    }
    buffer.writeln('];');

    return buffer.toString();
  }
}
