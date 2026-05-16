import 'package:harcapp_core/values/org.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';
import 'package:harcapp_core/values/srodowiska/okregi.dart';

// ===== Chorągwie ZHP =====
const choragiewBialostocka = Choragiew('bialostocka', 'Chorągiew Białostocka', Org.zhp);
const choragiewDolnoslaska = Choragiew('dolnoslaska', 'Chorągiew Dolnośląska', Org.zhp);
const choragiewGdanska = Choragiew('gdanska', 'Chorągiew Gdańska', Org.zhp);
const choragiewKielecka = Choragiew('kielecka', 'Chorągiew Kielecka', Org.zhp);
const choragiewKrakowska = Choragiew('krakowska', 'Chorągiew Krakowska', Org.zhp);
const choragiewKujawskoPomorska = Choragiew('kujawsko_pomorska', 'Chorągiew Kujawsko-Pomorska', Org.zhp);
const choragiewLubelska = Choragiew('lubelska', 'Chorągiew Lubelska', Org.zhp);
const choragiewLodzka = Choragiew('lodzka', 'Chorągiew Łódzka', Org.zhp);
const choragiewMazowiecka = Choragiew('mazowiecka', 'Chorągiew Mazowiecka', Org.zhp);
const choragiewOpolska = Choragiew('opolska', 'Chorągiew Opolska', Org.zhp);
const choragiewPodkarpacka = Choragiew('podkarpacka', 'Chorągiew Podkarpacka', Org.zhp);
const choragiewStoleczna = Choragiew('stoleczna', 'Chorągiew Stołeczna', Org.zhp);
const choragiewSlaska = Choragiew('slaska', 'Chorągiew Śląska', Org.zhp);
const choragiewWarminskoMazurska = Choragiew('warminsko_mazurska', 'Chorągiew Warmińsko-Mazurska', Org.zhp);
const choragiewWielkopolska = Choragiew('wielkopolska', 'Chorągiew Wielkopolska', Org.zhp);
const choragiewZachodniopomorska = Choragiew('zachodniopomorska', 'Chorągiew Zachodniopomorska', Org.zhp);
const choragiewZiemiLubuskiej = Choragiew('ziemi_lubuskiej', 'Chorągiew Ziemi Lubuskiej', Org.zhp);

