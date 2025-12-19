import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/all.dart';

import 'data/all.dart';
import 'data/harcerskie/all.dart';

Future<void> initKonspekts() async {
  await Future.wait([
    initKsztalcenieKonspekts(),
    initHarcerskieKonspekts(),
    initAllKonspekts(),
  ]);
}