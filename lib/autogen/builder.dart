import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'person_list_generator.dart';

Builder personBuilder(BuilderOptions options) => LibraryBuilder(
  PersonFieldGenerator(),
  generatedExtension: '.people_list.g.dart',
);
