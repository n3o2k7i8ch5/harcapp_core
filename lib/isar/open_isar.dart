import 'package:harcapp_core/sprawnosci/models.dart';
import 'package:isar_community/isar.dart';

Future<Isar> openIsar(String dbDir) => Isar.open(
  [SprawBookSchema, SprawGroupSchema, SprawFamilySchema, SprawSchema, SprawTaskSchema, SprawExternalSchema],
  directory: dbDir,
);