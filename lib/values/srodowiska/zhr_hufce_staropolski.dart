import 'package:harcapp_core/values/srodowiska/choragwie.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

// ===== Staropolska Chorągiew Harcerek =====
const hufiecPionkowskiDarzborHarcerek = Hufiec('pionkowski_darzbor_harcerek', 'Pionkowski Hufiec Harcerek „Darzbór”', choragiewStaropolskaHarcerek);
const hufiecRadomskiHarcerek = Hufiec('radomski_harcerek', 'Radomski Hufiec Harcerek', choragiewStaropolskaHarcerek);

// ===== Staropolska Chorągiew Harcerzy =====
const hufiecKozienickiKrolewscyHarcerzy = Hufiec('kozienicki_krolewscy_harcerzy', 'Kozienicki Hufiec Harcerzy „Królewscy”', choragiewStaropolskaHarcerzy);
const hufiecRadomskiNihilNoviHarcerzy = Hufiec('radomski_nihil_novi_harcerzy', 'Radomski Hufiec Harcerzy „Nihil Novi”', choragiewStaropolskaHarcerzy);

const List<Hufiec> hufceZhrStaropolski = [
  hufiecPionkowskiDarzborHarcerek,
  hufiecRadomskiHarcerek,
  hufiecKozienickiKrolewscyHarcerzy,
  hufiecRadomskiNihilNoviHarcerzy,
];
