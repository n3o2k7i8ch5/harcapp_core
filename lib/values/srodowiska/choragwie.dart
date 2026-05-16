import 'package:harcapp_core/values/srodowiska/models.dart';
import 'package:harcapp_core/values/srodowiska/okregi.dart';

// ===== Chorągwie ZHP =====
const choragiewBialostocka = Choragiew('bialostocka', 'Chorągiew Białostocka', okregZhpRoot);
const choragiewDolnoslaska = Choragiew('dolnoslaska', 'Chorągiew Dolnośląska', okregZhpRoot);
const choragiewGdanska = Choragiew('gdanska', 'Chorągiew Gdańska', okregZhpRoot);
const choragiewKielecka = Choragiew('kielecka', 'Chorągiew Kielecka', okregZhpRoot);
const choragiewKrakowska = Choragiew('krakowska', 'Chorągiew Krakowska', okregZhpRoot);
const choragiewKujawskoPomorska = Choragiew('kujawsko_pomorska', 'Chorągiew Kujawsko-Pomorska', okregZhpRoot);
const choragiewLubelska = Choragiew('lubelska', 'Chorągiew Lubelska', okregZhpRoot);
const choragiewLodzka = Choragiew('lodzka', 'Chorągiew Łódzka', okregZhpRoot);
const choragiewMazowiecka = Choragiew('mazowiecka', 'Chorągiew Mazowiecka', okregZhpRoot);
const choragiewOpolska = Choragiew('opolska', 'Chorągiew Opolska', okregZhpRoot);
const choragiewPodkarpacka = Choragiew('podkarpacka', 'Chorągiew Podkarpacka', okregZhpRoot);
const choragiewStoleczna = Choragiew('stoleczna', 'Chorągiew Stołeczna', okregZhpRoot);
const choragiewSlaska = Choragiew('slaska', 'Chorągiew Śląska', okregZhpRoot);
const choragiewWarminskoMazurska = Choragiew('warminsko_mazurska', 'Chorągiew Warmińsko-Mazurska', okregZhpRoot);
const choragiewWielkopolska = Choragiew('wielkopolska', 'Chorągiew Wielkopolska', okregZhpRoot);
const choragiewZachodniopomorska = Choragiew('zachodniopomorska', 'Chorągiew Zachodniopomorska', okregZhpRoot);
const choragiewZiemiLubuskiej = Choragiew('ziemi_lubuskiej', 'Chorągiew Ziemi Lubuskiej', okregZhpRoot);
const choragiewZhpPgK = Choragiew('zhp_pgk', 'ZHP poza granicami Kraju', okregZhpRoot);

