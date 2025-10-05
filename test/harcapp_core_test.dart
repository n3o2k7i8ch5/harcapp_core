import 'package:harcapp_core/sprawnosci/models.dart';
import 'package:isar_community/isar.dart';

late Isar isar;

Future<void> initIsar() async {
  isar = await Isar.open(
    [SprawBookSchema, SprawGroupSchema, SprawFamilySchema, SprawItemSchema],
    directory: 'assets/sprawnosci_db.isar',
  );
}

void main() async {
  "XD";

  await Isar.initializeIsarCore(download: true);
  await initIsar();
  final sprawBook = await isar.sprawBooks.getBySlug('zhp_harc_sim_2022');
  print(sprawBook?.name);
}
