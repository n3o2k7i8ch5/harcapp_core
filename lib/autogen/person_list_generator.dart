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
          if (typeElemName == 'RegisteredContributorPerson') return true;

          final constTypeElemName = element.computeConstantValue()?.type?.element?.name;
          return constTypeElemName == 'RegisteredContributorPerson';
        })
        .toList();

    if (topLevelPeople.isEmpty)
      throw StateError('No top-level const RegisteredContributorPerson values found.');

    Uri uri = buildStep.inputId.uri;
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln('');
    buffer.writeln("import '${uri}';");
    buffer.writeln("import 'package:${uri.pathSegments.sublist(0, uri.pathSegments.length - 1).join('/')}/models.dart';");
    buffer.writeln('');
    buffer.writeln('const List<RegisteredContributorPerson> allRegisteredPeople = [');
    for (final person in topLevelPeople) {
      buffer.writeln('  ${person.name},');
    }
    buffer.writeln('];');

    return buffer.toString();
  }
}
