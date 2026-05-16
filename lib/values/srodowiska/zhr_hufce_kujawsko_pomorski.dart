import 'package:harcapp_core/values/srodowiska/choragwie.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

// ===== Kujawsko-Pomorska Chorągiew Harcerek „Sól ziemi” =====
const hufiecBydgoskiJutrzenkaHarcerek = Hufiec('bydgoski_jutrzenka_harcerek', 'Bydgoski Hufiec Harcerek „Jutrzenka”', choragiewKujawskoPomorskaHarcerek);
const hufiecTorunskiKatarzynkiHarcerek = Hufiec('torunski_katarzynki_harcerek', 'Toruński Hufiec Zuchenek i Harcerek „Katarzynki”', choragiewKujawskoPomorskaHarcerek);
const hufiecKujawskiPosagHarcerek = Hufiec('kujawski_posag_harcerek', 'Kujawski Hufiec Harcerek „Posag”', choragiewKujawskoPomorskaHarcerek);

// ===== Kujawsko-Pomorska Chorągiew Harcerzy =====
const hufiecBydgoskiHarcerzy = Hufiec('bydgoski_harcerzy', 'Bydgoski Hufiec Harcerzy', choragiewKujawskoPomorskaHarcerzy);

const List<Hufiec> hufceZhrKujawskoPomorski = [
  hufiecBydgoskiJutrzenkaHarcerek,
  hufiecTorunskiKatarzynkiHarcerek,
  hufiecKujawskiPosagHarcerek,
  hufiecBydgoskiHarcerzy,
];
