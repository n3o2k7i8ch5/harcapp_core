import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

abstract class KonspektsSearchFilters{

  String phrase;

  KonspektsSearchFilters({required this.phrase});

  bool get isEmpty;
  bool get isNotEmpty => !isEmpty;

  bool get hideSearchFieldBottom;

  void clear(){
    phrase = '';
  }

}

class KonspektsHarcerskieSearchFilters extends KonspektsSearchFilters{
  final Set<Meto> selectedMetos;
  final Set<KonspektSphere> selectedSpheres;

  KonspektsHarcerskieSearchFilters({
    required super.phrase,
    required this.selectedMetos,
    required this.selectedSpheres,
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

class KonspektsKsztalcenioweSearchFilters extends KonspektsSearchFilters{
  final Set<Meto> selectedLevels;

  KonspektsKsztalcenioweSearchFilters({
    required super.phrase,
    required this.selectedLevels,
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