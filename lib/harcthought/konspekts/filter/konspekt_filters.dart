import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

abstract class KonspektFilters{

  String phrase;

  KonspektFilters({this.phrase = ""});

  bool get isEmpty;
  bool get isNotEmpty => !isEmpty;

  bool get hideSearchFieldBottom;

  void clear(){
    phrase = '';
  }

}

class KonspektHarcerskieFilters extends KonspektFilters{
  final Set<Meto> selectedMetos;
  final Set<KonspektSphere> selectedSpheres;

  KonspektHarcerskieFilters({
    super.phrase,
    this.selectedMetos = const {},
    this.selectedSpheres = const {},
  });

  @override
  bool get isEmpty => phrase.isEmpty && selectedMetos.isEmpty && selectedSpheres.isEmpty;

  @override
  bool get hideSearchFieldBottom => selectedMetos.isEmpty && selectedSpheres.isEmpty;

  @override
  void clear() {
    super.clear();
    selectedMetos.clear();
    selectedSpheres.clear();
  }

}

class KonspektKsztalcenioweFilters extends KonspektFilters{
  final Set<Meto> selectedLevels;

  KonspektKsztalcenioweFilters({
    super.phrase,
    this.selectedLevels = const {},
  });

  @override
  bool get isEmpty => phrase.isEmpty && selectedLevels.isEmpty;

  @override
  bool get hideSearchFieldBottom => selectedLevels.isEmpty;

  @override
  void clear() {
    super.clear();
    selectedLevels.clear();
  }

}