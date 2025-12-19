import '../konspekt.dart';
import 'harcerskie/all.dart';
import 'ksztalcenie/all.dart';

// List<Konspekt> get allKonspekts{
//   List<Konspekt> result = [];
//   result.addAll(allHarcerskieKonspekts);
//   result.addAll(allKsztalcenieKonspekts);
//
//   return result;
// }

Future<List<Konspekt>> _loadAllKonspekts() async{
  await Future.wait([
    initHarcerskieKonspekts(),
    initKsztalcenieKonspekts(),
  ]);

  return <Konspekt>[
    ...allHarcerskieKonspekts,
    ...allKsztalcenieKonspekts,
  ];
}

bool initialized = false;
late List<Konspekt> _allKonspekts;
List<Konspekt> get allKonspekts{
  if(!initialized)
    throw Exception("'allKonspekts' not initialized. Did you forget to call 'initializeKonspekts()'?");

  return _allKonspekts;
}

Future<void> initAllKonspekts() async {
  if(initialized) return;
  _allKonspekts = await _loadAllKonspekts();
  initialized = true;
}
