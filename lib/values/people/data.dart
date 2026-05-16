import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

import '../hufce.dart';



const RegisteredContributorPerson ABRAHAM_PRAGER = RegisteredContributorPerson(
  person: Person(
      name: 'Abraham Prager',
      druzyna: '1. Czarnkowska Drużyna Wielopoziomowa „Puszcza” im. Jana Kilińskiego',
  ),
  emails: ['abraham.p@wp.pl']
);

const RegisteredContributorPerson ADAM_DAWID = RegisteredContributorPerson(
  person: Person(
    name: 'Adam Dawid',
      druzyna: '33. CDH „Czarne stopy”',
      srodowisko: Srodowisko.hufiec(huf_zhp_ziemi_cieszynskiej, showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.dhc,
  ),
  emails: ['treaxy09@gmail.com'],
);

const RegisteredContributorPerson ADAM_DUDAK = RegisteredContributorPerson(
  person: Person(
    name: 'Adam Dudak',
      srodowisko: Srodowisko.hufiec(huf_zhp_warszawa_ursynow, showChoragiew: false, showOkreg: false),
      druzyna: '234. Warszawska Drużyna Harcerska „Forteca”',
  ),
  emails: const [],
);
const RegisteredContributorPerson ADAM_SKLODOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Adam Skłodowski',
      druzyna: '58. MDH „Cichociemni”',
      srodowisko: Srodowisko.custom('Eldorado', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrWywiadowca,
  ),
  emails: const [],
);
const RegisteredContributorPerson ADAM_SOBIERAJ = RegisteredContributorPerson(
  person: Person(
    name: 'Adam Sobieraj',
      druzyna: '24. Turystyczno Krajoznawcza DH',
      srodowisko: Srodowisko.hufiec(huf_zhp_jaktorow, showChoragiew: false, showOkreg: false),
  ),
  emails: ["sobierajadam96@gmail.com"],
);
const RegisteredContributorPerson ADAM_WIECZOREK = RegisteredContributorPerson(
  person: Person(
    name: 'Adam Wieczorek',
      druzyna: '160. WDSH „Silva”',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pd', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["aadam.wieczorek@gmail.com"],
);
const RegisteredContributorPerson AGATA_KOPYTKO = RegisteredContributorPerson(
  person: Person(
    name: 'Agata',
      druzyna: '22. LDH „Potok”',
      srodowisko: Srodowisko.custom('Lubelski Hufiec Harcerek „Rzeka”', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrOchotniczka,
  ),
  emails: ['aga.kopyto28@gmail.com'],
);
const RegisteredContributorPerson AGATA_MAJEWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Agata Majewska',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_widzew, orgSlug: 'zhp'),
  ),
  emails: ['agattam2004@gmail.com'],
);
const RegisteredContributorPerson AGNIESZKA_DURSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Agnieszka Durska',
      rankInstr: RankInstr.phm,
      srodowisko: Srodowisko.custom(huf_zhp_lodz_baluty),
  ),
  emails: const [],
);
const RegisteredContributorPerson AGNIESZKA_PIEKARSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Agnieszka Piekarska',
      druzyna: '3. Drużyna Wędrownicza „3DSH”',
      srodowisko: Srodowisko.custom(huf_zhp_szczecinsko_wloszczowski, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ['superbulinka@icloud.com', 'agapiekarskaa@gmail.com'],
);
const RegisteredContributorPerson AGNIESZKA_RADECKA_KUBICKA = RegisteredContributorPerson(
  person: Person(
    name: 'Agnieszka Radecka-Kubicka',
      druzyna: '5. Gromada Zuchów',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_sanockiej, orgSlug: 'zhp'),
  ),
  emails: ['irja@interia.pl'],
);
const RegisteredContributorPerson AGNIESZKA_SKUBA = RegisteredContributorPerson(
  person: Person(
    name: 'Agnieszka Skuba',
      srodowisko: Srodowisko.hufiec('grodzisk_mazowiecki', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.phm,
  ),
  emails: ["agnieszka.skuba@zhp.net.pl"],
);
const RegisteredContributorPerson AGNIESZKA_TYLKO = RegisteredContributorPerson(
  person: Person(
    name: 'Agnieszka Tylko',
    rankHarc: RankHarc.zhpPionierka,
    srodowisko: Srodowisko.hufiec('myslenice', showChoragiew: false, showOkreg: false),
    druzyna: '3,14. Myślenicka Drużyna Starszoharcerska „Awangarda”',
  ),
  emails: const [],
);
const RegisteredContributorPerson ALAN_FILAS = RegisteredContributorPerson(
  person: Person(
    name: 'Alan Filas',
      rankInstr: RankInstr.phm,
      druzyna: '2. Szczep „Malta”',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_nowe_miasto),
  ),
  emails: ['alan.filas@zhp.net.pl'],
);
const RegisteredContributorPerson ALEKSANDER_BIL = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksander Bil',
      druzyna: '28. Łódzka Drużyna Harcerzy im. Antoniego Olbromskiego',
      srodowisko: Srodowisko.custom(huf_zhr_lodz_polesie, orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrCwik,
  ),
  emails: ['bil.olek2010@gmail.com'],
);
const RegisteredContributorPerson ALEKSANDER_CHRZEST = RegisteredContributorPerson(
  person: Person(
    name: 'Olek Chrzęst',
      druzyna: '1. PGZ',
      srodowisko: Srodowisko.custom('Szaniec', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrCwik,
  ),
  emails: ["olgierd.chrzes@zhr.pl"],
);
const RegisteredContributorPerson ALEKSANDER_GROSZAN = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksander Groszan',
      druzyna: '25. RDHS „Kotwicz”',
      rankHarc: RankHarc.zhpCwik,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["olekgroszan@gmail.com"],
);
const RegisteredContributorPerson ALEKSANDER_PALKA = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksander Palka',
      druzyna: '10. HDŻ',
      srodowisko: Srodowisko.custom('Katowice', orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ['tomaszml9236@gmail.com'],
);
const RegisteredContributorPerson ALEKSANDER_WELYCZKO = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksander Wełyczko',
      druzyna: '5. DH „Czarne Wilki”',
      srodowisko: Srodowisko.custom('OłWa', orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpOdkrywca,
  ),
  emails: ["rxus759@gmail.com"],
);
const RegisteredContributorPerson ALEKSANDRA_ANTKIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Ola Antkiewicz',
      druzyna: '35. Chynowska Drużyna Wielopoziomowa „Vis Verum”',
      srodowisko: Srodowisko.custom(huf_zhp_grojec, orgSlug: 'zhp'),
  ),
  emails: ['drzewonadrzewie@gmail.com'],
);
const RegisteredContributorPerson ALEKSANDRA_CHRUSTEK = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksandra Chrustek',
      rankHarc: RankHarc.zhpHOd,
      rankInstr: RankInstr.pwd,
      srodowisko: Srodowisko.hufiec('warszawa_mokotow', showChoragiew: false, showOkreg: false),
  ),
  emails: ['olachrustek@gmail.com'],
);
const RegisteredContributorPerson ALEKSANDRA_CWYNAR = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksandra Cwynar',
      druzyna: '15.15 „Zadyma”',
      srodowisko: Srodowisko.custom(huf_zhp_wroclaw, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ['ola210411@gmail.com'],
);
const RegisteredContributorPerson ALEKSANDRA_GALIJ = RegisteredContributorPerson(
  person: Person(
    name: 'Ola Galij',
      druzyna: 'Studencki Krąg instruktorski im. Tonyego Halika',
      srodowisko: Srodowisko.custom(huf_zhp_bydgoszcz_miasto, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ["aleksandra.galij@zhp.net.pl", 'aleksandra.galij@gmail.com'],
);
const RegisteredContributorPerson ALEKSANDRA_KLEJDYSZ = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksandra Klejdysz',
      druzyna: '8. PgDW „Granat”',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ["olaklejdysz123@gmail.com"],
);
const RegisteredContributorPerson ALEKSANDRA_KOSTRZEWA = RegisteredContributorPerson(
  person: Person(
    name: 'Ola Kostrzewa',
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson ALEKSANDRA_KOWALSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksandra Kowalska',
    druzyna: '17. ZODH',
    srodowisko: Srodowisko.custom(huf_zhp_zgierz, orgSlug: 'zhp'),
  ),
  emails: ['kowalskaola057@gmail.com'],
);
const RegisteredContributorPerson ALEKSANDRA_KOZUBAL = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksandra Kozubal',
      rankHarc: RankHarc.zhpSamarytanka,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson ALEKSANDRA_KWAPISZ = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksandra Kwapisz',
      druzyna: '08. ŚTDH „Burza” im. Tadeusza „Zośki” Zawadzkiego',
      srodowisko: Srodowisko.custom(huf_zhp_ostrowiec_swietokrzyski, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ['aleksandra.kwapisz@zhp.net.pl'],
);
const RegisteredContributorPerson ALEKSANDRA_MISIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksandra Misiak',
      druzyna: 'ŁGZ „Pracowite Pszczółki”',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_baluty, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ['aleksandra.misiak@zhp.net.pl'],
);
const RegisteredContributorPerson ALEKSANDRA_SZKLARCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksandra Szklarczyk',
      druzyna: '3. DW „Szarada”',
      srodowisko: Srodowisko.hufiec('trzebinia', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.phm,
  ),
  emails: ['olaszklarczyk94@gmail.com'],
);
const RegisteredContributorPerson ALEKSANDRA_TIMM = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksandra Timm',
      druzyna: '21 WDW „Luna”',
      srodowisko: Srodowisko.custom(huf_zhp_wrzesnia_wrzos, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["aleksandra.timm@zhp.pl"],
);
const RegisteredContributorPerson ALEKSANDRA_TKOCZ = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksandra Tkocz',
      druzyna: 'XIX. WDH „Sokół”',
      srodowisko: Srodowisko.custom(huf_zhp_szczecin_dabie, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ['nikiii2115@gmail.com'],
);
const RegisteredContributorPerson ALEKSANDRA_WOJCIECHOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Aleksandra Wojciechowska',
      srodowisko: Srodowisko.custom(huf_zhp_plock, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ['aleksandra.wojciechowska@zhp.net.pl'],
);
const RegisteredContributorPerson ALICJA_DOBOSZ = RegisteredContributorPerson(
  person: Person(
    name: 'Alicja Dobosz',
      druzyna: '24. GDHS „Boreasz”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_gliwickiej),
  ),
  emails: ["alicja.dobosz@zhp.net.pl"],
);
const RegisteredContributorPerson ALICJA_JASINSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Alicja Jasińska',
      druzyna: '10 Świdnicka Drużyna Harcerska "Mrówkojady"',
      srodowisko: Srodowisko.custom(huf_zhp_swidnica, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ["jasinska.alicja@zhp.net.pl"],
);
const RegisteredContributorPerson ALICJA_JEZNACKA = RegisteredContributorPerson(
  person: Person(
    name: 'Alicja Jeznacka',
      druzyna: '79. WWDH „ALPHA”',
      srodowisko: Srodowisko.hufiec('warszawa_zoliborz', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ['alicja.jeznacka@zhp.net.pl'],
);
const RegisteredContributorPerson ALICJA_MAJCHER = RegisteredContributorPerson(
  person: Person(
    name: 'Ala Majcher',
      druzyna: '222. WDH „Bukowina” im. Jerzego Kukuczki',
      srodowisko: Srodowisko.hufiec('warszawa_wola', showChoragiew: false, showOkreg: false),
  ),
  emails: ['alicja.majcher@zhp.net.pl'],
);
const RegisteredContributorPerson ALICJA_NOWOSAD = RegisteredContributorPerson(
  person: Person(
    name: 'Alicja Nowosad',
  ),
  emails: ["alicjanowosad555@gmail.com"],
);
const RegisteredContributorPerson AMELIA_BOJARSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Amelia Bojarska',
      druzyna: '1. MDH „Wichry”',
      srodowisko: Srodowisko.custom(huf_zhp_ostroleka, orgSlug: 'zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson AMELIA_KALICKA = RegisteredContributorPerson(
  person: Person(
    name: 'Amelia Kalicka',
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ['amelkal678@gmail.com'],
);
const RegisteredContributorPerson AMELIA_SITNICKA = RegisteredContributorPerson(
  person: Person(
    name: 'Amelia Sitnicka',
      druzyna: '112. WDH „Czirokezi”',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pd', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ["ameliasitnicka787@gmail.com"],
);
const RegisteredContributorPerson AMELIA_SZALEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Amelia Szalewicz',
      druzyna: '16. „Astra”',
      srodowisko: Srodowisko.custom(huf_zhp_lowicz, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["amelia_sz.2010@o2.pl", "ameliaszalewicz@gmail.com"],
);
const RegisteredContributorPerson ANGELIKA_MOSKAL = RegisteredContributorPerson(
  person: Person(
    name: 'Angelika Moskal',
      rankHarc: RankHarc.dhd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["moskalangelika762@gmail.com"],
);
const RegisteredContributorPerson ANNA_RAJEWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Anna Rajewska',
      druzyna: '2. Drużyna im. Leona Zadurskiego w Żukowie',
      srodowisko: Srodowisko.custom(huf_zhp_kartuzy),
  ),
  emails: ['anna.rajewska14@gmail.com'],
);
const RegisteredContributorPerson ANNA_SZMAJ = RegisteredContributorPerson(
  person: Person(
    name: 'Anna Szmaj',
      druzyna: 'X pKDH „Andromeda”',
      rankHarc: RankHarc.zhrSamarytanka,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ['annaszmaj10@gmail.com'],
);
const RegisteredContributorPerson ANTONI_ATANASSOW = RegisteredContributorPerson(
  person: Person(
    name: 'Antoni Atanassow',
      druzyna: '5. PgDH „Eastwick” im. Zawiszy Czarnego',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpMlodzik,
  ),
  emails: ["hal133258007@gmail.com", 'obszycia-polemiczny2p@icloud.com'],
);
const RegisteredContributorPerson ANTONINA_KARMANSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Szczurowa',
      druzyna: '123. WSH „Za horyzontem”',
      srodowisko: Srodowisko.hufiec('warszawa_zoliborz', showChoragiew: false, showOkreg: false),
  ),
  emails: ['tosia.karmanska@gmail.com'],
);
const RegisteredContributorPerson ANTONINA_PIERZCHALA = RegisteredContributorPerson(
  person: Person(
    name: 'Antonina Pierzchała',
      druzyna: '41. Drużyna Harcerska „Huba”',
      srodowisko: Srodowisko.custom(huf_zhp_ostrowiec_swietokrzyski, orgSlug: 'zhp'),
  ),
  emails: ['tosiaczek118@gmail.com'],
);
const RegisteredContributorPerson ANTONINA_ROMANSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Antonina Romańska',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.dhd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['tosiaromanska@gmail.com'],
);
const RegisteredContributorPerson ANTONINA_SZTYGLIC = RegisteredContributorPerson(
  person: Person(
    name: 'Antonina Sztyglic',
      srodowisko: Srodowisko.custom(huf_zhp_lask, orgSlug: 'zhp'),
      druzyna: '5. Wieluńska Drużyna Harcerek Starszych „Kozy”',
  ),
  emails: ['sztyglica@gmail.com'],
);
const RegisteredContributorPerson ARTUR_KOSTRZEWA = RegisteredContributorPerson(
  person: Person(
    name: 'Artur Kostrzewa',
    druzyna: 'Puszczanie',
    srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
  ),
  emails: ['arturkos321@gmail.com'],
);
const RegisteredContributorPerson ARTUR_RUSA = RegisteredContributorPerson(
  person: Person(
    name: 'Artur Rusa',
    rankHarc: RankHarc.zhpWywiadowca,
    srodowisko: Srodowisko.custom(huf_zhp_pulawy, orgSlug: 'zhp'),
    druzyna: '113. SDSH',
  ),
  emails: const [],
);
const RegisteredContributorPerson BARBARA_THOMAS = RegisteredContributorPerson(
  person: Person(
    name: 'Barbara Thomas',
      rankInstr: RankInstr.phm,
  ),
  emails: const [],
);
const RegisteredContributorPerson BARTLOMIEJ_DANIELAK = RegisteredContributorPerson(
  person: Person(
    name: 'Bartłomiej Danielak',
      druzyna: 'HOWP „Cichociemni” Brzeg Dolny 8. SDDS GROM',
      rankInstr: RankInstr.pwd,
  ),
  emails: ['ketrabek4002@gmail.com'],
);
const RegisteredContributorPerson BARTLOMIEJ_JASKOLSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Bartłomiej Jaskólski',
      druzyna: '100 Drużyna Harcerska „Surykatki”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_tarnogorskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ["nino.prywatne@gmail.com", 'nino.music.tg@gmail.com'],
);
const RegisteredContributorPerson BARTLOMIEJ_MALYJUREK = RegisteredContributorPerson(
  person: Person(
    name: 'Bartłomiej Małyjurek',
      druzyna: '24. Jodła',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_cieszynskiej),
  ),
  emails: ["malyjurekbartlomiej@gmail.com"],
);
const RegisteredContributorPerson BARTLOMIEJ_SIUSTA = RegisteredContributorPerson(
  person: Person(
    name: 'Bartek Siusta',
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ["bartek.siusta1@gmail.com"],
);
const RegisteredContributorPerson BARTOSZ_DABROWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Bartosz Dąbrowski',
      rankHarc: RankHarc.zhpWywiadowca,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson BARTOSZ_IGNASIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Bartosz Ignasiak',
      rankHarc: RankHarc.zhpHOc,
      rankInstr: RankInstr.pwd,
      druzyna: '8. Drużyna Wędrownicza „Kuźnia Płomienia”',
  ),
  emails: const [],
);
const RegisteredContributorPerson BARTOSZ_KSIAZEK = RegisteredContributorPerson(
  person: Person(
    name: 'Bartosz Książek',
      druzyna: '91. DHS „Ad Astra”',
      srodowisko: Srodowisko.custom(huf_zhp_katowice, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHRc,
  ),
  emails: ["bartosz.ksiazek@zhp.net.pl"],
);
const RegisteredContributorPerson BLANKA_KARCZEWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Blanka Karczewska',
      druzyna: '56. WDS „Ignis”',
      srodowisko: Srodowisko.hufiec('warszawa_zoliborz', showChoragiew: false, showOkreg: false),
  ),
  emails: ["blankakarczewska10@gmail.com"],
);
const RegisteredContributorPerson BENIAMIN_PLUCINSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Beniamin Pluciński',
      druzyna: '17. ZODH',
  ),
  emails: ['ekhemmmik@gmail.com'],
);
const RegisteredContributorPerson BLAZEJ_KLEBBA = RegisteredContributorPerson(
  person: Person(
    name: 'Błażej Klebba',
      druzyna: '45. Drużyna Harcerska „Tuptaki”',
      srodowisko: Srodowisko.custom(huf_zhp_puck, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpMlodzik,
  ),
  emails: ['blazej3klebba.onet.pl@gmail.com'],
);
const RegisteredContributorPerson BRUNO_BRONCEL = RegisteredContributorPerson(
  person: Person(
    name: 'Bruno Broncel',
      rankHarc: RankHarc.zhpMlodzik,
      druzyna: '55. DHSiW „Exigo”',
      srodowisko: Srodowisko.custom(huf_zhp_karkonoski, orgSlug: 'zhp'),
  ),
  emails: ['bruno.broncel@gmail.com'],
);
const RegisteredContributorPerson BRUNO_WALERYCH = RegisteredContributorPerson(
  person: Person(
    name: 'Bruno Walerych',
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['bruno.walerych@zhp.pl'],
);
const RegisteredContributorPerson CELINA_STANISLAWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Celina Stanisławska',
      druzyna: '6. DW Canis Lupus',
      rankHarc: RankHarc.zhpSamarytanka,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["celina.stanislawska@zhp.pl"],
);
const RegisteredContributorPerson DAMIAN_SZYSZKA = RegisteredContributorPerson(
  person: Person(
    name: 'Damian Szyszka',
  ),
  emails: ['damianoszyszka@gmail.com'],
);
const RegisteredContributorPerson DANIEL_IWANICKI = RegisteredContributorPerson(
  person: Person(
    name: 'Daniel Iwanicki',
      rankHarc: RankHarc.zhpHOc,
      rankInstr: RankInstr.hm,
      druzyna: '72. WDHS „Uroczysko”',
  ),
  emails: ['daniel.iwanicki@zhp.net.pl'],
);
const RegisteredContributorPerson DANIEL_KRYSIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Daniel Krysiak',
      druzyna: 'I KDW im. Tadeusza Rejtana',
      srodowisko: Srodowisko.custom(huf_zhp_kutno, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["danielkrysiak8098@wp.pl", 'krysiakdaniel8098@gmail.com'],
);
const RegisteredContributorPerson DANIEL_KORZEB = RegisteredContributorPerson(
  person: Person(
    name: 'Daniel Korzeb',
    rankHarc: RankHarc.zhpOdkrywca,
    druzyna: '39. HDŻ Burza',
    srodowisko: Srodowisko.custom(huf_zhp_czestochowa, orgSlug: 'zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson DARIUSZ_DYMEK = RegisteredContributorPerson(
  person: Person(
    name: 'Dariusz Dymek',
      druzyna: 'PJDSH "Biała Róża"',
      srodowisko: Srodowisko.custom(huf_zhp_jaworzno, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["dymek.daro@gmail.com"],
);
const RegisteredContributorPerson DAWID_KOBEDZA = RegisteredContributorPerson(
  person: Person(
    name: 'Dawid Kobędza',
      druzyna: '8. ŁDH Gniazdo',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_gorna, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ["dawid.kobedza@zhp.net.pl"],
);
const RegisteredContributorPerson DAWID_LOBODA = RegisteredContributorPerson(
  person: Person(
    name: 'Dawid Łoboda',
      druzyna: '63. GDH im. mi. Hieronima Degutowskiego „Zapora”',
      srodowisko: Srodowisko.custom(huf_zhr_3_gdynski, orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrHOc,
  ),
  emails: ['dawidekk728@gmail.com'],
);
const RegisteredContributorPerson DAWID_PIOTR_JACHIMOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Dawid Piotr Jachimowski',
      druzyna: '1 Włodawska Drużyna Harcerzy "Delta" im. Augusta Emila Fieldorfa ps. "Nil"',
      rankHarc: RankHarc.zhrMlodzik,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ["dawid.kret011@gmail.com"],
);
const RegisteredContributorPerson DAWID_WYSZYNSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Dawid Wyszyński',
    rankHarc: RankHarc.dhc,
    srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson DOMINIK_BETKA = RegisteredContributorPerson(
  person: Person(
    name: 'Dominik Betka',
      druzyna: '53 GDSH "STEFANY"',
      srodowisko: Srodowisko.custom(huf_zhp_gdynia, orgSlug: 'zhp'),
      rankInstr: RankInstr.phm,
  ),
  emails: ["dominik.betka@zhp.net.pl"],
);
const RegisteredContributorPerson DOMINIK_KIERES = RegisteredContributorPerson(
  person: Person(
    name: 'Dominik Kiereś',
      druzyna: '9. Drużyna Starszoharcerska "Zachód"',
      srodowisko: Srodowisko.custom(huf_zhp_wolsztyn, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
  ),
  emails: ["dominik.kieres@zhp.net.pl"],
);
const RegisteredContributorPerson DOMINIK_PRZYBYLOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Dominik Przybyłowski',
      druzyna: '141. BDW',
      srodowisko: Srodowisko.custom(huf_zhp_bialystok, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHRc,
  ),
  emails: ['dominik.przybylowski@zhp.pl'],
);
const RegisteredContributorPerson DOMINIKA_GORZYNSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Dominika Gorzyńska', rankHarc: RankHarc.zhpPionierka,
    druzyna: '11. Gdańska Drużyna Starszoharcerska „Cegły” im. Anny Burdówny',
    srodowisko: Srodowisko.custom(huf_zhp_gdansk_srodmiesie, orgSlug: 'zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson DOMINIKA_HOCHMANSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Dominika Hochmańska',
      rankInstr: RankInstr.pwd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['dominika.hochmanska@gmail.com'],
);
const RegisteredContributorPerson DOMINIKA_KONARSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Dominika Konarska',
      druzyna: '12 DSH „Północ”',
      srodowisko: Srodowisko.custom('Krapkowice', orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpTropicielka,
  ),
  emails: ['u5796295922@gmail.com'],
);
const RegisteredContributorPerson DORIAN_JAREK = RegisteredContributorPerson(
  person: Person(
    name: 'Dorian Jarek',
      rankInstr: RankInstr.pwd,
      druzyna: '13. Konińska Drużyna Wędrownicza „Wadery”',
      srodowisko: Srodowisko.custom(huf_zhp_konin, orgSlug: 'zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson EMILIA_ADAMCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Emilka Adamczyk',
      druzyna: '222. WDH „Bukowina” im. Jerzego Kukuczki',
      srodowisko: Srodowisko.hufiec('warszawa_wola', showChoragiew: false, showOkreg: false),
  ),
  emails: ["e.emilia246@gmail.com"],
);
const RegisteredContributorPerson EMILIA_Z_FSE = RegisteredContributorPerson(
  person: Person(
    name: 'Emilia',
      druzyna: 'Ognisko Młodych Przewodniczek',
      srodowisko: Srodowisko.org('fse'),
  ),
  emails: ['rozapodcieniem@gmail.com'],
);
const RegisteredContributorPerson EMILIA_BARABASZ = RegisteredContributorPerson(
  person: Person(
    name: 'Emilia Barabasz',
      druzyna: '71. WGZ „Strażnicy Kraczaru”',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ['emilia.barabasz@zhp.net.pl'],
);
const RegisteredContributorPerson EMILIA_WARSZAJLO = RegisteredContributorPerson(
  person: Person(
    name: 'Emilia Warszajło',
      rankHarc: RankHarc.zhpSamarytanka,
      druzyna: '24. Szczep DHiGZ „Awangarda”',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_grunwald, orgSlug: 'zhp'),
  ),
  emails: ['emiwarszajlo@gmail.com'],
);
const RegisteredContributorPerson EMILIA_WITKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Emilia Witkowska',
      druzyna: '307. WDHiZ',
      srodowisko: Srodowisko.hufiec('warszawa_mokotow', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.phm,
      rankHarc: RankHarc.zhpHRd,
  ),
  emails: ['emilia.witkowska@zhp.net.pl', 's206102@sggw.edu.pl'],
);
const RegisteredContributorPerson EVELINA_STASILOVIC = RegisteredContributorPerson(
  person: Person(
    name: 'Evelina Stasilovič',
      rankHarc: RankHarc.zhpOchotniczka,
      druzyna: '9. Wileńska Drużyna Harcerek „Viator” im. kardynała Stefana Wyszyńskiego',
      srodowisko: Srodowisko.org('zhpNL'),
  ),
  emails: ['evelina.stasilovic@gmail.com'],
);
const RegisteredContributorPerson EWA_BYSTRZYNSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Ewa Bystrzyńska', rankHarc: RankHarc.dhd, srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson EWELINA_HUPKA = RegisteredContributorPerson(
  person: Person(
    name: 'Ewelina Hupka',
      druzyna: 'XXII. Drużyna Harcerska „Ignis”',
      srodowisko: Srodowisko.custom(huf_zhp_wegierska_gorka, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ['ewelina.hupka@zhp.net.pl'],
);
const RegisteredContributorPerson FILIP_BERGIER = RegisteredContributorPerson(
  person: Person(
    name: 'Filip Bergier',
      rankHarc: RankHarc.zhpWywiadowca,
      druzyna: '72. WDHS „Uroczysko”',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
  ),
  emails: ['janberg7272@gmail.com', 'filip.bergier@zhp.net.pl', 'filip.bergier111@gmail.com'],
);
const RegisteredContributorPerson FILIP_BRASZEWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Filip Brąszewski',
      druzyna: '62 KDHS „Brzoza” im. Stefana Szolca-Rogodzińskiego',
      srodowisko: Srodowisko.custom(huf_zhp_kalisz, orgSlug: 'zhp'),
  ),
  emails: ["fbraszewskii@gmail.com"],
);
const RegisteredContributorPerson FILIP_JASTRZEBSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Filip Jastrzębski',
      druzyna: '58 Mazowiecka Drużyna Harcerzy "Cichociemni" im. płk. Jana Piwnika ps. "Ponury"',
      srodowisko: Srodowisko.custom('Warszawski Hufiec Harcerzy „Eldorado”', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrWywiadowca,
  ),
  emails: ["filip8j@gmail.com"],
);
const RegisteredContributorPerson FILIP_KWIATKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Filip Kwiatkowski',
      rankHarc: RankHarc.dhc,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson FILIP_LEWICKI = RegisteredContributorPerson(
  person: Person(
    name: 'Filip Lewicki',
      druzyna: '44 BDO "Beryl"',
      srodowisko: Srodowisko.custom(huf_zhp_bialystok, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ["aleksandra.krzyzanowska@zhp.pl", 'olakrzy2004@gmail.com'],
);
const RegisteredContributorPerson FILIP_PIELA = RegisteredContributorPerson(
  person: Person(
    name: 'Filip Piela',
      druzyna: '1. KDHS „Świt"',
      rankHarc: RankHarc.dhc,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["filip.piela0209@gmail.com"],
);
const RegisteredContributorPerson FILIP_SOCHAJ = RegisteredContributorPerson(
  person: Person(
    name: 'Filip Sochaj',
  ),
  emails: const [],
);
const RegisteredContributorPerson FILIP_SWIDEREK = RegisteredContributorPerson(
  person: Person(
    name: 'Filip Świderek',
  ),
  emails: const [],
);
const RegisteredContributorPerson FLORIAN_PELEC = RegisteredContributorPerson(
  person: Person(
    name: 'Florian Pelec',
      druzyna: '28. DW "Żywica"',
      srodowisko: Srodowisko.custom(huf_zhp_jarocin, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["florian.pelec@zhp.pl"],
);

const RegisteredContributorPerson FRANCISZEK_FALENTA = RegisteredContributorPerson(
  person: Person(
    name: 'Franciszek Falenta',
      druzyna: '123. LDSH „Imperatyw”',
      srodowisko: Srodowisko.custom(huf_zhp_lublin, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["franciszek.falenta@zhp.pl"],
);
const RegisteredContributorPerson FRANCISZEK_HALUCH = RegisteredContributorPerson(
  person: Person(
    name: 'Franciszek Haluch',
      druzyna: '73. KDSH „Carpe Diem”',
      srodowisko: Srodowisko.custom(huf_zhp_beskidzki, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["franciszek.haluch@zhp.net.pl"],
);
const RegisteredContributorPerson FRANCISZEK_LINKE = RegisteredContributorPerson(
  person: Person(
    name: 'pwd. Franciszek Linke',
      rankInstr: RankInstr.pwd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['franciszek.linke@zhp.net.pl'],
);
const RegisteredContributorPerson FRANCISZEK_MICHALSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Franciszek Michalski',
      druzyna: '254. WDH „Matecznik” im. Janka Bytnara „Rudego”',
      srodowisko: Srodowisko.hufiec('warszawa_zoliborz', showChoragiew: false, showOkreg: false),
  ),
  emails: ['franciszek.michalski@zhp.net.pl'],
);
const RegisteredContributorPerson FRANCISZEK_PUKNEL = RegisteredContributorPerson(
  person: Person(
    name: 'Franek Puknel',
      druzyna: '579. WDH Łatwopalni',
      srodowisko: Srodowisko.custom(huf_zhp_powiatu_trzebnickiego, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpWywiadowca,
  ),
  emails: ["franekpuknel12@gmail.com", 'franek.pu@icloud.com'],
);
const RegisteredContributorPerson FRANCISZEK_TOMASZCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Franciszek Tomaszczyk',
      rankHarc: RankHarc.zhpWywiadowca, srodowisko: Srodowisko.custom(huf_zhp_ziemi_cieszynskiej, orgSlug: 'zhp'),
      druzyna: '33. CDH „Czarne stopy”, 4. GZ „Radosne Misie”',
  ),
  emails: const [],
);
const RegisteredContributorPerson FRANCISZEK_WOJDYLO = RegisteredContributorPerson(
  person: Person(
    name: 'Franciszek Wojdyło',
      druzyna: '424 DW „Puszcza”',
      srodowisko: Srodowisko.custom('Nowy Dwór Mazowiecki', orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ["franciszek.wojdylo@zhp.net.pl", 'franciszek.wojdylo@icloud.com'],
);
const RegisteredContributorPerson GABRIEL_KOSSAKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Gabriel Kossakowski',
      srodowisko: Srodowisko.hufiec('gorlice', showChoragiew: false, showOkreg: false),
  ),
  emails: const [],
);
const RegisteredContributorPerson GABRIEL_POZNANSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Gabriel Poznański',
      druzyna: '6. GZ „Jeźdźcy Smoków”',
      srodowisko: Srodowisko.custom(huf_zhp_chodziez, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ['gabriel.poznanski455@gmail.com'],
);
const RegisteredContributorPerson GABRIELA_OZOG = RegisteredContributorPerson(
  person: Person(
    name: 'Gabriela Ożóg',
      druzyna: '175. RwDW „Orientalis”',
      srodowisko: Srodowisko.custom(huf_zhp_rzeszow, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["gabriela.ozog.mw@gmail.com"],
);
const RegisteredContributorPerson GABRIELA_SAWICKA = RegisteredContributorPerson(
  person: Person(
    name: 'Gabriela Sawicka',
      druzyna: '14. BDSh „Pomost”',
      srodowisko: Srodowisko.custom(huf_zhp_bialystok),
  ),
  emails: ["bibi.sawicka@gmail.com"],
);

const RegisteredContributorPerson GABRIELA_SOBCZAK = RegisteredContributorPerson(
  person: Person(
    name: 'Gabriela Sobczak',
      druzyna: '10. DH',
      srodowisko: Srodowisko.custom(huf_zhp_jaktorow),
      rankHarc: RankHarc.zhpOchotniczka,
  ),
  emails: ["gabi.sobczak1011@gmail.com"],
);
const RegisteredContributorPerson GABRIELA_TWORKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Gabriela Tworkowska',
      druzyna: '75. ŁDH-EK „Brzask” im. gen. Marii Wittek',
      srodowisko: Srodowisko.custom('Łódzki Hufiec Harcerek „Mozaika”', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrTropicielka,
  ),
  emails: ['gabi.tworko@gmail.com'],
);
const RegisteredContributorPerson GRZEGORZ_BOROWIEC = RegisteredContributorPerson(
  person: Person(
    name: 'Grzegorz Borowiec',
    rankHarc: RankHarc.zhpHOc,
    druzyna: '66. WDW „Tornado”',
    srodowisko: Srodowisko.custom(huf_zhp_torun, orgSlug: 'zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson GRZEGORZ_FRANK = RegisteredContributorPerson(
  person: Person(
    name: 'Grzegorz Frank',
      srodowisko: Srodowisko.custom(huf_zhp_ruda_slaska, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ['grzegorz.frank@zhp.net.pl'],
);
const RegisteredContributorPerson GRZEGORZ_FRANKOW = RegisteredContributorPerson(
  person: Person(
    name: 'Grzegorz Franków',
      druzyna: '22. Kielecka Drużyna Harcerska',
      srodowisko: Srodowisko.custom(huf_zhp_kielce_miasto, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
  ),
  emails: ['grzegorz.frankow@zhp.net.pl'],
);
const RegisteredContributorPerson GRZEGORZ_GIBADLO = RegisteredContributorPerson(
  person: Person(
    name: 'Grzegorz Gibadło',
      druzyna: '25 DSH „Północ"',
      srodowisko: Srodowisko.hufiec('podkrakowski', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpOdkrywca,
  ),
  emails: ["gg.gibadło@gmail.com"],
);
const RegisteredContributorPerson GRZEGORZ_PAWLAK = RegisteredContributorPerson(
  person: Person(
    name: 'Grzegorz Pawlak',
  ),
  emails: ['grzegorz.pawlakk@gmail.com'],
);
const RegisteredContributorPerson GRZEGORZ_ZAWADZKI = RegisteredContributorPerson(
  person: Person(
    name: 'Grzegorz Zawadzki',
    druzyna: '8. DSH „Ignis”',
    srodowisko: Srodowisko.custom(huf_zhp_kutno),
  ),
  emails: const [],
);
const RegisteredContributorPerson GUSTAW_BAJCAR = RegisteredContributorPerson(
  person: Person(
    name: 'Gustaw Bajcar',
      druzyna: '2. WDH',
      srodowisko: Srodowisko.custom(huf_zhp_olawa, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpMlodzik,
  ),
  emails: ['gustaw.bajcar2@gmail.com'],
);
const RegisteredContributorPerson HANNA_BAJER = RegisteredContributorPerson(
  person: Person(
    name: 'Hanna Bajer',
      druzyna: '3. Gromada Zuchowa „Zawiszątka”',
      rankHarc: RankHarc.dhd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['bajerhanna12@gmail.com'],
);
const RegisteredContributorPerson HANNA_CISAKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Hania Cisakowska',
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ['hanna.cisakowska2009@gmail.com'],
);
const RegisteredContributorPerson HANNA_CZAJKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Hanna Czajkowska',
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['hanna.czajkowska@zhp.net.pl'],
);
const RegisteredContributorPerson HANNA_ERMAN = RegisteredContributorPerson(
  person: Person(
    name: 'Hanna Erman',
      druzyna: '62 KDHS "Brzoza" im. Stefana Szolca-Rogodzińskiego',
      srodowisko: Srodowisko.custom(huf_zhp_kalisz, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["bellahania511@gmail.com"],
);

const RegisteredContributorPerson HANNA_KESKA = RegisteredContributorPerson(
  person: Person(
    name: 'Hanna Kęska',
      rankHarc: RankHarc.zhpSamarytanka,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["hanusia.keska@gmail.com "],
);
const RegisteredContributorPerson HANNA_KUCINSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Hanna Kucińska',
      druzyna: '14. DHS „Wataha"',
      srodowisko: Srodowisko.hufiec('legionowo', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpTropicielka,
  ),
  emails: ["hanna.kucinska@vp.pl"],
);
const RegisteredContributorPerson HANNA_KUJAWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Hanna Kujawska',
      druzyna: '6. DSH „Wataha”',
  ),
  emails: ['kujawskahanka@gmail.com'],
);
const RegisteredContributorPerson HANNA_RYBACKA = RegisteredContributorPerson(
  person: Person(
    name: 'Hanna Rybacka',
      druzyna: 'Gromada Zuchowa „Ogniste Feniksy”',
      srodowisko: Srodowisko.custom(huf_zhp_zdunska_wola, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
      rankInstr: RankInstr.pwd,
  ),
  emails: ['hanna.rybacka@zhp.net.pl'],
);
const RegisteredContributorPerson HANNA_STRZESZEWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Hanna Strzeszewska',
      druzyna: '368. „Gniazdk”',
      srodowisko: Srodowisko.hufiec('warszawa_zoliborz', showChoragiew: false, showOkreg: false),
  ),
  emails: ['hania.prime@gmail.com'],
);
const RegisteredContributorPerson HANNA_WITKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Hanna Witkowska',
      druzyna: '66. Wrocławska Drużyna Harcerska „PSIAKI”',
      srodowisko: Srodowisko.custom(huf_zhp_wroclaw_polnoc, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ['hanna.witkowska@zhp.net.pl'],
);
const RegisteredContributorPerson HANNA_WNEKOWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Hanna Wnękowicz',
      druzyna: '12. DH „Szare Wilki” w Brodach',
      srodowisko: Srodowisko.custom(huf_zhp_zary, orgSlug: 'zhp'),
  ),
  emails: ['hannawnekowicz93@gmail.com'],
);
const RegisteredContributorPerson HELENA_LATOSINSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Helena Latosińska',
    druzyna: '39. Wielopoziomowa Drużyna Harcerska „Leśne Stwory z Radlina”',
    srodowisko: Srodowisko.custom(huf_zhp_ziemi_wodzislawskiej, orgSlug: 'zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson HELENA_SWIATKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Helena Świątkowska',
      rankHarc: RankHarc.zhrSamarytanka,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ['helena.swiatkowska@zhr.pl'],
);
const RegisteredContributorPerson HUBERT_CISLAK = RegisteredContributorPerson(
  person: Person(
    name: 'Hubert Ciślak',
      druzyna: '300. PgLDH „Wichura”',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpWywiadowca,
  ),
  emails: ["hubertcc007@gmail.com"],
);
const RegisteredContributorPerson HUBERT_FRUKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Hubert Frukowski',
  ),
  emails: const [],
);
const RegisteredContributorPerson HUBERT_JANIK = RegisteredContributorPerson(
  person: Person(
    name: 'Hubert Janik',
      druzyna: '7. BDH „Białe Czaple”',
      srodowisko: Srodowisko.custom(huf_zhp_bydgoszcz_miasto, orgSlug: 'zhp'),
  ),
  emails: ['hubert.janik@zhp.net.pl', 'hubert.janik@zhp.pl'],
);
const RegisteredContributorPerson HUBERT_MILEROWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Hubert Milerowicz',
      rankHarc: RankHarc.zhpOdkrywca,
      srodowisko: Srodowisko.hufiec('warszawa_ochota', showChoragiew: false, showOkreg: false),
      druzyna: 'Środowisko „Szczep 224”',
  ),
  emails: ['hubertmilerowicz@gmail.com'],
);
const RegisteredContributorPerson HUBERT_NAPIERALA = RegisteredContributorPerson(
  person: Person(
    name: 'Hubert Napierała',
  ),
  emails: ["napieralahubert501@gmail.com"],
);
const RegisteredContributorPerson HUBERT_SULSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Hubert Sulski',
      druzyna: '23. DSH „Legendarne Smoki”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_wodzislawskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ['hksik2007@gmail.com'],
);
const RegisteredContributorPerson HUGO_HANUSA = RegisteredContributorPerson(
  person: Person(
    name: 'Hugo Hanusa',
      druzyna: '44. KDH im Krzysztofa Kamil Baczyńskiego',
      srodowisko: Srodowisko.custom(huf_zhr_harcerzy_krakow_stare_miasto, orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrWywiadowca,
  ),
  emails: [
      'hugohanusa@icloud.com',
      'hanusahugo@gmail.com'
    ],
);
const RegisteredContributorPerson HUGO_ZASACKI = RegisteredContributorPerson(
  person: Person(
    name: 'Hugo Zasacki',
      druzyna: 'Impeesa',
      srodowisko: Srodowisko.custom("Wawer", orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrCwik,
  ),
  emails: ["hugozas10@gmail.com"],
);
const RegisteredContributorPerson IDA_BECHTOLD = RegisteredContributorPerson(
  person: Person(
    name: 'Ida Bechtold',
      druzyna: '18. ŁDH Wierchy',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_baluty, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpTropicielka,
  ),
  emails: ['idabechtold@icloud.com', 'i.bechtold@sp.120.elodz.edu.pl'],
);
const RegisteredContributorPerson IGNACY_DUDZIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Ignacy Dudziak',
      druzyna: '121. PgDSH „Szlak Łez” im. Plutonu „Alicja”',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpWywiadowca,
  ),
  emails: ['ignacy.dudziak@zhp.net.pl'],
);
const RegisteredContributorPerson IGNACY_SZYMICHOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Ignacy Szymichowski',
      druzyna: '70. SDH',
      srodowisko: Srodowisko.custom('Gdyński HH „Pasieka”', orgSlug: 'zhr'),
      rankInstr: RankInstr.phm,
      rankHarc: RankHarc.zhrHRc,
  ),
  emails: ["i.szymichowski@zhr.pl"],
);
const RegisteredContributorPerson IGNACY_WOJTCZAK = RegisteredContributorPerson(
  person: Person(
    name: 'Ignacy Wojtczak',
      druzyna: '8. ADH',
      srodowisko: Srodowisko.custom(huf_zhr_lodz_polesie, orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrMlodzik,
  ),
  emails: [
      'wojtczaki009@gmail.com'
    ],
);
const RegisteredContributorPerson IGOR_SOLECKI = RegisteredContributorPerson(
  person: Person(
    name: 'Igor Solecki',
      druzyna: '58. (MDH) Cichociemni ps. Ponury',
      srodowisko: Srodowisko.custom('Rosa Venti', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrWywiadowca,
  ),
  emails: ["mrk282665@gmail.com"],
);
const RegisteredContributorPerson IZABELA_MOSKAL = RegisteredContributorPerson(
  person: Person(
    name: 'Izabela Moskal',
      druzyna: '5. Krośnieńska Drużyna Harcerek „Shenandu”',
      srodowisko: Srodowisko.custom(huf_zhp_krosno, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ['izabela.moskal.5@gmail.com', 'izabela.moskal@zhp.pl'],
);
const RegisteredContributorPerson INGA_WIERZBICKA = RegisteredContributorPerson(
  person: Person(
    name: 'Inga Wierzbicka',
      druzyna: '11. PgDH „Ignis” im. Zofii Cierniakowej',
      srodowisko: Srodowisko.custom(huf_zhr_harcerek_krakow_podgorze, orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrOchotniczka,
  ),
  emails: ['ingawierzbicka1@gmail.com'],
);
const RegisteredContributorPerson JACEK_ANTKIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Jacek Antkiewicz',
      druzyna: '21. DH „Burza”',
  ),
  emails: ["jacek.ant11@gmail.com"],
);
const RegisteredContributorPerson JACEK_PELCZAR = RegisteredContributorPerson(
  person: Person(
    name: 'Jacek Pelczar',
      druzyna: '79. Warszawska Wodna Drużyna Harcerska „Alpha”',
      srodowisko: Srodowisko.hufiec('warszawa_zoliborz', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ["jacek.pelczar@zhp.net.pl", 'jacek.pelczar.stud@pw.edu.pl'],
);
const RegisteredContributorPerson JADWIGA_BILINSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Jadwiga Bilińska',
      rankInstr: RankInstr.phm,
      rankHarc: RankHarc.zhpSamarytanka,
      srodowisko: Srodowisko.hufiec('zielonka', showChoragiew: false, showOkreg: false),
      druzyna: '132. Mazowiecka Drużyna Harcerska „Wielkie Bractwo Halicza”',
  ),
  emails: ['jadwiga.bilinska@zhp.net.pl'],
);
const RegisteredContributorPerson JADWIGA_GORSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Jadwiga Górska',
      rankHarc: RankHarc.zhpHOd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['jdzgorska@gmail.com', 'jadwiga.gorska@zhp.net.pl'],
);
const RegisteredContributorPerson JADWIGA_SZEWCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Jadwiga Szewczyk',
  ),
  emails: ['jadzia.m.szewczyk@gmail.com'],
);
const RegisteredContributorPerson JAGIENKA_KULCZYCKA = RegisteredContributorPerson(
  person: Person(
    name: 'Jagienka Kulczycka',
    rankHarc: RankHarc.zhpOchotniczka,
    druzyna: '36. Kaliska Drużyna Harcerska „Orły”',
    srodowisko: Srodowisko.custom(huf_zhp_kalisz, orgSlug: 'zhp'),
  ),
  emails: ['jagienkakulczycka@gmail.com', 'kulczyckajagienka@gmail.com'],
);
const RegisteredContributorPerson JAGODA_BLASZCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Jagoda Błaszczyk',
      druzyna: '29. Zgierska Drużyna Harcerska „Dakota”',
      srodowisko: Srodowisko.custom(huf_zhp_zgierz, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpOchotniczka,
  ),
  emails: ['blaszczykjagoda25@gmail.com'],
);
const RegisteredContributorPerson JAGODA_SKOWRONSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Jagoda Skowrońska',
      druzyna: '125. „Aves”',
      srodowisko: Srodowisko.custom(huf_zhp_nowe_miasto_lubawskie, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ['jagoda.skowronska@edu.szkolagortatowo.pl', 'jagodaskowronska2021@gmail.com'],
);
const RegisteredContributorPerson JAKUB_BRYLA = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Bryła',
  ),
  emails: ["jakubbryla05@gmail.com"],
);
const RegisteredContributorPerson JAKUB_DEBICKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Dębicki',
      druzyna: '8. Drużyna Wędrownicza „Kuźnia Płomienia”',
      srodowisko: Srodowisko.custom(huf_zhp_lask, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ['j.debicki@icloud.com'],
);
const RegisteredContributorPerson JAKUB_DUDA = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Duda',
      druzyna: '6DW „Malachit”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_myszkowskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ['jakubduda2006@gmail.com'],
);
const RegisteredContributorPerson JAKUB_EJDUK = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Ejduk',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
      srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
  ),
  emails: const [],
);
const RegisteredContributorPerson JAKUB_GABIS = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Gabiś',
      druzyna: '47. DW „Popioły” im. Franciszka Brody',
      srodowisko: Srodowisko.custom(huf_zhp_kalisz),
  ),
  emails: ["kubulus1303@gmail.com"],
);
const RegisteredContributorPerson JAKUB_HURYSZ = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Hurysz',
      druzyna: '44. Kościerska Drużyna Harcerzy „Burza” im. Spadochroniarzy Armii Krajowej',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhrHRc,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ["kuba.hurysz@o2.pl", 'jakub.hurysz@zhr.pl'],
);
const RegisteredContributorPerson JAKUB_KLEPACZ = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Klepacz',
      druzyna: '7. ŁDW „Chaos”',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_gorna, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHRc,
  ),
  emails: ['jakub.klepacz@zhp.net.pl'],
);
const RegisteredContributorPerson JAKUB_KLUCZKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Kluczkowski',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_koszalinskiej, orgSlug: 'zhp'),
  ),
  emails: ['jakub.kluczkowski@zhp.net.pl'],
);
const RegisteredContributorPerson JAKUB_KRUCZKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Kruczkowski',
      druzyna: '128. WDHS',
      srodowisko: Srodowisko.custom('Warszawa Żoliborz', orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ['kuba.kruczkowski@icloud.com', 'jfkruczkowski@gmail.com'],
);
const RegisteredContributorPerson JAKUB_KUBICKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Kubicki',
      srodowisko: Srodowisko.custom(huf_zhp_jaktorow, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ['jakub.kubicki0@icloud.com', 'jakub.kubicki1@zhp.net.pl'],
);
const RegisteredContributorPerson JAKUB_LYSZKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Lyszkowski',
  ),
  emails: ['kubalyszka@gmail.com'],
);
const RegisteredContributorPerson JAKUB_MAGIERA = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Magiera',
      druzyna: '6. DSH „Ichtis”',
      srodowisko: Srodowisko.custom(huf_zhp_nisko, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHRd,
  ),
  emails: ["kuba.magiera220@gmial.com"],
);
const RegisteredContributorPerson JAKUB_MICHALSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Michalski',
      druzyna: '3. PDH im. płk. Jana Kilińskiego „Czarna Trójka”',
      srodowisko: Srodowisko.custom(huf_zhp_pabianice, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["michalski.jakub@zhp.net.pl"],
);
const RegisteredContributorPerson JAKUB_MLYNSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Młyński',
      druzyna: '77. WDH im. Harcerskiego Batalionu Szturmowego „Zośka”',
      srodowisko: Srodowisko.custom(huf_zhp_gdansk_srodmiesie, orgSlug: 'zhp'),
  ),
  emails: ['kubamlynski4@gmail.com'],
);
const RegisteredContributorPerson JAKUB_NOGA = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Noga',
      druzyna: "30. PgDSH „Waganci”",
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
  ),
  emails: ['jakub.noga@zhp.net.pl'],
);
const RegisteredContributorPerson JAKUB_SKUCHA = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Skucha', rankHarc: RankHarc.dhc,
  ),
  emails: const [],
);
const RegisteredContributorPerson JAKUB_STEFANSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Stefański', rankHarc: RankHarc.dhc, srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson JAKUB_STRACZYNSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Strączyński',
      druzyna: '52. KDHS',
      srodowisko: Srodowisko.custom(huf_zhp_kielce_miasto),
  ),
  emails: ['pancernuq@gmail.com', 'pancernu2@gmail.com', 'qbastraczynski@gmail.com'],
);
const RegisteredContributorPerson JAKUB_SWIT = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Świt',
      druzyna: '124. Łódzka Drużyna Harcerzy „Bór" im. K.K. Baczyńskiego',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_baluty, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ["jakub.swit@zhp.net.pl"],
);
const RegisteredContributorPerson JAKUB_TARNOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Tarnowski',
      druzyna: '101. Tarnowska Wędrownicza Drużyna Harcerska „Currahee”',
      srodowisko: Srodowisko.hufiec('tarnow', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["jakubtar14@gmail.com"],
);
const RegisteredContributorPerson JAKUB_ZDANOWICZ_ZASIDKO = RegisteredContributorPerson(
  person: Person(
    name: 'Jakub Zdanowicz-Zasidko', rankHarc: RankHarc.dhc,
  ),
  emails: const [],
);
const RegisteredContributorPerson JAN_JARECKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jan Jarecki',
      druzyna: '30. PgDSH „Waganci”',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
  ),
  emails: ['jareckijan07@gmail.com', 'jan.jarecki@zhp.pl'],
);
const RegisteredContributorPerson JAN_JAWORSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jan Jaworski',
      druzyna: '125. DH „Aves” im. Harcerzy Spod Znaku Rodła',
      srodowisko: Srodowisko.custom(huf_zhp_nowe_miasto_lubawskie, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ['jaworskijan8@gmail.com'],
);
const RegisteredContributorPerson JAN_KRASZEWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jan Kraszewski',
      druzyna: '50. TDSH „Impeesa”',
      srodowisko: Srodowisko.custom(huf_zhp_torun, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ['jan.kraszewski@zhp.net.pl'],
);
const RegisteredContributorPerson JAN_KUCZA = RegisteredContributorPerson(
  person: Person(
    name: 'Jan Kucza',
      druzyna: '12. PDHS „Parszywa Dwunastka”',
      srodowisko: Srodowisko.hufiec('legionowo', showChoragiew: false, showOkreg: false),
  ),
  emails: ['jan.kucza@zhp.net.pl', 's219284@sggw.edu.pl'],
);
const RegisteredContributorPerson JAN_KWIATKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jan Kwiatkowski',
      druzyna: 'Chabrowa 18. Toruńska Drużyna Harcerska „Las” im. Emilii Plater',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["jan.kwiatkowski@zhp.net.pl", "j.kwiat06@gmail.com"],
);
const RegisteredContributorPerson JAN_LEWANDOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jan Lewandowski',
      druzyna: '58. MDH „Cichociemni”',
      srodowisko: Srodowisko.custom('Eldorado', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrWywiadowca,
  ),
  emails: ["janeklefy@gmail.com"],
);
const RegisteredContributorPerson JAN_LICZBANSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jan Liczbański',
      druzyna: '1. PDH „Puszcza” im. KWP',
      srodowisko: Srodowisko.custom('Łódzki Hufiec Harcerzy "Szaniec"', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrWywiadowca,
  ),
  emails: ["janekliczbanski10@gmail.com", "kowalewiczgosia@gmail.com"],
);
const RegisteredContributorPerson JAN_NOWAK = RegisteredContributorPerson(
  person: Person(
    name: 'Jan Nowak',
      druzyna: '8. UDH „Knieja”',
      srodowisko: Srodowisko.custom(huf_zhr_urynowski_hufiec_rawicz, orgSlug: 'zhr'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ['lolekmarian.200@gmail.com'],
);
const RegisteredContributorPerson JAN_REWERSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jan Rewerski',
      druzyna: '173. WDH „Biała” im K. K. Baczyńskiego',
      srodowisko: Srodowisko.hufiec('warszawa_ochota', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpMlodzik,
  ),
  emails: ["jarewerski@gmail.com"],
);
const RegisteredContributorPerson JAN_STANULA = RegisteredContributorPerson(
  person: Person(
    name: 'Jan Stanula',
      druzyna: '4. DSH Ogniste Płomyki',
      srodowisko: Srodowisko.hufiec('trzebinia', showChoragiew: false, showOkreg: false),
  ),
  emails: const [],
);
const RegisteredContributorPerson JANUSZ_ORLUTA = RegisteredContributorPerson(
  person: Person(
    name: 'Janusz Orluta',
      rankHarc: RankHarc.zhpHRc,
      rankInstr: RankInstr.hm,
      druzyna: 'Krąg Instruktorski "Amfibia"',
  ),
  emails: ['janusz.orluta@zhp.net.pl'],
);
const RegisteredContributorPerson JAROMIR_JABLONSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jaromir Jabłoński',
      druzyna: '132. Mazowiecka Drużyna Harcerzy "Synowie Szarego Wilka"',
      srodowisko: Srodowisko.hufiec('zielonka', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.phm,
      rankHarc: RankHarc.zhpHRc,
  ),
  emails: ["jaromir.jablonski@zhp.pl"],
);
const RegisteredContributorPerson JAROSLAW_JAKUBIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Jarosław Jakubiak', rankHarc: RankHarc.dhc,
    srodowisko: Srodowisko.custom(huf_zhp_uk),
  ),
  emails: const [],
);
const RegisteredContributorPerson JAROSLAW_ZASACKI = RegisteredContributorPerson(
  person: Person(
    name: 'Jarosław Zasacki', rankHarc: RankHarc.zhpHOc, rankInstr: RankInstr.phm,
    srodowisko: Srodowisko.custom(huf_zhr_zielonagora_topor, orgSlug: 'zhrChlop'),
  ),
  emails: const [],
);
const RegisteredContributorPerson JASMINA_ROZYCKA = RegisteredContributorPerson(
  person: Person(
    name: 'Jaśmina Różycka',
      druzyna: '12. Lubelska Drużyna Wędrowniczek Północ',
      srodowisko: Srodowisko.custom(huf_zhr_lubelski_hufiec_harcerek_harmonia, orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrSamarytanka,
  ),
  emails: ["kontrabasistka5@gmail.com", "rozyckajasmina@gmail.com"],
);
const RegisteredContributorPerson JERZY_ZOLNA = RegisteredContributorPerson(
  person: Person(
    name: 'Jerzy Żołna',
      druzyna: '30. PDSH „Chruptasy”',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_stare_miasto, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ["kamil12356544@gmail.com"],
);
const RegisteredContributorPerson JOANNA_ASZKLAR = RegisteredContributorPerson(
  person: Person(
    name: 'Joanna Aszklar',
      druzyna: '155. WDSH „Kuźnia”',
      srodowisko: Srodowisko.hufiec('warszawa_mokotow', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ["Joanna.aszklar@zhp.net.pl"],
);
const RegisteredContributorPerson JOANNA_MICHALOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Joanna Michałowska', rankHarc: RankHarc.zhpSamarytanka,
    druzyna: '18. Poznańska Drużyna Harcerek im. Olgi Drahonowskiej-Małkowskiej',
    srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson JOANNA_PAJAK = RegisteredContributorPerson(
  person: Person(
    name: 'Asia Pająk',
      druzyna: '124. ŁGDH „Płomienie”',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_gorna, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ['joanna.pajak@zhp.net.pl', 'pasiajak1@gmail.com'],
);
const RegisteredContributorPerson JOANNA_RACZKO = RegisteredContributorPerson(
  person: Person(
    name: 'Joanna Raczko',
      druzyna: '33. WWDH „Korsarze” im. Marynarki Wojennej RP',
      srodowisko: Srodowisko.custom('Wejherowo', orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
  ),
  emails: ['joanna.raczko@zhp.net.pl'],
);
const RegisteredContributorPerson JOANNA_ZUBEK = RegisteredContributorPerson(
  person: Person(
    name: 'Joanna Zubek',
      druzyna: '234. WDW „Feniks”',
      srodowisko: Srodowisko.custom('Hufiec ZHP Warszawa Mokotów', orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ['joanna.zubek@zhp.net.pl'],
);

const RegisteredContributorPerson JULIA_SZOZDA = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Szozda',
      druzyna: '123. LDSh „Imperatyw”',
      srodowisko: Srodowisko.custom(huf_zhp_lublin, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["jszozdaaa@gmail.com"],
);
const RegisteredContributorPerson JOANNA_WALENDZIK = RegisteredContributorPerson(
  person: Person(
    name: 'Joanna Walendzik',
      druzyna: '111 Artystyczna Drużyna Harcerska',
      srodowisko: Srodowisko.custom(huf_zhp_starachowice, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHRd,
  ),
  emails: ["joanna.walendzik@zhp.net.pl"],
);
const RegisteredContributorPerson JOLA_RYS = RegisteredContributorPerson(
  person: Person(
    name: 'Jola Ryś',
      druzyna: '5. Drużyna „Dzieci Gór”',
      srodowisko: Srodowisko.hufiec('gorczanski', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ["hrismas772@gmail.com", "szkolny77@gmail.com"],
);
const RegisteredContributorPerson JOWITA_BUCZYNSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Jowita Buczyńska',
      druzyna: '23 ZDH "Zorza"',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_bedzinskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ['jowitabuczynska947@gmail.com'],
);
const RegisteredContributorPerson JULIA_BENEDYK = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Benedyk',
      druzyna: '9. MDH',
      srodowisko: Srodowisko.custom(huf_zhp_mielec, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpTropicielka,
  ),
  emails: ['benedykjulia976@gmail.com'],
);
const RegisteredContributorPerson JULIA_BIENIEK = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Bieniek',
      druzyna: '254. Warszawska Drużyna Harcerska im. Janka Bytnara „Rudego” Matecznik',
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['juliamariabieniek@gmail.com'],
);
const RegisteredContributorPerson JULIA_BOLOZ = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Bołoz',
  ),
  emails: ["bolozjulia2@gmail.com"],
);
const RegisteredContributorPerson JULIA_GRODZKA = RegisteredContributorPerson(
  person: Person(
    name: 'Julka Grodzka',
      druzyna: '2. DH „Śpiący Rycerz”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_rybnickiej),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ['jucia.grodzka@gmail.com', 'grodzka.julia@zhp.net.pl'],
);
const RegisteredContributorPerson JULIA_JAROSZ = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Jarosz',
      druzyna: '72. WDH „Knieja”',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ['julia.jarosz@zhp.net.pl'],
);
const RegisteredContributorPerson JULIA_KARAS = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Karaś',
      rankHarc: RankHarc.zhpPionierka,
      druzyna: '78. Grunwaldzka Wielopoziomowa Drużyna Harcerska „Halny” im. hm. Józefy Kantor',
      srodowisko: Srodowisko.custom(huf_zhp_beskidzki, orgSlug: 'zhp'),
  ),
  emails: ['karasjulka81@gmail.com'],
);
const RegisteredContributorPerson JULIA_KOSZTYLA = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Kosztyła',
      druzyna: '7. DH NEMUS',
      srodowisko: Srodowisko.custom(huf_zhp_krosno, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ['juliakosztyla23@gmail.com'],
);
const RegisteredContributorPerson JULIA_MARCINIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Marciniak',
      druzyna: '22 Lubelska Drużyna Harcerek "Potok" im. hm. Danuty Zofii Magierskiej',
      srodowisko: Srodowisko.custom('Lubelski Hufiec Harcerek "Rzeka"', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrSamarytanka,
  ),
  emails: ["juliamarcinka08@gmail.com"],
);
const RegisteredContributorPerson JULIA_PIASKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Piaskowska',
      druzyna: '41 TDH Astrum',
      srodowisko: Srodowisko.custom(huf_zhp_tomaszow_mazowiecki, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpTropicielka,
  ),
  emails: ['jpiaskowska25@gmail.com'],
);
const RegisteredContributorPerson JULIA_PILCH = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Pilch', rankHarc: RankHarc.dhd,
  ),
  emails: const [],
);
const RegisteredContributorPerson JULIA_PROSZKIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Proszkiewicz',
      rankHarc: RankHarc.zhpPionierka,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['juliaproszkiewicz@gmail.com'],
);
const RegisteredContributorPerson JULIA_SIUDMAK = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Siudmak',
  ),
  emails: const [],
);
const RegisteredContributorPerson JULIA_SLAZAK = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Ślązak',
      druzyna: '6 Świdnicka Drużyna Harcerska "Pasieka"',
      srodowisko: Srodowisko.custom(huf_zhp_swidnica, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ["juliaslazak2000@gmail.com"],
);
const RegisteredContributorPerson JULIA_TYSZKIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Tyszkiewicz',
      druzyna: '328. WDW „Fantasmagoria”',
      srodowisko: Srodowisko.hufiec('warszawa_centrum', showChoragiew: false, showOkreg: false),
  ),
  emails: ['julia.tyszkiewicz@zhp.net.pl'],
);
const RegisteredContributorPerson JULIA_WIERZBA = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Wierzba',
  ),
  emails: ["juliawierzba132@gmial.com"],
);
const RegisteredContributorPerson JULIA_WIESZOLEK = RegisteredContributorPerson(
  person: Person(
    name: 'Julia Wieszołek',
      druzyna: '3. Ozimska Drużyna Harcerek „Małapanew”',
      srodowisko: Srodowisko.custom('Zawadczański Związek Drużyn Harcerek „Horyzonty”', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrWedrowniczka,
  ),
  emails: ["julia.wieszolek@zhr.pl"],
);
const RegisteredContributorPerson JULIAN_SLAZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Julian Ślazyk',
      druzyna: '47. ŁWDW',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_polesie),
      rankHarc: RankHarc.dhd,
  ),
  emails: ['l.z.slazyk@gmail.com', 'podstawczak0@gmail.com'],
);
const RegisteredContributorPerson JULIANNA_KLUS = RegisteredContributorPerson(
  person: Person(
    name: 'Julianna Klus',
      druzyna: '208. Warszawska Drużyna Harcerska „Helios”',
      srodowisko: Srodowisko.hufiec('warszawa_mokotow', showChoragiew: false, showOkreg: false),
  ),
  emails: ['julianna.klus@zhp.net.pl', 'julianna.klus4@gmail.com'],
);
const RegisteredContributorPerson JULITA_STEPIEN = RegisteredContributorPerson(
  person: Person(
    name: 'Julita Stępień',
  ),
  emails: const [],
);

