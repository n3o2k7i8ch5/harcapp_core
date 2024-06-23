import '../konspekt.dart';
import 'basic.dart';
import 'ksztalcenie/all.dart';

List<Konspekt> get allKonspekts{
  List<Konspekt> result = [];
  result.addAll(allBasicKonspekts);
  result.addAll(allKsztalcenieKonspekts);

  return result;
}