import 'package:harcapp_core/values/srodowiska/choragwie.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

// ===== Zachodniopomorska Chorągiew Harcerek „Wirydarz” =====
const hufiecSzczecinskiWrzosHarcerek = Hufiec('szczecinski_wrzos_harcerek', 'Szczeciński Hufiec Harcerek „Wrzos”', choragiewPolnocnoZachodniaHarcerek);
const hufiecGorzowskiPolanaHarcerek = Hufiec('gorzowski_polana_harcerek', 'Gorzowski Hufiec Harcerek „Polana”', choragiewPolnocnoZachodniaHarcerek);

// ===== Północno-Zachodnia Chorągiew Harcerzy =====
const hufiecSzczecinskiRojHarcerzy = Hufiec('szczecinski_roj_harcerzy', 'Szczeciński Hufiec Harcerzy „Rój”', choragiewPolnocnoZachodniaHarcerzy);
const hufiecPomorskiHarcerzy = Hufiec('pomorski_harcerzy', 'Pomorski Hufiec Harcerzy', choragiewPolnocnoZachodniaHarcerzy);

const List<Hufiec> hufceZhrPolnocnoZachodni = [
  hufiecSzczecinskiWrzosHarcerek,
  hufiecGorzowskiPolanaHarcerek,
  hufiecSzczecinskiRojHarcerzy,
  hufiecPomorskiHarcerzy,
];