const RegisteredContributorPerson KACPER_BACZKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Bączkowski',
      druzyna: 'Ewangelickie Duszpasterstwo Związku Harcerstwa Polskiego',
      rankHarc: RankHarc.zhpHOc,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['baczkowski.kacper.04@gmail.com', 'kacper.baczkowski@zhp.pl'],
);
const RegisteredContributorPerson KACPER_CIESIELSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Ciesielski',
      druzyna: '64. Świnoujska drużyna harcerska im. Batalionów “Zośka” i “Parasol”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_wolinskiej, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHRc,
  ),
  emails: ['yorunokoibito@gmail.com'],
);
const RegisteredContributorPerson KACPER_FRONC = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Fronc',
      druzyna: '19.DH „Modrzewie” im. 12. Pułku Ułanów Podolskich z Telatyna',
  ),
  emails: ['kacperfronc44@gmail.com'],
);
const RegisteredContributorPerson KACPER_JASINSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Jasiński',
      druzyna: '7. PDW "Żar"',
      srodowisko: Srodowisko.custom('Poleski Hufiec Harcerzy "Świt"', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrMlodzik,
  ),
  emails: ["kjasinski008@gmail.com"],
);
const RegisteredContributorPerson KACPER_KORDEK = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Kordek', rankHarc: RankHarc.zhpCwik,
  ),
  emails: const [],
);
const RegisteredContributorPerson KACPER_KOTECKI = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Kotecki',
      druzyna: '3. GŚDHS Kumade Niedździedzia Łapa',
      srodowisko: Srodowisko.custom(huf_zhp_glowno, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpWywiadowca,
  ),
  emails: ["panszkrzyneczka@gmail.com"],
);
const RegisteredContributorPerson KACPER_KOZLUK = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Koźluk',
  ),
  emails: ['kacper@kozluk.pl'],
);
const RegisteredContributorPerson KACPER_MIESOWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Mięsowicz',
      druzyna: '99. DH Amazonki',
      srodowisko: Srodowisko.hufiec('bochnia', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpMlodzik,
  ),
  emails: ['kacper.miesowicz@gmail.com'],
);
const RegisteredContributorPerson KACPER_OLEJNIK = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Olejnik',
      druzyna: '8 DW "Leśne Licho"',
      srodowisko: Srodowisko.custom(huf_zhp_lubaczow, orgSlug: 'zhp'),
  ),
  emails: ["kacper.olejnik@zhp.pl"],
);
const RegisteredContributorPerson KACPER_SMOLKA = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Smółka', srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['kacper.smolka@zhp.net.pl'],
);
const RegisteredContributorPerson KACPER_SWITKIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Świtkiewicz', rankHarc: RankHarc.dhc, srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson KACPER_SZCZENSY = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Szczęsny', rankHarc: RankHarc.zhpWywiadowca, srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson KACPER_SZYMANKIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Szymankiewicz',
      druzyna: '15. Dąbrowska Drużyna Starszoharcerska „Niezłomni” im. Rotmistrza Witolda Pileckiego',
      srodowisko: Srodowisko.custom(huf_zhp_dabrowa_gornicza),
  ),
  emails: ['kacper.szymankiewicz@zhp.net.pl'],
);
const RegisteredContributorPerson KACPER_TOMCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Tomczyk',
      druzyna: '77. Wrzesińska Drużyna Wędrownicza „Huragan”',
      srodowisko: Srodowisko.custom(huf_zhp_wrzesnia_wrzos, orgSlug: 'zhp'),
  ),
  emails: ['celnysnajper@gmail.com'],
);
const RegisteredContributorPerson KACPER_TRUCHLEWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Truchlewski',
      druzyna: '13. DSH „Szalona Trzynsatka”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_mikolowskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ['truchlewski_kacper@enaukasp1.laziska.pl'],
);
const RegisteredContributorPerson KACPER_WIDZ = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Widz',
    rankHarc: RankHarc.zhpMlodzik,
    srodowisko: Srodowisko.custom(huf_zhp_lublin, orgSlug: 'zhp'),
    druzyna: '8. Lubelska Drużyna Wędrownicza „Infiniti”',
  ),
  emails: const [],
);
const RegisteredContributorPerson KACPER_WIETRZYKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Kacper Wietrzykowski',
      srodowisko: Srodowisko.hufiec('legionowo', showChoragiew: false, showOkreg: false),
  ),
  emails: ['kacper.wietrzykowski@zhp.net.pl'],
);

