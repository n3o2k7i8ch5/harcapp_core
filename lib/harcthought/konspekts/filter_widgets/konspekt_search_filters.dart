import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

abstract class KonspektSearchFilters{

  String phrase;

  KonspektSearchFilters({required this.phrase});

  bool get isEmpty;

  bool get hideSearchFieldBottom;

}

class KonspektHarcerskieSearchFilters extends KonspektSearchFilters{
  final Set<Meto> selectedMetos;
  final Set<KonspektSphere> selectedSpheres;

  KonspektHarcerskieSearchFilters({
    required super.phrase,
    required this.selectedMetos,
    required this.selectedSpheres,
  });

  @override
  bool get isEmpty => phrase.isEmpty && selectedMetos.isEmpty && selectedSpheres.isEmpty;

  @override
  bool get hideSearchFieldBottom => selectedMetos.isEmpty && selectedSpheres.isEmpty;

}

class KonspektKsztalcenioweSearchFilters extends KonspektSearchFilters{
  final Set<Meto> selectedLevels;

  KonspektKsztalcenioweSearchFilters({
    required super.phrase,
    required this.selectedLevels,
  });

  @override
  bool get isEmpty => phrase.isEmpty && selectedLevels.isEmpty;

  @override
  bool get hideSearchFieldBottom => selectedLevels.isEmpty;

}