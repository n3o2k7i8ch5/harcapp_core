import '../konspekt.dart';
import 'basic.dart';
import 'ksztalcenie.dart';

List<Konspekt> get allKonspekts{
  List<Konspekt> result = [];
  result.addAll(allBasicKonspekts);
  result.addAll(allKsztalcenieKonspekts);

  return result;
}