// ===== Chorągwie ZHR =====
// Each okreg has two chorągwie (harcerek/harcerzy) — separate gendered organizations.
const choragiewDolnoslaskaHarcerek = Choragiew('dolnoslaska_harcerek', 'Chorągiew Harcerek Okręgu Dolnośląskiego', Org.zhr, okreg: okregDolnoslaski);
const choragiewDolnoslaskaHarcerzy = Choragiew('dolnoslaska_harcerzy', 'Chorągiew Harcerzy Okręgu Dolnośląskiego', Org.zhr, okreg: okregDolnoslaski);
const choragiewGornoslaskaHarcerek = Choragiew('gornoslaska_harcerek', 'Chorągiew Harcerek Okręgu Górnośląskiego', Org.zhr, okreg: okregGornoslaski);
const choragiewGornoslaskaHarcerzy = Choragiew('gornoslaska_harcerzy', 'Chorągiew Harcerzy Okręgu Górnośląskiego', Org.zhr, okreg: okregGornoslaski);
const choragiewKujawskoPomorskaHarcerek = Choragiew('kujawsko_pomorska_harcerek', 'Chorągiew Harcerek Okręgu Kujawsko-Pomorskiego', Org.zhr, okreg: okregKujawskoPomorski);
const choragiewKujawskoPomorskaHarcerzy = Choragiew('kujawsko_pomorska_harcerzy', 'Chorągiew Harcerzy Okręgu Kujawsko-Pomorskiego', Org.zhr, okreg: okregKujawskoPomorski);
const choragiewLubelskaHarcerek = Choragiew('lubelska_harcerek', 'Chorągiew Harcerek Okręgu Lubelskiego', Org.zhr, okreg: okregLubelski);
const choragiewLubelskaHarcerzy = Choragiew('lubelska_harcerzy', 'Chorągiew Harcerzy Okręgu Lubelskiego', Org.zhr, okreg: okregLubelski);
const choragiewLodzkaHarcerek = Choragiew('lodzka_harcerek', 'Chorągiew Harcerek Okręgu Łódzkiego', Org.zhr, okreg: okregLodzki);
const choragiewLodzkaHarcerzy = Choragiew('lodzka_harcerzy', 'Chorągiew Harcerzy Okręgu Łódzkiego', Org.zhr, okreg: okregLodzki);
const choragiewMalopolskaHarcerek = Choragiew('malopolska_harcerek', 'Chorągiew Harcerek Okręgu Małopolskiego', Org.zhr, okreg: okregMalopolski);
const choragiewMalopolskaHarcerzy = Choragiew('malopolska_harcerzy', 'Chorągiew Harcerzy Okręgu Małopolskiego', Org.zhr, okreg: okregMalopolski);
const choragiewMazowieckaHarcerek = Choragiew('mazowiecka_harcerek', 'Chorągiew Harcerek Okręgu Mazowieckiego', Org.zhr, okreg: okregMazowiecki);
const choragiewMazowieckaHarcerzy = Choragiew('mazowiecka_harcerzy', 'Chorągiew Harcerzy Okręgu Mazowieckiego', Org.zhr, okreg: okregMazowiecki);
const choragiewPodkarpackaHarcerek = Choragiew('podkarpacka_harcerek', 'Chorągiew Harcerek Okręgu Podkarpackiego', Org.zhr, okreg: okregPodkarpacki);
const choragiewPodkarpackaHarcerzy = Choragiew('podkarpacka_harcerzy', 'Chorągiew Harcerzy Okręgu Podkarpackiego', Org.zhr, okreg: okregPodkarpacki);
const choragiewPomorskaHarcerek = Choragiew('pomorska_harcerek', 'Chorągiew Harcerek Okręgu Pomorskiego', Org.zhr, okreg: okregPomorski);
const choragiewPomorskaHarcerzy = Choragiew('pomorska_harcerzy', 'Chorągiew Harcerzy Okręgu Pomorskiego', Org.zhr, okreg: okregPomorski);
const choragiewPolnocnoZachodniaHarcerek = Choragiew('polnocno_zachodnia_harcerek', 'Chorągiew Harcerek Okręgu Północno-Zachodniego', Org.zhr, okreg: okregPolnocnoZachodni);
const choragiewPolnocnoZachodniaHarcerzy = Choragiew('polnocno_zachodnia_harcerzy', 'Chorągiew Harcerzy Okręgu Północno-Zachodniego', Org.zhr, okreg: okregPolnocnoZachodni);
const choragiewStaropolskaHarcerek = Choragiew('staropolska_harcerek', 'Chorągiew Harcerek Okręgu Staropolskiego', Org.zhr, okreg: okregStaropolski);
const choragiewStaropolskaHarcerzy = Choragiew('staropolska_harcerzy', 'Chorągiew Harcerzy Okręgu Staropolskiego', Org.zhr, okreg: okregStaropolski);
const choragiewWielkopolskaHarcerek = Choragiew('wielkopolska_harcerek', 'Chorągiew Harcerek Okręgu Wielkopolskiego', Org.zhr, okreg: okregWielkopolski);
const choragiewWielkopolskaHarcerzy = Choragiew('wielkopolska_harcerzy', 'Chorągiew Harcerzy Okręgu Wielkopolskiego', Org.zhr, okreg: okregWielkopolski);

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

  // ZHR
  choragiewDolnoslaskaHarcerek, choragiewDolnoslaskaHarcerzy,
  choragiewGornoslaskaHarcerek, choragiewGornoslaskaHarcerzy,
  choragiewKujawskoPomorskaHarcerek, choragiewKujawskoPomorskaHarcerzy,
  choragiewLubelskaHarcerek, choragiewLubelskaHarcerzy,
  choragiewLodzkaHarcerek, choragiewLodzkaHarcerzy,
  choragiewMalopolskaHarcerek, choragiewMalopolskaHarcerzy,
  choragiewMazowieckaHarcerek, choragiewMazowieckaHarcerzy,
  choragiewPodkarpackaHarcerek, choragiewPodkarpackaHarcerzy,
  choragiewPomorskaHarcerek, choragiewPomorskaHarcerzy,
  choragiewPolnocnoZachodniaHarcerek, choragiewPolnocnoZachodniaHarcerzy,
  choragiewStaropolskaHarcerek, choragiewStaropolskaHarcerzy,
  choragiewWielkopolskaHarcerek, choragiewWielkopolskaHarcerzy,
];