const RegisteredContributorPerson KAJETAN_MEDYK = RegisteredContributorPerson(
  person: Person(
    name: 'Kajetan Mędyk',
      druzyna: '254 Warszawskie Drużyny Harcerskie i Gromady Zuchowe',
      srodowisko: Srodowisko.hufiec('warszawa_zoliborz', showChoragiew: false, showOkreg: false),
  ),
  emails: ['Kajetan_Medyk@outlook.com'],
);
const RegisteredContributorPerson KAJETAN_RUSZKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Kajetan Ruszkowski',
    druzyna: 'XV. ŁDH „Zielony Płomień” im. Andrzeja Małkowskiego',
    srodowisko: Srodowisko.custom(huf_zhr_lodz, orgSlug: 'zhr'),
    rankHarc: RankHarc.zhpHOc,
  ),
  emails: const [],
);
const RegisteredContributorPerson KAJETAN_WITKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Kajetan Witkowski',
      druzyna: '2. DH Iskry',
      srodowisko: Srodowisko.custom(huf_zhp_miedzyrzecz, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpMlodzik,
  ),
  emails: ['kajetanwitkowski1602@gmail.com'],
);
const RegisteredContributorPerson KAJETAN_WYGNANSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Kajetan Wygrański',
    druzyna: '62. MDSH „Krzemień”',
    srodowisko: Srodowisko.hufiec('pruszkow', showChoragiew: false, showOkreg: false),
    rankHarc: RankHarc.zhpOdkrywca,
  ),
  emails: const [],
);
const RegisteredContributorPerson KAROLINA_BABOL = RegisteredContributorPerson(
  person: Person(
    name: 'Karolina Bąbol',
      druzyna: '1. PDH-ek „Płomień” im. Olgi Drahonowskiej- Małkowskiej',
      srodowisko: Srodowisko.custom('Łodzki Hufiec Harcerek „Mozaika”', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrTropicielka,
  ),
  emails: ["karolinababolzhr@gmail.com"],
);
const RegisteredContributorPerson KAROLINA_CZARNECKA = RegisteredContributorPerson(
  person: Person(
    name: 'Karolina Czarnecka',
      rankHarc: RankHarc.dhd,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ['karolinaczarnecka2007@gmail.com'],
);
const RegisteredContributorPerson KAROLINA_HAJDUK = RegisteredContributorPerson(
  person: Person(
    name: 'Karolina Hajduk',
      druzyna: '21. DH',
      srodowisko: Srodowisko.custom(huf_zhp_bytom, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpOchotniczka,
  ),
  emails: ['kotrolina.h@gmail.com'],
);
const RegisteredContributorPerson KAROLINA_MARCINKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Karolina Marcinkowska',
  ),
  emails: const [],
);
const RegisteredContributorPerson KAROLINA_MROCZKO = RegisteredContributorPerson(
  person: Person(
    name: 'Karolina Mroczko',
      druzyna: '14. Próbna SDH „Fenris”',
      srodowisko: Srodowisko.custom(huf_zhp_lagiewniki, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpOchotniczka,
  ),
  emails: ["luskam1234@gmail.com"],
);
const RegisteredContributorPerson KAROLINA_WISNIEWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Karolina Wiśniewska',
      rankHarc: RankHarc.dhc,
      druzyna: '70 WPDH „Nienudni”',
      srodowisko: Srodowisko.custom(huf_zhp_podlasie_w_siedlcach, orgSlug: 'zhp'),
  ),
  emails: ['carowis07@gmail.com'],
);
const RegisteredContributorPerson KAMIL_GORNIK = RegisteredContributorPerson(
  person: Person(
    name: 'Kamil Gurnik',
      rankHarc: RankHarc.zhpCwik,
      druzyna: '64. WDHS „Etos”',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
  ),
  emails: ['kamilgurnik@gmail.com'],
);
const RegisteredContributorPerson KAMIL_ORGANISTA = RegisteredContributorPerson(
  person: Person(
    name: 'Kamil Organista',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
      srodowisko: Srodowisko.custom(huf_zhp_zamosc, orgSlug: 'zhp'),
  ),
  emails: ['k.furiao@gmail.com', 'k.organista@onet.pl'],
);
const RegisteredContributorPerson KAMIL_ZAK = RegisteredContributorPerson(
  person: Person(
    name: 'Kamil Żak',
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: const [],
);
const RegisteredContributorPerson KAMILA_GAJEWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Kamila Gajewska',
      druzyna: '16. Drużyna Harcerska „Metrum”',
      srodowisko: Srodowisko.custom(huf_zhp_grojec, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
  ),
  emails: ["kgajewska1616@gmail.com"],
);
const RegisteredContributorPerson KAROL_FRANKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Karol Frankowski',
      druzyna: '1. PDH „Borek”',
      rankHarc: RankHarc.zhrCwik,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ['karol.frankowski@zhr.pl'],
);
const RegisteredContributorPerson KAROL_FROST = RegisteredContributorPerson(
  person: Person(
    name: 'Karol Frost',
      druzyna: '20. DSH „Nomada”',
      srodowisko: Srodowisko.custom(huf_zhp_starogard_gdanski, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["Karol.frost@zhp.pl"],
);
const RegisteredContributorPerson KAROL_GOLABEK = RegisteredContributorPerson(
  person: Person(
    name: 'Karol Gołąbek',
      rankHarc: RankHarc.zhpMlodzik,
      druzyna: '44. Drużyna Starszoharcerska „Potok” w Miękinii',
  ),
  emails: const [],
);
const RegisteredContributorPerson KAROL_MALINSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Karol Maliński',
      druzyna: '31. Sopocka Wielopoziomowa Drużyna Wodna „Ventus”',
      rankHarc: RankHarc.zhpHOc,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["karol.malinski@zhp.net.pl"],
);
const RegisteredContributorPerson KAROL_MALUS = RegisteredContributorPerson(
  person: Person(
    name: 'Karol Malus',
      rankHarc: RankHarc.dhc,
  ),
  emails: const [],
);
const RegisteredContributorPerson KAROL_PODOLSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Karol Podolski',
      druzyna: '22. IMDW „Baribale”',
      srodowisko: Srodowisko.custom(huf_zhp_ilawa, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
  ),
  emails: ["karol.podolski@zhp.net.pl"],
);
const RegisteredContributorPerson KATARZYNA_BIALAS = RegisteredContributorPerson(
  person: Person(
    name: 'Katarzyna Białas',
      druzyna: 'IV SDH „Jutrzenka”',
  ),
  emails: ["katarzyna.bialas2010@gmail.com"],
);
const RegisteredContributorPerson KATARZYNA_LISAK = RegisteredContributorPerson(
  person: Person(
    name: 'Katarzyna Lisak',
      druzyna: '88. DW „Wierchy”',
      srodowisko: Srodowisko.custom(huf_zhp_beskidzki, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ['katarzyna.lisak@zhp.net.pl'],
);
const RegisteredContributorPerson KATARZYNA_MAZUR = RegisteredContributorPerson(
  person: Person(
    name: 'Katarzyna Mazur',
      druzyna: '9. Próbna Drużyna Wędrownicza „Vigilo”',
      rankHarc: RankHarc.zhpPionierka,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["k.mazur@zhp.pl"],
);
const RegisteredContributorPerson KATARZYNA_POLANSKA_WILK = RegisteredContributorPerson(
  person: Person(
    name: 'Katarzyna Polańska-Wilk',
      druzyna: '36. DSH „Duchy Gór”',
      rankInstr: RankInstr.pwd,
  ),
  emails: ["katarzyna.wilk1@zhp.net.pl"],
);
const RegisteredContributorPerson KATARZYNA_STUDNICKA = RegisteredContributorPerson(
  person: Person(
    name: 'Katarzyna Studnicka',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.dhd,
      druzyna: '12. DH „Na Tropie”',
      srodowisko: Srodowisko.hufiec('andrychow', showChoragiew: false, showOkreg: false),
  ),
  emails: ['katarzyna.studnicka@zhp.net.pl'],
);
const RegisteredContributorPerson KATARZYNA_TRZESNIOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Katarzyna Trześniowska',
      druzyna: '4. Lubelska Drużyna Wędrownicza „Czarna Czwórka” im. hetmana Jana Zamojskiego',
      srodowisko: Srodowisko.custom(huf_zhp_lublin, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["kasiat.trzesniowska@gmail.com"],
);
const RegisteredContributorPerson KINGA_BABIARSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Kinga Babiarska',
      druzyna: '6. RDH „Skrzydła”',
      rankHarc: RankHarc.zhrSamarytanka,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ["zabababa8933@gmail.com"],
);
const RegisteredContributorPerson KINGA_KONOPCZYNSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Kinga Konopczyńska',
      druzyna: '29. WDCzB',
      srodowisko: Srodowisko.custom(huf_zhp_rumia, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHRd,
  ),
  emails: ["kinga.konopczynska@zhp.net.pl", "franciszek.skwiercz@zhp.pl"],
);
const RegisteredContributorPerson KINGA_ZEBRACKA = RegisteredContributorPerson(
  person: Person(
    name: 'Kinga Żebracka',
      druzyna: '10. Harcerska Drużyna Żeglarska',
  ),
  emails: ["kingabzebracka@gmail.com"],
);
const RegisteredContributorPerson KINGA_JANKO = RegisteredContributorPerson(
  person: Person(
    name: 'K. Janko',
      druzyna: '1. DSH im. Szarych Szeregów',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_tarnogorskiej),
  ),
  emails: ["jankokinga9@gmail.com"],
);
const RegisteredContributorPerson KINGA_JASKULSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Kinga Jaskulska',
      druzyna: '100. WDH „Triera”',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['kinga.jaskulska1@zhp.net.pl'],
);
const RegisteredContributorPerson KLARA_MAZEK = RegisteredContributorPerson(
  person: Person(
    name: 'Klara Mazek',
  ),
  emails: const [],
);
const RegisteredContributorPerson KLAUDIA_PARNIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Klaudia Parniewicz',
      druzyna: '12 Drużyna Starszoharcerska „Horyzont”',
      srodowisko: Srodowisko.custom(huf_zhp_nowy_tomysl, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ["klaudia.parniewicz@zhp.net.pl"],
);
const RegisteredContributorPerson KLAUDIA_STASINSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Klaudia Stasińska',
      rankInstr: RankInstr.phm,
      rankHarc: RankHarc.zhpHOd,
      druzyna: '45 Nowomiejska Gromada Zuchowa „Czterolistne Koniczynki”',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_nowe_miasto, orgSlug: 'zhp'),
  ),
  emails: ['klaudia.stasinska@zhp.net.pl', 'claudia.stasinska@gmail.com'],
);
const RegisteredContributorPerson KLAUDIUSZ_PALUCH = RegisteredContributorPerson(
  person: Person(
    name: 'Klaudiusz Paluch',
  ),
  emails: const [],
);
const RegisteredContributorPerson KLEMENTYNA_MARWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Klementyna Marwicz',
      druzyna: 'Przełęcz',
      rankHarc: RankHarc.zhrOchotniczka,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ["kemarwicz@gmail.com"],
);
const RegisteredContributorPerson KORDIAN_LATOCHA = RegisteredContributorPerson(
  person: Person(
    name: 'Kordian Latocha',
      druzyna: '10. ŁDH',
      srodowisko: Srodowisko.custom(huf_zhr_lodz_polesie, orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrMlodzik,
  ),
  emails: ["latochakordian@gmail.com"],
);
const RegisteredContributorPerson KORNEL_DABKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Kornel Dąbkowski',
      druzyna: '0,5. Próbna Drużyna Wędrownicza „Włóczykije”',
      srodowisko: Srodowisko.custom(huf_zhp_trzcianka, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["rener17011973@gmail.com"],
);
const RegisteredContributorPerson KORNEL_GOLEBIEWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Kornel Gołębiewski',
  ),
  emails: ['kornelg2001@wp.pl'],
);
const RegisteredContributorPerson KORNELIA_KASIBORSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Kornelia Kasiborska',
      druzyna: '45. WDH „Alias”',
      srodowisko: Srodowisko.custom(huf_zhp_wloclawek, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["korneliakasiborska76@gmail.com"],
);
const RegisteredContributorPerson KORNELIA_MROWKA = RegisteredContributorPerson(
  person: Person(
    name: 'Kornelia Mrówka',
      druzyna: '11 DH Ragnar im Jana Bytnara w Sierakowie',
      srodowisko: Srodowisko.custom(huf_zhp_miedzychod, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["kornelia.mrowka1@gmail.com"],
);
const RegisteredContributorPerson KORNELIA_PRZYCZOLKA = RegisteredContributorPerson(
  person: Person(
    name: 'Kornelia Przyczółka',
    rankHarc: RankHarc.zhpOchotniczka,
  ),
  emails: ['alicjaspacer@gmail.com'],
);
const RegisteredContributorPerson KRYSTIAN_BULANDA = RegisteredContributorPerson(
  person: Person(
    name: 'Krystian Bulanda',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
  ),
  emails: ['krystian.bulanda@zhp.net.pl'],
);
const RegisteredContributorPerson KRYSTYNA_BITNER = RegisteredContributorPerson(
  person: Person(
    name: 'Krystyna Bitner',
      srodowisko: Srodowisko.org('zhp'),
      druzyna: 'Chorągiew Stołeczna',
  ),
  emails: ['krystyna.bitner@zhp.net.pl'],
);
const RegisteredContributorPerson KRZESIMIR_KARBOWNIK = RegisteredContributorPerson(
  person: Person(
    name: 'Krzesimir Karbownik',
      druzyna: '132. MDH "SSzW"',
      srodowisko: Srodowisko.hufiec('zielonka', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ["krzesimir@karbownik.org"],
);
const RegisteredContributorPerson KRZYSZTOF_BANIK = RegisteredContributorPerson(
  person: Person(
    name: 'Krzysztof Banik',
      druzyna: 'Strażnicy Żywiołów',
      rankHarc: RankHarc.dhc,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["krystofb2010@gmail.com"],
);
const RegisteredContributorPerson KRZYSZTOF_GORECKI = RegisteredContributorPerson(
  person: Person(
    name: 'Krzysztof Górecki',
      druzyna: 'Szczep Pomarańczowy',
      srodowisko: Srodowisko.hufiec('andrychow', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.phm,
  ),
  emails: ["krzysztof.gorecki@zhp.net.pl"],
);
const RegisteredContributorPerson KRZYSZTOF_KANIEWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Krzysztof Kaniewski',
      rankHarc: RankHarc.zhpHOc,
      druzyna: '1. DW „Geneza”',
      srodowisko: Srodowisko.hufiec('legionowo', showChoragiew: false, showOkreg: false),
  ),
  emails: ['krzysztof.kaniewski@zhp.net.pl'],
);
const RegisteredContributorPerson KRZYSZTOF_KRAWCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Krzysztof Krawczyk',
      rankHarc: RankHarc.dhc,
  ),
  emails: const [],
);
const RegisteredContributorPerson KRZYSZTOF_LUBAS = RegisteredContributorPerson(
  person: Person(
    name: 'Krzysztof Lubas',
      druzyna: '1. Śledziejowicka Drużyna Harcerzy „Pełnia”',
      srodowisko: Srodowisko.custom('Polonia Minor', orgSlug: 'zhr'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhrHOc,
  ),
  emails: ["krzysztof.lubas@zhr.pl", "krzyslubas07@gmail.com"],
);
const RegisteredContributorPerson KRZYSZTOF_MALIKIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Krzysztof Malikiewicz',
      rankHarc: RankHarc.zhpHRc,
      srodowisko: Srodowisko.hufiec('trzebinia', showChoragiew: false, showOkreg: false),
  ),
  emails: ['krzysztof.malikiewicz@zhp.net.pl', 'krzysztof.malikiewicz@zhp.pl'],
);
const RegisteredContributorPerson KRZYSZTOF_MALINOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Krzysztof Malinowski',
      druzyna: '19. DWa',
      srodowisko: Srodowisko.custom('5. Hufiec Warszawski', orgSlug: 'fse'),
  ),
  emails: ["krzysztofwmalinowski@gmail.com"],
);
const RegisteredContributorPerson KRZYSZTOF_PIOTR_WAGROWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Krzysztof Piotr Wągrowski',
      druzyna: '8. Aleksandrowska Drużyna Harcerzy',
      srodowisko: Srodowisko.custom(huf_zhr_lodz_polesie, orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrMlodzik,
  ),
  emails: ['krzysio.wagrowski@gmail.com', "agattam2004@gmail.com"],
);
const RegisteredContributorPerson KRZYSZTOF_RODZINKA = RegisteredContributorPerson(
  person: Person(
    name: 'Krzysiek Rodzinka',
      druzyna: 'Czarna Jedynka Rzeszów',
  ),
  emails: ['krzysztof.rodzinka2007@gmail.com'],
);
const RegisteredContributorPerson KRZYSZTOF_SUCHARSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Krzysztof Sucharski',
      druzyna: '14 DSH Fenris',
      srodowisko: Srodowisko.custom(huf_zhp_lagiewniki, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["krzysztofsucharski75@gmail.com"],
);
const RegisteredContributorPerson KSAWERY_TWORKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Ksawery Tworkowski',
      druzyna: '81. ŁDH',
      rankHarc: RankHarc.zhrCwik,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ["ksawery.tworkowski@zhr.pl", "ksawtwor1@wp.pl"],
);
const RegisteredContributorPerson KSENIA_OKRUCINSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Ksenia Okrucińska',
      druzyna: '51. TDH „Czarne Stopy”',
      rankHarc: RankHarc.zhpPionierka,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['polaczekn48@gmail.com', 'ksenia_okrucinska@wp.pl'],
);
const RegisteredContributorPerson LAURA_FRASZEWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Laura Fraszewska',
  ),
  emails: const [],
);
const RegisteredContributorPerson LAURA_NOWAKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Laura Nowakowska',
      druzyna: '25. GGDSH „Zawiszacy” im. dh. Stefana Mirowskiego',
      srodowisko: Srodowisko.hufiec('grodzisk_mazowiecki', showChoragiew: false, showOkreg: false),
  ),
  emails: ['kocham.racuchy.pl@gmail.com', 'laura.elwartowska@edu.sp1grodzisk.pl'],
);
const RegisteredContributorPerson LENA_PATLA = RegisteredContributorPerson(
  person: Person(
    name: 'Lena Patla',
      druzyna: '3. Krośnieńska Górska Drużyna Harcerska „Adventure”',
      srodowisko: Srodowisko.custom(huf_zhp_krosno, orgSlug: 'zhp'),
  ),
  emails: ['lena.patla@icloud.com'],
);
const RegisteredContributorPerson LENA_STEFANSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Lena Stefańska',
      druzyna: 'Różanie',
      srodowisko: Srodowisko.custom(huf_zhp_bydgoszcz_miasto, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpOchotniczka,
  ),
  emails: ["lenastefanska16@gmail.com"],
);
const RegisteredContributorPerson LENA_WEISS = RegisteredContributorPerson(
  person: Person(
    name: 'Lena Weiss',
      druzyna: '8. SDSH',
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['weiss.lenaa@icloud.com'],
);
const RegisteredContributorPerson LILIANA_KASPRZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Liliana Kasprzyk',
      druzyna: '9 GDHS Lukarna',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_gliwickiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["lilianokotek@wp.pl", "lilka.kasprzyk@gmail.com"],
);
const RegisteredContributorPerson LILIANA_MIROTA = RegisteredContributorPerson(
  person: Person(
    name: 'Liliana Mirota',
      druzyna: '7. BDH „Wrzosowisko”',
      srodowisko: Srodowisko.custom(huf_zhp_reduta, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpOchotniczka,
  ),
  emails: ['lilianamirota@gmail.com', 'lilianokotek@wp.pl'],
);
const RegisteredContributorPerson LUCJA_PRABUCKA = RegisteredContributorPerson(
  person: Person(
    name: 'Łucja Prabucka',
      druzyna: '99. Elbląska żeńska drużyna starszo harcerska "Wapiti"  im. Marii Konopnickiej',
      rankHarc: RankHarc.zhpOchotniczka,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["lucja4815@gmail.com"],
);
const RegisteredContributorPerson LUCJA_TALKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Łucja Talkowska',
      druzyna: 'Callis',
      rankHarc: RankHarc.zhrOchotniczka,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ['lusitalkowska@gmail.com'],
);
const RegisteredContributorPerson LUKAS_JANOSIS = RegisteredContributorPerson(
  person: Person(
    name: 'Lukas Janonis',
      srodowisko: Srodowisko.org('zhpNL'),
  ),
  emails: const [],
);
const RegisteredContributorPerson LUKASZ_STANISZEWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Łukasz Staniszewski',
      druzyna: '27. DW „Śreżoga”',
      srodowisko: Srodowisko.hufiec('legionowo', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHRc,
  ),
  emails: ["lukasz.staniszewski@zhp.net.pl"],
);
const RegisteredContributorPerson LUKASZ_STROZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Łukasz Stróżyk',
      druzyna: '3. MWDH „Brzask”',
      srodowisko: Srodowisko.custom(huf_zhp_wagrowiec, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["lukaszstrozyk33@gmail.com"],
);
const RegisteredContributorPerson LUKASZ_SZEPIELAK = RegisteredContributorPerson(
  person: Person(
    name: 'Łukasz Szepielak', rankHarc: RankHarc.dhc, srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson LUKASZ_SZTANDERA = RegisteredContributorPerson(
  person: Person(
    name: 'Łukasz Sztandera',
      rankHarc: RankHarc.zhpWywiadowca,
      srodowisko: Srodowisko.custom(huf_zhp_kielce_poludnie, orgSlug: 'zhp'),
      druzyna: '29. Kielecka Drużyna Harcerska „Bukowina”',
  ),
  emails: ['lukasz.sztandera@zhp.net.pl'],
);
const RegisteredContributorPerson LUKASZ_KRYWULT = RegisteredContributorPerson(
  person: Person(
    name: 'Łukasz Krywult', rankHarc: RankHarc.zhpCwik, srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson LUKASZ_RYBINSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Łukasz Rybiński', rankInstr: RankInstr.pwd,
  ),
  emails: const [],
);
const RegisteredContributorPerson LUKASZ_WERNIK = RegisteredContributorPerson(
  person: Person(
    name: 'Łukasz Wernik',
      druzyna: '3. DSH „Feniks”',
      srodowisko: Srodowisko.custom(huf_zhp_gostynin, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["lukasz.wernik@zhp.pl", 'danzelrex0@gmail.com'],
);
const RegisteredContributorPerson MACIEJ_BATKO = RegisteredContributorPerson(
  person: Person(
    name: 'Maciej Batko', rankHarc: RankHarc.dhc,
      druzyna: '117. Elbląskiej Męskiej Drużyny Harcerskiej „Mato”',
  ),
  emails: ['maciej.batko@uczen11.elblag.pl', 'maciemaciek160@gmail.com', 'maciut2007@gmail.com'],
);
const RegisteredContributorPerson MACIEJ_CHUSTECKI = RegisteredContributorPerson(
  person: Person(
    name: 'Maciej Chustecki',
      rankHarc: RankHarc.zhrMlodzik,
      druzyna: '15. samodzielny zastęp „Burza”',
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: const [],
);
const RegisteredContributorPerson MACIEJ_DOBROWOLSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Maciej Dobrowolski',
      srodowisko: Srodowisko.custom(huf_zhp_elblag, orgSlug: 'zhp'),
      rankInstr: RankInstr.phm,
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ['roinuj5@gmail.com', 'maciej.dobrowolski@zhp.net.pl'],
);
const RegisteredContributorPerson MACIEJ_GRZELAZKA = RegisteredContributorPerson(
  person: Person(
    name: 'Maciej Grzelązka',
      druzyna: '314. „Pierścienia”',
      rankHarc: RankHarc.zhpMlodzik,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['maciej.grzelazka@gmail.com'],
);
const RegisteredContributorPerson MACIEJ_KOLAKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Maciej Kołakowski',
      druzyna: '97. DSh',
      srodowisko: Srodowisko.custom(huf_zhp_zywiec, orgSlug: 'zhp'),
  ),
  emails: ['maciej.kolakowski@zhp.net.pl'],
);
const RegisteredContributorPerson MACIEJ_LADOS = RegisteredContributorPerson(
  person: Person(
    name: 'Maciej Ładoś',
    rankInstr: RankInstr.pwd,
    druzyna: '8. PgDW Granat',
    srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
  ),
  emails: ['macieklad@gmail.com', 'maciej.lados@zhp.net.pl'],
);
const RegisteredContributorPerson MACIEJ_PAWLICA = RegisteredContributorPerson(
  person: Person(
    name: 'Maciej Pawlica',
      druzyna: '1. Nadarzyńska Drużyna Starszoharcerska „Impessa”',
      srodowisko: Srodowisko.hufiec('pruszkow', showChoragiew: false, showOkreg: false),
  ),
  emails: ['maciek.pawlica@outlook.com'],
);
const RegisteredContributorPerson MACIEJ_PRZYBYSZ = RegisteredContributorPerson(
  person: Person(
    name: 'Maciej Przybysz',
      druzyna: '20. DW „Avengers”',
      srodowisko: Srodowisko.hufiec('legionowo', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ['maciej.przybysz@zhp.net.pl'],
);
const RegisteredContributorPerson MACIEJ_SZOLC = RegisteredContributorPerson(
  person: Person(
    name: 'Maciej Szolc',
      druzyna: '17. Drużyna Harcerska „Salamandra” z Jejkowic',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_rybnickiej),
  ),
  emails: ['maciekszolc12@gmail.com'],
);
const RegisteredContributorPerson MACIEJ_WYSOCKI = RegisteredContributorPerson(
  person: Person(
    name: 'Maciej Wysocki',
      druzyna: 'WDHiZ „Matecznik”',
      srodowisko: Srodowisko.hufiec('warszawa_zoliborz', showChoragiew: false, showOkreg: false),
  ),
  emails: ['pan.macieq@gmail.com'],
);
const RegisteredContributorPerson MAGDALENA_BAJER = RegisteredContributorPerson(
  person: Person(
    name: 'Madzia',
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["magdbajer@gmail.com"],
);
const RegisteredContributorPerson MAGDALENA_KALISZ = RegisteredContributorPerson(
  person: Person(
    name: 'Magdalena Kalisz',
      druzyna: '64. WDH „Skaut”',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
  ),
  emails: ['magdalena.kalisz@zhp.net.pl'],
);
const RegisteredContributorPerson MAGDALENA_KOZLOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Magdalena Kozłowska',
      rankHarc: RankHarc.zhpSamarytanka,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['madziakoz2008@gmail.com'],
);

const RegisteredContributorPerson MAGDALENA_KROSZCZYNSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Magdalena Kroszczyńska',
      druzyna: '73. WDHS „Sensorium"',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ["madzik.kroszczyk@gmail.com"],
);
const RegisteredContributorPerson MAGDALENA_MIELNIK = RegisteredContributorPerson(
  person: Person(
    name: 'Anonim', // 'Magdalena Mielnik',
      // druzyna: '10. Drużyna Harcerska "Fidem" w Majdanie Starym im. Wandy "Wacek" Wasilewskiej',
      // rankHarc: RankHarc.zhrTropicielka,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ['madzia.mielnik@onet.pl', 'fajrantelo@gmail.com', 'melizaikk@gmail.com'],
);
const RegisteredContributorPerson MAKSYM_KAWULA = RegisteredContributorPerson(
  person: Person(
    name: 'Maksym Kawula',
      druzyna: '29 TDSH "Feniks"',
      srodowisko: Srodowisko.hufiec('tarnow', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.dhc,
  ),
  emails: ['maksym.kawula@gmail.com'],
);
const RegisteredContributorPerson MAKSYMILIAN_SPADLO = RegisteredContributorPerson(
  person: Person(
    name: 'Maksymilian Spadło',
    rankHarc: RankHarc.dhc,
    druzyna: '101. DSH „Lupus”',
    srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['maks118119@gmail.com'],
);
const RegisteredContributorPerson MAKSYMILIAN_TURZYNSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Maksymilian Turzyński',
      druzyna: '124. „Bór”',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_baluty, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["jestemwlasku@gmail.com", "jestemwborze@gmail.com"],
);
const RegisteredContributorPerson MAKSYMILIAN_WERAN = RegisteredContributorPerson(
  person: Person(
    name: 'Maksymilian Weran',
      druzyna: '1 Nadarzyńska Drużyna Harcerska „Impeesa”',
      rankHarc: RankHarc.zhpCwik,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["maksymilian.weran@zhp.net.pl"],
);
const RegisteredContributorPerson MAJA_BUDZIOSZ = RegisteredContributorPerson(
  person: Person(
    name: 'Maja Budziosz',
      druzyna: '3. PDH-ek Róża Wiatrów',
      srodowisko: Srodowisko.custom('Kraków', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrOchotniczka,
  ),
  emails: ["akita.wiktoria@gmail.com"],
);
const RegisteredContributorPerson MAJA_GUCIK = RegisteredContributorPerson(
  person: Person(
    name: 'Maja gucik',
      druzyna: '4RDH-ek „Stellae”',
      rankHarc: RankHarc.zhrMlodzik,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ["gucikmaja@gmail.com"],
);
const RegisteredContributorPerson MAJA_HAJDACKA = RegisteredContributorPerson(
  person: Person(
    name: 'Maja Hajdacka',
      druzyna: '21. CDW im. Jana Bytanara ps. Rudy',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["maja.hajdacka@gmail.com"],
);
const RegisteredContributorPerson MAJA_SLOWINSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Maja Słowińska',
      srodowisko: Srodowisko.custom('Pałuki', orgSlug: 'zhp'),
  ),
  emails: ["slowinska.maja1@gmail.com"],
);
const RegisteredContributorPerson MAJA_WOJTYNIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Maja Wojtyniak',
      rankHarc: RankHarc.zhrOchotniczka,
      druzyna: '1. ZDH „Rzeka”',
  ),
  emails: ['m.wojtyniak@zhr.pl'],
);
const RegisteredContributorPerson MAJA_ZAJACZKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Maja Zajączkowska',
      druzyna: '3. PDH „Jabłoń” im. św. siostry Faustyny Kowalskiej',
      srodowisko: Srodowisko.custom('PHH-ek "Przymierze"', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrSamarytanka,
  ),
  emails: ["m.zajaczkowska@zhr.pl"],
);
const RegisteredContributorPerson MALGORZATA_KLOC = RegisteredContributorPerson(
  person: Person(
    name: 'Małgorzata Kloc',
      rankHarc: RankHarc.zhpPionierka,
      druzyna: '9. Gliwicka Drużyna Harcerzy Starszych „Lukarna” im. płk. Witolda Pileckiego',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_gliwickiej, orgSlug: 'zhp'),
  ),
  emails: ['malgorzata.kloc@zhp.net.pl'],
);
const RegisteredContributorPerson MALGORZATA_MASKO_HORYZA = RegisteredContributorPerson(
  person: Person(
    name: 'Małgorzata Maśko-Horyza',
    rankInstr: RankInstr.phm,
    srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['m.masko-horyza@zhp.net.pl', 'malgorzata.masko-horyza@zhp.net.pl'],
);
const RegisteredContributorPerson MALGORZATA_ORANKIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Małgorzata Orankiewicz',
      druzyna: '43. ZDHS „Parasol”',
      srodowisko: Srodowisko.custom(huf_zhp_zgierz, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ["orankiewicz.gosia1@gmail.com"],
);
const RegisteredContributorPerson MALGORZATA_SZMUK = RegisteredContributorPerson(
  person: Person(
    name: 'Małgorzata Szmuk',
      druzyna: '16. DH WATAHA',
  ),
  emails: ['szgosia2k19@gmail.com'],
);
const RegisteredContributorPerson MALWINA_TRUSZKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Malwina Truszkowska',
      rankHarc: RankHarc.zhpPionierka,
      druzyna: '23. Warszawska Drużyna Wędrownicza „Binduga”',
      srodowisko: Srodowisko.hufiec('warszawa_mokotow', showChoragiew: false, showOkreg: false),
  ),
  emails: ['malwina.truszkowska@zhp.net.pl', 'malvisianna@gmail.com'],
);
const RegisteredContributorPerson MARCEL_MICHALIK = RegisteredContributorPerson(
  person: Person(
    name: 'Marcel Michalik',
      druzyna: '7. DSH „Kosogłos”',
      srodowisko: Srodowisko.custom(huf_zhp_glogow, orgSlug: 'zhp'),
  ),
  emails: ["michalikmsp@gmail.com"],
);
const RegisteredContributorPerson MARCEL_RYCHTER = RegisteredContributorPerson(
  person: Person(
    name: 'Marcel Rychter',
      druzyna: 'Szczep Podhale, Toronto, Kanada',
  ),
  emails: ['m.rychter@gmail.com', 'm.rychter1441@gmail.com'],
);
const RegisteredContributorPerson MARCEL_WOZNIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Marcel Woźniak',
      druzyna: '10. KDSH Zioła',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_koszalinskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ['marcel.wozniak.144@gmail.com'],
);
const RegisteredContributorPerson MARCELI_WARDA = RegisteredContributorPerson(
  person: Person(
    name: 'Marceli Warda',
      druzyna: '123. LDSh „Imperatyw”',
      srodowisko: Srodowisko.custom(huf_zhp_lublin, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["marceliwarda@gmail.com"],
);
const RegisteredContributorPerson MARCELINA_SZYNDLER = RegisteredContributorPerson(
  person: Person(
    name: "Marcelina Szyndler",
  ),
  emails: ['marcelina.szyndler@gmail.com'],
);
const RegisteredContributorPerson MARCELINA_WILCZAK = RegisteredContributorPerson(
  person: Person(
    name: 'Marcelina Wilczak',
      druzyna: '1. DH „Bór”',
      srodowisko: Srodowisko.hufiec('trzebinia', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ['marcelina.wilczak@zhp.net.pl', 'wilczakmarcelina@gmail.com'],
);
const RegisteredContributorPerson MARCIN_JANKOWIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Marcin Jankowiak',
    srodowisko: Srodowisko.custom(huf_zhp_jarocin, orgSlug: 'zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson MARCIN_SOBKOWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Marcin Sobkowicz',
      druzyna: '107. DH „Powsinogi” im. Zygmunta Glogera',
      srodowisko: Srodowisko.custom(huf_zhp_opole),
  ),
  emails: ["m.sobkovicz@gmail.com"],
);
const RegisteredContributorPerson MARCJANNA_NEY = RegisteredContributorPerson(
  person: Person(
    name: 'Marcjanna Ney',
      druzyna: '16 EŻDH Lilie',
      srodowisko: Srodowisko.custom(huf_zhp_elblag, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ["marcjanna199@gmail.com"],
);
const RegisteredContributorPerson MAREK_BIZON = RegisteredContributorPerson(
  person: Person(
    name: 'Marek Bizoń',
      druzyna: '17. DH „Salamandra”',
      srodowisko: Srodowisko.custom('Hufiec Ziemi Rybnickiej', orgSlug: 'zhp'),
      rankInstr: RankInstr.phm,
      rankHarc: RankHarc.zhpHRc,
  ),
  emails: ['marek1bizon@gmail.com', 'marek.bizon@zhp.net.pl'],
);
const RegisteredContributorPerson MAREK_BOJARUN = RegisteredContributorPerson(
  person: Person(
    name: 'Marek Bojarun',
      druzyna: '64. ODSH „Cień”',
      rankHarc: RankHarc.zhpWywiadowca,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['marekbojarun220@gmail.com', 'm.bojarun09@gmail.com'],
);
const RegisteredContributorPerson MAREK_LEWANCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Marek Lewańczyk',
      rankHarc: RankHarc.zhpHOc,
      rankInstr: RankInstr.pwd,
      druzyna: '7. GDH „Wilki”',
  ),
  emails: ['marek.lewanczyk@zhp.net.pl'],
);
const RegisteredContributorPerson MAREK_MUSIALIK = RegisteredContributorPerson(
  person: Person(
    name: 'Marek Musialik', rankHarc: RankHarc.dhc, srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson MARLENA_BANIA = RegisteredContributorPerson(
  person: Person(
    name: 'Marlena Bania',
      rankHarc: RankHarc.zhpSamarytanka,
      druzyna: '9. Gliwicka Drużyna Wędrownicza „Maszkaron”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_gliwickiej, orgSlug: 'zhp'),
  ),
  emails: ['marlena.bania6474@gmail.com', 'marlena.bania@zhp.net.pl'],
);
const RegisteredContributorPerson MARIA_BATKO = RegisteredContributorPerson(
  person: Person(
    name: 'Maria Batko',
      druzyna: '99 EŻDSH Wapiti im. Marii Konopnickiej',
      srodowisko: Srodowisko.custom(huf_zhp_elblag, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ["marysiajamna@gmail.com"],
);
const RegisteredContributorPerson MARIA_GRZYWACZ = RegisteredContributorPerson(
  person: Person(
    name: 'Maria Grzywacz',
      druzyna: '13. CDH „Bezimienni”',
      srodowisko: Srodowisko.custom(huf_zhp_czestochowa, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ["marysia.grzywacz@gmail.com"],
);
const RegisteredContributorPerson MARIA_KIELIN = RegisteredContributorPerson(
  person: Person(
    name: 'Maria Kielin',
      druzyna: '11. WKDH Czarne Kruki',
      srodowisko: Srodowisko.custom(huf_zhp_konin, orgSlug: 'zhp'),
  ),
  emails: ['eryh4757@gmail.com'],
);
const RegisteredContributorPerson MARIA_LAKOMA = RegisteredContributorPerson(
  person: Person(
    name: 'Maria Łakoma',
      druzyna: '1 Specjalnościowa Drużyna Harcerska GROM im. Cichociemnych Spadochroniarzy AK',
      srodowisko: Srodowisko.custom(huf_zhp_doliny_liwca, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ["maria.lakoma@zhp.net.pl"],
);
const RegisteredContributorPerson MARIA_MAGDALENA_DESKUR = RegisteredContributorPerson(
  person: Person(
    name: 'Maria Magdalena Deskur',
  ),
  emails: ['nenadeskur12@gmail.com'],
);
const RegisteredContributorPerson MARIA_MIELCZAREK = RegisteredContributorPerson(
  person: Person(
    name: 'Maria Mielczarek',
      druzyna: '86. ŁWDSH',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_polesie, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ["marysia.m.mielczarek@gmail.com"],
);
const RegisteredContributorPerson MARIA_PIKOSZ = RegisteredContributorPerson(
  person: Person(
    name: 'Maria Pikosz',
      druzyna: '42. BDSH „Krzewy”',
      srodowisko: Srodowisko.custom(huf_zhp_bydgoszcz_miasto, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpTropicielka,
  ),
  emails: ["nszzbga@gmail.comI"],
);
const RegisteredContributorPerson MARIA_PRZYBYLSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Maria Przybylska',
      druzyna: '49. Łódzka Drużyna Harcerek im. gen. Elżbiety Zawackiej „Zo”',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_baluty, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ['marysia.przybylska10@gmail.com', 'maria.przybylska@zhp.net.pl'],
);
const RegisteredContributorPerson MARIA_SKOWRONEK = RegisteredContributorPerson(
  person: Person(
    name: 'Maria Skowronek',
      druzyna: 'Chorągiew Stołeczna',
      rankInstr: RankInstr.phm,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['maria.skowronek@zhp.net.pl'],
);
const RegisteredContributorPerson MARIA_STACHARSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Maria Stacharska',
      druzyna: '8. PgDSH "Pandora"',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ['maria.f.stacharska@gmail.com'],
);
const RegisteredContributorPerson MARTA_GOLEBIOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Marta Gołębiowka',
      rankInstr: RankInstr.pwd,
      druzyna: "7 BDSH „Żywica” im. Ryszarda Kaczorowskiego",
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["marta.golebiowska@zhp.net.pl"],
);
const RegisteredContributorPerson MARTA_SZYMANDERSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Marta Szymanderska', rankHarc: RankHarc.dhd, srodowisko: Srodowisko.hufiec('warszawa_mokotow', showChoragiew: false, showOkreg: false),
  ),
  emails: const [],
);
const RegisteredContributorPerson MARTYNA_BULAKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Martyna Bułakowska',
      rankHarc: RankHarc.zhpHOd,
      rankInstr: RankInstr.pwd,
      druzyna: '17 Rudzka Grubwaldzka Drużyna Harcerska „VICTORY”',
      srodowisko: Srodowisko.custom(huf_zhp_ruda_slaska, orgSlug: 'zhp'),
  ),
  emails: ['m.bulakowska1997@gmail.com'],
);
const RegisteredContributorPerson MARTYNA_CEGLAREK = RegisteredContributorPerson(
  person: Person(
    name: 'Martyna Ceglarek',
      druzyna: '21. Drużyna Harcerska „Gawra”',
      srodowisko: Srodowisko.custom(huf_zhp_wolsztyn, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpTropicielka,
  ),
  emails: ["ceglarekmartyna003@gmail.com"],
);
const RegisteredContributorPerson MARTYNA_SADOWNIK = RegisteredContributorPerson(
  person: Person(
    name: 'Martyna Sadownik',
      druzyna: '316. GDH „Huragan”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_gliwickiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ['martyna.sadownik@zhp.net.pl'],
);
const RegisteredContributorPerson MARTYNA_WASILEWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Martyna Wasilewska',
      druzyna: '7. BDSH „Żywica”',
      srodowisko: Srodowisko.custom('Reduta', orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ['martynawasilewska.1972@gmail.com', 'martynawas91@gmail.com'],
);
const RegisteredContributorPerson MARTYNA_ZAJAC = RegisteredContributorPerson(
  person: Person(
    name: 'Martyna Zając',
      druzyna: '12. PDH „Atomówki”',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_grunwald, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ['zajacmartyna000@gmail.com'],
);
const RegisteredContributorPerson MARYSIA_SLUGAJ = RegisteredContributorPerson(
  person: Person(
    name: 'Marysia Ślugaj',
      rankHarc: RankHarc.zhpHOd,
      srodowisko: Srodowisko.custom(huf_zhp_wrzesnia_wrzos),
      druzyna: '77. Wrzesińska Drużyna Wędrownicza „Huragan”',
  ),
  emails: ['nutkiq@gmail.com', 'giyuu@op.pl'],
);
const RegisteredContributorPerson MATEUSZ_CIAGLO = RegisteredContributorPerson(
  person: Person(
    name: 'Mateusz Ciągło', rankHarc: RankHarc.dhc,
  ),
  emails: const [],
);
const RegisteredContributorPerson MATEUSZ_D = RegisteredContributorPerson(
  person: Person(
    name: 'Mateusz D',
      druzyna: '2. BDH „Rajza”',
      srodowisko: Srodowisko.custom(huf_zhr_bytomski_zwiazek_druzyn, orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrWywiadowca,
  ),
  emails: ["matiadormateusz@gmail.com"],
);
const RegisteredContributorPerson MATEUSZ_GAWRYSIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Mateusz Gawrysiak', rankHarc: RankHarc.zhpCwik,
  ),
  emails: const [],
);
const RegisteredContributorPerson MATEUSZ_KOBYLAREK = RegisteredContributorPerson(
  person: Person(
    name: 'Mateusz Kobylarek',
    rankHarc: RankHarc.zhpMlodzik,
    druzyna: '35. Poznańska Drużyna Harcerska im. I Polskiej Samodzielnej Kompanii Commando',
    srodowisko: Srodowisko.custom(huf_zhp_poznan_wilda, orgSlug: 'zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson MATEUSZ_KORZENIOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Mateusz Korzeniowski',
      druzyna: '1. DH D.R.E.S.Z.C.Z',
      srodowisko: Srodowisko.hufiec('wieliczka', showChoragiew: false, showOkreg: false),
  
      rankHarc: RankHarc.dhc,
  ),
  emails: ['mateusz.korzeniowski@zhp.net.pl'],
);
const RegisteredContributorPerson MATEUSZ_MIKLASZEWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Mateusz Miklaszewski',
      druzyna: '12. DH Silva',
      srodowisko: Srodowisko.custom(huf_zhp_augustow, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.dhc,
  ),
  emails: ['mateusz.miklaszewski@gmail.com'],
);
const RegisteredContributorPerson MATEUSZ_PYSZKA = RegisteredContributorPerson(
  person: Person(
    name: 'Mateusz Pyszka',
      druzyna: '70. SDH',
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ['mati.matixos@gmail.com'],
);
const RegisteredContributorPerson MATEUSZ_OLSZANSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Mateusz Olszański',
      druzyna: '30 Pgdsh "Waganci"',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpWywiadowca,
  ),
  emails: ["mateusz@olszanski.com"],
);
const RegisteredContributorPerson MATEUSZ_STEPNIEWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Mateusz Stępniewski',
      druzyna: '119',
      srodowisko: Srodowisko.hufiec('warszawa_zoliborz', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpWywiadowca,
  ),
  emails: ['mateuszk.stepniewski@gmail.com'],
);
const RegisteredContributorPerson MATEUSZ_SWIEBODA = RegisteredContributorPerson(
  person: Person(
    name: 'Mateusz Świeboda',
      druzyna: '17. KDH Jaworznia',
      srodowisko: Srodowisko.custom(huf_zhp_kielce_miasto, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ['etykik0@gmail.com'],
);
const RegisteredContributorPerson MATEUSZ_URBANIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Mateusz Urbaniak',
      druzyna: '42 DDH „Czarne Stopy”',
      rankHarc: RankHarc.zhpCwik,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['m.urbaniak125@gmail.com'],
);
const RegisteredContributorPerson MATEUSZ_WAS = RegisteredContributorPerson(
  person: Person(
    name: 'Mateusz Wąs',
      druzyna: '91 Kłobucka Drużyna Wędrownicza „Hades”',
      srodowisko: Srodowisko.custom(huf_zhp_klobuck, orgSlug: 'zhp'),
  ),
  emails: ['was.mateusz@zhp.pl'],
);
const RegisteredContributorPerson MATVII_MASLOVSKYI = RegisteredContributorPerson(
  person: Person(
    name: 'Матвій Масловскi',
      druzyna: '6. DSH',
      srodowisko: Srodowisko.custom(huf_zhp_gniezno, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["matvijmaslovski@gmail.com"],
);
const RegisteredContributorPerson MATYLDA_OLEJNIK = RegisteredContributorPerson(
  person: Person(
    name: 'Matylda Olejnik',
      druzyna: 'V DH Impsa',
      srodowisko: Srodowisko.custom(huf_zhp_kedzierzyn_kozle),
  ),
  emails: ["matyldazbagien@gmail.com"],
);
const RegisteredContributorPerson MAXIMILIAN_STEINHOFF = RegisteredContributorPerson(
  person: Person(
    name: 'Maximilian Steinhoff',
    //stop_h: StopZHP.dhc,
    rankInstr: RankInstr.pwd,
    druzyna: 'Próbna Drużyna Harcerzy w Berlinie ZHP Świat „Miś Wojtek”',
  ),
  emails: const [],
);
const RegisteredContributorPerson MICHAL_CHOLEWCZYNSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Cholewczyński',
      druzyna: '77. PDW „Chimera”',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_jezyce, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ['michal.cholewczynski@zhp.net.pl', 'michalcholewczynski@gmail.com', 'theniedzwiedz@icloud.com'],
);
const RegisteredContributorPerson MICHAL_DYDERSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Dyderski',
      rankHarc: RankHarc.zhpHOc,
      rankInstr: RankInstr.pwd,
      druzyna: '93. PDW',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_wilda, orgSlug: 'zhp'),
  ),
  emails: ['michal.dyderski6@gmail.com', 'michal.dyderski@zhp.net.pl'],
);
const RegisteredContributorPerson MICHAL_JABCZYNSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Jabczyński',
      rankHarc: RankHarc.zhpHRc,
      rankInstr: RankInstr.pwd,
      druzyna: '9. DH „Feniks”',
      srodowisko: Srodowisko.custom(huf_zhp_gniezno, orgSlug: 'zhp'),
  ),
  emails: ['michal.jabczynski@gmail.com'],
);
const RegisteredContributorPerson MICHAL_JANAS = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Janas',
  ),
  emails: ['mdjanas@gmail.com'],
);
const RegisteredContributorPerson MICHAL_KARWOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Karwowski',
    rankHarc: RankHarc.zhpHOc,
    rankInstr: RankInstr.phm,
    druzyna: '72. Szczep WDHiGZ „Ostoja”',
    srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
  ),
  emails: const [],
);
const RegisteredContributorPerson MICHAL_KUSTOSIK = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Kustosik',
      druzyna: 'Krąg Instruktorski',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_polesie),
  ),
  emails: ["mkustosik@gmail.com"],
);
const RegisteredContributorPerson MICHAL_MACULEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Maculewicz',
      druzyna: '6. GNDH „Vitae" im.Floriana Marciniaka',
      rankHarc: RankHarc.zhpHOc,
      srodowisko: Srodowisko.custom(huf_zhp_nidzica, orgSlug: 'zhp'),
  ),
  emails: ['michal.maculewicz@zhp.net.pl'],
);
const RegisteredContributorPerson MICHAL_METEL = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Mętel',
    druzyna: 'Szczep „Unia” im. Władysława Jagiełły',
    rankHarc: RankHarc.zhpHOc,
    rankInstr: RankInstr.pwd,
    srodowisko: Srodowisko.hufiec('krakow_nowa_huta', showChoragiew: false, showOkreg: false),
  ),
  emails: ['michal.metel@zhp.net.pl'],
);
const RegisteredContributorPerson MICHAL_PIENIAZEK = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Pieniążek',
      druzyna: '1 KDH',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHRc,
      srodowisko: Srodowisko.org('hrp'),
  ),
  emails: ['4michalpieniazek@gmail.com'],
);
const RegisteredContributorPerson MICHAL_RZEZNIKIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Rzeźnikiewicz',
      druzyna: '104. WDH „Strumień”',
      srodowisko: Srodowisko.custom(huf_zhp_karkonoski, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpWywiadowca,
  ),
  emails: ["rzeznikiewiczmichal@gmail.com", "michalrzeznik2819@gmail.com"],
);
const RegisteredContributorPerson MICHAL_SITEK = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Sitek',
      druzyna: '21. EŚDH Horyzont',
      srodowisko: Srodowisko.custom(huf_zhp_chrzanow),
  ),
  emails: ['misiokikol@gmail.com'],
);
const RegisteredContributorPerson MICHAL_SMULIK = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Smulik',
      druzyna: '62 kdhs brzoza',
      srodowisko: Srodowisko.custom(huf_zhp_kalisz, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["smumichal@gmail.com"],
);
const RegisteredContributorPerson MICHAL_SUPINSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Michał Supiński',
      rankHarc: RankHarc.zhpHOc,
      rankInstr: RankInstr.pwd,
      druzyna: '149. Poznańska Drużyna Harcerska „Bzura” im. generała Tadeusza Kutrzeby',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_nowe_miasto, orgSlug: 'zhp'),
  ),
  emails: ['michal.supinskii@gmail.com'],
);
const RegisteredContributorPerson MIECZYSLAW_MICHALIK = RegisteredContributorPerson(
  person: Person(
    name: 'Mietek Michalik',
  ),
  emails: ['mimich@onet.pl'],
);
const RegisteredContributorPerson MIESZKO_OKROJ = RegisteredContributorPerson(
  person: Person(
    name: 'Mieszko Okrój',
      druzyna: '82 ŁDSH "Eliock" im. 1SBS',
      srodowisko: Srodowisko.custom(huf_zhp_lodz_gorna, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ['mooj1234567890@gmail.com', 'mieszko.okroj@zhp.net.pl'],
);
const RegisteredContributorPerson MIKOLAJ_GORECKI = RegisteredContributorPerson(
  person: Person(
    name: 'Mikołaj Górecki',
      druzyna: '30. PgDSHW „Waganci”',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
  ),
  emails: ['mikolaj.gorecki.pl@gmail.com'],
);
const RegisteredContributorPerson MIKOLAJ_HORDEJUK = RegisteredContributorPerson(
  person: Person(
    name: 'Mikołaj Hordejuk',
      druzyna: '44 44 WDH "Kedyw" im. gen. Augusta Emila Fieldorfa ps. "Nil"',
      srodowisko: Srodowisko.custom(huf_zhr_mazowiecki_hufiec_harcerzy_pogranicze, orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrMlodzik,
  ),
  emails: ["mgmiko813@gmail.com"],
);
const RegisteredContributorPerson MIKOLAJ_LACHENDRO = RegisteredContributorPerson(
  person: Person(
    name: 'Mikołaj Lachendro',
      druzyna: '28 d. harcerska południe',
      srodowisko: Srodowisko.hufiec('andrychow', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpWywiadowca,
  ),
  emails: ["mikilego2012@gmail.com"],
);
const RegisteredContributorPerson MIKOLAJ_LUKASIK = RegisteredContributorPerson(
  person: Person(
    name: 'Mikołaj Łukasik',
      druzyna: '8. PgDSH „Pandora”',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.dhc,
  ),
  emails: ['mikiriki2017@gmail.com'],
);
const RegisteredContributorPerson MIKOLAJ_MATUSZEWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Mikołaj Matuszewski',
    druzyna: '43. CHDG „SULIMA” im. Rycerza Zawiszy Czarnego',
    srodowisko: Srodowisko.custom(huf_zhp_czestochowa, orgSlug: 'zhp'),
  ),
  emails: ['mikolaj.matuszewski@zhp.net.pl'],
);
const RegisteredContributorPerson MIKOLAJ_SOBON = RegisteredContributorPerson(
  person: Person(
    name: 'Mikołaj Soboń',
      druzyna: '16. Drużyna Harcerska',
      srodowisko: Srodowisko.custom(huf_zhp_zyrardow, orgSlug: 'zhp'),
      rankInstr: RankInstr.phm,
      rankHarc: RankHarc.zhpHRc,
  ),
  emails: ['mikolaj.sobon@zhp.net.pl'],
);
const RegisteredContributorPerson MIKOLAJ_WITKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Mikołaj Witkowski',
  ),
  emails: const [],
);
const RegisteredContributorPerson MILENA_DULAK = RegisteredContributorPerson(
  person: Person(
    name: 'Milena Dułak',
      druzyna: '14. BDH-ek „Róża Wiatrów”',
      rankHarc: RankHarc.zhrOchotniczka,
  ),
  emails: ['dulakmilena@gmail.com'],
);
const RegisteredContributorPerson MILENA_NOWICKA = RegisteredContributorPerson(
  person: Person(
    name: 'Milena Nowicka',
      druzyna: '13 BGDH Astus im. KS. Edmunda Barbasiewicza',
      srodowisko: Srodowisko.custom(huf_zhp_biala_podlaska, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ["milenia.now123@gmail.com"],
);
const RegisteredContributorPerson MILOSZ_SZYMANSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Miłosz Szymański',
      druzyna: '9. RDH „Włóczykije”',
      rankHarc: RankHarc.dhc,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['miloszszymanski38@gmail.com'],
);
const RegisteredContributorPerson MINION_MALGOSIA_MIKOLAJCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Minion Małgosia Mikołajczyk',
      druzyna: '119. Warszawska Drużyna Harcerska „Immortales”',
      srodowisko: Srodowisko.hufiec('warszawa_zoliborz', showChoragiew: false, showOkreg: false),
  ),
  emails: ["malgorzata.a.mikolajczyk@gmail.com"],
);
const RegisteredContributorPerson NADIA_STOLAR = RegisteredContributorPerson(
  person: Person(
    name: 'Nadia Stolar',
      druzyna: '41. TDH „Astrum”',
      srodowisko: Srodowisko.custom(huf_zhp_tomaszow_mazowiecki),
      rankHarc: RankHarc.zhpOchotniczka,
  ),
  emails: ["stolar.nadia14@gmail.com"],
);
const RegisteredContributorPerson NADIA_OSSOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Nadia Ossowska',
    rankHarc: RankHarc.dhd,
    druzyna: '6. Zagłębiowska Drużyna Harcerska „Eleusis” im.Stanisława Żółkiewskiego',
    srodowisko: Srodowisko.custom(huf_zhp_ziemi_bedzinskiej, orgSlug: 'zhp'),
  ),
  emails: ['nadia.ossowska.2007@gmail.com', 'nadia.ossowska@icloud.com'],
);
const RegisteredContributorPerson NADIA_WYSZOGRODZKA = RegisteredContributorPerson(
  person: Person(
    name: 'Nadia Wyszogrodzka',
      druzyna: '1. Drużyna Specjalnościowa „Grom” im. Cichociemnych Spadochroniarzy Armi Krajowej w Węgrowie',
      srodowisko: Srodowisko.custom(huf_zhp_doliny_liwca, orgSlug: 'zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson NATALIA_KLEPACKA = RegisteredContributorPerson(
  person: Person(
    name: 'Natalia Klepacka',
      druzyna: '23. WDH "Wilki" im. Bogusława Ustaborowicza "Żara"',
      srodowisko: Srodowisko.custom(huf_zhp_wroclaw_polnoc),
  ),
  emails: ["natalia.klepacka@zhp.net.pl"],
);
const RegisteredContributorPerson NATALIA_STODOLNA = RegisteredContributorPerson(
  person: Person(
    name: 'Natalia Stodolna',
      druzyna: '1. DSH „Viatores”',
      srodowisko: Srodowisko.custom(huf_zhp_zielona_gora, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ['natalia.stodolna@zhp.net.pl'],
);
const RegisteredContributorPerson NATALIA_SZYMANIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Natalia Szymaniak',
      druzyna: '14. WGZ „Trollinki z Kniei” św. Huberta',
      rankHarc: RankHarc.zhrSamarytanka,
      srodowisko: Srodowisko.org('zhr'),
  ),
  emails: ['nataliaszym009@gmail.com'],
);
const RegisteredContributorPerson NATALIA_WOJTYCZKA = RegisteredContributorPerson(
  person: Person(
    name: 'Natalia Wojtyczka',
      druzyna: '39. DH „Azymut” im. Batalionu „Zośka”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_tyskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ["nataliawojtyczka00@gmail.com"],
);
const RegisteredContributorPerson NATASZA_OLSZANSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Natasza Olszańska',
      druzyna: '9. Mielecka Drużyna Harcerska',
      srodowisko: Srodowisko.custom(huf_zhp_mielec),
      rankHarc: RankHarc.zhpTropicielka,
  ),
  emails: ["natasza.olszanska1@gmail.com"],
);
const RegisteredContributorPerson NINA_KESKA = RegisteredContributorPerson(
  person: Person(
    name: 'Nina K',
      druzyna: '8. PDH „Widmo"',
      rankHarc: RankHarc.dhd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["keska.nina@gmail.com"],
);
const RegisteredContributorPerson NINA_MIKLAS = RegisteredContributorPerson(
  person: Person(
    name: 'Nina Mikłas',
      druzyna: '39. DH „Azymut” Im Batalionu „Zośka”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_tyskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ["nina.miklas05@gmail.com"],
);
const RegisteredContributorPerson NINA_ROGUSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Nina Roguska',
      druzyna: '300. Warszawska Drużyna Wielopoziomowa „Elba”',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ["ninka.roguska@gmail.com"],
);
const RegisteredContributorPerson NORBERT_PIATKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Norbert Piątkowski',
      srodowisko: Srodowisko.custom(huf_zhp_szczecin, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
  ),
  emails: const [],
);
const RegisteredContributorPerson NORBERT_SOWA = RegisteredContributorPerson(
  person: Person(
    name: 'Norbert Sowa',
      druzyna: '18. DH „Ogniki”',
      srodowisko: Srodowisko.custom(huf_zhp_lagiewniki, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpOdkrywca,
  ),
  emails: ["norbert.sowa2010@gmail.com"],
);
const RegisteredContributorPerson OLAF_MILEROWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Olaf Milerowicz',
      druzyna: '173. WDH „Biała” im. Krzysztofa Kamila Baczyńskiego',
      srodowisko: Srodowisko.hufiec('warszawa_ochota', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpMlodzik,
  ),
  emails: ["milerowicz.olaf@gmail.com"],
);
const RegisteredContributorPerson OLEKSII_OVCHYNNIKOV = RegisteredContributorPerson(
  person: Person(
    name: 'Oleksii Ovchynnikov',
      druzyna: '191. „Żagiew”',
      srodowisko: Srodowisko.hufiec('warszawa_mokotow', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpOdkrywca,
  ),
  emails: ['dobroslaovch@gmail.com'],
);
const RegisteredContributorPerson OLGA_JAJKO = RegisteredContributorPerson(
  person: Person(
    name: 'Olga Jajko',
      rankInstr: RankInstr.pwd,
      druzyna: '1. Krakowska Drużyna Harcerska HRP',
      srodowisko: Srodowisko.org('hrp'),
  ),
  emails: ['olgajajko2004@gmail.com'],
);
const RegisteredContributorPerson OLGA_LUCZAK = RegisteredContributorPerson(
  person: Person(
    name: 'Olga Łuczak',
      druzyna: '1. DH „Huragan”',
      srodowisko: Srodowisko.custom(huf_zhp_sieradz, orgSlug: 'zhp'),
  ),
  emails: ['oluczak390@gmail.com'],
);
const RegisteredContributorPerson OLIWIA_MAJDA = RegisteredContributorPerson(
  person: Person(
    name: 'Oliwia Majda',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
      druzyna: '47. Bolszewska Gromada Zuchowa „Odważne Pingwiny”',
      srodowisko: Srodowisko.custom(huf_zhp_wejherowo, orgSlug: 'zhp'),
  ),
  emails: ['oliwia.majda@zhp.net.pl'],
);
const RegisteredContributorPerson OLIWIA_STANCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Oliwia Stańczyk',
      rankInstr: RankInstr.pwd,
      druzyna: '355. WDHiGZ „Utrøst”',
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['oliwia.stanczyk@zhp.net.pl'],
);
const RegisteredContributorPerson OLIWIER_STARCZEWSKI = RegisteredContributorPerson(
  person: Person(
    name: '- Oliwier Starczewski',
      druzyna: '16 GDH „Cichociemni” im. Adama „Pługa” Borysa',
      srodowisko: Srodowisko.custom(huf_zhp_gdansk_srodmiesie, orgSlug: 'zhp'),
  ),
  emails: ['staryoliwierszoli@gmail.com'],
);
const RegisteredContributorPerson OSKAR_PARDYAK = RegisteredContributorPerson(
  person: Person(
    name: 'Oskar Pardyak', rankInstr: RankInstr.pwd, rankHarc: RankHarc.zhpHOc, srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson OSKAR_POLONSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Oskar Połoński',
      druzyna: '53. WDSH "Vesper"',
      srodowisko: Srodowisko.hufiec('warszawa_mokotow', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ["oskarpolonski@gmail.com"],
);
const RegisteredContributorPerson OSKAR_SAKOWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Oskar Sakowicz',
      druzyna: '50WDH-y „Sztorm” im. gen. Mariusza Zaruskiego',
      srodowisko: Srodowisko.org('sh'),
  ),
  emails: ['oskarsakowicz05@gmail.com'],
);
const RegisteredContributorPerson PATRYCJA_BINKIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Patrycja Binkiewicz',
      druzyna: '5. SDH „Trawersi”',
      srodowisko: Srodowisko.custom(huf_zhp_sokolka, orgSlug: 'zhp'),
  ),
  emails: ["patrycja.binkiewicz@zhp.net.pl", "patrycjabinkiewicz2@gmail.com"],
);
const RegisteredContributorPerson PATRYCJA_DUDZINSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Patrycja Dudzinska',
      druzyna: '88. Drużyna Wędrownicza „Wierchy”',
      rankHarc: RankHarc.zhpSamarytanka,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['dudzinska.patrycjaa@gmail.com'],
);
const RegisteredContributorPerson PATRYCJA_KALINOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Patrycja Kalinowska',
      rankHarc: RankHarc.zhpPionierka,
      srodowisko: Srodowisko.custom(huf_zhp_zory, orgSlug: 'zhp'),
  ),
  emails: ['patrycja.kalinowska@zhp.pl'],
);
const RegisteredContributorPerson PATRYCJA_PIETRAS = RegisteredContributorPerson(
  person: Person(
    name: 'Patrycja Pietras',
      druzyna: '6. ZDH „Eleusis”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_bedzinskiej, orgSlug: 'zhp'),
  ),
  emails: ['patusiapietras2101@gmail.com'],
);
const RegisteredContributorPerson PATRYCJA_POLOWCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Patrycja Polowczyk',
      druzyna: '25 DH Przygoda',
      srodowisko: Srodowisko.custom(huf_zhp_karkonoski, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ["patrycjapolo09@gmail.com"],
);
const RegisteredContributorPerson PATRYCJA_SPYRKA = RegisteredContributorPerson(
  person: Person(
    name: 'Patrycja Spyrka',
      druzyna: '8. PgDSH „Pandora”',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
  ),
  emails: ['patrycjaspyrka13@gmail.com'],
);
const RegisteredContributorPerson PATRYCJA_SZCZESNA = RegisteredContributorPerson(
  person: Person(
    name: 'Patrycja Szczęsna', rankInstr: RankInstr.pwd, rankHarc: RankHarc.zhpHOd, srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
  ),
  emails: const [],
);
const RegisteredContributorPerson PATRYCJA_TARCZYNSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Patrycja Tarczyńska',
      druzyna: '92. DH AQUA „Zgórze”',
      srodowisko: Srodowisko.hufiec('garwolin', showChoragiew: false, showOkreg: false),
  ),
  emails: ["pa.tarczyn@op.pl"],
);
const RegisteredContributorPerson PATRYK_CZUPIK = RegisteredContributorPerson(
  person: Person(
    name: 'Patryk Czupik',
      druzyna: '92. PDH „Orzeł” im. III Kompanii „AGAT”',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_wilda, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ["patryk.czupik@zhp.net.pl"],
);
const RegisteredContributorPerson PATRYK_GRABOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Patryk Grabowski',
      druzyna: '174. WDH-y „Wilki”',
      srodowisko: Srodowisko.hufiec('warszawa_ochota', showChoragiew: false, showOkreg: false),
  ),
  emails: ['patryk.grabowski@zhp.net.pl'],
);
const RegisteredContributorPerson PATRYK_OLECH = RegisteredContributorPerson(
  person: Person(
    name: 'Patryk Olech',
      druzyna: '1. JDH „Pościg” im. Jana III Sobieskiego',
      srodowisko: Srodowisko.custom('Południowo-Wschodni Hufiec Harcerzy "Grody" im. gen. bryg. Antoniego Chruściela ps. "Monter"', orgSlug: 'zhr'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhrHOc,
  ),
  emails: ["patryk.olech@zhr.pl"],
);
const RegisteredContributorPerson PAULINA_BURDZIK = RegisteredContributorPerson(
  person: Person(
    name: 'Paulina Burdzik', rankInstr: RankInstr.pwd, srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false), comment: 'J. niemiecki',
  ),
  emails: const [],
);
const RegisteredContributorPerson PAULINA_FERENC = RegisteredContributorPerson(
  person: Person(
    name: 'Paulina Ferenc',
      druzyna: '14. DSH „Fenris”',
      srodowisko: Srodowisko.custom(huf_zhp_lagiewniki, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ["ur.fav.paulinka@gmail.com", "paulaferenc45@gmail.com"],
);
const RegisteredContributorPerson PAULINA_JASKULOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Paulina Jaskułowska',
      druzyna: 'Chorągiew Stołeczna',
      rankInstr: RankInstr.phm,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['paulina.prokop@zhp.net.pl'],
);
const RegisteredContributorPerson PAULINA_LUBOS = RegisteredContributorPerson(
  person: Person(
    name: 'Paulina Lubos',
    druzyna: '4. Niezależna Drużyna Harcerek „Casus”',
    srodowisko: Srodowisko.org('sh'),
  ),
  emails: ['4ndhcasus@gmail.com'],
);
const RegisteredContributorPerson PAULA_PALA = RegisteredContributorPerson(
  person: Person(
    name: 'Paula Pala',
      srodowisko: Srodowisko.hufiec('ziemi_wadowickiej', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.dhd,
  ),
  emails: ['paulinapala2000@gmail.com'],
);
const RegisteredContributorPerson PAULINA_PODGORSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Paulina Podgórska',
      druzyna: '254. DW „Paloma”',
      srodowisko: Srodowisko.custom('Krapkowice', orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ["paulina.podgorska@zhp.pl"],
);
const RegisteredContributorPerson PAWEL_KIMEL = RegisteredContributorPerson(
  person: Person(
    name: 'Paweł Kimel',
  ),
  emails: ['pawel.kimel@gmail.com'],
);
const RegisteredContributorPerson PAWEL_MARUD = RegisteredContributorPerson(
  person: Person(
    name: 'Piotr Marud',
  ),
  emails: const [],
);
const RegisteredContributorPerson PAWEL_SZCZYGIEL = RegisteredContributorPerson(
  person: Person(
    name: 'Paweł Szczygieł',
      druzyna: '15. Radomska Drużyna Harcerska „Paszczaki"',
      srodowisko: Srodowisko.custom(huf_zhp_radom_miasto, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["pawel.szczygiel@zhp.net.pl"],
);
const RegisteredContributorPerson PIOTR_BUKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Piotr Bukowski',
      druzyna: '2. DH „Sokoły”',
      srodowisko: Srodowisko.custom(huf_zhp_milicz, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpOdkrywca,
  ),
  emails: ["piotr.bukowski@zhp.pl"],
);
const RegisteredContributorPerson PIOTR_CHELMINIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Piotr Chełminiak',
      druzyna: 'PWDH „Gloria Mare”',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_jezyce, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpMlodzik,
  ),
  emails: ["wrutek2000@gmail.com"],
);
const RegisteredContributorPerson PIOTR_GASIOR = RegisteredContributorPerson(
  person: Person(
    name: 'Piotr Gąsior',
      druzyna: '44. Drużyna Harcerska „Stella”',
      srodowisko: Srodowisko.custom(huf_zhp_myslowice, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["patusiapietras2101@gmail.com", "piotr.gasior@zhp.net.pl"],
);
const RegisteredContributorPerson PIOTR_KRAKOWIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Piotr Krakowiak',
      druzyna: '25. KDW',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["epik2006@wp.pl"],
);
const RegisteredContributorPerson PIOTR_KUBOWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Piotr Kubowicz',
      druzyna: '2. NDWP „Płomienie”',
      srodowisko: Srodowisko.hufiec('nowy_sacz', showChoragiew: false, showOkreg: false),
  ),
  emails: ['piotr.kubowicz@supersnow.com', 'ocwypyziuleh@gmail.com'],
);
const RegisteredContributorPerson PIOTR_KWAPIEN = RegisteredContributorPerson(
  person: Person(
    name: 'Piotr Kwapień',
      druzyna: '35. TDH "Ignis" im. Józefy Kantor',
      srodowisko: Srodowisko.custom(huf_zhp_torun, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ['piotr.kwapien@zhp.net.pl'],
);
const RegisteredContributorPerson PIOTR_MACIEJ_KABATA = RegisteredContributorPerson(
  person: Person(
    name: 'Piotr Maciej Kabata',
  ),
  emails: const [],
);
const RegisteredContributorPerson PIOTR_SOSNOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Piotr Sosnowski',
    rankInstr: RankInstr.pwd,
    druzyna: 'II. SzDHiZ, 74. Poznańska Drużyna Wędrownicza „Lewe Skrzydło” im. Dywizjonu 303',
    srodowisko: Srodowisko.custom(huf_zhp_poznan_wilda, orgSlug: 'zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson PIOTR_TUROWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Piotr Turowski',
      rankInstr: RankInstr.pwd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['piotr.turowski@zhp.net.pl'],
);
const RegisteredContributorPerson PIOTR_URBANIEC = RegisteredContributorPerson(
  person: Person(
    name: 'Piotr Urbaniec',
    rankHarc: RankHarc.zhpWywiadowca,
    srodowisko: Srodowisko.custom(huf_zhp_ziemi_rybnickiej, orgSlug: 'zhp'),
  ),
  emails: ['piotr23042006@gmail.com'],
);
const RegisteredContributorPerson PIOTR_ZIEMBIKIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Piotr Ziembikiewicz', rankInstr: RankInstr.phm,
  ),
  emails: const [],
);
const RegisteredContributorPerson POLA_MARCINKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Pola Marcinkowska',
      druzyna: '2. DH „Mimo wszystko”',
      srodowisko: Srodowisko.custom(huf_zhp_krosno, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
  ),
  emails: ['polamarcinkowska2005@gmail.com'],
);
const RegisteredContributorPerson PRZEMYSLAW_KLUCZKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Przemysław Kluczkowski',
  ),
  emails: const [],
);
const RegisteredContributorPerson PRZEMYSLAW_KOWALIK = RegisteredContributorPerson(
  person: Person(
    name: 'Przemysław Kowalik',
      druzyna: '300. PgLDH „Wichura"',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["przemek.kowalik.pl@gmail.com"],
);
const RegisteredContributorPerson PRZEMYSLAW_MROCZKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Przemysław Mroczkowski',
      druzyna: '16. Drużyna Harcerska im. marsz. J. Piłsudskiego „Niepokonani”',
      srodowisko: Srodowisko.custom(huf_zhp_bytom, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ['przemyslawom@gmail.com'],
);
const RegisteredContributorPerson RADOSLAW_JASZCZAK = RegisteredContributorPerson(
  person: Person(
    name: 'Radosław Jaszczak',
      druzyna: '77. PDW CHIMERA',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_jezyce, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
  ),
  emails: ["radoslaw.jaszczak@zhp.net.pl"],
);
const RegisteredContributorPerson RADOSLAW_RELIDZYNSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Radosław Relidzyński',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
      druzyna: 'Warszawska Drużyna Wędrownicza „Halny”',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
  ),
  emails: const [],
);
const RegisteredContributorPerson RAFAL_ANTONICKI = RegisteredContributorPerson(
  person: Person(
    name: 'Rafał Antonicki',
      druzyna: '27. HDW',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_mikolowskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["rafalantonicki@gmail.com"],
);
const RegisteredContributorPerson RAFAL_BARAN = RegisteredContributorPerson(
  person: Person(
    name: 'Rafał Baran',
    rankHarc: RankHarc.dhc,
    druzyna: '72. Dąbrowska Drużyna Starszoharcerska „Niebieska Mgła”',
  ),
  emails: const [],
);
const RegisteredContributorPerson RAFAL_KOWALSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Radał Kowalski',
    rankHarc: RankHarc.zhpMlodzik,
    srodowisko: Srodowisko.custom(huf_zhp_rzeszow, orgSlug: 'zhp'),
    druzyna: '14. DH im. K.K. Baczyńskiego',
  ),
  emails: const [],
);
const RegisteredContributorPerson RAFAL_LALIK = RegisteredContributorPerson(
  person: Person(
    name: 'Rafał Lalik', rankHarc: RankHarc.zhpHOc,
    druzyna: '30. Podgórska Drużyna Harcerska „Zielone Stopy”',
    srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
  ),
  emails: const [],
);
const RegisteredContributorPerson RAFAL_RECZKIN = RegisteredContributorPerson(
  person: Person(
    name: 'Rafał Reczkin',
      druzyna: '3. DW „Chmara”',
      srodowisko: Srodowisko.custom('Ziemi Tarnogórskiej'),
      rankInstr: RankInstr.phm,
  ),
  emails: ['rafal.reczkin@zhp.net.pl'],
);
const RegisteredContributorPerson ROBERT_LISZEWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Robert Liszewski',
      druzyna: "25. Środowiskowa Drużyna Harcerska „Echo” im. Tony'ego Halika",
      srodowisko: Srodowisko.custom(huf_zhp_sochaczew, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ['liszewskir25@gmail.com', 'robert.liszewski@zhp.net.pl'],
);
const RegisteredContributorPerson ROBERT_LOPATKA = RegisteredContributorPerson(
  person: Person(
    name: 'Robert Łopatka',
      druzyna: '37. Drużyna Wędrownicza "Nocne Licha"',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_zywieckiej, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHRc,
  ),
  emails: ["robert.lopatka@zhp.pl"],
);
const RegisteredContributorPerson ROBERT_MAZUR = RegisteredContributorPerson(
  person: Person(
    name: 'Robert Mazur',
      rankHarc: RankHarc.zhpOdkrywca,
  ),
  emails: const [],
);
const RegisteredContributorPerson ROBERT_ROBOTYCKI = RegisteredContributorPerson(
  person: Person(
    name: 'Robert Rybotycki',
    rankHarc: RankHarc.zhpOdkrywca,
    srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson RYSZARD_LASECKI = RegisteredContributorPerson(
  person: Person(
    name: 'Ryszard Łasecki',
      druzyna: '102. WDH',
      srodowisko: Srodowisko.custom(huf_zhp_wagrowiec, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ['lasecki.rysiu@gmail.com'],
);
const RegisteredContributorPerson SANDRA_RZESZUREK = RegisteredContributorPerson(
  person: Person(
    name: 'Sandra Rzeszutek',
  ),
  emails: ['sandrarzeszutek@wp.pl'],
);
const RegisteredContributorPerson SARA_WALCZYNSKA_GORA = RegisteredContributorPerson(
  person: Person(
    name: 'Sara Walczyńska-Góra',
      rankHarc: RankHarc.zhpPionierka,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson SEBASTIAN_BINKOWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Sebastian Bińkowicz',
  ),
  emails: ['sebastian.binkowicz@zhp.net.pl'],
);
const RegisteredContributorPerson SEBASTIAN_KOPROWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Stanisław Koprowski',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
      druzyna: '37. Harcerska Drużyna Męska im. Franciszka Drake’a',
      srodowisko: Srodowisko.custom(huf_zhp_brodnica),
  ),
  emails: ['sebastian.koprowski@zhp.net.pl'],
);
const RegisteredContributorPerson SEBASTIAN_SOBOLEWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Sebastian Sobolewski',
  ),
  emails: ['sebastian.sobolewski05@gmail.com'],
);
const RegisteredContributorPerson SEBASTIAN_SUGALSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Sebastian Sugalski',
    rankHarc: RankHarc.zhpHOc,
    rankInstr: RankInstr.pwd,
    druzyna: 'Zielony Szczep 10-ych Koszalińskich Drużyn Harcerskich i Gromad Zuchowych',
    srodowisko: Srodowisko.custom(huf_zhp_ziemi_koszalinskiej),
  ),
  emails: ['sugalski29@gmail.com'],
);
const RegisteredContributorPerson SEWERYN_WOLINSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Seweryn Woliński',
      rankHarc: RankHarc.zhpOdkrywca,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson SLAWOMIR_MILEWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Sławomir Milewski',
      rankHarc: RankHarc.zhpHRc,
      rankInstr: RankInstr.phm,
      druzyna: '70. Luzińska Wodna Drużyna Harcerska „Tramontana” im. Tajnej Organizacji Wojskowej „Gryf Pomorski”',
  ),
  emails: const [],
);
const RegisteredContributorPerson SOFIJA_GALICKA = RegisteredContributorPerson(
  person: Person(
    name: 'Sofija Galicka',
      druzyna: '8. PgDSH „Pandora”',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.dhd,
  ),
  emails: ['galicka.sofija16@gmail.com'],
);
const RegisteredContributorPerson STANISLAW_WATOR = RegisteredContributorPerson(
  person: Person(
    name: 'Stanisław Wątor',
      druzyna: '19. WDH "Przygoda" im. Ludwika Narbutta',
      srodowisko: Srodowisko.hufiec('warszawa_wola', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ["stanislaw.wator@zhp.pl"],
);
const RegisteredContributorPerson STANISLAW_MARCHEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Stanisław Marchewicz',
      druzyna: 'Baszta',
      rankInstr: RankInstr.phm,
      rankHarc: RankHarc.dhc,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['stas.marchewicz@gmail.com'],
);
const RegisteredContributorPerson STANISLAW_WOJCIECHOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Stanisław Wojciechowski',
      druzyna: '58. DW "Szuwary"',
      srodowisko: Srodowisko.custom(huf_zhp_ostrow_wielkopolski, orgSlug: 'zhp'),
  ),
  emails: ["stasiu2w2@gmail.com"],
);
const RegisteredContributorPerson STANISLAW_WRONSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Stanisław Wroński',
  ),
  emails: const [],
);
const RegisteredContributorPerson STEFAN_KRYCZKA = RegisteredContributorPerson(
  person: Person(
    name: 'Stefan Kryczka',
      rankHarc: RankHarc.zhpCwik,
      druzyna: '295. Warszawska Drużyna „Wataha”',
  ),
  emails: const [],
);
const RegisteredContributorPerson SZYMON_BARCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Barczyk',
      druzyna: '60. WDH „Amber”',
      srodowisko: Srodowisko.hufiec('warszawa_ursus_wlochy', showChoragiew: false, showOkreg: false),
  ),
  emails: ['szbarsz5@gmail.com', 'szymon.barczyk@zhp.net.pl'],
);
const RegisteredContributorPerson SZYMON_CHORAZY = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon „Durszlak” Chorąży',
      druzyna: '72. WDHS „Uroczysko”',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
  ),
  emails: const [],
);
const RegisteredContributorPerson SZYMON_DRATWINSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Dratwiński',
      rankHarc: RankHarc.zhpCwik,
      druzyna: '16. Krakowska Drużyna Harcerska',
      srodowisko: Srodowisko.hufiec('krakow_srodmiescie', showChoragiew: false, showOkreg: false),
  ),
  emails: ['szymon.dratwinski@gmail.com'],
);
const RegisteredContributorPerson SZYMON_DROPEK = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Dropek',
      druzyna:'7. Kwidzyńska Drużyna Harcerska',
      srodowisko: Srodowisko.custom(huf_zhp_kwidzyn, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
  ),
  emails: ['szymon111drop@gmail.com', 'szymon.dropek@zhp.net.pl'],
);
const RegisteredContributorPerson SZYMON_HARAZIM = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Harazim',
      druzyna: '5. Drużyna Harcerska „Zorza”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_tarnogorskiej, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
  ),
  emails: ["szymon.harazim@zhp.net.pl"],
);
const RegisteredContributorPerson SZYMON_JACKIEWICZ = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Jackiewicz',
      druzyna: '63. DW „Nagi Tanka”',
      rankHarc: RankHarc.zhpWywiadowca,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['szymbro300@gmail.com'],
);
const RegisteredContributorPerson SZYMON_JAWOREK = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Jaworek',
      druzyna: '17. DH „Gryfne Bajtle”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_tarnogorskiej),
  ),
  emails: const [],
);
const RegisteredContributorPerson SZYMON_KLIMUNTOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Klimuntowski',
      druzyna: '7. DH „Iskra”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_dzierzoniowskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["klimuntowskiszymon@gmail.com"],
);
const RegisteredContributorPerson SZYMON_LANDORF = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Landorf',
  ),
  emails: ['szymon.landorf@gmail.com'],
);
const RegisteredContributorPerson SZYMON_MALCZAK = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Małczak',
      druzyna: '128. WDH „Orion”',
      srodowisko: Srodowisko.custom(huf_zhp_zary, orgSlug: 'zhp'),
  ),
  emails: ["tomek02897@gmail.com"],
);
const RegisteredContributorPerson SZYMON_MASLOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Masłowski',
      druzyna: 'Chorągiew Białostocka',
      rankInstr: RankInstr.pwd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['szymon.maslowski@zhp.net.pl'],
);
const RegisteredContributorPerson SZYMON_OPLOCKI_NIEMIEC = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Opłocki-Niemiec',
      srodowisko: Srodowisko.hufiec('warszawa_mokotow', showChoragiew: false, showOkreg: false),
      druzyna: 'Szczep 156. i 414. WDHiZ',
  ),
  emails: ['szymon.oplocki.niemiec@gmail.com'],
);
const RegisteredContributorPerson SZYMON_OZOG = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Ożóg',
      druzyna: '175. RwDW „Orientalis”',
      rankInstr: RankInstr.pwd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["szymon.ozog@zhp.net.pl"],
);
const RegisteredContributorPerson SZYMON_PADOK = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Padok',
      druzyna: '9. WDH „Wataha” im. Józefa Gołębiowskiego',
      srodowisko: Srodowisko.custom(huf_zhp_gorzow_wielkopolski, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["abeber444@gmail.com"],
);
const RegisteredContributorPerson SZYMON_PODGORNY = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Podgórny',
      druzyna:'19. Pyzdrska Drużyna Wędrownicza „Wataha”, 5 Pyzdrski szczep „Orion”',
      srodowisko: Srodowisko.custom(huf_zhp_wrzesnia_wrzos, orgSlug: 'zhp'),
  ),
  emails: ['szymon.podgorny@zhp.net.pl'],
);
const RegisteredContributorPerson SZYMON_REKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Rekowski',
      druzyna: '8. GDH „Brzask”',
      srodowisko: Srodowisko.custom(huf_zhp_gdynia, orgSlug: 'zhp'),
  ),
  emails: ["szym.rekowski@gmail.com"],
);
const RegisteredContributorPerson SZYMON_SITEK = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Sitek',
      druzyna: '29. DSH „Ignis” w Zgórzu',
      srodowisko: Srodowisko.hufiec('garwolin', showChoragiew: false, showOkreg: false),
  ),
  emails: ['szymonsitek09@gmail.com'],
);
const RegisteredContributorPerson SZYMON_ZDZIEBKO = RegisteredContributorPerson(
  person: Person(
    name: 'Szymon Zdziebko',
  ),
  emails: const [],
);
const RegisteredContributorPerson TADEUSZ_BOJANOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Tadeusz Bojanowski',
      rankHarc: RankHarc.dhc,
      druzyna: '417. ŁDH „Arbor”',
  ),
  emails: ['tbojanowskit@gmail.com'],
);
const RegisteredContributorPerson TADEUSZ_BRACHA = RegisteredContributorPerson(
  person: Person(
    name: 'Tadeusz K. Bracha',
      druzyna: '6. DSH „Andromeda”',
      srodowisko: Srodowisko.custom('Hufiec Oświęcim', orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["tadekbracha@gmail.com"],
);
const RegisteredContributorPerson TAMANACO_NORIEGA = RegisteredContributorPerson(
  person: Person(
    name: 'Tamanaco Noriega',
      druzyna: '73. WDH „Custodia”',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pn', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["tamanaconoriegau@gmail.com"],
);
const RegisteredContributorPerson TOMASZ_BUKOWIECKI = RegisteredContributorPerson(
  person: Person(
    name: 'Tomasz Bukowiecki',
      rankHarc: RankHarc.zhpHOc,
      druzyna: '25. Wielopoziomowa Drużyna Harcerska „Brzask” im. Cichociemnych Spadochroniarzy Armii Krajowej',
      srodowisko: Srodowisko.hufiec('legionowo', showChoragiew: false, showOkreg: false),
  ),
  emails: ['tomasz.bukowiecki@zhp.net.pl'],
);
const RegisteredContributorPerson TOMASZ_FLORCZAK = RegisteredContributorPerson(
  person: Person(
    name: 'Tomasz Florczak',
      druzyna: '99. Przemyska Drużyna Starszoharcerska',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_przemyskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhc,
  ),
  emails: ['tflorczak913@gmail.com'],
);
const RegisteredContributorPerson TOMASZ_GORECKI = RegisteredContributorPerson(
  person: Person(
    name: 'Tomek Górecki',
  ),
  emails: ["tomekgorecki26@gmail.com"],
);
const RegisteredContributorPerson TOMASZ_KOTOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Tomasz Kotowski',
      druzyna: '20. DW „Avengers”',
      srodowisko: Srodowisko.hufiec('legionowo', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["tomasz.kotowski@zhp.net.pl"],
);
const RegisteredContributorPerson TOMASZ_LUDWIG = RegisteredContributorPerson(
  person: Person(
    name: 'Tomasz Ludwig',
      druzyna: '8. PgDW „Granat”',
      srodowisko: Srodowisko.hufiec('krakow_podgorze', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["tomasz.ludwig@zhp.pl"],
);
const RegisteredContributorPerson TOMASZ_SMOLKA = RegisteredContributorPerson(
  person: Person(
    name: 'Tomasz Smołka',
    srodowisko: Srodowisko.org('zhr'),
  ),
  emails: const [],
);
const RegisteredContributorPerson TOMASZ_ZAGORSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Tomasz Zagórski',
      rankInstr: RankInstr.phm,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['tomasz.zagorski@zhp.net.pl'],
);
const RegisteredContributorPerson TOMASZ_ZGORSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Tomasz Zgórski',
      druzyna: '27. Wielopoziomowa Drużyna Harcerska „Eskulapy”',
      srodowisko: Srodowisko.custom(huf_zhp_jastrzebie_zdroj, orgSlug: 'zhp'),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ["tomasz.zgorski@zhp.net.pl"],
);
const RegisteredContributorPerson TOSIA_BANASZAK = RegisteredContributorPerson(
  person: Person(
    name: 'Tosia Banaszak',
      druzyna: '14. WDSH „AD ASTRA”',
      rankHarc: RankHarc.zhpTropicielka,
  ),
  emails: ['banaszak.antosia13@gmail.com'],
);
const RegisteredContributorPerson TOSIA_KLEPACKA = RegisteredContributorPerson(
  person: Person(
    name: 'Tosia Klepacka',
      druzyna: '89. WDS „W drogę”',
      srodowisko: Srodowisko.custom(huf_zhp_wroclaw_polnoc, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpTropicielka,
  ),
  emails: ["klepacka.tosia@gmail.com", 'antonina.klepacka@zhp.pl'],
);
const RegisteredContributorPerson TYMON_TALECKI = RegisteredContributorPerson(
  person: Person(
    name: 'Tymon Talecki',
      druzyna: '1. DSH „Orlęta”',
      srodowisko: Srodowisko.hufiec('gorlice', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.dhc,
  ),
  emails: ['vulturebro323@gmail.com'],
);
const RegisteredContributorPerson TYMOTEUSZ_JAWORSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Tymoteusz Jaworski',
      druzyna: '60. KDH „Puszczanie”',
      srodowisko: Srodowisko.custom(huf_zhr_harcerzy_krakow_srodmiescie, orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrWywiadowca,
  ),
  emails: ['tymekjaworski36@gmail.com'],
);
const RegisteredContributorPerson URSZULA_KOWALSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Ula Kowalska',
      druzyna: '47. WDHS „Tajfun”',
      rankHarc: RankHarc.zhpTropicielka,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["kobea9415@gmail.com"],
);
const RegisteredContributorPerson WANDA_MARCHEL = RegisteredContributorPerson(
  person: Person(
    name: 'Wanda Marchel',
      rankHarc: RankHarc.zhpOchotniczka,
      druzyna: '13. DH „Szczęściarze”',
      srodowisko: Srodowisko.custom(huf_zhp_opole, orgSlug: 'zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson WERONIKA_IWANISZYN = RegisteredContributorPerson(
  person: Person(
    name: 'Weronika Iwaniszyn',
      druzyna: '222. WDS „Biedrony"',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_walbrzyskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["wera.iw03@gmail.com"],
);
const RegisteredContributorPerson WERONIKA_KOLCZ = RegisteredContributorPerson(
  person: Person(
    name: 'Weronika Kołcz',
      rankInstr: RankInstr.pwd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ["weronika.kolcz@zhp.pl"],
);
const RegisteredContributorPerson WERONIKA_MATECKA = RegisteredContributorPerson(
  person: Person(
    name: 'Weronika Matecka',
      druzyna: '31. JGZ „Bordowe Wilczęta"',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_jezyce, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["weronika.matecka@zhp.net.pl"],
);
const RegisteredContributorPerson WERONIKA_PUSCIAN = RegisteredContributorPerson(
  person: Person(
    name: 'Weronika Puścian',
      druzyna: '37. Drużyna Harcerska im. Zawiszy Czarnego w „Góralach Mandarynki"',
      srodowisko: Srodowisko.custom(huf_zhp_brodnica, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ["weronika.puscian@zhp.pl"],
);
const RegisteredContributorPerson WERONIKA_WICHER = RegisteredContributorPerson(
  person: Person(
    name: 'Weronika Wicher',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOc,
      druzyna: '1. KDH im. ks. Alojzego Koziełka',
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['weronika.wicher@zhp.net.pl'],
);
const RegisteredContributorPerson WERONIKA_ZAWIERUCHA = RegisteredContributorPerson(
  person: Person(
    name: 'Weronika Zawierucha',
      druzyna: '43. ZDHS „Parasol”',
      srodowisko: Srodowisko.custom(huf_zhp_zgierz, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ['zawieruchaweronika570@gmail.com'],
);
const RegisteredContributorPerson WIKTOR_KARPALA = RegisteredContributorPerson(
  person: Person(
    name: 'Wiktor Karpała',
    rankHarc: RankHarc.zhpHOc,
    rankInstr: RankInstr.pwd,
    druzyna:'74. DH „Desant” im. 1. SBS gen. bryg. Stanisława Sosabowskiego',
    srodowisko: Srodowisko.hufiec('podkrakowski', showChoragiew: false, showOkreg: false),
  ),
  emails: const [],
);
const RegisteredContributorPerson WIKTOR_KOWALCZUK = RegisteredContributorPerson(
  person: Person(
    name: 'Wiktor Kowalczuk',
      druzyna: '2. WDH „Aves”',
      srodowisko: Srodowisko.custom(huf_zhp_olecko),
  ),
  emails: ["vect0428m66@gmail.com"],
);
const RegisteredContributorPerson WIKTORIA_DRGAS = RegisteredContributorPerson(
  person: Person(
    name: 'Wiktoria Drgas',
      druzyna: 'DW Ijupiter',
      srodowisko: Srodowisko.custom(huf_zhp_zary, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ["wiktoria.drgas@zhp.net.pl"],
);
const RegisteredContributorPerson WIKTORIA_LUKASIK = RegisteredContributorPerson(
  person: Person(
    name: 'Wiktoria Łukasik',
      druzyna: '160. WDH „Desertum”',
      srodowisko: Srodowisko.hufiec('warszawa_praga_pd', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ["wiktoria.lukasik@zhp.net.pl", 'w.lukasik.02@wp.pl'],
);
const RegisteredContributorPerson WIKTORIA_PINKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Wiktoria Pinkowska',
      druzyna: '8. Zgierska Wodna Drużyna Harcerzy Starszych „Nieskończoność”',
      srodowisko: Srodowisko.custom(huf_zhp_zgierz),
  ),
  emails: ['wiktoria.pinkowska@zhp.net.pl', 'w.pinkowskaa@gmail.com'],
);
const RegisteredContributorPerson WIKTORIA_POPIS = RegisteredContributorPerson(
  person: Person(
    name: 'Wiktoria Popis',
      druzyna: '40. WDSH-ek B.U.R.Z.A.',
      srodowisko: Srodowisko.hufiec('warszawa_mokotow', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ["wiktoria.popis@zhp.net.pl"],
);
const RegisteredContributorPerson WIKTORIA_PRUSZYNSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Wiktoria Pruszyńska',
  ),
  emails: const [],
);
const RegisteredContributorPerson WIKTORIA_WENCEL = RegisteredContributorPerson(
  person: Person(
    name: 'Wiktoria Wencel',
      druzyna: '4. ODH im. Jadwigi Falkowskiej',
      srodowisko: Srodowisko.custom('Ostrzeszowski hufiec harcerek "Agat" im. szarych szeregów', orgSlug: 'zhr'),
      rankHarc: RankHarc.zhrOchotniczka,
  ),
  emails: ['sigmaboy.oe@gmail.com'],
);
const RegisteredContributorPerson WIKTORIA_WOJCIK = RegisteredContributorPerson(
  person: Person(
    name: 'Wiktoria Wójcik',
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ['wiktoria.wojcik1@zhp.net.pl'],
);
const RegisteredContributorPerson WINCENTY_DIETRYCH = RegisteredContributorPerson(
  person: Person(
    name: 'Wincenty Dietrych',
      rankHarc: RankHarc.dhc,
  ),
  emails: const [],
);
const RegisteredContributorPerson WITOLD_BASIURA = RegisteredContributorPerson(
  person: Person(
    name: 'Witold Basiura',
      druzyna: '1. KDSH „Świt”',
      srodowisko: Srodowisko.hufiec('podkrakowski', showChoragiew: false, showOkreg: false),
  ),
  emails: ['witold.basiura@gmail.com'],
);
const RegisteredContributorPerson WITOLD_BRACHA = RegisteredContributorPerson(
  person: Person(
    name: 'Witold Bracha',
      druzyna: '16. DH „Celestials”',
      srodowisko: Srodowisko.hufiec('oswiecim', showChoragiew: false, showOkreg: false),
  ),
  emails: ['u0021657761@gmail.com'],
);
const RegisteredContributorPerson WITOLD_FIALKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Witold Fiałkowski',
      druzyna: '243. PDHS „Aves”',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_jezyce, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpWywiadowca,
  ),
  emails: ["witekfia@gmail.com"],
);
const RegisteredContributorPerson WITOLD_JAKUBOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Witold Jakubowski',
      druzyna: '50. WDW „BOREALIS”',
      srodowisko: Srodowisko.hufiec('warszawa_ursus_wlochy', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpMlodzik,
  ),
  emails: ['shinypokemin.hunterxdddd@gmail.com'],
);
const RegisteredContributorPerson WOJCIECH_GRUSZCZYNSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Wojciech Gruszczyński',
    rankHarc: RankHarc.zhpCwik,
    druzyna: '35. Poznańska Drużyna Harcerska',
    srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson WOJCIECH_KITA = RegisteredContributorPerson(
  person: Person(
    name: 'Wojciech Kita',
      druzyna: '10 JDSH "Minerki"',
      srodowisko: Srodowisko.hufiec('jordanow', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.zhpCwik,
  ),
  emails: ["wojtix912@gmail.com"],
);
const RegisteredContributorPerson WOJCIECH_KORZENIOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Wojciech Korzeniowski',
      druzyna: '72. WDSH Gawra',
      srodowisko: Srodowisko.custom(huf_zhp_wroclaw_polnoc),
      rankHarc: RankHarc.dhc,
  ),
  emails: ["wojtek2012k@gmail.com"],
);
const RegisteredContributorPerson WOJCIECH_KUCHARSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Wojciech Kucharski',
      druzyna: '73. DSH „Aborygeni”',
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['kucharskiwojtek4@gmail.com'],
);
const RegisteredContributorPerson WOJCIECH_GODECKI = RegisteredContributorPerson(
  person: Person(
    name: 'Wojciech Godecki',
      rankInstr: RankInstr.hm,
      druzyna: '„Złota Ósemka” im. Zawiszy Czarnego',
      srodowisko: Srodowisko.custom(huf_zhp_dabrowa_gornicza),
  ),
  emails: ['wojciech.godecki@zhp.net.pl'],
);
const RegisteredContributorPerson WOJCIECH_JUCYK = RegisteredContributorPerson(
  person: Person(
    name: 'Wojciech Jucyk',
      druzyna: '73 DSH „Los Niños”',
      srodowisko: Srodowisko.custom(huf_zhp_konin, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpOdkrywca,
  ),
  emails: ['wojtek.jucyk.buffon@gmail.com', 'wojciech.jucyk@zhp.net.pl'],
);
const RegisteredContributorPerson WOJCIECH_TURSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Wojciech Turski',
      rankHarc: RankHarc.zhpCwik,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson WOJCIECH_WALACH = RegisteredContributorPerson(
  person: Person(
    name: 'Wojciech Wałach',
    druzyna: '34. DH „Watra” im. Braci Buchalików',
    srodowisko: Srodowisko.custom(huf_zhp_ziemi_rybnickiej, orgSlug: 'zhp'),
  ),
  emails: ['wojtek.w.2008@gmail.com'],
);
const RegisteredContributorPerson WOJCIECH_WOLNIK = RegisteredContributorPerson(
  person: Person(
    name: 'Wojciech Wolnik',
      rankHarc: RankHarc.zhpMlodzik,
      druzyna: '7. Przemeckiej Drużyna Harcerska im. Jana Pawła II',
      srodowisko: Srodowisko.custom(huf_zhp_wolsztyn, orgSlug: 'zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson WOJCIECH_ZIELINSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Wojciech Zielinski',
      rankHarc: RankHarc.dhc,
  ),
  emails: const [],
);
const RegisteredContributorPerson ZBYSZEK_CHODAKOWSKI = RegisteredContributorPerson(
  person: Person(
    name: 'Zbyszek Chodakowski',
      rankHarc: RankHarc.zhpCwik,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: const [],
);
const RegisteredContributorPerson ZOFIA_FABROWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Zofia Fabrowska',
      rankHarc: RankHarc.zhpHOd,
      rankInstr: RankInstr.pwd,
      srodowisko: Srodowisko.org('zhp'),
  ),
  emails: ['zofia.fabrowska@zhp.net.pl'],
);
const RegisteredContributorPerson ZOFIA_KOSIDER = RegisteredContributorPerson(
  person: Person(
    name: 'Zosia Kosider',
      druzyna: '1. DH „Wilcza Sfora”',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_wodzislawskiej, orgSlug: 'zhp'),
  ),
  emails: ['zosiakosider@gmail.com'],
);
const RegisteredContributorPerson ZOFIA_SZAFRANEK = RegisteredContributorPerson(
  person: Person(
    name: 'Zofia Szafranek',
      rankHarc: RankHarc.zhpPionierka,
      druzyna: '39. Wielopoziomowa Drużyna Harcerska „Leśne Stwory” w Radlinie',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_wodzislawskiej, orgSlug: 'zhp'),
  ),
  emails: ['zofia.szafranek2008@gmail.com'],
);
const RegisteredContributorPerson ZOFIA_ZAWADZKA = RegisteredContributorPerson(
  person: Person(
    name: 'Zofia Zawadzka',
      rankHarc: RankHarc.zhpTropicielka,
      srodowisko: Srodowisko.hufiec('warszawa_zoliborz', showChoragiew: false, showOkreg: false),
      druzyna: '128. WDH',
  ),
  emails: const [],
);
const RegisteredContributorPerson ZOFIA_ZBRUK = RegisteredContributorPerson(
  person: Person(
    name: 'Zofia Zbruk',
      druzyna: '5. PDHS „Wagabunda” im. Kazimierza Nowaka',
      srodowisko: Srodowisko.custom(huf_zhp_poznan_grunwald, orgSlug: 'zhp'),
  ),
  emails: ['anonusiauvu@gmail.com'],
);
const RegisteredContributorPerson ZUZANNA_ANDRZEJCZAK = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Andrzejczak',
      druzyna: '15. ZWDH „Atlantyda”',
      srodowisko: Srodowisko.custom(huf_zhp_zgierz),
  ),
  emails: ['zuzannaandrzejczak12@gmail.com'],
);
const RegisteredContributorPerson ZUZANNA_BIALA = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Biała',
  ),
  emails: ['zuzubiala08@gmail.com'],
);
const RegisteredContributorPerson ZUZANNA_CHMIEL = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Chmiel',
      druzyna: '48. Lubelska Drużyna Harcerska ,Araukanie"',
      srodowisko: Srodowisko.custom(huf_zhp_lublin, orgSlug: 'zhp'),
  ),
  emails: ['chmiel.zuzanna@zhp.pl'],
);

const RegisteredContributorPerson ZUZANNA_DUDEK = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Dudek',
      druzyna: '8. Drużyna Harcerska „Tajne Śledzie”',
      srodowisko: Srodowisko.hufiec('olkusz', showChoragiew: false, showOkreg: false),
      rankHarc: RankHarc.dhd,
  ),
  emails: ['z.dudek2011@gmail.com', 'zizigames2011@gmail.com'],
);

const RegisteredContributorPerson ZUZANNA_DZIEDZIC = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzia Dziedzic',
      druzyna: '128 WDH Orion',
      srodowisko: Srodowisko.custom(huf_zhp_zary, orgSlug: 'zhp'),
  ),
  emails: ['z_dziedzic@icloud.com', '5363@e-at.edu.pl'],
);

