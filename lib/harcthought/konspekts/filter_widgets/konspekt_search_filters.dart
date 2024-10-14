import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

abstract class KonspektSearchFilters{}

class KonspektHarcerskieSearchFilters extends KonspektSearchFilters{
  final Set<Meto> selectedMetos;
  final Set<KonspektSphere> selectedSpheres;

  KonspektHarcerskieSearchFilters({
    required this.selectedMetos,
    required this.selectedSpheres,
  });
}

class KonspektKsztalcenioweSearchFilters extends KonspektSearchFilters{
  final Set<Meto> selectedLevels;

  KonspektKsztalcenioweSearchFilters({
    required this.selectedLevels,
  });
}