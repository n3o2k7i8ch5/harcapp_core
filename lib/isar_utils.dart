import 'package:harcapp_core/sprawnosci/models.dart';
import 'package:isar_community/isar.dart';

late Isar isar;

Future<void> initIsar() async {
  await Isar.initializeIsarCore(download: true);
  isar = await Isar.open(
    [SprawBookSchema, SprawGroupSchema, SprawFamilySchema, SprawSchema],
    directory: 'assets/sprawnosci_db.isar',
  );
}