const RegisteredContributorPerson ZUZANNA_EJSMONT = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Ejsmont',
      druzyna: '2. WDH „Aves”',
      srodowisko: Srodowisko.custom(huf_zhp_olecko),
  ),
  emails: ["vect0428m66@gmail.com"],
);

const RegisteredContributorPerson ZUZANNA_GRZESIAK = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Grzesiak',
      srodowisko: Srodowisko.custom(huf_zhp_kepno, orgSlug: 'zhp'),
  ),
  emails: ["gzuzia415@gmail.com"],
);

const RegisteredContributorPerson ZUZANNA_GUGALA = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Gugała',
      druzyna: '51 BDW „Silva”',
      srodowisko: Srodowisko.custom(huf_zhp_bialystok, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["zuzanna.gugala@zhp.pl"],
);

const RegisteredContributorPerson ZUZANNA_JANKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Jankowska',
      druzyna: '12. GWDH „Północ”',
      srodowisko: Srodowisko.custom(huf_zhp_paluki, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpPionierka,
  ),
  emails: ["niebieskizozolek@gmail.com"],
);

const RegisteredContributorPerson ZUZANNA_JAWORSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Jaworska',
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
      srodowisko: Srodowisko.custom(huf_zhp_wroclaw, orgSlug: 'zhp'),
  ),
  emails: const [],
);