// ===== Chorągwie ZHR =====
// Each okreg has two chorągwie (harcerek/harcerzy) — separate gendered organizations.
const choragiewDolnoslaskaHarcerek = Choragiew('dolnoslaska_harcerek', 'Chorągiew Harcerek Okręgu Dolnośląskiego', okregDolnoslaski);
const choragiewDolnoslaskaHarcerzy = Choragiew('dolnoslaska_harcerzy', 'Chorągiew Harcerzy Okręgu Dolnośląskiego', okregDolnoslaski);
const choragiewGornoslaskaHarcerek = Choragiew('gornoslaska_harcerek', 'Chorągiew Harcerek Okręgu Górnośląskiego', okregGornoslaski);
const choragiewGornoslaskaHarcerzy = Choragiew('gornoslaska_harcerzy', 'Chorągiew Harcerzy Okręgu Górnośląskiego', okregGornoslaski);
const choragiewZiemiOpolskiejHarcerzy = Choragiew('ziemi_opolskiej_harcerzy', 'Chorągiew Harcerzy Ziemi Opolskiej', okregGornoslaski);
const choragiewKujawskoPomorskaHarcerek = Choragiew('kujawsko_pomorska_harcerek', 'Chorągiew Harcerek Okręgu Kujawsko-Pomorskiego', okregKujawskoPomorski);
const choragiewKujawskoPomorskaHarcerzy = Choragiew('kujawsko_pomorska_harcerzy', 'Chorągiew Harcerzy Okręgu Kujawsko-Pomorskiego', okregKujawskoPomorski);
const choragiewLubelskaHarcerek = Choragiew('lubelska_harcerek', 'Chorągiew Harcerek Okręgu Lubelskiego', okregLubelski);
const choragiewLubelskaHarcerzy = Choragiew('lubelska_harcerzy', 'Chorągiew Harcerzy Okręgu Lubelskiego', okregLubelski);
const choragiewLodzkaHarcerek = Choragiew('lodzka_harcerek', 'Chorągiew Harcerek Okręgu Łódzkiego', okregLodzki);
const choragiewLodzkaHarcerzy = Choragiew('lodzka_harcerzy', 'Chorągiew Harcerzy Okręgu Łódzkiego', okregLodzki);
const choragiewMalopolskaHarcerek = Choragiew('malopolska_harcerek', 'Chorągiew Harcerek Okręgu Małopolskiego', okregMalopolski);
const choragiewMalopolskaHarcerzy = Choragiew('malopolska_harcerzy', 'Chorągiew Harcerzy Okręgu Małopolskiego', okregMalopolski);
const choragiewMazowieckaHarcerek = Choragiew('mazowiecka_harcerek', 'Chorągiew Harcerek Okręgu Mazowieckiego', okregMazowiecki);
const choragiewMazowieckaHarcerzy = Choragiew('mazowiecka_harcerzy', 'Chorągiew Harcerzy Okręgu Mazowieckiego', okregMazowiecki);
const choragiewPolnocnoWschodniaHarcerzy = Choragiew('polnocno_wschodnia_harcerzy', 'Północno-Wschodnia Chorągiew Harcerzy', okregMazowiecki);
const choragiewPodkarpackaHarcerek = Choragiew('podkarpacka_harcerek', 'Chorągiew Harcerek Okręgu Podkarpackiego', okregPodkarpacki);
const choragiewPodkarpackaHarcerzy = Choragiew('podkarpacka_harcerzy', 'Chorągiew Harcerzy Okręgu Podkarpackiego', okregPodkarpacki);
const choragiewPomorskaHarcerek = Choragiew('pomorska_harcerek', 'Chorągiew Harcerek Okręgu Pomorskiego', okregPomorski);
const choragiewPomorskaHarcerzy = Choragiew('pomorska_harcerzy', 'Chorągiew Harcerzy Okręgu Pomorskiego', okregPomorski);
const choragiewPolnocnoZachodniaHarcerek = Choragiew('polnocno_zachodnia_harcerek', 'Chorągiew Harcerek Okręgu Północno-Zachodniego', okregPolnocnoZachodni);
const choragiewPolnocnoZachodniaHarcerzy = Choragiew('polnocno_zachodnia_harcerzy', 'Chorągiew Harcerzy Okręgu Północno-Zachodniego', okregPolnocnoZachodni);
const choragiewStaropolskaHarcerek = Choragiew('staropolska_harcerek', 'Chorągiew Harcerek Okręgu Staropolskiego', okregStaropolski);
const choragiewStaropolskaHarcerzy = Choragiew('staropolska_harcerzy', 'Chorągiew Harcerzy Okręgu Staropolskiego', okregStaropolski);
const choragiewWielkopolskaHarcerek = Choragiew('wielkopolska_harcerek', 'Chorągiew Harcerek Okręgu Wielkopolskiego', okregWielkopolski);
const choragiewWielkopolskaHarcerzy = Choragiew('wielkopolska_harcerzy', 'Chorągiew Harcerzy Okręgu Wielkopolskiego', okregWielkopolski);

const List<Choragiew> choragwie = [
  // ZHP
  choragiewBialostocka,
  choragiewDolnoslaska,
  choragiewGdanska,
  choragiewKielecka,
  choragiewKrakowska,
  choragiewKujawskoPomorska,
  choragiewLubelska,
  choragiewLodzka,
  choragiewMazowiecka,
  choragiewOpolska,
  choragiewPodkarpacka,
  choragiewStoleczna,
  choragiewSlaska,
  choragiewWarminskoMazurska,
  choragiewWielkopolska,
  choragiewZachodniopomorska,
  choragiewZiemiLubuskiej,
  choragiewZhpPgK,

  // ZHR
  choragiewDolnoslaskaHarcerek, choragiewDolnoslaskaHarcerzy,
  choragiewGornoslaskaHarcerek, choragiewGornoslaskaHarcerzy, choragiewZiemiOpolskiejHarcerzy,
  choragiewKujawskoPomorskaHarcerek, choragiewKujawskoPomorskaHarcerzy,
  choragiewLubelskaHarcerek, choragiewLubelskaHarcerzy,
  choragiewLodzkaHarcerek, choragiewLodzkaHarcerzy,
  choragiewMalopolskaHarcerek, choragiewMalopolskaHarcerzy,
  choragiewMazowieckaHarcerek, choragiewMazowieckaHarcerzy, choragiewPolnocnoWschodniaHarcerzy,
  choragiewPodkarpackaHarcerek, choragiewPodkarpackaHarcerzy,
  choragiewPomorskaHarcerek, choragiewPomorskaHarcerzy,
  choragiewPolnocnoZachodniaHarcerek, choragiewPolnocnoZachodniaHarcerzy,
  choragiewStaropolskaHarcerek, choragiewStaropolskaHarcerzy,
  choragiewWielkopolskaHarcerek, choragiewWielkopolskaHarcerzy,
];
