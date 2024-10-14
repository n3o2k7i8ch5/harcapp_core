import '../konspekt.dart';
import 'harcerskie/harcerskie.dart';
import 'ksztalcenie/all.dart';

List<Konspekt> get allKonspekts{
  List<Konspekt> result = [];
  result.addAll(allHarcerskieKonspekts);
  result.addAll(allKsztalcenieKonspekts);

  return result;
}