const RegisteredContributorPerson ZUZANNA_KOLIS = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Kolis',
    rankHarc: RankHarc.zhpOchotniczka,
    druzyna: '„Wilki”',
    srodowisko: Srodowisko.custom(huf_zhp_glowno, orgSlug: 'zhp'),
  ),
  emails: ['koliszuzia@gmail.com'],
);

const RegisteredContributorPerson ZUZANNA_KOWALCZYK = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Kowalczyk',
      rankHarc: RankHarc.zhpOchotniczka,
      srodowisko: Srodowisko.custom(huf_zhp_stargard, orgSlug: 'zhp'),
      druzyna: '1. Choszczeńska Drużyna Starszoharcerska „Regulus” im. Janusza Korczaka',
  ),
  emails: const [],
);

const RegisteredContributorPerson ZUZANNA_MIERZEJEWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Mierzejewska',
      rankHarc: RankHarc.zhpOchotniczka,
      druzyna: '13. Lubańska Drużyna Starszoharcerska „Brzask”',
      srodowisko: Srodowisko.custom(huf_zhp_luban, orgSlug: 'zhp'),
  ),
  emails: const [],
);

const RegisteredContributorPerson ZUZANNA_NAWROT = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Nawrot',
      druzyna: '9. BGZ „Pszczółki”',
      srodowisko: Srodowisko.custom(huf_zhp_reduta, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpSamarytanka,
  ),
  emails: ['zuzannanawrot5c@gmail.com'],
);

const RegisteredContributorPerson ZUZANNA_NIEWEGLOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Niewęgłowska',
      druzyna: '307. WDH-EK „Zorza”',
      srodowisko: Srodowisko.hufiec('warszawa_mokotow', showChoragiew: false, showOkreg: false),
      rankInstr: RankInstr.pwd,
      rankHarc: RankHarc.zhpHOd,
  ),
  emails: ["zuzanna.nieweglowska@zhp.net.pl", 'z.nieweglowska01@gmail.com'],
);

const RegisteredContributorPerson ZUZANNA_PIWKO = RegisteredContributorPerson(
  person: Person(
    name: 'Zuza Piwko',
      rankHarc: RankHarc.zhpHOc,
      rankInstr: RankInstr.pwd,
      druzyna: '46. Wrocławska Drużyna Harcerska „Arda”',
      srodowisko: Srodowisko.custom(huf_zhp_wroclaw_wschod, orgSlug: 'zhp'),
  ),
  emails: ['zuzanna.piwko@zhp.net.pl'],
);

const RegisteredContributorPerson ZUZANNA_RELKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Rełkowska',
      druzyna: '5. DH Niebo w Kleszczowie',
      srodowisko: Srodowisko.custom(huf_zhp_reduta, orgSlug: 'zhp'),
      rankHarc: RankHarc.dhd,
  ),
  emails: ["zuzanna.relkowska@wp.pl"],
);

const RegisteredContributorPerson ZUZANNA_ROMANISZYN = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Romaniszyn',
      druzyna: '321 Teraz',
      srodowisko: Srodowisko.hufiec('krakow_nowa_huta', showChoragiew: false, showOkreg: false),
  ),
  emails: ['zuziarysia19@outlook.com', 'zuziarysia19@gmail.com'],
);

const RegisteredContributorPerson ZUZANNA_RADKOWSKA = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Radkowska',
      druzyna: '21. ZDH',
      srodowisko: Srodowisko.custom(huf_zhp_ziemi_zawiercianskiej, orgSlug: 'zhp'),
      rankHarc: RankHarc.zhpTropicielka,
  ),
  emails: ['zuzanna.radkowska21.12@gmail.com'],
);

const RegisteredContributorPerson ZUZANNA_WARCHOL = RegisteredContributorPerson(
  person: Person(
    name: 'Zuzanna Warchoł',
      druzyna: '113. TWDH „Pustynna Burza”',
      srodowisko: Srodowisko.custom(huf_zhp_szczecin_pogodno, orgSlug: 'zhp'),
  ),
  emails: const [],
);
