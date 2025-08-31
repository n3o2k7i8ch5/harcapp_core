import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';

import 'hufce.dart';
import 'org.dart';

List<Person> allPeople = [];

Person _register(Person person) {
  allPeople.add(person);
  return person;
}

Map<String, Person> __getAllPeopleByEmailMap(){
  Map<String, Person> result = {};

  for(Person person in allPeople)
    for(String email in person.email)
      result[email] = person;

  return result;
}

Map<String, Person> allPeopleByEmailMap = __getAllPeopleByEmailMap();

Person ABRAHAM_PRAGER = _register(const Person(
  name: 'Abraham Prager',
  druzyna: '1. Czarnkowska Drużyna Wielopoziomowa „Puszcza” im. Jana Kilińskiego',
  email: ['abraham.p@wp.pl']
));
Person ADAM_DAWID = _register(const Person(
    name: 'Adam Dawid',
    druzyna: '33. CDH „Czarne stopy”',
    hufiec: huf_zhp_ziemi_cieszynskiej,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['treaxy09@gmail.com']
));
Person ADAM_DUDAK = _register(const Person(
    name: 'Adam Dudak',
    hufiec: huf_zhp_warszawa_ursynow,
    druzyna: '234. Warszawska Drużyna Harcerska „Forteca”'
));
Person ADAM_SKLODOWSKI = _register(const Person(
    name: 'Adam Skłodowski',
    druzyna: '58. MDH „Cichociemni”',
    hufiec: 'Eldorado',
    rankHarc: RankHarc.zhrWywiadowca,
    org: Org.zhr,
    email: []
));
Person ADAM_WIECZOREK = _register(const Person(
    name: 'Adam Wieczorek',
    druzyna: '160. WDSH „Silva”',
    hufiec: huf_zhp_warszawa_praga_pd,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["aadam.wieczorek@gmail.com"]
));
Person AGATA_KOPYTKO = _register(const Person(
    name: 'Agata',
    druzyna: '22. LDH „Potok”',
    hufiec: 'Lubelski Hufiec Harcerek „Rzeka”',
    rankHarc: RankHarc.zhrOchotniczka,
    org: Org.zhr,
    email: ['aga.kopyto28@gmail.com']
));
Person AGATA_MAJEWSKA = _register(const Person(
    name: 'Agata Majewska',
    hufiec: huf_zhp_lodz_widzew,
    org: Org.zhp,
    email: ['agattam2004@gmail.com']
));
Person AGNIESZKA_DURSKA = _register(const Person(name: 'Agnieszka Durska', rankInstr: RankInstr.phm, hufiec: huf_zhp_lodz_baluty));
Person AGNIESZKA_PIEKARSKA = _register(const Person(
    name: 'Agnieszka Piekarska',
    druzyna: '3. Drużyna Wędrownicza „3DSH”',
    hufiec: huf_zhp_szczecinsko_wloszczowski,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ['superbulinka@icloud.com', 'agapiekarskaa@gmail.com']
));
Person AGNIESZKA_RADECKA_KUBICKA = _register(const Person(
    name: 'Agnieszka Radecka-Kubicka',
    druzyna: '5. Gromada Zuchów',
    hufiec: huf_zhp_ziemi_sanockiej,
    org: Org.zhp,
    email: ['irja@interia.pl']
));
Person AGNIESZKA_TYLKO = _register(const Person(name: 'Agnieszka Tylko', rankHarc: RankHarc.zhpPionierka,
  hufiec: huf_zhp_myslenice,
  druzyna: '3,14. Myślenicka Drużyna Starszoharcerska „Awangarda”',
  org: Org.zhp,
));
Person ALAN_FILAS = _register(const Person(
    name: 'Alan Filas',
    rankInstr: RankInstr.phm,
    druzyna: '2. Szczep „Malta”',
    hufiec: huf_zhp_poznan_nowe_miasto,
    email: ['alan.filas@zhp.net.pl']
));
Person ALEKSANDER_CHRZEST = _register(const Person(
    name: 'Olek Chrzęst',
    druzyna: '1. PGZ',
    hufiec: 'Szaniec',
    rankHarc: RankHarc.zhrCwik,
    org: Org.zhr,
    email: ["olgierd.chrzes@zhr.pl"]
));
Person ALEKSANDER_PALKA = _register(const Person(
    name: 'Aleksander Palka',
    druzyna: '10. HDŻ',
    hufiec: 'Katowice',
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['tomaszml9236@gmail.com']
));
Person ALEKSANDER_WELYCZKO = _register(const Person(
    name: 'Aleksander Wełyczko',
    druzyna: '5. DH „Czarne Wilki”',
    hufiec: 'OłWa',
    rankHarc: RankHarc.zhpOdkrywca,
    org: Org.zhp,
    email: ["rxus759@gmail.com"]
));
Person ALEKSANDRA_ANTKIEWICZ = _register(const Person(
    name: 'Ola Antkiewicz',
    druzyna: '35. Chynowska Drużyna Wielopoziomowa „Vis Verum”',
    hufiec: huf_zhp_grojec,
    org: Org.zhp,
    email: ['drzewonadrzewie@gmail.com']
));
Person ALEKSANDRA_CHRUSTEK = _register(const Person(
    name: 'Aleksandra Chrustek',
    rankHarc: RankHarc.zhpHOd,
    rankInstr: RankInstr.pwd,
    hufiec: huf_zhp_warszawa_mokotow,
    org: Org.zhp,
    email: ['olachrustek@gmail.com']
));
Person ALEKSANDRA_GALIJ = _register(const Person(
    name: 'Ola Galij',
    druzyna: 'Studencki Krąg instruktorski im. Tonyego Halika',
    hufiec: huf_zhp_bydgoszcz_miasto,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ["aleksandra.galij@zhp.net.pl", 'aleksandra.galij@gmail.com']
));
Person ALEKSANDRA_KOSTRZEWA = _register(const Person(name: 'Ola Kostrzewa', org: Org.zhp));
Person ALEKSANDRA_KOWALSKA = _register(const Person(
  name: 'Aleksandra Kowalska',
  druzyna: '17. ZODH',
  hufiec: huf_zhp_zgierz,
  email: ['kowalskaola057@gmail.com'],
  org: Org.zhp,
));
Person ALEKSANDRA_KOZUBAL = _register(const Person(name: 'Aleksandra Kozubal', rankHarc: RankHarc.zhpSamarytanka, org: Org.zhp));
Person ALEKSANDRA_KWAPISZ = _register(const Person(
    name: 'Aleksandra Kwapisz',
    druzyna: '08. ŚTDH „Burza” im. Tadeusza „Zośki” Zawadzkiego',
    hufiec: huf_zhp_ostrowiec_swietokrzyski,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ['aleksandra.kwapisz@zhp.net.pl']
));
Person ALEKSANDRA_MISIAK = _register(const Person(
    name: 'Aleksandra Misiak',
    druzyna: 'ŁGZ „Pracowite Pszczółki”',
    hufiec: huf_zhp_lodz_baluty,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ['aleksandra.misiak@zhp.net.pl']
));
Person ALEKSANDRA_SZKLARCZYK = _register(const Person(
    name: 'Aleksandra Szklarczyk',
    druzyna: '3. DW „Szarada”',
    hufiec: huf_zhp_trzebinia,
    rankInstr: RankInstr.phm,
    org: Org.zhp,
    email: ['olaszklarczyk94@gmail.com']
));
Person ALEKSANDRA_TIMM = _register(const Person(
    name: 'Aleksandra Timm',
    druzyna: '21 WDW „Luna”',
    hufiec: huf_zhp_wrzesnia_wrzos,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ["aleksandra.timm@zhp.pl"]
));
Person ALEKSANDRA_TKOCZ = _register(const Person(
    name: 'Aleksandra Tkocz',
    druzyna: 'XIX. WDH „Sokół”',
    hufiec: huf_zhp_szczecin_dabie,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ['nikiii2115@gmail.com']
));
Person ALEKSANDRA_WOJCIECHOWSKA = _register(const Person(
    name: 'Aleksandra Wojciechowska',
    hufiec: huf_zhp_plock,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ['aleksandra.wojciechowska@zhp.net.pl']
));
Person ALICJA_DOBOSZ = _register(const Person(
    name: 'Alicja Dobosz',
    druzyna: '24. GDHS „Boreasz”',
    hufiec: huf_zhp_ziemi_gliwickiej,
    email: ["alicja.dobosz@zhp.net.pl"]
));
Person ALICJA_JASINSKA = _register(const Person(
    name: 'Alicja Jasińska',
    druzyna: '10 Świdnicka Drużyna Harcerska "Mrówkojady"',
    hufiec: huf_zhp_swidnica,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ["jasinska.alicja@zhp.net.pl"]
));
Person ALICJA_JEZNACKA = _register(const Person(
    name: 'Alicja Jeznacka',
    druzyna: '79. WWDH „ALPHA”',
    hufiec: huf_zhp_warszawa_zoliborz,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ['alicja.jeznacka@zhp.net.pl']
));
Person ALICJA_MAJCHER = _register(const Person(
    name: 'Ala Majcher',
    druzyna: '222. WDH „Bukowina” im. Jerzego Kukuczki',
    hufiec: huf_zhp_warszawa_wola,
    org: Org.zhp,
    email: ['alicja.majcher@zhp.net.pl']
));
Person ALICJA_NOWOSAD = _register(const Person(
    name: 'Alicja Nowosad',
    email: ["alicjanowosad555@gmail.com"]
));
Person AMELIA_BOJARSKA = _register(const Person(
    name: 'Amelia Bojarska',
    druzyna: '1. MDH „Wichry”',
    hufiec: huf_zhp_ostroleka,
    org: Org.zhp,
    email: []
));
Person AMELIA_KALICKA = _register(const Person(
    name: 'Amelia Kalicka',
    org: Org.zhr,
    email: ['amelkal678@gmail.com']
));
Person AMELIA_SITNICKA = _register(const Person(
    name: 'Amelia Sitnicka',
    druzyna: '112. WDH „Czirokezi”',
    hufiec: huf_zhp_warszawa_praga_pd,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ["ameliasitnicka787@gmail.com"]
));
Person AMELIA_SZALEWICZ = _register(const Person(
    name: 'Amelia Szalewicz',
    druzyna: '16. „Astra”',
    hufiec: huf_zhp_lowicz,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ["amelia_sz.2010@o2.pl", "ameliaszalewicz@gmail.com"]
));
Person ANNA_RAJEWSKA = _register(const Person(
    name: 'Anna Rajewska',
    druzyna: '2. Drużyna im. Leona Zadurskiego w Żukowie',
    hufiec: huf_zhp_kartuzy,
    email: ['anna.rajewska14@gmail.com']
));
Person ANTONI_ATANASSOW = _register(const Person(
    name: 'Antoni Atanassow',
    druzyna: '5. PgDH „Eastwick” im. Zawiszy Czarnego',
    hufiec: huf_zhp_krakow_pdg,
    rankHarc: RankHarc.zhpMlodzik,
    org: Org.zhp,
    email: ["hal133258007@gmail.com", 'obszycia-polemiczny2p@icloud.com']
));
Person ANTONINA_KARMANSKA = _register(const Person(
    name: 'Szczurowa',
    druzyna: '123. WSH „Za horyzontem”',
    hufiec: huf_zhp_warszawa_zoliborz,
    org: Org.zhp,
    email: ['tosia.karmanska@gmail.com']
));
Person ANTONINA_PIERZCHALA = _register(const Person(
    name: 'Antonina Pierzchała',
    druzyna: '41. Drużyna Harcerska „Huba”',
    hufiec: huf_zhp_ostrowiec_swietokrzyski,
    org: Org.zhp,
    email: ['tosiaczek118@gmail.com']
));
Person ANTONINA_ROMANSKA = _register(const Person(
    name: 'Antonina Romańska',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ['tosiaromanska@gmail.com']
));
Person ANTONINA_SZTYGLIC = _register(const Person(
    name: 'Antonina Sztyglic',
    hufiec: huf_zhp_lask,
    druzyna: '5. Wieluńska Drużyna Harcerek Starszych „Kozy”',
    org: Org.zhp,
    email: ['sztyglica@gmail.com']
));
Person ARTUR_KOSTRZEWA = _register(const Person(
  name: 'Artur Kostrzewa',
  druzyna: 'Puszczanie',
  hufiec: huf_zhp_krakow_pdg,
  org: Org.zhp,
  email: ['arturkos321@gmail.com'],
));
Person ARTUR_RUSA = _register(const Person(name: 'Artur Rusa', rankHarc: RankHarc.zhpWywiadowca, hufiec: huf_zhp_pulawy, druzyna: '113. SDSH', org: Org.zhp,));
Person BARBARA_THOMAS = _register(const Person(name: 'Barbara Thomas', rankInstr: RankInstr.phm));
Person BARTLOMIEJ_DANIELAK = _register(const Person(
    name: 'Bartłomiej Danielak',
    druzyna: 'HOWP „Cichociemni” Brzeg Dolny 8. SDDS GROM',
    rankInstr: RankInstr.pwd,
    email: ['ketrabek4002@gmail.com']
));
Person BARTLOMIEJ_JASKOLSKI = _register(const Person(
    name: 'Bartłomiej Jaskólski',
    druzyna: '100 Drużyna Harcerska „Surykatki”',
    hufiec: huf_zhp_ziemi_tarnogorskiej,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ["nino.prywatne@gmail.com", 'nino.music.tg@gmail.com']
));
Person BARTLOMIEJ_MALYJUREK = _register(const Person(
    name: 'Bartłomiej Małyjurek',
    druzyna: '24. Jodła',
    hufiec: huf_zhp_ziemi_cieszynskiej,
    email: ["malyjurekbartlomiej@gmail.com"]
));
Person BARTLOMIEJ_SIUSTA = _register(const Person(
    name: 'Bartek Siusta',
    org: Org.zhr,
    email: ["bartek.siusta1@gmail.com"]
));
Person BARTOSZ_DABROWSKI = _register(const Person(name: 'Bartosz Dąbrowski', rankHarc: RankHarc.zhpWywiadowca, org: Org.zhp));
Person BARTOSZ_IGNASIAK = _register(const Person(name: 'Bartosz Ignasiak', rankHarc: RankHarc.zhpHOc, rankInstr: RankInstr.pwd, druzyna: '8. Drużyna Wędrownicza „Kuźnia Płomienia”'));
Person BARTOSZ_KSIAZEK = _register(const Person(
    name: 'Bartosz Książek',
    druzyna: '91. DHS „Ad Astra”',
    hufiec: huf_zhp_katowice,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHRc,
    org: Org.zhp,
    email: ["bartosz.ksiazek@zhp.net.pl"]
));
Person BLANKA_KARCZEWSKA = _register(const Person(
    name: 'Blanka Karczewska',
    druzyna: '56. WDS „Ignis”',
    hufiec: huf_zhp_warszawa_zoliborz,
    email: ["blankakarczewska10@gmail.com"]
));
Person BENIAMIN_PLUCINSKI = _register(const Person(
    name: 'Beniamin Pluciński',
    druzyna: '17. ZODH',
    email: ['ekhemmmik@gmail.com']
));
Person BLAZEJ_KLEBBA = _register(const Person(
    name: 'Błażej Klebba',
    druzyna: '45. Drużyna Harcerska „Tuptaki”',
    hufiec: huf_zhp_puck,
    rankHarc: RankHarc.zhpMlodzik,
    org: Org.zhp,
    email: ['blazej3klebba.onet.pl@gmail.com']
));
Person BRUNO_BRONCEL = _register(const Person(
    name: 'Bruno Broncel',
    rankHarc: RankHarc.zhpMlodzik,
    druzyna: '55. DHSiW „Exigo”',
    hufiec: huf_zhp_karkonoski,
    org: Org.zhp,
    email: ['bruno.broncel@gmail.com']
));
Person BRUNO_WALERYCH = _register(const Person(
    name: 'Bruno Walerych',
    org: Org.zhp,
    email: ['bruno.walerych@zhp.pl']
));
Person CELINA_STANISLAWSKA = _register(const Person(
    name: 'Celina Stanisławska',
    druzyna: '6. DW Canis Lupus',
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ["celina.stanislawska@zhp.pl"]
));
Person DAMIAN_SZYSZKA = _register(const Person(
    name: 'Damian Szyszka',
    email: ['damianoszyszka@gmail.com']
));
Person DANIEL_IWANICKI = _register(const Person(
    name: 'Daniel Iwanicki',
    rankHarc: RankHarc.zhpHOc,
    rankInstr: RankInstr.hm,
    druzyna: '72. WDHS „Uroczysko”',
    email: ['daniel.iwanicki@zhp.net.pl']
));
Person DANIEL_KRYSIAK = _register(const Person(
    name: 'Daniel Krysiak',
    druzyna: 'I KDW im. Tadeusza Rejtana',
    hufiec: huf_zhp_kutno,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["danielkrysiak8098@wp.pl", 'krysiakdaniel8098@gmail.com']
));
Person DANIEL_KORZEB = _register(const Person(name: 'Daniel Korzeb', rankHarc: RankHarc.zhpOdkrywca,
  druzyna: '39. HDŻ Burza',
  hufiec: huf_zhp_czestochowa,
  org: Org.zhp,
));
Person DARIUSZ_DYMEK = _register(const Person(
    name: 'Dariusz Dymek',
    druzyna: 'PJDSH "Biała Róża"',
    hufiec: huf_zhp_jaworzno,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["dymek.daro@gmail.com"]
));
Person DAWID_KOBEDZA = _register(const Person(
    name: 'Dawid Kobędza',
    druzyna: '8. ŁDH Gniazdo',
    hufiec: huf_zhp_lodz_gorna,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ["dawid.kobedza@zhp.net.pl"]
));
Person DAWID_LOBODA = _register(const Person(
    name: 'Dawid Łoboda',
    druzyna: '63. GDH im. mi. Hieronima Degutowskiego „Zapora”',
    hufiec: huf_zhr_3_gdynski,
    rankHarc: RankHarc.zhrHOc,
    org: Org.zhr,
    email: ['dawidekk728@gmail.com']
));
Person DAWID_PIOTR_JACHIMOWSKI = _register(const Person(
    name: 'Dawid Piotr Jachimowski',
    druzyna: '1 Włodawska Drużyna Harcerzy "Delta" im. Augusta Emila Fieldorfa ps. "Nil"',
    rankHarc: RankHarc.zhrMlodzik,
    org: Org.zhr,
    email: ["dawid.kret011@gmail.com"]
));
Person DAWID_WYSZYNSKI = _register(const Person(name: 'Dawid Wyszyński', rankHarc: RankHarc.dhc, org: Org.zhp,));
Person DOMINIK_BETKA = _register(const Person(
    name: 'Dominik Betka',
    druzyna: '53 GDSH "STEFANY"',
    hufiec: huf_zhp_gdynia,
    rankInstr: RankInstr.phm,
    org: Org.zhp,
    email: ["dominik.betka@zhp.net.pl"]
));
Person DOMINIK_KIERES = _register(const Person(
    name: 'Dominik Kiereś',
    druzyna: '9. Drużyna Starszoharcerska "Zachód"',
    hufiec: huf_zhp_wolsztyn,
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ["dominik.kieres@zhp.net.pl"]
));
Person DOMINIKA_GORZYNSKA = _register(const Person(name: 'Dominika Gorzyńska', rankHarc: RankHarc.zhpPionierka,
  druzyna: '11. Gdańska Drużyna Starszoharcerska „Cegły” im. Anny Burdówny',
  hufiec: huf_zhp_gdansk_srodmiesie,
  org: Org.zhp,
));
Person DOMINIKA_HOCHMANSKA = _register(const Person(
    name: 'Dominika Hochmańska',
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ['dominika.hochmanska@gmail.com']
));
Person DORIAN_JAREK = _register(const Person(
    name: 'Dorian Jarek',
    rankInstr: RankInstr.pwd,
    druzyna: '13. Konińska Drużyna Wędrownicza „Wadery”',
    hufiec: huf_zhp_konin,
    org: Org.zhp
));
Person EMILIA_ADAMCZYK = _register(const Person(
    name: 'Emilka Adamczyk',
    druzyna: '222. WDH „Bukowina” im. Jerzego Kukuczki',
    hufiec: huf_zhp_warszawa_wola,
    org: Org.zhp,
    email: ["e.emilia246@gmail.com"]
));
Person EMILIA_Z_FSE = _register(const Person(
    name: 'Emilia',
    druzyna: 'Ognisko Młodych Przewodniczek',
    org: Org.fse,
    email: ['rozapodcieniem@gmail.com']
));
Person EMILIA_BARABASZ = _register(const Person(
    name: 'Emilia Barabasz',
    druzyna: '71. WGZ „Strażnicy Kraczaru”',
    hufiec: huf_zhp_warszawa_praga_pn,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ['emilia.barabasz@zhp.net.pl']
));
Person EMILIA_WARSZAJLO = _register(const Person(
    name: 'Emilia Warszajło',
    rankHarc: RankHarc.zhpSamarytanka,
    druzyna: '24. Szczep DHiGZ „Awangarda”',
    hufiec: huf_zhp_poznan_grunwald,
    org: Org.zhp,
    email: ['emiwarszajlo@gmail.com']
));
Person EMILIA_WITKOWSKA = _register(const Person(
    name: 'Emilia Witkowska',
    druzyna: '307. WDHiZ',
    hufiec: huf_zhp_warszawa_mokotow,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHRd,
    org: Org.zhp,
    email: ['emilia.witkowska@zhp.net.pl', 's206102@sggw.edu.pl']
));
Person EVELINA_STASILOVIC = _register(const Person(
    name: 'Evelina Stasilovič',
    rankHarc: RankHarc.zhpOchotniczka,
    druzyna: '9. Wileńska Drużyna Harcerek „Viator” im. kardynała Stefana Wyszyńskiego',
    org: Org.zhpNL,
    email: ['evelina.stasilovic@gmail.com']
));
Person EWA_BYSTRZYNSKA = _register(const Person(name: 'Ewa Bystrzyńska', rankHarc: RankHarc.dhd, org: Org.zhp));
Person EWELINA_HUPKA = _register(const Person(
    name: 'Ewelina Hupka',
    druzyna: 'XXII. Drużyna Harcerska „Ignis”',
    hufiec: huf_zhp_wegierska_gorka,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ['ewelina.hupka@zhp.net.pl']
));
Person FILIP_BERGIER = _register(const Person(
    name: 'Filip Bergier',
    rankHarc: RankHarc.zhpWywiadowca,
    druzyna: '72. WDHS „Uroczysko”',
    hufiec: huf_zhp_warszawa_praga_pn,
    org: Org.zhp,
    email: ['janberg7272@gmail.com', 'filip.bergier@zhp.net.pl', 'filip.bergier111@gmail.com']
));
Person FILIP_BRASZEWSKI = _register(const Person(
    name: 'Filip Brąszewski',
    druzyna: '62 KDHS „Brzoza” im. Stefana Szolca-Rogodzińskiego',
    hufiec: huf_zhp_kalisz,
    org: Org.zhp,
    email: ["fbraszewskii@gmail.com"]
));
Person FILIP_JASTRZEBSKI = _register(const Person(
    name: 'Filip Jastrzębski',
    druzyna: '58 Mazowiecka Drużyna Harcerzy "Cichociemni" im. płk. Jana Piwnika ps. "Ponury"',
    hufiec: 'Warszawski Hufiec Harcerzy „Eldorado”',
    rankHarc: RankHarc.zhrWywiadowca,
    org: Org.zhr,
    email: ["filip8j@gmail.com"]
));
Person FILIP_KWIATKOWSKI = _register(const Person(name: 'Filip Kwiatkowski', rankHarc: RankHarc.dhc, org: Org.zhp));
Person FILIP_LEWICKI = _register(const Person(
    name: 'Filip Lewicki',
    druzyna: '44 BDO "Beryl"',
    hufiec: huf_zhp_bialystok,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ["aleksandra.krzyzanowska@zhp.pl", 'olakrzy2004@gmail.com']
));
Person FILIP_PIELA = _register(const Person(
    name: 'Filip Piela',
    druzyna: '1. KDHS „Świt"',
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["filip.piela0209@gmail.com"]
));
Person FILIP_SOCHAJ = _register(const Person(name: 'Filip Sochaj'));
Person FILIP_SWIDEREK = _register(const Person(name: 'Filip Świderek'));
Person FLORIAN_PELEC = _register(const Person(
    name: 'Florian Pelec',
    druzyna: '28. DW "Żywica"',
    hufiec: huf_zhp_jarocin,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["florian.pelec@zhp.pl"]
));

Person FRANCISZEK_FALENTA = _register(const Person(
    name: 'Franciszek Falenta',
    druzyna: '123. LDSH „Imperatyw”',
    hufiec: huf_zhp_lublin,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["franciszek.falenta@zhp.pl"]
));
Person FRANCISZEK_HALUCH = _register(const Person(
    name: 'Franciszek Haluch',
    druzyna: '73. KDSH „Carpe Diem”',
    hufiec: huf_zhp_beskidzki,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["franciszek.haluch@zhp.net.pl"]
));
Person FRANCISZEK_LINKE = _register(const Person(
    name: 'pwd. Franciszek Linke',
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ['franciszek.linke@zhp.net.pl']
));
Person FRANCISZEK_MICHALSKI = _register(const Person(
    name: 'Franciszek Michalski',
    druzyna: '254. WDH „Matecznik” im. Janka Bytnara „Rudego”',
    hufiec: huf_zhp_warszawa_zoliborz,
    org: Org.zhp,
    email: ['franciszek.michalski@zhp.net.pl']
));
Person FRANCISZEK_PUKNEL = _register(const Person(
    name: 'Franek Puknel',
    druzyna: '579. WDH Łatwopalni',
    hufiec: huf_zhp_powiatu_trzebnickiego,
    rankHarc: RankHarc.zhpWywiadowca,
    org: Org.zhp,
    email: ["franekpuknel12@gmail.com", 'franek.pu@icloud.com']
));
Person FRANCISZEK_TOMASZCZYK = _register(const Person(
    name: 'Franciszek Tomaszczyk',
    rankHarc: RankHarc.zhpWywiadowca, hufiec: huf_zhp_ziemi_cieszynskiej,
    druzyna: '33. CDH „Czarne stopy”, 4. GZ „Radosne Misie”',
    org: Org.zhp
));
Person FRANCISZEK_WOJDYLO = _register(const Person(
    name: 'Franciszek Wojdyło',
    druzyna: '424 DW „Puszcza”',
    hufiec: 'Nowy Dwór Mazowiecki',
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ["franciszek.wojdylo@zhp.net.pl", 'franciszek.wojdylo@icloud.com']
));
Person GABRIEL_POZNANSKI = _register(const Person(
    name: 'Gabriel Poznański',
    druzyna: '6. GZ „Jeźdźcy Smoków”',
    hufiec: huf_zhp_chodziez,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ['gabriel.poznanski455@gmail.com']
));
Person GABRIELA_OZOG = _register(const Person(
    name: 'Gabriela Ożóg',
    druzyna: '175. RwDW „Orientalis”',
    hufiec: huf_zhp_rzeszow,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ["gabriela.ozog.mw@gmail.com"]
));
Person GABRIELA_SAWICKA = _register(const Person(
    name: 'Gabriela Sawicka',
    druzyna: '14. BDSh „Pomost”',
    hufiec: huf_zhp_bialystok,
    email: ["bibi.sawicka@gmail.com"]
));

Person GABRIELA_SOBCZAK = _register(const Person(
    name: 'Gabriela Sobczak',
    druzyna: '10. DH',
    hufiec: huf_zhp_jaktorow,
    rankHarc: RankHarc.zhpOchotniczka,
    email: ["gabi.sobczak1011@gmail.com"]
));
Person GRZEGORZ_BOROWIEC = _register(const Person(
  name: 'Grzegorz Borowiec',
  rankHarc: RankHarc.zhpHOc,
  druzyna: '66. WDW „Tornado”',
  hufiec: huf_zhp_torun,
  org: Org.zhp,
));
Person GRZEGORZ_FRANK = _register(const Person(
    name: 'Grzegorz Frank',
    hufiec: huf_zhp_ruda_slaska,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ['grzegorz.frank@zhp.net.pl']
));
Person GRZEGORZ_FRANKOW = _register(const Person(
    name: 'Grzegorz Franków',
    druzyna: '22. Kielecka Drużyna Harcerska',
    hufiec: huf_zhp_kielce_miasto,
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ['grzegorz.frankow@zhp.net.pl']
));
Person GRZEGORZ_GIBADLO = _register(const Person(
    name: 'Grzegorz Gibadło',
    druzyna: '25 DSH „Północ"',
    hufiec: huf_zhp_podkrakowski,
    rankHarc: RankHarc.zhpOdkrywca,
    org: Org.zhp,
    email: ["gg.gibadło@gmail.com"]
));
Person GRZEGORZ_PAWLAK = _register(const Person(
    name: 'Grzegorz Pawlak',
    email: ['grzegorz.pawlakk@gmail.com']
));
Person GRZEGORZ_ZAWADZKI = _register(const Person(
  name: 'Grzegorz Zawadzki',
  druzyna: '8. DSH „Ignis”',
  hufiec: huf_zhp_kutno,
));
Person GUSTAW_BAJCAR = _register(const Person(
    name: 'Gustaw Bajcar',
    druzyna: '2. WDH',
    hufiec: huf_zhp_olawa,
    rankHarc: RankHarc.zhpMlodzik,
    org: Org.zhp,
    email: ['gustaw.bajcar2@gmail.com']
));
Person HANNA_CISAKOWSKA = _register(const Person(
    name: 'Hania Cisakowska',
    rankHarc: RankHarc.zhpPionierka,
    email: ['hanna.cisakowska2009@gmail.com']
));
Person HANNA_CZAJKOWSKA = _register(const Person(
    name: 'Hanna Czajkowska',
    org: Org.zhp,
    email: ['hanna.czajkowska@zhp.net.pl']
));
Person HANNA_KESKA = _register(const Person(
    name: 'Hanna Kęska',
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ["hanusia.keska@gmail.com "]
));
Person HANNA_KUCINSKA = _register(const Person(
    name: 'Hanna Kucińska',
    druzyna: '14. DHS „Wataha"',
    hufiec: huf_zhp_legionowo,
    rankHarc: RankHarc.zhpTropicielka,
    org: Org.zhp,
    email: ["hanna.kucinska@vp.pl"]
));
Person HANNA_KUJAWSKA = _register(const Person(
    name: 'Hanna Kujawska',
    druzyna: '6. DSH „Wataha”',
    email: ['kujawskahanka@gmail.com']
));
Person HANNA_RYBACKA = _register(const Person(name: 'Hanna Rybacka',
    druzyna: 'Gromada Zuchowa „Ogniste Feniksy”',
    hufiec: huf_zhp_zdunska_wola,
    rankHarc: RankHarc.zhpSamarytanka,
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ['hanna.rybacka@zhp.net.pl']
));
Person HANNA_STRZESZEWSKA = _register(const Person(
    name: 'Hanna Strzeszewska',
    druzyna: '368. „Gniazdk”',
    hufiec: huf_zhp_warszawa_zoliborz,
    email: ['hania.prime@gmail.com']
));
Person HANNA_WITKOWSKA = _register(const Person(
    name: 'Hanna Witkowska',
    druzyna: '66. Wrocławska Drużyna Harcerska „PSIAKI”',
    hufiec: huf_zhp_wroclaw_polnoc,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ['hanna.witkowska@zhp.net.pl']
));
Person HANNA_WNEKOWICZ = _register(const Person(
    name: 'Hanna Wnękowicz',
    druzyna: '12. DH „Szare Wilki” w Brodach',
    hufiec: huf_zhp_zary,
    org: Org.zhp,
    email: ['hannawnekowicz93@gmail.com']
));
Person HELENA_LATOSINSKA = _register(const Person(name: 'Helena Latosińska',
  druzyna: '39. Wielopoziomowa Drużyna Harcerska „Leśne Stwory z Radlina”',
  hufiec: huf_zhp_ziemi_wodzislawskiej,
  org: Org.zhp,
));
Person HELENA_SWIATKOWSKA = _register(const Person(
    name: 'Helena Świątkowska',
    rankHarc: RankHarc.zhrSamarytanka,
    org: Org.zhr,
    email: ['helena.swiatkowska@zhr.pl']
));
Person HUBERT_CISLAK = _register(const Person(
    name: 'Hubert Ciślak',
    druzyna: '300. PgLDH „Wichura”',
    hufiec: huf_zhp_krakow_pdg,
    rankHarc: RankHarc.zhpWywiadowca,
    email: ["hubertcc007@gmail.com"]
));
Person HUBERT_FRUKOWSKI = _register(const Person(
    name: 'Hubert Frukowski'
));
Person HUBERT_JANIK = _register(const Person(
    name: 'Hubert Janik',
    druzyna: '7. BDH „Białe Czaple”',
    hufiec: huf_zhp_bydgoszcz_miasto,
    org: Org.zhp,
    email: ['hubert.janik@zhp.net.pl', 'hubert.janik@zhp.pl']
));
Person HUBERT_MILEROWICZ = _register(const Person(
    name: 'Hubert Milerowicz',
    rankHarc: RankHarc.zhpOdkrywca,
    hufiec: huf_zhp_warszawa_ochota,
    druzyna: 'Środowisko „Szczep 224”',
    email: ['hubertmilerowicz@gmail.com']
));
Person HUBERT_NAPIERALA = _register(const Person(
    name: 'Hubert Napierała',
    email: ["napieralahubert501@gmail.com"]
));
Person HUBERT_SULSKI = _register(const Person(
    name: 'Hubert Sulski',
    druzyna: '23. DSH „Legendarne Smoki”',
    hufiec: huf_zhp_ziemi_wodzislawskiej,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['hksik2007@gmail.com']
));
Person HUGO_HANUSA = _register(const Person(
    name: 'Hugo Hanusa',
    druzyna: '44. KDH im Krzysztofa Kamil Baczyńskiego',
    hufiec: huf_zhr_harcerzy_krakow_stare_miasto,
    rankHarc: RankHarc.zhrWywiadowca,
    org: Org.zhr,
    email: [
      'hugohanusa@icloud.com',
      'hanusahugo@gmail.com'
    ]
));
Person HUGO_ZASACKI = _register(const Person(
    name: 'Hugo Zasacki',
    druzyna: 'Impeesa',
    hufiec: "Wawer",
    rankHarc: RankHarc.zhrCwik,
    org: Org.zhr,
    email: ["hugozas10@gmail.com"]
));
Person IDA_BECHTOLD = _register(const Person(
    name: 'Ida Bechtold',
    druzyna: '18. ŁDH Wierchy',
    hufiec: huf_zhp_lodz_baluty,
    rankHarc: RankHarc.zhpTropicielka,
    org: Org.zhp,
    email: ['idabechtold@icloud.com', 'i.bechtold@sp.120.elodz.edu.pl']
));
Person IGNACY_DUDZIAK = _register(const Person(
    name: 'Ignacy Dudziak',
    druzyna: '121. PgDSH „Szlak Łez” im. Plutonu „Alicja”',
    hufiec: huf_zhp_krakow_pdg,
    rankHarc: RankHarc.zhpWywiadowca,
    org: Org.zhp,
    email: ['ignacy.dudziak@zhp.net.pl']
));
Person IGNACY_SZYMICHOWSKI = _register(const Person(
    name: 'Ignacy Szymichowski',
    druzyna: '70. SDH',
    hufiec: 'Gdyński HH „Pasieka”',
    rankInstr: RankInstr.phm,
    rankHarc: RankHarc.zhrHRc,
    org: Org.zhr,
    email: ["i.szymichowski@zhr.pl"]
));
Person IGNACY_WOJTCZAK = _register(const Person(
    name: 'Ignacy Wojtczak',
    druzyna: '8. ADH',
    hufiec: huf_zhr_lodz_polesie,
    rankHarc: RankHarc.zhrMlodzik,
    org: Org.zhr,
    email: [
      'wojtczaki009@gmail.com'
    ]
));
Person IZABELA_MOSKAL = _register(const Person(
    name: 'Izabela Moskal',
    email: ['izabela.moskal.5@gmail.com']
));
Person INGA_WIERZBICKA = _register(const Person(
    name: 'Inga Wierzbicka',
    druzyna: '11. PgDH „Ignis” im. Zofii Cierniakowej',
    hufiec: huf_zhr_harcerek_krakow_podgorze,
    rankHarc: RankHarc.zhrOchotniczka,
    org: Org.zhr,
    email: ['ingawierzbicka1@gmail.com']
));
Person JACEK_PELCZAR = _register(const Person(
    name: 'Jacek Pelczar',
    druzyna: '79. Warszawska Wodna Drużyna Harcerska „Alpha”',
    hufiec: huf_zhp_warszawa_zoliborz,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ["jacek.pelczar@zhp.net.pl", 'jacek.pelczar.stud@pw.edu.pl']
));
Person JADWIGA_BILINSKA = _register(const Person(
    name: 'Jadwiga Bilińska',
    rankInstr: RankInstr.phm,
    rankHarc: RankHarc.zhpSamarytanka,
    hufiec: huf_zhp_zielonka,
    druzyna: '132. Mazowiecka Drużyna Harcerska „Wielkie Bractwo Halicza”',
    org: Org.zhp,
    email: ['jadwiga.bilinska@zhp.net.pl']
));
Person JADWIGA_GORSKA = _register(const Person(
    name: 'Jadwiga Górska',
    rankHarc: RankHarc.zhpHOd,
    email: ['jdzgorska@gmail.com', 'jadwiga.gorska@zhp.net.pl'],
    org: Org.zhp
));
Person JADWIGA_SZEWCZYK = _register(const Person(
  name: 'Jadwiga Szewczyk',
  email: ['jadzia.m.szewczyk@gmail.com'],
));
Person JAGIENKA_KULCZYCKA = _register(const Person(
  name: 'Jagienka Kulczycka',
  rankHarc: RankHarc.zhpOchotniczka,
  druzyna: '36. Kaliska Drużyna Harcerska „Orły”',
  hufiec: huf_zhp_kalisz,
  org: Org.zhp,
  email: ['jagienkakulczycka@gmail.com', 'kulczyckajagienka@gmail.com'],
));
Person JAGODA_BLASZCZYK = _register(const Person(
    name: 'Jagoda Błaszczyk',
    druzyna: '29. Zgierska Drużyna Harcerska „Dakota”',
    hufiec: huf_zhp_zgierz,
    rankHarc: RankHarc.zhpOchotniczka,
    org: Org.zhp,
    email: ['blaszczykjagoda25@gmail.com']
));
Person JAGODA_SKOWRONSKA = _register(const Person(
    name: 'Jagoda Skowrońska',
    druzyna: '125. „Aves”',
    hufiec: huf_zhp_nowe_miasto_lubawskie,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ['jagoda.skowronska@edu.szkolagortatowo.pl', 'jagodaskowronska2021@gmail.com']
));
Person JAKUB_BRYLA = _register(const Person(
    name: 'Jakub Bryła',
    email: ["jakubbryla05@gmail.com"]
));
Person JAKUB_DEBICKI = _register(const Person(
    name: 'Jakub Dębicki',
    druzyna: '8. Drużyna Wędrownicza „Kuźnia Płomienia”',
    hufiec: huf_zhp_lask,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ['j.debicki@icloud.com']
));
Person JAKUB_DUDA = _register(const Person(
    name: 'Jakub Duda',
    druzyna: '6DW „Malachit”',
    hufiec: huf_zhp_ziemi_myszkowskiej,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ['jakubduda2006@gmail.com']
));
Person JAKUB_EJDUK = _register(const Person(
    name: 'Jakub Ejduk',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    hufiec: huf_zhp_warszawa_praga_pn,
    org: Org.zhp
));
Person JAKUB_GABIS = _register(const Person(
    name: 'Jakub Gabiś',
    druzyna: '47 DW „Popioły” im. Franciszka Brody',
    hufiec: huf_zhp_kalisz,
    email: ["kubulus1303@gmail.com"]
));
Person JAKUB_HURYSZ = _register(const Person(
    name: 'Jakub Hurysz',
    druzyna: '44. Kościerska Drużyna Harcerzy „Burza” im. Spadochroniarzy Armii Krajowej',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhrHRc,
    org: Org.zhr,
    email: ["kuba.hurysz@o2.pl", 'jakub.hurysz@zhr.pl']
));
Person JAKUB_KLEPACZ = _register(const Person(
    name: 'Jakub Klepacz',
    druzyna: '7. ŁDW „Chaos”',
    hufiec: huf_zhp_lodz_gorna,
    rankHarc: RankHarc.zhpHRc,
    org: Org.zhp,
    email: ['jakub.klepacz@zhp.net.pl']
));
Person JAKUB_KUBICKI = _register(const Person(
    name: 'Jakub Kubicki',
    hufiec: huf_zhp_jaktorow,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ['jakub.kubicki0@icloud.com', 'jakub.kubicki1@zhp.net.pl']
));
Person JAKUB_KLUCZKOWSKI = _register(const Person(
    name: 'Jakub Kluczkowski',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    hufiec: huf_zhp_ziemi_koszalinskiej,
    org: Org.zhp,
    email: ['jakub.kluczkowski@zhp.net.pl']
));
Person JAKUB_LYSZKOWSKI = _register(const Person(
    name: 'Jakub Lyszkowski',
    email: ['kubalyszka@gmail.com']
));
Person JAKUB_MAGIERA = _register(const Person(
    name: 'Jakub Magiera',
    druzyna: '6. DSH „Ichtis”',
    hufiec: huf_zhp_nisko,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHRd,
    org: Org.zhp,
    email: ["kuba.magiera220@gmial.com"]
));
Person JAKUB_MICHALSKI = _register(const Person(
    name: 'Jakub Michalski',
    druzyna: '3 PDH im. płk. Jana Kilińskiego „Czarna Trójka”',
    hufiec: huf_zhp_pabianice,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["michalski.jakub@zhp.net.pl"]
));
Person JAKUB_MLYNSKI = _register(const Person(
    name: 'Jakub Młyński',
    druzyna: '77. WDH im. Harcerskiego Batalionu Szturmowego „Zośka”',
    hufiec: huf_zhp_gdansk_srodmiesie,
    org: Org.zhp,
    email: ['kubamlynski4@gmail.com']
));
Person JAKUB_NOGA = _register(const Person(
    name: 'Jakub Noga',
    druzyna: "30. PgDSH „Waganci”",
    hufiec: huf_zhp_krakow_pdg,
    org: Org.zhp,
    email: ['jakub.noga@zhp.net.pl']
));
Person JAKUB_SKUCHA = _register(const Person(name: 'Jakub Skucha', rankHarc: RankHarc.dhc));
Person JAKUB_STEFANSKI = _register(const Person(name: 'Jakub Stefański', rankHarc: RankHarc.dhc, org: Org.zhp));
Person JAKUB_STRACZYNSKI = _register(const Person(
    name: 'Jakub Strączyński',
    druzyna: '52. KDHS',
    hufiec: huf_zhp_kielce_miasto,
    email: ['pancernuq@gmail.com', 'pancernu2@gmail.com', 'qbastraczynski@gmail.com']
));
Person JAKUB_SWIT = _register(const Person(
    name: 'Jakub Świt',
    druzyna: '124. Łódzka Drużyna Harcerzy „Bór" im. K.K. Baczyńskiego',
    hufiec: huf_zhp_lodz_baluty,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ["jakub.swit@zhp.net.pl"]
));
Person JAKUB_TARNOWSKI = _register(const Person(
    name: 'Jakub Tarnowski',
    druzyna: '101. Tarnowska Wędrownicza Drużyna Harcerska „Currahee”',
    hufiec: huf_zhp_tarnow,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["jakubtar14@gmail.com"]
));
Person JAKUB_ZDANOWICZ_ZASIDKO = _register(const Person(name: 'Jakub Zdanowicz-Zasidko', rankHarc: RankHarc.dhc));
Person JAN_JARECKI = _register(const Person(
    name: 'Jan Jarecki',
    druzyna: '30. PgDSH „Waganci”',
    hufiec: huf_zhp_krakow_pdg,
    org: Org.zhp,
    email: ['jareckijan07@gmail.com', 'jan.jarecki@zhp.pl']
));
Person JAN_JAWORSKI = _register(const Person(
    name: 'Jan Jaworski',
    druzyna: '125. DH „Aves” im. Harcerzy Spod Znaku Rodła',
    hufiec: huf_zhp_nowe_miasto_lubawskie,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ['jaworskijan8@gmail.com']
));
Person JAN_KUCZA = _register(const Person(
    name: 'Jan Kucza',
    druzyna: '12. PDHS „Parszywa Dwunastka”',
    hufiec: huf_zhp_legionowo,
    org: Org.zhp,
    email: ['jan.kucza@zhp.net.pl', 's219284@sggw.edu.pl']
));
Person JAN_KWIATKOWSKI = _register(const Person(
    name: 'Jan Kwiatkowski',
    druzyna: 'Chabrowa 18. Toruńska Drużyna Harcerska „Las” im. Emilii Plater',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ["jan.kwiatkowski@zhp.net.pl", "j.kwiat06@gmail.com"]
));
Person JAN_LEWANDOWSKI = _register(const Person(
    name: 'Jan Lewandowski',
    druzyna: '58. MDH „Cichociemni”',
    hufiec: 'Eldorado',
    rankHarc: RankHarc.zhrWywiadowca,
    org: Org.zhr,
    email: ["janeklefy@gmail.com"]
));
Person JAN_LICZBANSKI = _register(const Person(
    name: 'Jan Liczbański',
    druzyna: '1. PDH „Puszcza” im. KWP',
    hufiec: 'Łódzki Hufiec Harcerzy "Szaniec"',
    rankHarc: RankHarc.zhrWywiadowca,
    org: Org.zhr,
    email: ["janekliczbanski10@gmail.com", "kowalewiczgosia@gmail.com"]
));
Person JAN_NOWAK = _register(const Person(
    name: 'Jan Nowak',
    druzyna: '8. UDH „Knieja”',
    hufiec: huf_zhr_urynowski_hufiec_rawicz,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhr,
    email: ['lolekmarian.200@gmail.com']
));
Person JAN_REWERSKI = _register(const Person(
    name: 'Jan Rewerski',
    druzyna: '173. WDH „Biała” im K. K. Baczyńskiego',
    hufiec: huf_zhp_warszawa_ochota,
    rankHarc: RankHarc.zhpMlodzik,
    org: Org.zhp,
    email: ["jarewerski@gmail.com"]
));
Person JAN_STANULA = _register(const Person(
    name: 'Jan Stanula',
    druzyna: '4. DSH Ogniste Płomyki',
    hufiec: huf_zhp_trzebinia,
    org: Org.zhp
));
Person JANUSZ_ORLUTA = _register(const Person(
    name: 'Janusz Orluta',
    rankHarc: RankHarc.zhpHRc,
    rankInstr: RankInstr.hm,
    druzyna: 'Krąg Instruktorski "Amfibia"',
    email: ['janusz.orluta@zhp.net.pl']
));
Person JAROMIR_JABLONSKI = _register(const Person(
    name: 'Jaromir Jabłoński',
    druzyna: '132. Mazowiecka Drużyna Harcerzy "Synowie Szarego Wilka"',
    hufiec: huf_zhp_zielonka,
    rankInstr: RankInstr.phm,
    rankHarc: RankHarc.zhpHRc,
    org: Org.zhp,
    email: ["jaromir.jablonski@zhp.pl"]
));
Person JAROSLAW_JAKUBIAK = _register(const Person(name: 'Jarosław Jakubiak', rankHarc: RankHarc.dhc,
  hufiec: huf_zhp_uk,
));
Person JAROSLAW_ZASACKI = _register(const Person(name: 'Jarosław Zasacki', rankHarc: RankHarc.zhpHOc, rankInstr: RankInstr.phm,
  hufiec: huf_zhr_zielonagora_topor,
  org: Org.zhrChlop,
));
Person JASMINA_ROZYCKA = _register(const Person(
    name: 'Jaśmina Różycka',
    druzyna: '12. Lubelska Drużyna Wędrowniczek Północ',
    hufiec: huf_zhr_lubelski_hufiec_harcerek_harmonia,
    rankHarc: RankHarc.zhrSamarytanka,
    org: Org.zhr,
    email: ["kontrabasistka5@gmail.com", "rozyckajasmina@gmail.com"]
));
Person JERZY_ZOLNA = _register(const Person(
    name: 'Jerzy Żołna',
    druzyna: '30. PDSH „Chruptasy”',
    hufiec: huf_zhp_poznan_stare_miasto,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ["kamil12356544@gmail.com"]
));

Person JOANNA_MICHALOWSKA = _register(const Person(name: 'Joanna Michałowska', rankHarc: RankHarc.zhpSamarytanka,
  druzyna: '18. Poznańska Drużyna Harcerek im. Olgi Drahonowskiej-Małkowskiej',
  org: Org.zhp,
));
Person JOANNA_PAJAK = _register(const Person(
    name: 'Asia Pająk',
    druzyna: '124. ŁGDH „Płomienie”',
    hufiec: huf_zhp_lodz_gorna,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ['joanna.pajak@zhp.net.pl', 'pasiajak1@gmail.com']
));
Person JOANNA_RACZKO = _register(const Person(
    name: 'Joanna Raczko',
    druzyna: '33. WWDH „Korsarze” im. Marynarki Wojennej RP',
    hufiec: 'Wejherowo',
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ['joanna.raczko@zhp.net.pl']
));

Person JULIA_SZOZDA = _register(const Person(
    name: 'Julia Szozda',
    druzyna: '123. LDSh „Imperatyw”',
    hufiec: huf_zhp_lublin,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ["jszozdaaa@gmail.com"]
));
Person JOANNA_WALENDZIK = _register(const Person(
    name: 'Joanna Walendzik',
    druzyna: '111 Artystyczna Drużyna Harcerska',
    hufiec: huf_zhp_starachowice,
    rankHarc: RankHarc.zhpHRd,
    org: Org.zhp,
    email: ["joanna.walendzik@zhp.net.pl"]
));
Person JOLA_RYS = _register(const Person(
    name: 'Jola Ryś',
    druzyna: '5. Drużyna „Dzieci Gór”',
    hufiec: huf_zhp_gorczanski,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ["hrismas772@gmail.com", "szkolny77@gmail.com"]
));
Person JOWITA_BUCZYNSKA = _register(const Person(
    name: 'Jowita Buczyńska',
    druzyna: '23 ZDH "Zorza"',
    hufiec: huf_zhp_ziemi_bedzinskiej,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ['jowitabuczynska947@gmail.com']
));
Person JULIA_BIENIEK = _register(const Person(
    name: 'Julia Bieniek',
    druzyna: '254. Warszawska Drużyna Harcerska im. Janka Bytnara „Rudego” Matecznik',
    org: Org.zhp,
    email: ['juliamariabieniek@gmail.com']
));
Person JULIA_BOLOZ = _register(const Person(
    name: 'Julia Bołoz',
    email: ["bolozjulia2@gmail.com"]
));
Person JULIA_GRODZKA = _register(const Person(
    name: 'Julka Grodzka',
    druzyna: '2. DH „Śpiący Rycerz”',
    hufiec: huf_zhp_ziemi_rybnickiej,
    rankHarc: RankHarc.zhpSamarytanka,
    email: ['jucia.grodzka@gmail.com', 'grodzka.julia@zhp.net.pl']
));
Person JULIA_JAROSZ = _register(const Person(
    name: 'Julia Jarosz',
    druzyna: '72. WDH „Knieja”',
    hufiec: huf_zhp_warszawa_praga_pn,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ['julia.jarosz@zhp.net.pl']
));
Person JULIA_KARAS = _register(const Person(
    name: 'Julia Karaś',
    rankHarc: RankHarc.zhpPionierka,
    druzyna: '78. Grunwaldzka Wielopoziomowa Drużyna Harcerska „Halny” im. hm. Józefy Kantor',
    hufiec: huf_zhp_beskidzki,
    org: Org.zhp,
    email: ['karasjulka81@gmail.com']
));
Person JULIA_KOSZTYLA = _register(const Person(
    name: 'Julia Kosztyła',
    druzyna: '7. DH NEMUS',
    hufiec: huf_zhp_krosno,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ['juliakosztyla23@gmail.com']
));
Person JULIA_MARCINIAK = _register(const Person(
    name: 'Julia Marciniak',
    druzyna: '22 Lubelska Drużyna Harcerek "Potok" im. hm. Danuty Zofii Magierskiej',
    hufiec: 'Lubelski Hufiec Harcerek "Rzeka"',
    rankHarc: RankHarc.zhrSamarytanka,
    org: Org.zhr,
    email: ["juliamarcinka08@gmail.com"]
));
Person JULIA_PIASKOWSKA = _register(const Person(
    name: 'Julia Piaskowska',
    druzyna: '41 TDH Astrum',
    hufiec: huf_zhp_tomaszow_mazowiecki,
    rankHarc: RankHarc.zhpTropicielka,
    org: Org.zhp,
    email: ['jpiaskowska25@gmail.com']
));
Person JULIA_PILCH = _register(const Person(name: 'Julia Pilch', rankHarc: RankHarc.dhd));
Person JULIA_PROSZKIEWICZ = _register(const Person(
    name: 'Julia Proszkiewicz',
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ['juliaproszkiewicz@gmail.com']
));
Person JULIA_SIUDMAK = _register(const Person(name: 'Julia Siudmak'));
Person JULIA_SLAZAK = _register(const Person(
    name: 'Julia Ślązak',
    druzyna: '6 Świdnicka Drużyna Harcerska "Pasieka"',
    hufiec: huf_zhp_swidnica,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ["juliaslazak2000@gmail.com"]
));
Person JULIA_TYSZKIEWICZ = _register(const Person(
    name: 'Julia Tyszkiewicz',
    druzyna: '328. WDW „Fantasmagoria”',
    hufiec: huf_zhp_warszawa_centrum,
    org: Org.zhp,
    email: ['julia.tyszkiewicz@zhp.net.pl']
));
Person JULIA_WIERZBA = _register(const Person(
    name: 'Julia Wierzba',
    email: ["juliawierzba132@gmial.com"]
));
Person JULIA_WIESZOLEK = _register(const Person(
    name: 'Julia Wieszołek',
    druzyna: '3. Ozimska Drużyna Harcerek „Małapanew”',
    hufiec: 'Zawadczański Związek Drużyn Harcerek „Horyzonty”',
    rankHarc: RankHarc.zhrWedrowniczka,
    org: Org.zhr,
    email: ["julia.wieszolek@zhr.pl"]
));
Person JULIAN_SLAZYK = _register(const Person(
    name: 'Julian Ślazyk',
    druzyna: '47. ŁWDW',
    hufiec: huf_zhp_lodz_polesie,
    rankHarc: RankHarc.dhd,
    email: ['l.z.slazyk@gmail.com', 'podstawczak0@gmail.com']
));
Person JULIANNA_KLUS = _register(const Person(
    name: 'Julianna Klus',
    druzyna: '208. Warszawska Drużyna Harcerska „Helios”',
    hufiec: huf_zhp_warszawa_mokotow,
    org: Org.zhp,
    email: ['julianna.klus@zhp.net.pl', 'julianna.klus4@gmail.com']
));
Person JULITA_STEPIEN = _register(const Person(name: 'Julita Stępień'));

Person KACPER_BACZKOWSKI = _register(const Person(
    name: 'Kacper Bączkowski',
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['baczkowski.kacper.04@gmail.com']
));
Person KACPER_CIESIELSKI = _register(const Person(
    name: 'Kacper Ciesielski',
    druzyna: '17. Zgierska Obronną Drużyna Harcerska „Sokoły”',
    hufiec: huf_zhp_zgierz,
    rankHarc: RankHarc.zhpOdkrywca,
    org: Org.zhp,
    email: ['yorunokoibito@gmail.com']
));
Person KACPER_FRONC = _register(const Person(
    name: 'Kacper Fronc',
    druzyna: '19.DH „Modrzewie” im. 12. Pułku Ułanów Podolskich z Telatyna',
    email: ['kacperfronc44@gmail.com']
));
Person KACPER_KORDEK = _register(const Person(name: 'Kacper Kordek', rankHarc: RankHarc.zhpCwik));
Person KACPER_KOTECKI = _register(const Person(
    name: 'Kacper Kotecki',
    druzyna: '3. GŚDHS Kumade Niedździedzia Łapa',
    hufiec: huf_zhp_glowno,
    rankHarc: RankHarc.zhpWywiadowca,
    org: Org.zhp,
    email: ["panszkrzyneczka@gmail.com"]
));
Person KACPER_KOZLUK = _register(const Person(
    name: 'Kacper Koźluk',
    email: ['kacper@kozluk.pl']
));
Person KACPER_MIESOWICZ = _register(const Person(
    name: 'Kacper Mięsowicz',
    druzyna: '99. DH Amazonki',
    hufiec: huf_zhp_bochnia,
    rankHarc: RankHarc.zhpMlodzik,
    org: Org.zhp,
    email: ['kacper.miesowicz@gmail.com']
));
Person KACPER_SMOLKA = _register(const Person(name: 'Kacper Smółka', org: Org.zhp, email: ['kacper.smolka@zhp.net.pl']));
Person KACPER_SWITKIEWICZ = _register(const Person(name: 'Kacper Świtkiewicz', rankHarc: RankHarc.dhc, org: Org.zhp));
Person KACPER_SZCZENSY = _register(const Person(name: 'Kacper Szczęsny', rankHarc: RankHarc.zhpWywiadowca, org: Org.zhp));
Person KACPER_SZYMANKIEWICZ = _register(const Person(
    name: 'Kacper Szymankiewicz',
    druzyna: '15. Dąbrowska Drużyna Starszoharcerska „Niezłomni” im. Rotmistrza Witolda Pileckiego',
    hufiec: huf_zhp_dabrowa_gornicza,
    email: ['kacper.szymankiewicz@zhp.net.pl']
));
Person KACPER_TOMCZYK = _register(const Person(
    name: 'Kacper Tomczyk',
    druzyna: '77. Wrzesińska Drużyna Wędrownicza „Huragan”',
    hufiec: huf_zhp_wrzesnia_wrzos,
    org: Org.zhp,
    email: ['celnysnajper@gmail.com']
));
Person KACPER_WIDZ = _register(const Person(
  name: 'Kacper Widz',
  rankHarc: RankHarc.zhpMlodzik,
  org: Org.zhp,
  hufiec: huf_zhp_lublin,
  druzyna: '8. Lubelska Drużyna Wędrownicza „Infiniti”',
));
Person KACPER_WIETRZYKOWSKI = _register(const Person(
    name: 'Kacper Wietrzykowski',
    hufiec: huf_zhp_legionowo,
    org: Org.zhp,
    email: ['kacper.wietrzykowski@zhp.net.pl']
));

Person KAJETAN_RUSZKOWSKI = _register(const Person(
  name: 'Kajetan Ruszkowski',
  druzyna: 'XV. ŁDH „Zielony Płomień” im. Andrzeja Małkowskiego',
  hufiec: huf_zhr_lodz,
  rankHarc: RankHarc.zhpHOc,
  org: Org.zhr,
));
Person KAJETAN_WITKOWSKI = _register(const Person(
    name: 'Kajetan Witkowski',
    druzyna: '2. DH Iskry',
    hufiec: huf_zhp_miedzyrzecz,
    rankHarc: RankHarc.zhpMlodzik,
    org: Org.zhp,
    email: ['kajetanwitkowski1602@gmail.com']
));
Person KAJETAN_WYGNANSKI = _register(const Person(
  name: 'Kajetan Wygrański',
  druzyna: '62. MDSH „Krzemień”',
  hufiec: huf_zhp_pruszkow,
  rankHarc: RankHarc.zhpOdkrywca,
  org: Org.zhp,
));
Person KAROLINA_BABOL = _register(const Person(
    name: 'Karolina Bąbol',
    druzyna: '1. PDH-ek „Płomień” im. Olgi Drahonowskiej- Małkowskiej',
    hufiec: 'Łodzki Hufiec Harcerek „Mozaika”',
    rankHarc: RankHarc.zhrTropicielka,
    org: Org.zhr,
    email: ["karolinababolzhr@gmail.com"]
));
Person KAROLINA_CZARNECKA = _register(const Person(
    name: 'Karolina Czarnecka',
    rankHarc: RankHarc.dhd,
    org: Org.zhr,
    email: ['karolinaczarnecka2007@gmail.com']
));
Person KAROLINA_HAJDUK = _register(const Person(
    name: 'Karolina Hajduk',
    druzyna: '21. DH',
    hufiec: huf_zhp_bytom,
    rankHarc: RankHarc.zhpOchotniczka,
    org: Org.zhp,
    email: ['kotrolina.h@gmail.com']
));
Person KAROLINA_MARCINKOWSKA = _register(const Person(name: 'Karolina Marcinkowska'));
Person KAROLINA_MROCZKO = _register(const Person(
    name: 'Karolina Mroczko',
    druzyna: '14. Próbna SDH „Fenris”',
    hufiec: huf_zhp_lagiewniki,
    rankHarc: RankHarc.zhpOchotniczka,
    org: Org.zhp,
    email: ["luskam1234@gmail.com"]
));
Person KAROLINA_WISNIEWSKA = _register(const Person(
    name: 'Karolina Wiśniewska',
    rankHarc: RankHarc.dhc,
    druzyna: '70 WPDH „Nienudni”',
    hufiec: huf_zhp_podlasie_w_siedlcach,
    org: Org.zhp,
    email: ['carowis07@gmail.com']
));
Person KAMIL_GORNIK = _register(const Person(
    name: 'Kamil Gurnik',
    rankHarc: RankHarc.zhpCwik,
    druzyna: '64. WDHS „Etos”',
    hufiec: huf_zhp_warszawa_praga_pn,
    org: Org.zhp,
    email: ['kamilgurnik@gmail.com']
));
Person KAMIL_ORGANISTA = _register(const Person(
    name: 'Kamil Organista',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    hufiec: huf_zhp_zamosc,
    org: Org.zhp,
    email: ['k.furiao@gmail.com', 'k.organista@onet.pl']
));
Person KAMIL_ZAK = _register(const Person(name: 'Kamil Żak', rankHarc: RankHarc.zhpHOc));
Person KAROL_FRANKOWSKI = _register(const Person(
    name: 'Karol Frankowski',
    druzyna: '1. PDH „Borek”',
    rankHarc: RankHarc.zhrCwik,
    org: Org.zhr,
    email: ['karol.frankowski@zhr.pl']
));
Person KAROL_FROST = _register(const Person(
    name: 'Karol Frost',
    druzyna: '20. DSH „Nomada”',
    hufiec: huf_zhp_starogard_gdanski,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["Karol.frost@zhp.pl"]
));
Person KAROL_GOLABEK = _register(const Person(
    name: 'Karol Gołąbek',
    rankHarc: RankHarc.zhpMlodzik,
    druzyna: '44. Drużyna Starszoharcerska „Potok” w Miękinii'
));
Person KAROL_MALINSKI = _register(const Person(
    name: 'Karol Maliński',
    druzyna: '31. Sopocka Wielopoziomowa Drużyna Wodna „Ventus”',
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ["karol.malinski@zhp.net.pl"]
));
Person KAROL_MALUS = _register(const Person(name: 'Karol Malus', rankHarc: RankHarc.dhc));
Person KAROL_PODOLSKI = _register(const Person(
    name: 'Karol Podolski',
    druzyna: '22. IMDW „Baribale”',
    hufiec: huf_zhp_ilawa,
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ["karol.podolski@zhp.net.pl"]
));
Person KATARZYNA_BIALAS = _register(const Person(
    name: 'Katarzyna Białas',
    druzyna: 'IV SDH „Jutrzenka”',
    email: ["katarzyna.bialas2010@gmail.com"]
));
Person KATARZYNA_LISAK = _register(const Person(
    name: 'Katarzyna Lisak',
    druzyna: '88. DW „Wierchy”',
    hufiec: huf_zhp_beskidzki,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ['katarzyna.lisak@zhp.net.pl']
));
Person KATARZYNA_MAZUR = _register(const Person(
    name: 'Katarzyna Mazur',
    druzyna: '9. Próbna Drużyna Wędrownicza „Vigilo”',
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ["k.mazur@zhp.pl"]
));
Person KATARZYNA_POLANSKA_WILK = _register(const Person(
    name: 'Katarzyna Polańska-Wilk',
    druzyna: '36. DSH „Duchy Gór”',
    rankInstr: RankInstr.pwd,
    email: ["katarzyna.wilk1@zhp.net.pl"]
));
Person KATARZYNA_STUDNICKA = _register(const Person(
    name: 'Katarzyna Studnicka',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.dhd,
    druzyna: '12. DH „Na Tropie”',
    hufiec: huf_zhp_andrychow, org: Org.zhp,
    email: ['katarzyna.studnicka@zhp.net.pl']
));
Person KINGA_BABIARSKA = _register(const Person(
    name: 'Kinga Babiarska',
    druzyna: '6. RDH „Skrzydła”',
    rankHarc: RankHarc.zhrSamarytanka,
    org: Org.zhr,
    email: ["zabababa8933@gmail.com"]
));
Person KINGA_KONOPCZYNSKA = _register(const Person(
    name: 'Kinga Konopczyńska',
    druzyna: '29. WDCzB',
    hufiec: huf_zhp_rumia,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHRd,
    org: Org.zhp,
    email: ["kinga.konopczynska@zhp.net.pl", "franciszek.skwiercz@zhp.pl"]
));
Person KINGA_ZEBRACKA = _register(const Person(
    name: 'Kinga Żebracka',
    druzyna: '10. Harcerska Drużyna Żeglarska',
    email: ["kingabzebracka@gmail.com"]
));
Person KINGA_JANKO = _register(const Person(
    name: 'K. Janko',
    druzyna: '1. DSH im. Szarych Szeregów',
    hufiec: huf_zhp_ziemi_tarnogorskiej,
    email: ["jankokinga9@gmail.com"]
));
Person KLARA_MAZEK = _register(const Person(name: 'Klara Mazek'));
Person KLAUDIA_PARNIEWICZ = _register(const Person(
    name: 'Klaudia Parniewicz',
    druzyna: '12 Drużyna Starszoharcerska Horyzont',
    hufiec: huf_zhp_nowy_tomysl,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ["klaudia.parniewicz@zhp.net.pl"]
));
Person KLAUDIA_STASINSKA = _register(const Person(
    name: 'Klaudia Stasińska',
    rankInstr: RankInstr.phm,
    rankHarc: RankHarc.zhpHOd,
    druzyna: '45 Nowomiejska Gromada Zuchowa „Czterolistne Koniczynki”',
    hufiec: huf_zhp_poznan_nowe_miasto,
    org: Org.zhp,
    email: ['klaudia.stasinska@zhp.net.pl', 'claudia.stasinska@gmail.com']
));
Person KLAUDIUSZ_PALUCH = _register(const Person(name: 'Klaudiusz Paluch'));
Person KLEMENTYNA_MARWICZ = _register(const Person(
    name: 'Klementyna Marwicz',
    druzyna: 'Przełęcz',
    rankHarc: RankHarc.zhrOchotniczka,
    org: Org.zhr,
    email: ["kemarwicz@gmail.com"]
));
Person KORNEL_GOLEBIEWSKI = _register(const Person(
    name: 'Kornel Gołębiewski',
    email: ['kornelg2001@wp.pl']
));
Person KORDIAN_LATOCHA = _register(const Person(
    name: 'Kordian Latocha',
    druzyna: '10. ŁDH',
    hufiec: huf_zhr_lodz_polesie,
    rankHarc: RankHarc.zhrMlodzik,
    org: Org.zhr,
    email: ["latochakordian@gmail.com"]
));
Person KORNEL_DABKOWSKI = _register(const Person(
    name: 'Kornel Dąbkowski',
    druzyna: '0,5. Próbna Drużyna Wędrownicza „Włóczykije”',
    hufiec: 'Trzcianka',
    org: Org.zhp,
    email: ["rener17011973@gmail.com"]
));
Person KORNELIA_KASIBORSKA = _register(const Person(
    name: 'Kornelia Kasiborska',
    druzyna: '45. WDH „Alias”',
    hufiec: huf_zhp_wloclawek,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ["korneliakasiborska76@gmail.com"]
));
Person KORNELIA_MROWKA = _register(const Person(
    name: 'Kornelia Mrówka',
    druzyna: '11 DH Ragnar im Jana Bytnara w Sierakowie',
    hufiec: huf_zhp_miedzychod,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ["kornelia.mrowka1@gmail.com"]
));
Person KORNELIA_PRZYCZOLKA = _register(const Person(
  name: 'Kornelia Przyczółka',
  rankHarc: RankHarc.zhpOchotniczka,
  email: ['alicjaspacer@gmail.com'],
));
Person KRYSTIAN_BULANDA = _register(const Person(
    name: 'Krystian Bulanda',
    hufiec: huf_zhp_krakow_pdg,
    email: ['krystian.bulanda@zhp.net.pl'],
    org: Org.zhp
));
Person KRZYSZTOF_BANIK = _register(const Person(
    name: 'Krzysztof Banik',
    druzyna: 'Strażnicy Żywiołów',
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["krystofb2010@gmail.com"]
));
Person KRZYSZTOF_GORECKI = _register(const Person(
    name: 'Krzysztof Górecki',
    druzyna: 'Szczep Pomarańczowy',
    hufiec: huf_zhp_andrychow,
    rankInstr: RankInstr.phm,
    org: Org.zhp,
    email: ["krzysztof.gorecki@zhp.net.pl"]
));
Person KRZYSZTOF_KANIEWSKI = _register(const Person(
    name: 'Krzysztof Kaniewski',
    rankHarc: RankHarc.zhpHOc,
    druzyna: '1. DW „Geneza”',
    hufiec: huf_zhp_legionowo,
    org: Org.zhp,
    email: ['krzysztof.kaniewski@zhp.net.pl']
));
Person KRZYSZTOF_KRAWCZYK = _register(const Person(name: 'Krzysztof Krawczyk', rankHarc: RankHarc.dhc));
Person KRZYSZTOF_LUBAS = _register(const Person(
    name: 'Krzysztof Lubas',
    druzyna: '1. Śledziejowicka Drużyna Harcerzy „Pełnia”',
    hufiec: 'Polonia Minor',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhrHOc,
    org: Org.zhr,
    email: ["krzysztof.lubas@zhr.pl", "krzyslubas07@gmail.com"]
));
Person KRZYSZTOF_MALIKIEWICZ = _register(const Person(
    name: 'Krzysztof Malikiewicz',
    rankHarc: RankHarc.zhpHRc,
    hufiec: huf_zhp_trzebinia,
    email: ['krzysztof.malikiewicz@zhp.net.pl']
));
Person KRZYSZTOF_MALINOWSKI = _register(const Person(
    name: 'Krzysztof Malinowski',
    druzyna: '19. DWa',
    hufiec: '5. Hufiec Warszawski',
    org: Org.fse,
    email: ["krzysztofwmalinowski@gmail.com"]
));
Person KRZYSZTOF_PIOTR_WAGROWSKI = _register(const Person(
    name: 'Krzysztof Piotr Wągrowski',
    druzyna: '8. Aleksandrowska Drużyna Harcerzy',
    hufiec: huf_zhr_lodz_polesie,
    rankHarc: RankHarc.zhrMlodzik,
    org: Org.zhr,
    email: ['krzysio.wagrowski@gmail.com', "agattam2004@gmail.com"]
));
Person KRZYSZTOF_RODZINKA = _register(const Person(
    name: 'Krzysiek Rodzinka',
    druzyna: 'Czarna Jedynka Rzeszów',
    email: ['krzysztof.rodzinka2007@gmail.com']
));
Person KRZYSZTOF_SUCHARSKI = _register(const Person(
    name: 'Krzysztof Sucharski',
    druzyna: 'Wataha',
    hufiec: huf_zhp_lagiewniki,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: []
));
Person KSAWERY_TWORKOWSKI = _register(const Person(
    name: 'Ksawery Tworkowski',
    druzyna: '81. ŁDH',
    rankHarc: RankHarc.zhrCwik,
    org: Org.zhr,
    email: ["ksawery.tworkowski@zhr.pl", "ksawtwor1@wp.pl"]
));
Person KSENIA_OKRUCINSKA = _register(const Person(
    name: 'Ksenia Okrucińska',
    druzyna: '51. TDH „Czarne Stopy”',
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ['polaczekn48@gmail.com', 'ksenia_okrucinska@wp.pl']
));
Person LAURA_FRASZEWSKA = _register(const Person(name: 'Laura Fraszewska'));
Person LAURA_NOWAKOWSKA = _register(const Person(
    name: 'Laura Nowakowska',
    druzyna: '25. GGDSH „Zawiszacy” im. dh. Stefana Mirowskiego',
    hufiec: huf_zhp_grodzisk_mazowiecki,
    org: Org.zhp,
    email: ['kocham.racuchy.pl@gmail.com', 'laura.elwartowska@edu.sp1grodzisk.pl']
));
Person LENA_PATLA = _register(const Person(
    name: 'Lena Patla',
    druzyna: '3. Krośnieńska Górska Drużyna Harcerska „Adventure”',
    hufiec: huf_zhp_krosno,
    org: Org.zhp,
    email: ['lena.patla@icloud.com']
));
Person LENA_STEFANSKA = _register(const Person(
    name: 'Lena Stefańska',
    druzyna: 'Różanie',
    hufiec: huf_zhp_bydgoszcz_miasto,
    rankHarc: RankHarc.zhpOchotniczka,
    org: Org.zhp,
    email: ["lenastefanska16@gmail.com"]
));
Person LENA_WEISS = _register(const Person(
    name: 'Lena Weiss',
    druzyna: '8. SDSH',
    org: Org.zhp,
    email: ['weiss.lenaa@icloud.com']
));
Person LILIANA_KASPRZYK = _register(const Person(
    name: 'Liliana Kasprzyk',
    druzyna: '9 GDHS Lukarna',
    hufiec: huf_zhp_ziemi_gliwickiej,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ["lilianokotek@wp.pl", "lilka.kasprzyk@gmail.com"]
));
Person LILIANA_MIROTA = _register(const Person(
    name: 'Liliana Mirota',
    druzyna: '7. BDH „Wrzosowisko”',
    hufiec: huf_zhp_reduta,
    rankHarc: RankHarc.zhpOchotniczka,
    org: Org.zhp,
    email: ['lilianamirota@gmail.com', 'lilianokotek@wp.pl']
));
Person LUCJA_PRABUCKA = _register(const Person(
    name: 'Łucja Prabucka',
    druzyna: '99. Elbląska żeńska drużyna starszo harcerska "Wapiti"  im. Marii Konopnickiej',
    rankHarc: RankHarc.zhpOchotniczka,
    org: Org.zhp,
    email: ["lucja4815@gmail.com"]
));
Person LUCJA_TALKOWSKA = _register(const Person(
    name: 'Łucja Talkowska',
    druzyna: 'Callis',
    rankHarc: RankHarc.zhrOchotniczka,
    org: Org.zhr,
    email: ['lusitalkowska@gmail.com']
));
Person LUKAS_JANOSIS = _register(const Person(
    name: 'Lukas Janonis',
    org: Org.zhpNL,
    email: []
));
Person LUKASZ_STROZYK = _register(const Person(
    name: 'Łukasz Stróżyk',
    druzyna: '3. MWDH „Brzask”',
    hufiec: huf_zhp_wagrowiec,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["lukaszstrozyk33@gmail.com"]
));
Person LUKASZ_SZEPIELAK = _register(const Person(name: 'Łukasz Szepielak', rankHarc: RankHarc.dhc, org: Org.zhp,));
Person LUKASZ_SZTANDERA = _register(const Person(
    name: 'Łukasz Sztandera',
    rankHarc: RankHarc.zhpWywiadowca,
    hufiec: huf_zhp_kielce_poludnie,
    druzyna: '29. Kielecka Drużyna Harcerska „Bukowina”',
    org: Org.zhp,
    email: ['lukasz.sztandera@zhp.net.pl']
));
Person LUKASZ_KRYWULT = _register(const Person(name: 'Łukasz Krywult', rankHarc: RankHarc.zhpCwik, org: Org.zhp,));
Person LUKASZ_RYBINSKI = _register(const Person(name: 'Łukasz Rybiński', rankInstr: RankInstr.pwd));
Person LUKASZ_WERNIK = _register(const Person(
    name: 'Łukasz Wernik',
    druzyna: '3. DSH „Feniks”',
    hufiec: huf_zhp_gostynin,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["lukasz.wernik@zhp.pl", 'danzelrex0@gmail.com']
));
Person MACIEJ_BATKO = _register(const Person(name: 'Maciej Batko', rankHarc: RankHarc.dhc,
    druzyna: '117. Elbląskiej Męskiej Drużyny Harcerskiej „Mato”',
    email: ['maciej.batko@uczen11.elblag.pl', 'maciemaciek160@gmail.com', 'maciut2007@gmail.com']
));
Person MACIEJ_CHUSTECKI = _register(const Person(
    name: 'Maciej Chustecki',
    rankHarc: RankHarc.zhrMlodzik,
    druzyna: '15. samodzielny zastęp „Burza”',
    org: Org.zhr
));
Person MACIEJ_DOBROWOLSKI = _register(const Person(
    name: 'Maciej Dobrowolski',
    hufiec: huf_zhp_elblag,
    rankInstr: RankInstr.phm,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ['roinuj5@gmail.com', 'maciej.dobrowolski@zhp.net.pl']
));
Person MACIEJ_GRZELAZKA = _register(const Person(
    name: 'Maciej Grzelązka',
    druzyna: '314. „Pierścienia”',
    rankHarc: RankHarc.zhpMlodzik,
    org: Org.zhp,
    email: ['maciej.grzelazka@gmail.com']
));
Person MACIEJ_KOLAKOWSKI = _register(const Person(
    name: 'Maciej Kołakowski',
    druzyna: '97. DSh',
    hufiec: huf_zhp_zywiec,
    org: Org.zhp,
    email: ['maciej.kolakowski@zhp.net.pl']
));
Person MACIEJ_LADOS = _register(const Person(
  name: 'Maciej Ładoś',
  rankInstr: RankInstr.pwd,
  druzyna: '8. PgDW Granat',
  hufiec: huf_zhp_krakow_pdg,
  org: Org.zhp,
  email: ['macieklad@gmail.com', 'maciej.lados@zhp.net.pl'],
));
Person MACIEJ_PAWLICA = _register(const Person(
    name: 'Maciej Pawlica',
    druzyna: '1. Nadarzyńska Drużyna Starszoharcerska „Impessa”',
    hufiec: huf_zhp_pruszkow,
    org: Org.zhp,
    email: ['maciek.pawlica@outlook.com']
));
Person MACIEJ_PRZYBYSZ = _register(const Person(
    name: 'Maciej Przybysz',
    druzyna: '20. DW „Avengers”',
    hufiec: huf_zhp_legionowo,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ['maciej.przybysz@zhp.net.pl']
));
Person MACIEJ_SZOLC = _register(const Person(
    name: 'Maciej Szolc',
    druzyna: '17. Drużyna Harcerska „Salamandra” z Jejkowic',
    hufiec: huf_zhp_ziemi_rybnickiej,
    email: ['maciekszolc12@gmail.com']
));
Person MACIEJ_WYSOCKI = _register(const Person(
    name: 'Maciej Wysocki',
    druzyna: 'WDHiZ „Matecznik”',
    hufiec: huf_zhp_warszawa_zoliborz,
    org: Org.zhp,
    email: ['pan.macieq@gmail.com']
));
Person MAGDALENA_BAJER = _register(const Person(
    name: 'Madzia',
    org: Org.zhp,
    email: ["magdbajer@gmail.com"]
));
Person MAGDALENA_KALISZ = _register(const Person(
    name: 'Magdalena Kalisz',
    druzyna: '64. WDH „Skaut”',
    hufiec: huf_zhp_warszawa_praga_pn,
    org: Org.zhp,
    email: ['magdalena.kalisz@zhp.net.pl']
));
Person MAGDALENA_KOZLOWSKA = _register(const Person(
    name: 'Magdalena Kozłowska',
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ['madziakoz2008@gmail.com']
));

Person MAGDALENA_KROSZCZYNSKA = _register(const Person(
    name: 'Magdalena Kroszczyńska',
    druzyna: '73. WDHS „Sensorium"',
    hufiec: huf_zhp_warszawa_praga_pn,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ["madzik.kroszczyk@gmail.com"]
));
Person MAGDALENA_MIELNIK = _register(const Person(
    name: 'Magdalena Mielnik',
    druzyna: '10. Drużyna Harcerska "Fidem" w Majdanie Starym im. Wandy "Wacek" Wasilewskiej',
    rankHarc: RankHarc.zhrTropicielka,
    org: Org.zhr,
    email: ['madzia.mielnik@onet.pl', 'fajrantelo@gmail.com', 'melizaikk@gmail.com']
));
Person MAKSYM_KAWULA = _register(const Person(
    name: 'Maksym Kawula',
    druzyna: '29 TDSH "Feniks"',
    hufiec: huf_zhp_tarnow,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['maksym.kawula@gmail.com']
));
Person MAKSYMILIAN_SPADLO = _register(const Person(
  name: 'Maksymilian Spadło',
  rankHarc: RankHarc.dhc,
  druzyna: '101. DSH „Lupus”',
  org: Org.zhp,
  email: ['maks118119@gmail.com'],
));
Person MAKSYMILIAN_TURZYNSKI = _register(const Person(
    name: 'Maksymilian Turzyński',
    druzyna: '124. „Bór”',
    hufiec: huf_zhp_lodz_baluty,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["jestemwlasku@gmail.com", "jestemwborze@gmail.com"]
));
Person MAKSYMILIAN_WERAN = _register(const Person(
    name: 'Maksymilian Weran',
    druzyna: '1 Nadarzyńska Drużyna Harcerska „Impeesa”',
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["maksymilian.weran@zhp.net.pl"]
));
Person MAJA_BUDZIOSZ = _register(const Person(
    name: 'Maja Budziosz',
    druzyna: '3. PDH-ek Róża Wiatrów',
    hufiec: 'Kraków',
    rankHarc: RankHarc.zhrOchotniczka,
    org: Org.zhr,
    email: ["akita.wiktoria@gmail.com"]
));
Person MAJA_GUCIK = _register(const Person(
    name: 'Maja gucik',
    druzyna: '4RDH-ek „Stellae”',
    rankHarc: RankHarc.zhrMlodzik,
    org: Org.zhr,
    email: ["gucikmaja@gmail.com"]
));
Person MAJA_HAJDACKA = _register(const Person(
    name: 'Maja Hajdacka',
    druzyna: '21. CDW im. Jana Bytanara ps. Rudy',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ["maja.hajdacka@gmail.com"]
));
Person MAJA_SLOWINSKA = _register(const Person(
    name: 'Maja Słowińska',
    hufiec: 'Pałuki',
    org: Org.zhp,
    email: ["slowinska.maja1@gmail.com"]
));
Person MAJA_WOJTYNIAK = _register(const Person(
    name: 'Maja Wojtyniak',
    rankHarc: RankHarc.zhrOchotniczka,
    druzyna: '1. ZDH „Rzeka”',
    email: ['m.wojtyniak@zhr.pl']
));
Person MALGORZATA_KLOC = _register(const Person(
    name: 'Małgorzata Kloc',
    rankHarc: RankHarc.zhpPionierka,
    druzyna: '9. Gliwicka Drużyna Harcerzy Starszych „Lukarna” im. płk. Witolda Pileckiego',
    hufiec: huf_zhp_ziemi_gliwickiej,
    org: Org.zhp,
    email: ['malgorzata.kloc@zhp.net.pl']
));
Person MALGORZATA_MASKO_HORYZA = _register(const Person(
  name: 'Małgorzata Maśko-Horyza',
  rankInstr: RankInstr.phm,
  email: ['m.masko-horyza@zhp.net.pl', 'malgorzata.masko-horyza@zhp.net.pl'],
  org: Org.zhp,
));
Person MALGORZATA_ORANKIEWICZ = _register(const Person(
    name: 'Małgorzata Orankiewicz',
    druzyna: '43. ZDHS „Parasol”',
    hufiec: huf_zhp_zgierz,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ["orankiewicz.gosia1@gmail.com"]
));
Person MALGORZATA_SZMUK = _register(const Person(
    name: 'Małgorzata Szmuk',
    druzyna: '16. DH WATAHA',
    email: ['szgosia2k19@gmail.com']
));
Person MALWINA_TRUSZKOWSKA = _register(const Person(
    name: 'Malwina Truszkowska',
    rankHarc: RankHarc.zhpPionierka,
    druzyna: '23. Warszawska Drużyna Wędrownicza „Binduga”',
    hufiec: huf_zhp_warszawa_mokotow,
    org: Org.zhp,
    email: ['malwina.truszkowska@zhp.net.pl', 'malvisianna@gmail.com']
));
Person MARCEL_MICHALIK = _register(const Person(
    name: 'Marcel Michalik',
    druzyna: '7. DSH „Kosogłos”',
    hufiec: huf_zhp_glogow,
    org: Org.zhp,
    email: ["michalikmsp@gmail.com"]
));
Person MARCEL_RYCHTER = _register(const Person(
    name: 'Marcel Rychter',
    druzyna: 'Szczep Podhale, Toronto, Kanada',
    email: ['m.rychter@gmail.com', 'm.rychter1441@gmail.com']
));
Person MARCEL_WOZNIAK = _register(const Person(
    name: 'Marcel Woźniak',
    druzyna: '10. KDSH Zioła',
    hufiec: huf_zhp_ziemi_koszalinskiej,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ['marcel.wozniak.144@gmail.com']
));
Person MARCELI_WARDA = _register(const Person(
    name: 'Marceli Warda',
    druzyna: '123. LDSh „Imperatyw”',
    hufiec: huf_zhp_lublin,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["marceliwarda@gmail.com"]
));
Person MARCELINA_SZYNDLER = _register(const Person(
    name: "Marcelina Szyndler",
    email: ['marcelina.szyndler@gmail.com']
));
Person MARCELINA_WILCZAK = _register(const Person(
    name: 'Marcelina Wilczak',
    druzyna: '1. DH „Bór”',
    hufiec: huf_zhp_trzebinia,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ['marcelina.wilczak@zhp.net.pl', 'wilczakmarcelina@gmail.com']
));
Person MARCIN_JANKOWIAK = _register(const Person(name: 'Marcin Jankowiak', hufiec: huf_zhp_jarocin, org: Org.zhp,));
Person MARCIN_SOBKOWICZ = _register(const Person(
    name: 'Marcin Sobkowicz',
    druzyna: '107. DH „Powsinogi” im. Zygmunta Glogera',
    hufiec: huf_zhp_opole,
    email: ["m.sobkovicz@gmail.com"]
));
Person MARCJANNA_NEY = _register(const Person(
    name: 'Marcjanna Ney',
    druzyna: '16 EŻDH Lilie',
    hufiec: huf_zhp_elblag,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ["marcjanna199@gmail.com"]
));
Person MAREK_BIZON = _register(const Person(
    name: 'Marek Bizoń',
    druzyna: '17. DH „Salamandra”',
    hufiec: 'Hufiec Ziemi Rybnickiej',
    rankInstr: RankInstr.phm,
    rankHarc: RankHarc.zhpHRc,
    org: Org.zhp,
    email: ['marek1bizon@gmail.com', 'marek.bizon@zhp.net.pl']
));
Person MAREK_BOJARUN = _register(const Person(
    name: 'Marek Bojarun',
    druzyna: '64. ODSH „Cień”',
    rankHarc: RankHarc.zhpWywiadowca,
    org: Org.zhp,
    email: ['marekbojarun220@gmail.com', 'm.bojarun09@gmail.com']
));
Person MAREK_LEWANCZYK = _register(const Person(
    name: 'Marek Lewańczyk',
    rankHarc: RankHarc.zhpHOc,
    rankInstr: RankInstr.pwd,
    druzyna: '7. GDH „Wilki”',
    email: ['marek.lewanczyk@zhp.net.pl']
));
Person MAREK_MUSIALIK = _register(const Person(name: 'Marek Musialik', rankHarc: RankHarc.dhc, org: Org.zhp));
Person MARLENA_BANIA = _register(const Person(
    name: 'Marlena Bania',
    rankHarc: RankHarc.zhpSamarytanka,
    druzyna: '9. Gliwicka Drużyna Wędrownicza „Maszkaron”',
    hufiec: huf_zhp_ziemi_gliwickiej,
    org: Org.zhp,
    email: ['marlena.bania6474@gmail.com', 'marlena.bania@zhp.net.pl']
));
Person MARIA_GRZYWACZ = _register(const Person(
    name: 'Maria Grzywacz',
    druzyna: '13. CDH „Bezimienni”',
    hufiec: huf_zhp_czestochowa,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ["marysia.grzywacz@gmail.com"]
));
Person MARIA_KIELIN = _register(const Person(
    name: 'Maria Kielin',
    druzyna: '11. WKDH Czarne Kruki',
    hufiec: huf_zhp_konin,
    org: Org.zhp,
    email: ['eryh4757@gmail.com']
));
Person MARIA_LAKOMA = _register(const Person(
    name: 'Maria Łakoma',
    druzyna: '1 Specjalnościowa Drużyna Harcerska GROM im. Cichociemnych Spadochroniarzy AK',
    hufiec: huf_zhp_doliny_liwca,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ["maria.lakoma@zhp.net.pl"]
));
Person MARIA_MAGDALENA_DESKUR = _register(const Person(
    name: 'Maria Magdalena Deskur',
    email: ['nenadeskur12@gmail.com']
));
Person MARIA_MIELCZAREK = _register(const Person(
    name: 'Maria Mielczarek',
    druzyna: '86. ŁWDSH',
    hufiec: huf_zhp_lodz_polesie,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ["marysia.m.mielczarek@gmail.com"]
));
Person MARIA_PIKOSZ = _register(const Person(
    name: 'Maria Pikosz',
    druzyna: '42. BDSH „Krzewy”',
    hufiec: huf_zhp_bydgoszcz_miasto,
    rankHarc: RankHarc.zhpTropicielka,
    org: Org.zhp,
    email: ["nszzbga@gmail.comI"]
));
Person MARIA_PRZYBYLSKA = _register(const Person(
    name: 'Maria Przybylska',
    druzyna: '49. Łódzka Drużyna Harcerek im. gen. Elżbiety Zawackiej „Zo”',
    hufiec: huf_zhp_lodz_baluty,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ['marysia.przybylska10@gmail.com', 'maria.przybylska@zhp.net.pl']
));
Person MARTA_GOLEBIOWSKA = _register(const Person(
    name: 'Marta Gołębiowka',
    rankInstr: RankInstr.pwd,
    druzyna: "7 BDSH „Żywica” im. Ryszarda Kaczorowskiego",
    org: Org.zhp,
    email: ["marta.golebiowska@zhp.net.pl"]
));
Person MARTA_SZYMANDERSKA = _register(const Person(name: 'Marta Szymanderska', rankHarc: RankHarc.dhd, hufiec: huf_zhp_warszawa_mokotow, org: Org.zhp));
Person MARTYNA_BULAKOWSKA = _register(const Person(
    name: 'Martyna Bułakowska',
    rankHarc: RankHarc.zhpHOd,
    rankInstr: RankInstr.pwd,
    druzyna: '17 Rudzka Grubwaldzka Drużyna Harcerska „VICTORY”',
    hufiec: huf_zhp_ruda_slaska,
    org: Org.zhp,
    email: ['m.bulakowska1997@gmail.com']
));
Person MARTYNA_SADOWNIK = _register(const Person(
    name: 'Martyna Sadownik',
    druzyna: '316. GDH „Huragan”',
    hufiec: huf_zhp_ziemi_gliwickiej,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ['martyna.sadownik@zhp.net.pl']
));
Person MARTYNA_WASILEWSKA = _register(const Person(
    name: 'Martyna Wasilewska',
    druzyna: '7. BDSH „Żywica”',
    hufiec: 'Reduta',
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ['martynawasilewska.1972@gmail.com', 'martynawas91@gmail.com']
));
Person MARTYNA_ZAJAC = _register(const Person(
    name: 'Martyna Zając',
    druzyna: '12. PDH „Atomówki”',
    hufiec: huf_zhp_poznan_grunwald,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ['zajacmartyna000@gmail.com']
));
Person MARYSIA_SLUGAJ = _register(const Person(
    name: 'Marysia Ślugaj',
    rankHarc: RankHarc.zhpHOd,
    hufiec: huf_zhp_wrzesnia_wrzos,
    druzyna: '77. Wrzesińska Drużyna Wędrownicza „Huragan”',
    email: ['nutkiq@gmail.com', 'giyuu@op.pl']
));
Person MATEUSZ_CIAGLO = _register(const Person(name: 'Mateusz Ciągło', rankHarc: RankHarc.dhc));
Person MATEUSZ_D = _register(const Person(
    name: 'Mateusz D',
    druzyna: '2. BDH „Rajza”',
    hufiec: huf_zhr_bytomski_zwiazek_druzyn,
    rankHarc: RankHarc.zhrWywiadowca,
    org: Org.zhr,
    email: ["matiadormateusz@gmail.com"]
));
Person MATEUSZ_GAWRYSIAK = _register(const Person(name: 'Mateusz Gawrysiak', rankHarc: RankHarc.zhpCwik));
Person MATEUSZ_KOBYLAREK = _register(const Person(
  name: 'Mateusz Kobylarek',
  rankHarc: RankHarc.zhpMlodzik,
  druzyna: '35. Poznańska Drużyna Harcerska im. I Polskiej Samodzielnej Kompanii Commando',
  hufiec: huf_zhp_poznan_wilda,
  org: Org.zhp,));
Person MATEUSZ_KORZENIOWSKI = _register(const Person(
    name: 'Mateusz Korzeniowski',
    druzyna: '1. DH D.R.E.S.Z.C.Z',
    hufiec: huf_zhp_wieliczka,

    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['mateusz.korzeniowski@zhp.net.pl']
));
Person MATEUSZ_MIKLASZEWSKI = _register(const Person(
    name: 'Mateusz Miklaszewski',
    druzyna: '12. DH Silva',
    hufiec: huf_zhp_augustow,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['mateusz.miklaszewski@gmail.com']
));
Person MATEUSZ_PYSZKA = _register(const Person(
    name: 'Mateusz Pyszka',
    druzyna: '70. SDH',
    org: Org.zhr,
    email: ['mati.matixos@gmail.com']
));
Person MATEUSZ_OLSZANSKI = _register(const Person(
    name: 'Mateusz Olszański',
    druzyna: '30 Pgdsh "Waganci"',
    hufiec: huf_zhp_krakow_pdg,
    rankHarc: RankHarc.zhpWywiadowca,
    org: Org.zhp,
    email: ["mateusz@olszanski.com"]
));
Person MATEUSZ_STEPNIEWSKI = _register(const Person(
    name: 'Mateusz Stępniewski',
    druzyna: '119',
    hufiec: huf_zhp_warszawa_zoliborz,
    rankHarc: RankHarc.zhpWywiadowca,
    org: Org.zhp,
    email: ['mateuszk.stepniewski@gmail.com']
));
Person MATEUSZ_SWIEBODA = _register(const Person(
    name: 'Mateusz Świeboda',
    druzyna: '17. KDH Jaworznia',
    hufiec: huf_zhp_kielce_miasto,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['etykik0@gmail.com']
));
Person MATEUSZ_URBANIAK = _register(const Person(
    name: 'Mateusz Urbaniak',
    druzyna: '42 DDH „Czarne Stopy”',
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ['m.urbaniak125@gmail.com']
));
Person MATEUSZ_WAS = _register(const Person(
    name: 'Mateusz Wąs',
    druzyna: '91 Kłobucka Drużyna Wędrownicza „Hades”',
    hufiec: huf_zhp_klobuck,
    org: Org.zhp,
    email: ['was.mateusz@zhp.pl']
));
Person MATVII_MASLOVSKYI = _register(const Person(
    name: 'Матвій Масловскi',
    druzyna: '6. DSH',
    hufiec: huf_zhp_gniezno,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["matvijmaslovski@gmail.com"]
));
Person MATYLDA_OLEJNIK = _register(const Person(
    name: 'Matylda Olejnik',
    druzyna: 'V DH Impsa',
    hufiec: huf_zhp_kedzierzyn_kozle,
    email: ["matyldazbagien@gmail.com"]
));
Person MAXIMILIAN_STEINHOFF = _register(const Person(
  name: 'Maximilian Steinhoff',
  //stop_h: StopZHP.dhc,
  rankInstr: RankInstr.pwd,
  druzyna: 'Próbna Drużyna Harcerzy w Berlinie ZHP Świat „Miś Wojtek”',
));
Person MICHAL_CHOLEWCZYNSKI = _register(const Person(
    name: 'Michał Cholewczyński',
    druzyna: '77. PDW „Chimera”',
    hufiec: huf_zhp_poznan_jezyce,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ['michal.cholewczynski@zhp.net.pl', 'michalcholewczynski@gmail.com', 'theniedzwiedz@icloud.com']
));
Person MICHAL_DYDERSKI = _register(const Person(
    name: 'Michał Dyderski',
    rankHarc: RankHarc.zhpHOc,
    rankInstr: RankInstr.pwd,
    druzyna: '93. PDW',
    hufiec: huf_zhp_poznan_wilda,
    org: Org.zhp,
    email: ['michal.dyderski6@gmail.com', 'michal.dyderski@zhp.net.pl']
));
Person MICHAL_JABCZYNSKI = _register(const Person(
    name: 'Michał Jabczyński',
    rankHarc: RankHarc.zhpHRc,
    rankInstr: RankInstr.pwd,
    druzyna: '9. DH „Feniks”',
    hufiec: huf_zhp_gniezno,
    org: Org.zhp,
    email: ['michal.jabczynski@gmail.com']
));
Person MICHAL_JANAS = _register(const Person(
    name: 'Michał Janas',
    email: ['mdjanas@gmail.com']
));
Person MICHAL_KARWOWSKI = _register(const Person(
  name: 'Michał Karwowski',
  rankHarc: RankHarc.zhpHOc,
  rankInstr: RankInstr.phm,
  druzyna: '72. Szczep WDHiGZ „Ostoja”',
  hufiec: huf_zhp_warszawa_praga_pn,
  org: Org.zhp,
));
Person MICHAL_KUSTOSIK = _register(const Person(
    name: 'Michał Kustosik',
    druzyna: 'Krąg Instruktorski',
    hufiec: huf_zhp_lodz_polesie,
    email: ["mkustosik@gmail.com"]
));
Person MICHAL_MACULEWICZ = _register(const Person(
    name: 'Michał Maculewicz',
    druzyna: '6. GNDH „Vitae" im.Floriana Marciniaka',
    rankHarc: RankHarc.zhpHOc,
    hufiec: huf_zhp_nidzica,
    org: Org.zhp,
    email: ['michal.maculewicz@zhp.net.pl']
));
Person MICHAL_METEL = _register(const Person(
  name: 'Michał Mętel',
  druzyna: 'Szczep „Unia” im. Władysława Jagiełły',
  rankHarc: RankHarc.zhpHOc,
  rankInstr: RankInstr.pwd,
  hufiec: huf_zhp_krakow_nowa_huta,
  org: Org.zhp,
  email: ['michal.metel@zhp.net.pl'],
));
Person MICHAL_PIENIAZEK = _register(const Person(
    name: 'Michał Pieniążek',
    druzyna: '1 KDH',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHRc,
    org: Org.hrp,
    email: ['4michalpieniazek@gmail.com']
));
Person MICHAL_RZEZNIKIEWICZ = _register(const Person(
    name: 'Michał Rzeźnikiewicz',
    druzyna: '104. WDH „Strumień”',
    hufiec: huf_zhp_karkonoski,
    rankHarc: RankHarc.zhpWywiadowca,
    org: Org.zhp,
    email: ["rzeznikiewiczmichal@gmail.com", "michalrzeznik2819@gmail.com"]
));
Person MICHAL_SITEK = _register(const Person(
    name: 'Michał Sitek',
    druzyna: '21. EŚDH Horyzont',
    hufiec: huf_zhp_chrzanow,
    email: ['misiokikol@gmail.com']
));
Person MICHAL_SMULIK = _register(const Person(
    name: 'Michał Smulik',
    druzyna: '62 kdhs brzoza',
    hufiec: huf_zhp_kalisz,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["smumichal@gmail.com"]
));
Person MICHAL_SUPINSKI = _register(const Person(
    name: 'Michał Supiński',
    rankHarc: RankHarc.zhpHOc,
    rankInstr: RankInstr.pwd,
    druzyna: '149. Poznańska Drużyna Harcerska „Bzura” im. generała Tadeusza Kutrzeby',
    hufiec: huf_zhp_poznan_nowe_miasto,
    org: Org.zhp,
    email: ['michal.supinskii@gmail.com']
));
Person MIECZYSLAW_MICHALIK = _register(const Person(
  name: 'Mietek Michalik',
  email: ['mimich@onet.pl'],
));
Person MIESZKO_OKROJ = _register(const Person(
    name: 'Mieszko Okrój',
    druzyna: '82 ŁDSH "Eliock" im. 1SBS',
    hufiec: huf_zhp_lodz_gorna,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ['mooj1234567890@gmail.com', 'mieszko.okroj@zhp.net.pl']
));
Person MIKOLAJ_GORECKI = _register(const Person(
    name: 'Mikołaj Górecki',
    druzyna: '30. PgDSHW „Waganci”',
    hufiec: huf_zhp_krakow_pdg,
    org: Org.zhp,
    email: ['mikolaj.gorecki.pl@gmail.com']
));
Person MIKOLAJ_HORDEJUK = _register(const Person(
    name: 'Mikołaj Hordejuk',
    druzyna: '44 44 WDH "Kedyw" im. gen. Augusta Emila Fieldorfa ps. "Nil"',
    hufiec: huf_zhr_mazowiecki_hufiec_harcerzy_pogranicze,
    rankHarc: RankHarc.zhrMlodzik,
    org: Org.zhr,
    email: ["mgmiko813@gmail.com"]
));
Person MIKOLAJ_LACHENDRO = _register(const Person(
    name: 'Mikołaj Lachendro',
    druzyna: '28 d. harcerska południe',
    hufiec: huf_zhp_andrychow,
    rankHarc: RankHarc.zhpWywiadowca,
    org: Org.zhp,
    email: ["mikilego2012@gmail.com"]
));
Person MIKOLAJ_LUKASIK = _register(const Person(
    name: 'Mikołaj Łukasik',
    druzyna: '8. PgDSH „Pandora”',
    hufiec: huf_zhp_krakow_pdg,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['mikiriki2017@gmail.com']
));
Person MIKOLAJ_MATUSZEWSKI = _register(const Person(
  name: 'Mikołaj Matuszewski',
  druzyna: '43. CHDG „SULIMA” im. Rycerza Zawiszy Czarnego',
  hufiec: huf_zhp_czestochowa,
  org: Org.zhp,
  email: ['mikolaj.matuszewski@zhp.net.pl'],
));
Person MIKOLAJ_SOBON = _register(const Person(
    name: 'Mikołaj Soboń',
    druzyna: '16. Drużyna Harcerska',
    hufiec: huf_zhp_zyrardow,
    rankInstr: RankInstr.phm,
    rankHarc: RankHarc.zhpHRc,
    org: Org.zhp,
    email: ['mikolaj.sobon@zhp.net.pl']
));
Person MIKOLAJ_WITKOWSKI = _register(const Person(
  name: 'Mikołaj Witkowski',
));
Person MILENA_DULAK = _register(const Person(
    name: 'Milena Dułak',
    druzyna: '14. BDH-ek „Róża Wiatrów”',
    rankHarc: RankHarc.zhrOchotniczka,
    email: ['dulakmilena@gmail.com']
));
Person MINION_MALGOSIA_MIKOLAJCZYK = _register(const Person(
    name: 'Minion Małgosia Mikołajczyk',
    druzyna: '119. Warszawska Drużyna Harcerska „Immortales”',
    hufiec: huf_zhp_warszawa_zoliborz,
    org: Org.zhp,
    email: ["malgorzata.a.mikolajczyk@gmail.com"]
));
Person NADIA_STOLAR = _register(const Person(
    name: 'Nadia Stolar',
    druzyna: '41. TDH „Astrum”',
    hufiec: huf_zhp_tomaszow_mazowiecki,
    rankHarc: RankHarc.zhpOchotniczka,
    email: ["stolar.nadia14@gmail.com"]
));
Person NADIA_OSSOWSKA = _register(const Person(
  name: 'Nadia Ossowska',
  rankHarc: RankHarc.dhd,
  druzyna: '6. Zagłębiowska Drużyna Harcerska „Eleusis” im.Stanisława Żółkiewskiego',
  hufiec: huf_zhp_ziemi_bedzinskiej,
  org: Org.zhp,
  email: ['nadia.ossowska.2007@gmail.com', 'nadia.ossowska@icloud.com'],
));
Person NADIA_WYSZOGRODZKA = _register(const Person(
    name: 'Nadia Wyszogrodzka',
    druzyna: '1. Drużyna Specjalnościowa „Grom” im. Cichociemnych Spadochroniarzy Armi Krajowej w Węgrowie',
    hufiec: huf_zhp_doliny_liwca,
    org: Org.zhp
));
Person NATALIA_KLEPACKA = _register(const Person(
    name: 'Natalia Klepacka',
    druzyna: '23. WDH "Wilki" im. Bogusława Ustaborowicza "Żara"',
    hufiec: huf_zhp_wroclaw_polnoc,
    email: ["natalia.klepacka@zhp.net.pl"]
));
Person NATALIA_STODOLNA = _register(const Person(
    name: 'Natalia Stodolna',
    druzyna: '1. DSH „Viatores”',
    hufiec: huf_zhp_zielona_gora,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ['natalia.stodolna@zhp.net.pl']
));
Person NATALIA_WOJTYCZKA = _register(const Person(
    name: 'Natalia Wojtyczka',
    druzyna: '39. DH „Azymut” im. Batalionu „Zośka”',
    hufiec: huf_zhp_ziemi_tyskiej,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ["nataliawojtyczka00@gmail.com"]
));
Person NATASZA_OLSZANSKA = _register(const Person(
    name: 'Natasza Olszańska',
    druzyna: '9. Mielecka Drużyna Harcerska',
    hufiec: huf_zhp_mielec,
    rankHarc: RankHarc.zhpTropicielka,
    email: ["natasza.olszanska1@gmail.com"]
));
Person NINA_KESKA = _register(const Person(
    name: 'Nina K',
    druzyna: '8. PDH „Widmo"',
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ["keska.nina@gmail.com"]
));
Person NINA_MIKLAS = _register(const Person(
    name: 'Nina Mikłas',
    druzyna: '39. DH „Azymut” Im Batalionu „Zośka”',
    hufiec: huf_zhp_ziemi_tyskiej,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ["nina.miklas05@gmail.com"]
));
Person NORBERT_PIATKOWSKI = _register(const Person(
    name: 'Norbert Piątkowski',
    hufiec: huf_zhp_szczecin,
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: []
));
Person NORBERT_SOWA = _register(const Person(
    name: 'Norbert Sowa',
    druzyna: '18. DH „Ogniki”',
    hufiec: huf_zhp_lagiewniki,
    rankHarc: RankHarc.zhpOdkrywca,
    org: Org.zhp,
    email: ["norbert.sowa2010@gmail.com"]
));
Person OLEKSII_OVCHYNNIKOV = _register(const Person(
    name: 'Oleksii Ovchynnikov',
    druzyna: '191. „Żagiew”',
    hufiec: huf_zhp_warszawa_mokotow,
    rankHarc: RankHarc.zhpOdkrywca,
    org: Org.zhp,
    email: ['dobroslaovch@gmail.com']
));
Person OLGA_JAJKO = _register(const Person(
    name: 'Olga Jajko',
    rankInstr: RankInstr.pwd,
    druzyna: '1. Krakowska Drużyna Harcerska HRP',
    org: Org.hrp,
    email: ['olgajajko2004@gmail.com']
));
Person OLGA_LUCZAK = _register(const Person(
    name: 'Olga Łuczak',
    druzyna: '1. DH „Huragan”',
    hufiec: huf_zhp_sieradz,
    org: Org.zhp,
    email: ['oluczak390@gmail.com']
));
Person OLIWIA_MAJDA = _register(const Person(
    name: 'Oliwia Majda',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    druzyna: '47. Bolszewska Gromada Zuchowa „Odważne Pingwiny”',
    hufiec: huf_zhp_wejherowo,
    org: Org.zhp,
    email: ['oliwia.majda@zhp.net.pl']
));
Person OLIWIA_STANCZYK = _register(const Person(
    name: 'Oliwia Stańczyk',
    org: Org.zhp,
    email: ['oliwia.stanczyk@zhp.net.pl']
));
Person OLIWIER_STARCZEWSKI = _register(const Person(
    name: '- Oliwier Starczewski',
    druzyna: '16 GDH „Cichociemni” im. Adama „Pługa” Borysa',
    hufiec: huf_zhp_gdansk_srodmiesie,
    org: Org.zhp,
    email: ['staryoliwierszoli@gmail.com']
));
Person OSKAR_PARDYAK = _register(const Person(name: 'Oskar Pardyak', rankInstr: RankInstr.pwd, rankHarc: RankHarc.zhpHOc, org: Org.zhp));
Person OSKAR_POLONSKI = _register(const Person(
    name: 'Oskar Połoński',
    druzyna: '53. WDSH "Vesper"',
    hufiec: huf_zhp_warszawa_mokotow,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ["oskarpolonski@gmail.com"]
));
Person OSKAR_SAKOWICZ = _register(const Person(
    name: 'Oskar Sakowicz',
    druzyna: '50WDH-y „Sztorm” im. gen. Mariusza Zaruskiego',
    org: Org.sh,
    email: ['oskarsakowicz05@gmail.com']
));
Person PATRYCJA_BINKIEWICZ = _register(const Person(
    name: 'Patrycja Binkiewicz',
    druzyna: '5 SDH „Trawersi”',
    hufiec: huf_zhp_sokolka,
    org: Org.zhp,
    email: ["patrycja.binkiewicz@zhp.net.pl", "patrycjabinkiewicz2@gmail.com"]
));
Person PATRYCJA_KALINOWSKA = _register(const Person(
    name: 'Patrycja Kalinowska',
    rankHarc: RankHarc.zhpPionierka,
    hufiec: huf_zhp_zory,
    org: Org.zhp,
    email: ['patrycja.kalinowska@zhp.pl']
));
Person PATRYCJA_PIETRAS = _register(const Person(
    name: 'Patrycja Pietras',
    druzyna: '6. ZDH „Eleusis”',
    hufiec: huf_zhp_ziemi_bedzinskiej,
    org: Org.zhp,
    email: ['patusiapietras2101@gmail.com']
));
Person PATRYCJA_POLOWCZYK = _register(const Person(
    name: 'Patrycja Polowczyk',
    druzyna: '25 DH Przygoda',
    hufiec: huf_zhp_karkonoski,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ["patrycjapolo09@gmail.com"]
));
Person PATRYCJA_SPYRKA = _register(const Person(
    name: 'Patrycja Spyrka',
    druzyna: '8. PgDSH „Pandora”',
    hufiec: huf_zhp_krakow_pdg,
    org: Org.zhp,
    email: ['patrycjaspyrka13@gmail.com']
));
Person PATRYCJA_SZCZESNA = _register(const Person(name: 'Patrycja Szczęsna', rankInstr: RankInstr.pwd, rankHarc: RankHarc.zhpHOd, hufiec: huf_zhp_warszawa_praga_pn, org: Org.zhp));
Person PATRYCJA_TARCZYNSKA = _register(const Person(
    name: 'Patrycja Tarczyńska',
    druzyna: '92. DH AQUA „Zgórze”',
    hufiec: huf_zhp_garwolin,
    org: Org.zhp,
    email: ["pa.tarczyn@op.pl"]
));
Person PATRYK_GRABOWSKI = _register(const Person(
    name: 'Patryk Grabowski',
    druzyna: '174. WDH-y „Wilki”',
    hufiec: huf_zhp_warszawa_ochota,
    org: Org.zhp,
    email: ['patryk.grabowski@zhp.net.pl']
));
Person PATRYK_OLECH = _register(const Person(
    name: 'Patryk Olech',
    druzyna: '1 JDH „Pościg” im. Jana III Sobieskiego',
    hufiec: 'Południowo-Wschodni Hufiec Harcerzy "Grody" im. gen. bryg. Antoniego Chruściela ps. "Monter"',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhrHOc,
    org: Org.zhr,
    email: ["patryk.olech@zhr.pl"]
));
Person PAULINA_BURDZIK = _register(const Person(name: 'Paulina Burdzik', rankInstr: RankInstr.pwd, hufiec: huf_zhp_krakow_pdg, org: Org.zhp, comment: 'J. niemiecki',));
Person PAULINA_FERENC = _register(const Person(
    name: 'Paulina Ferenc',
    druzyna: '14. DSH „Fenris”',
    hufiec: huf_zhp_lagiewniki,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ["ur.fav.paulinka@gmail.com", "paulaferenc45@gmail.com"]
));
Person PAULINA_LUBOS = _register(const Person(
  name: 'Paulina Lubos',
  druzyna: '4. Niezależna Drużyna Harcerek „Casus”',
  org: Org.sh,
  email: ['4ndhcasus@gmail.com'],
));
Person PAULINA_PODGORSKA = _register(const Person(
    name: 'Paulina Podgórska',
    druzyna: '254 DW „Paloma”',
    hufiec: 'Krapkowice',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ["paulina.podgorska@zhp.pl"]
));
Person PAWEL_KIMEL = _register(const Person(
    name: 'Paweł Kimel',
    email: ['pawel.kimel@gmail.com']
));
Person PAWEL_MARUD = _register(const Person(name: 'Piotr Marud'));
Person PAWEL_SZCZYGIEL = _register(const Person(
    name: 'Paweł Szczygieł',
    druzyna: '15. Radomska Drużyna Harcerska „Paszczaki"',
    hufiec: huf_zhp_radom_miasto,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["pawel.szczygiel@zhp.net.pl"]
));
Person PIOTR_BUKOWSKI = _register(const Person(
    name: 'Piotr Bukowski',
    druzyna: '2. DH „Sokoły”',
    hufiec: huf_zhp_milicz,
    rankHarc: RankHarc.zhpOdkrywca,
    org: Org.zhp,
    email: ["piotr.bukowski@zhp.pl"]
));
Person PIOTR_CHELMINIAK = _register(const Person(
    name: 'Piotr Chełminiak',
    druzyna: 'PWDH „Gloria Mare”',
    hufiec: huf_zhp_poznan_jezyce,
    rankHarc: RankHarc.zhpMlodzik,
    org: Org.zhp,
    email: ["wrutek2000@gmail.com"]
));
Person PIOTR_GASIOR = _register(const Person(
    name: 'Piotr Gąsior',
    druzyna: '44. Drużyna Harcerska „Stella”',
    hufiec: huf_zhp_myslowice,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["patusiapietras2101@gmail.com", "piotr.gasior@zhp.net.pl"]
));
Person PIOTR_KRAKOWIAK = _register(const Person(
    name: 'Piotr Krakowiak',
    druzyna: '25. KDW',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ["epik2006@wp.pl"]
));
Person PIOTR_KUBOWICZ = _register(const Person(
    name: 'Piotr Kubowicz',
    druzyna: '2. NDWP „Płomienie”',
    hufiec: huf_zhp_nowy_sacz,
    email: ['piotr.kubowicz@supersnow.com', 'ocwypyziuleh@gmail.com']
));
Person PIOTR_KWAPIEN = _register(const Person(
    name: 'Piotr Kwapień',
    druzyna: '35 TDH "Ignis" im. Józefy Kantor',
    hufiec: huf_zhp_torun,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ['piotr.kwapien@zhp.net.pl']
));
Person PIOTR_MACIEJ_KABATA = _register(const Person(name: 'Piotr Maciej Kabata'));
Person PIOTR_SOSNOWSKI = _register(const Person(name: 'Piotr Sosnowski', rankInstr: RankInstr.pwd,
  druzyna: 'II. SzDHiZ, 74. Poznańska Drużyna Wędrownicza „Lewe Skrzydło” im. Dywizjonu 303',
  hufiec: huf_zhp_poznan_wilda,
  org: Org.zhp,
));
Person PIOTR_TUROWSKI = _register(const Person(
    name: 'Piotr Turowski',
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ['piotr.turowski@zhp.net.pl']
));
Person PIOTR_URBANIEC = _register(const Person(
  name: 'Piotr Urbaniec',
  rankHarc: RankHarc.zhpWywiadowca,
  hufiec: huf_zhp_ziemi_rybnickiej,
  org: Org.zhp,
  email: ['piotr23042006@gmail.com'],
));
Person PIOTR_ZIEMBIKIEWICZ = _register(const Person(name: 'Piotr Ziembikiewicz', rankInstr: RankInstr.phm));
Person POLA_MARCINKOWSKA = _register(const Person(
    name: 'Pola Marcinkowska',
    druzyna: '2. DH „Mimo wszystko”',
    hufiec: huf_zhp_krosno,
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ['polamarcinkowska2005@gmail.com']
));
Person PRZEMYSLAW_KLUCZKOWSKI = _register(const Person(name: 'Przemysław Kluczkowski'));
Person PRZEMYSLAW_KOWALIK = _register(const Person(
    name: 'Przemysław Kowalik',
    druzyna: '300. PgLDH „Wichura"',
    hufiec: huf_zhp_krakow_pdg,
    rankHarc: RankHarc.dhc,
    email: ["przemek.kowalik.pl@gmail.com"]
));
Person PRZEMYSLAW_MROCZKOWSKI = _register(const Person(
    name: 'Przemysław Mroczkowski',
    druzyna: '16. Drużyna Harcerska im. marsz. J. Piłsudskiego „Niepokonani”',
    hufiec: huf_zhp_bytom,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ['przemyslawom@gmail.com']
));
Person RADOSLAW_JASZCZAK = _register(const Person(
    name: 'Radosław Jaszczak',
    druzyna: '77. PDW CHIMERA',
    hufiec: huf_zhp_poznan_jezyce,
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ["radoslaw.jaszczak@zhp.net.pl"]
));
Person RADOSLAW_RELIDZYNSKI = _register(const Person(
    name: 'Radosław Relidzyński',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    druzyna: 'Warszawska Drużyna Wędrownicza „Halny”',
    hufiec: huf_zhp_warszawa_praga_pn,
    org: Org.zhp
));
Person RAFAL_ANTONICKI = _register(const Person(
    name: 'Rafał Antonicki',
    druzyna: '27. HDW',
    hufiec: huf_zhp_ziemi_mikolajowskiej,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["rafalantonicki@gmail.com"]
));
Person RAFAL_BARAN = _register(const Person(
  name: 'Rafał Baran',
  rankHarc: RankHarc.dhc,
  druzyna: '72. Dąbrowska Drużyna Starszoharcerska „Niebieska Mgła”',
));
Person RAFAL_KOWALSKI = _register(const Person(
  name: 'Radał Kowalski',
  rankHarc: RankHarc.zhpMlodzik,
  hufiec: huf_zhp_rzeszow,
  druzyna: '14. DH im. K.K. Baczyńskiego',
  org: Org.zhp,
));
Person RAFAL_LALIK = _register(const Person(name: 'Rafał Lalik', rankHarc: RankHarc.zhpHOc,
  druzyna: '30. Podgórska Drużyna Harcerska „Zielone Stopy”',
  hufiec: huf_zhp_krakow_pdg,
  org: Org.zhp,
));
Person RAFAL_RECZKIN = _register(const Person(
    name: 'Rafał Reczkin',
    druzyna: '3. DW „Chmara”',
    hufiec: 'Ziemi Tarnogórskiej',
    rankInstr: RankInstr.phm,
    email: ['rafal.reczkin@zhp.net.pl']
));
Person ROBERT_LISZEWSKI = _register(const Person(
    name: 'Robert Liszewski',
    druzyna: "25. Środowiskowa Drużyna Harcerska „Echo” im. Tony'ego Halika",
    hufiec: huf_zhp_sochaczew,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ['liszewskir25@gmail.com']
));
Person ROBERT_MAZUR = _register(const Person(name: 'Robert Mazur', rankHarc: RankHarc.zhpOdkrywca));
Person ROBERT_ROBOTYCKI = _register(const Person(name: 'Robert Rybotycki', rankHarc: RankHarc.zhpOdkrywca, org: Org.zhp,));
Person RYSZARD_LASECKI = _register(const Person(
    name: 'Ryszard Łasecki',
    druzyna: '102. WDH',
    hufiec: huf_zhp_wagrowiec,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['lasecki.rysiu@gmail.com']
));
Person SANDRA_RZESZUREK = _register(const Person(name: 'Sandra Rzeszutek', email: ['sandrarzeszutek@wp.pl']));
Person SARA_WALCZYNSKA_GORA = _register(const Person(name: 'Sara Walczyńska-Góra', rankHarc: RankHarc.zhpPionierka, org: Org.zhp));
Person SEBASTIAN_BINKOWICZ = _register(const Person(
    name: 'Sebastian Bińkowicz',
    email: ['sebastian.binkowicz@zhp.net.pl']
));
Person SEBASTIAN_KOPROWSKI = _register(const Person(
    name: 'Stanisław Koprowski',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    druzyna: '37. Harcerska Drużyna Męska im. Franciszka Drake’a',
    hufiec: huf_zhp_brodnica,
    email: ['sebastian.koprowski@zhp.net.pl']
));
Person SEBASTIAN_SOBOLEWSKI = _register(const Person(
    name: 'Sebastian Sobolewski',
    email: ['sebastian.sobolewski05@gmail.com']
));
Person SEBASTIAN_SUGALSKI = _register(const Person(
  name: 'Sebastian Sugalski',
  rankHarc: RankHarc.zhpHOc,
  rankInstr: RankInstr.pwd,
  druzyna: 'Zielony Szczep 10-ych Koszalińskich Drużyn Harcerskich i Gromad Zuchowych',
  hufiec: huf_zhp_ziemi_koszalinskiej,
  email: ['sugalski29@gmail.com'],
));
Person SEWERYN_WOLINSKI = _register(const Person(name: 'Seweryn Woliński', rankHarc: RankHarc.zhpOdkrywca, org: Org.zhp));
Person SLAWOMIR_MILEWSKI = _register(const Person(
    name: 'Sławomir Milewski',
    rankHarc: RankHarc.zhpHRc,
    rankInstr: RankInstr.phm,
    druzyna: '70. Luzińska Wodna Drużyna Harcerska „Tramontana” im. Tajnej Organizacji Wojskowej „Gryf Pomorski”'
));
Person SOFIJA_GALICKA = _register(const Person(
    name: 'Sofija Galicka',
    druzyna: '8. PgDSH „Pandora”',
    hufiec: huf_zhp_krakow_pdg,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ['galicka.sofija16@gmail.com']
));
Person STANISLAW_WATOR = _register(const Person(
    name: 'Stanisław Wątor',
    druzyna: '19. WDH "Przygoda" im. Ludwika Narbutta',
    hufiec: huf_zhp_warszawa_wola,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ["stanislaw.wator@zhp.pl"]
));
Person STANISLAW_MARCHEWICZ = _register(const Person(
    name: 'Stanisław Marchewicz',
    druzyna: 'Baszta',
    rankInstr: RankInstr.phm,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['stas.marchewicz@gmail.com']
));
Person STANISLAW_WOJCIECHOWSKI = _register(const Person(
    name: 'Stanisław Wojciechowski',
    druzyna: '58 DW "Szuwary"',
    hufiec: huf_zhp_ostrow_wielkopolski,
    org: Org.zhp,
    email: ["stasiu2w2@gmail.com"]
));
Person STANISLAW_WRONSKI = _register(const Person(name: 'Stanisław Wroński'));
Person STEFAN_KRYCZKA = _register(const Person(name: 'Stefan Kryczka', rankHarc: RankHarc.zhpCwik, druzyna: '295. Warszawska Drużyna „Wataha”'));
Person SZYMON_BARCZYK = _register(const Person(
    name: 'Szymon Barczyk',
    druzyna: '60. WDH „Amber”',
    hufiec: huf_zhp_warszawa_ursus_wlochy,
    org: Org.zhp,
    email: ['szbarsz5@gmail.com', 'szymon.barczyk@zhp.net.pl']
));
Person SZYMON_CHORAZY = _register(const Person(
    name: 'Szymon „Durszlak” Chorąży',
    druzyna: '72. WDHS „Uroczysko”',
    hufiec: huf_zhp_warszawa_praga_pn,
    org: Org.zhp
));
Person SZYMON_DRATWINSKI = _register(const Person(
    name: 'Szymon Dratwiński',
    rankHarc: RankHarc.zhpCwik,
    druzyna: '16. Krakowska Drużyna Harcerska',
    hufiec: huf_zhp_krakow_srodmiescie,
    org: Org.zhp,
    email: ['szymon.dratwinski@gmail.com']
));
Person SZYMON_DROPEK = _register(const Person(
    name: 'Szymon Dropek',
    druzyna:'7. Kwidzyńska Drużyna Harcerska',
    hufiec: huf_zhp_kwidzyn,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    org: Org.zhp,
    email: ['szymon111drop@gmail.com', 'szymon.dropek@zhp.net.pl']
));
Person SZYMON_HARAZIM = _register(const Person(
    name: 'Szymon Harazim',
    druzyna: '5. Drużyna Harcerska „Zorza”',
    hufiec: huf_zhp_ziemi_tarnogorskiej,
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ["szymon.harazim@zhp.net.pl"]
));
Person SZYMON_JACKIEWICZ = _register(const Person(
    name: 'Szymon Jackiewicz',
    druzyna: '63. DW „Nagi Tanka”',
    rankHarc: RankHarc.zhpWywiadowca,
    org: Org.zhp,
    email: ['szymbro300@gmail.com']
));
Person SZYMON_JAWOREK = _register(const Person(name: 'Szymon Jaworek',
    druzyna: '17. DH „Gryfne Bajtle”',
    hufiec: huf_zhp_ziemi_tarnogorskiej
));
Person SZYMON_KLIMUNTOWSKI = _register(const Person(
    name: 'Szymon Klimuntowski',
    druzyna: '7. DH "Iskra"',
    hufiec: huf_zhp_ziemi_dzierzoniowskiej,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["klimuntowskiszymon@gmail.com"]
));
Person SZYMON_LANDORF = _register(const Person(
    name: 'Szymon Landorf',
    email: ['szymon.landorf@gmail.com']
));
Person SZYMON_OPLOCKI_NIEMIEC = _register(const Person(
    name: 'Szymon Opłocki-Niemiec',
    hufiec: huf_zhp_warszawa_mokotow,
    druzyna: 'Szczep 156. i 414. WDHiZ',
    org: Org.zhp,
    email: ['szymon.oplocki.niemiec@gmail.com']
));
Person SZYMON_OZOG = _register(const Person(
    name: 'Szymon Ożóg',
    druzyna: '175. RwDW Orientalis',
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ["szymon.ozog@zhp.net.pl"]
));
Person SZYMON_PADOK = _register(const Person(
    name: 'Szymon Padok',
    druzyna: '9 WDH Wataha im. Józefa Gołębiowskiego',
    hufiec: huf_zhp_mysliborz,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["abeber444@gmail.com"]
));
Person SZYMON_PODGORNY = _register(const Person(name: 'Szymon Podgórny',
    druzyna:'19. Pyzdrska Drużyna Wędrownicza „Wataha”, 5 Pyzdrski szczep „Orion”',
    hufiec: huf_zhp_wrzesnia_wrzos,
    org: Org.zhp,
    email: ['szymon.podgorny@zhp.net.pl']
));
Person SZYMON_REKOWSKI = _register(const Person(
    name: 'Szymon Rekowski',
    druzyna: '8 GDH Brzask',
    hufiec: huf_zhp_gdynia,
    org: Org.zhp,
    email: ["szym.rekowski@gmail.com"]
));
Person SZYMON_SITEK = _register(const Person(
    name: 'Szymon Sitek',
    druzyna: '29 DSH „Ignis” w Zgórzu',
    hufiec: huf_zhp_garwolin,
    org: Org.zhp,
    email: ['szymonsitek09@gmail.com']
));
Person SZYMON_ZDZIEBKO = _register(const Person(name: 'Szymon Zdziebko'));
Person TADEUSZ_BOJANOWSKI = _register(const Person(
    name: 'Tadeusz Bojanowski',
    rankHarc: RankHarc.dhc,
    druzyna: '417. ŁDH „Arbor”',
    email: ['tbojanowskit@gmail.com']
));
Person TADEUSZ_BRACHA = _register(const Person(
    name: 'Tadeusz K. Bracha',
    druzyna: '6 DSH Andromeda',
    hufiec: 'Hufiec Oświęcim',
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["tadekbracha@gmail.com"]
));
Person TAMANACO_NORIEGA = _register(const Person(
    name: 'Tamanaco Noriega',
    druzyna: '73. WDH "Custodia"',
    hufiec: huf_zhp_warszawa_praga_pn,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ["tamanaconoriegau@gmail.com"]
));
Person TOMASZ_BUKOWIECKI = _register(const Person(
    name: 'Tomasz Bukowiecki',
    rankHarc: RankHarc.zhpHOc,
    druzyna: '25. Wielopoziomowa Drużyna Harcerska „Brzask” im. Cichociemnych Spadochroniarzy Armii Krajowej',
    hufiec: huf_zhp_legionowo,
    org: Org.zhp,
    email: ['tomasz.bukowiecki@zhp.net.pl']
));
Person TOMASZ_FLORCZAK = _register(const Person(
    name: 'Tomasz Florczak',
    druzyna: '99. Przemyska Drużyna Starszoharcerska',
    hufiec: huf_zhp_ziemi_przemyskiej,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['tflorczak913@gmail.com']
));
Person TOMASZ_GORECKI = _register(const Person(
    name: 'Tomek Górecki',
    email: ["tomekgorecki26@gmail.com"]
));
Person TOMASZ_KOTOWSKI = _register(const Person(
    name: 'Tomasz Kotowski',
    druzyna: '20. DW „Avengers”',
    hufiec: huf_zhp_legionowo,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["tomasz.kotowski@zhp.net.pl"]
));
Person TOMASZ_LUDWIG = _register(const Person(
    name: 'Tomasz Ludwig',
    druzyna: '8. PgDW „Granat”',
    hufiec: huf_zhp_krakow_pdg,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["tomasz.ludwig@zhp.pl"]
));
Person TOMASZ_SMOLKA = _register(const Person(
  name: 'Tomasz Smołka',
  org: Org.zhr,
));
Person TOMASZ_ZAGORSKI = _register(const Person(
    name: 'Tomasz Zagórski',
    rankInstr: RankInstr.phm,
    org: Org.zhp,
    email: ['tomasz.zagorski@zhp.net.pl']
));
Person TOMASZ_ZGORSKI = _register(const Person(
    name: 'Tomasz Zgórski',
    druzyna: '27. Wielopoziomowa Drużyna Harcerska „Eskulapy”',
    hufiec: huf_zhp_jastrzebie_zdroj,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ["tomasz.zgorski@zhp.net.pl"]
));
Person TOSIA_BANASZAK = _register(const Person(
    name: 'Tosia Banaszak',
    druzyna: '14. WDSH „AD ASTRA”',
    rankHarc: RankHarc.zhpTropicielka,
    email: ['banaszak.antosia13@gmail.com']
));
Person TOSIA_KLEPACKA = _register(const Person(
    name: 'Tosia Klepacka',
    druzyna: '89. WDS „W drogę”',
    hufiec: huf_zhp_wroclaw_polnoc,
    rankHarc: RankHarc.zhpTropicielka,
    org: Org.zhp,
    email: ["klepacka.tosia@gmail.com", 'antonina.klepacka@zhp.pl']
));
Person TYMON_TALECKI = _register(const Person(
    name: 'Tymon Talecki',
    druzyna: '1. DSH „Orlęta”',
    hufiec: huf_zhp_gorlice,
    rankHarc: RankHarc.dhc,
    org: Org.zhp,
    email: ['vulturebro323@gmail.com']
));
Person TYMOTEUSZ_JAWORSKI = _register(const Person(
    name: 'Tymoteusz Jaworski',
    druzyna: '60. KDH „Puszczanie”',
    hufiec: huf_zhr_harcerzy_krakow_srodmiescie,
    rankHarc: RankHarc.zhrWywiadowca,
    org: Org.zhr,
    email: ['tymekjaworski36@gmail.com']
));
Person URSZULA_KOWALSKA = _register(const Person(
    name: 'Ula Kowalska',
    druzyna: '47. WDHS „Tajfun”',
    rankHarc: RankHarc.zhpTropicielka,
    org: Org.zhp,
    email: ["kobea9415@gmail.com"]
));
Person WANDA_MARCHEL = _register(const Person(
    name: 'Wanda Marchel',
    rankHarc: RankHarc.zhpOchotniczka,
    druzyna: '13. DH „Szczęściarze”',
    hufiec: huf_zhp_opole,
    org: Org.zhp
));
Person WERONIKA_IWANISZYN = _register(const Person(
    name: 'Weronika Iwaniszyn',
    druzyna: '222. WDS „Biedrony"',
    hufiec: huf_zhp_ziemi_walbrzyskiej,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ["wera.iw03@gmail.com"]
));
Person WERONIKA_KOLCZ = _register(const Person(
    name: 'Weronika Kołcz',
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ["weronika.kolcz@zhp.pl"]
));
Person WERONIKA_MATECKA = _register(const Person(
    name: 'Weronika Matecka',
    druzyna: '31. JGZ „Bordowe Wilczęta"',
    hufiec: huf_zhp_poznan_jezyce,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ["weronika.matecka@zhp.net.pl"]
));
Person WERONIKA_WICHER = _register(const Person(
    name: 'Weronika Wicher',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOc,
    druzyna: '1. KDH im. ks. Alojzego Koziełka',
    org: Org.zhp,
    email: ['weronika.wicher@zhp.net.pl']
));
Person WERONIKA_ZAWIERUCHA = _register(const Person(
    name: 'Weronika Zawierucha',
    druzyna: '43. ZDHS „Parasol”',
    hufiec: huf_zhp_zgierz,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ['zawieruchaweronika570@gmail.com']
));
Person WIKTOR_KARPALA = _register(const Person(
  name: 'Wiktor Karpała',
  rankHarc: RankHarc.zhpHOc,
  rankInstr: RankInstr.pwd,
  druzyna:'74. DH „Desant” im. 1. SBS gen. bryg. Stanisława Sosabowskiego',
  hufiec: huf_zhp_podkrakowski,
  org: Org.zhp,
));
Person WIKTOR_KOWALCZUK = _register(const Person(
    name: 'Wiktor Kowalczuk',
    druzyna: '2. WDH „Aves”',
    hufiec: huf_zhp_olecko,
    email: ["vect0428m66@gmail.com"]
));
Person WIKTORIA_DRGAS = _register(const Person(
    name: 'Wiktoria Drgas',
    druzyna: 'DW Ijupiter',
    hufiec: huf_zhp_zary,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ["wiktoria.drgas@zhp.net.pl"]
));
Person WIKTORIA_LUKASIK = _register(const Person(
    name: 'Wiktoria Łukasik',
    druzyna: '160. WDH „Desertum”',
    hufiec: huf_zhp_warszawa_praga_pd,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ["wiktoria.lukasik@zhp.net.pl", 'w.lukasik.02@wp.pl']
));
Person WIKTORIA_PINKOWSKA = _register(const Person(
    name: 'Wiktoria Pinkowska',
    druzyna: '8. Zgierska Wodna Drużyna Harcerzy Starszych „Nieskończoność”',
    hufiec: huf_zhp_zgierz,
    email: ['wiktoria.pinkowska@zhp.net.pl', 'w.pinkowskaa@gmail.com']
));
Person WIKTORIA_PRUSZYNSKA = _register(const Person(
  name: 'Wiktoria Pruszyńska',
));
Person WIKTORIA_WOJCIK = _register(const Person(
    name: 'Wiktoria Wójcik',
    rankHarc: RankHarc.zhpSamarytanka,
    email: ['wiktoria.wojcik1@zhp.net.pl']
));
Person WINCENTY_DIETRYCH = _register(const Person(name: 'Wincenty Dietrych', rankHarc: RankHarc.dhc));
Person WITOLD_BASIURA = _register(const Person(
    name: 'Witold Basiura',
    druzyna: '1. KDSH „Świt”',
    hufiec: huf_zhp_podkrakowski,
    org: Org.zhp,
    email: ['witold.basiura@gmail.com']
));
Person WITOLD_FIALKOWSKI = _register(const Person(
    name: 'Witold Fiałkowski',
    druzyna: '243. PDHS „Aves”',
    hufiec: huf_zhp_poznan_jezyce,
    rankHarc: RankHarc.zhpWywiadowca,
    org: Org.zhp,
    email: ["witekfia@gmail.com"]
));
Person WITOLD_JAKUBOWSKI = _register(const Person(
    name: 'Witold Jakubowski',
    druzyna: '50. WDW „BOREALIS”',
    hufiec: huf_zhp_warszawa_ursus_wlochy,
    rankHarc: RankHarc.zhpMlodzik,
    org: Org.zhp,
    email: ['shinypokemin.hunterxdddd@gmail.com']
));
Person WOJCIECH_GRUSZCZYNSKI = _register(const Person(name: 'Wojciech Gruszczyński', rankHarc: RankHarc.zhpCwik,
  druzyna: '35. Poznańska Drużyna Harcerska',
  org: Org.zhp,
));
Person WOJCIECH_KITA = _register(const Person(
    name: 'Wojciech Kita',
    druzyna: '10 JDSH "Minerki"',
    hufiec: huf_zhp_jordanow,
    rankHarc: RankHarc.zhpCwik,
    org: Org.zhp,
    email: ["wojtix912@gmail.com"]
));
Person WOJCIECH_KUCHARSKI = _register(const Person(
    name: 'Wojciech Kucharski',
    druzyna: '73. DSH „Aborygeni”',
    org: Org.zhp,
    email: ['kucharskiwojtek4@gmail.com']
));
Person WOJCIECH_GODECKI = _register(const Person(
    name: 'Wojciech Godecki',
    rankInstr: RankInstr.hm,
    druzyna: '„Złota Ósemka” im. Zawiszy Czarnego',
    hufiec: huf_zhp_dabrowa_gornicza,
    email: ['wojciech.godecki@zhp.net.pl']
));
Person WOJCIECH_JUCYK = _register(const Person(
    name: 'Wojciech Jucyk',
    druzyna: '73 DSH „Los Niños”',
    hufiec: huf_zhp_konin,
    rankHarc: RankHarc.zhpOdkrywca,
    org: Org.zhp,
    email: ['wojtek.jucyk.buffon@gmail.com', 'wojciech.jucyk@zhp.net.pl']
));
Person WOJCIECH_TURSKI = _register(const Person(name: 'Wojciech Turski', rankHarc: RankHarc.zhpCwik, org: Org.zhp));
Person WOJCIECH_WALACH = _register(const Person(
  name: 'Wojciech Wałach',
  druzyna: '34. DH „Watra” im. Braci Buchalików',
  hufiec: huf_zhp_ziemi_rybnickiej,
  org: Org.zhp,
  email: ['wojtek.w.2008@gmail.com'],
));
Person WOJCIECH_WOLNIK = _register(const Person(
    name: 'Wojciech Wolnik',
    rankHarc: RankHarc.zhpMlodzik,
    druzyna: '7. Przemeckiej Drużyna Harcerska im. Jana Pawła II',
    hufiec: huf_zhp_wolsztyn,
    org: Org.zhp
));
Person WOJCIECH_ZIELINSKI = _register(const Person(name: 'Wojciech Zielinski', rankHarc: RankHarc.dhc));
Person ZBYSZEK_CHODAKOWSKI = _register(const Person(name: 'Zbyszek Chodakowski', rankHarc: RankHarc.zhpCwik, org: Org.zhp));
Person ZOFIA_FABROWSKA = _register(const Person(
    name: 'Zofia Fabrowska',
    rankHarc: RankHarc.zhpHOd,
    rankInstr: RankInstr.pwd,
    org: Org.zhp,
    email: ['zofia.fabrowska@zhp.net.pl']
));
Person ZOFIA_KOSIDER = _register(const Person(
    name: 'Zosia Kosider',
    druzyna: '1. DH „Wilcza Sfora”',
    hufiec: huf_zhp_ziemi_wodzislawskiej,
    org: Org.zhp,
    email: ['zosiakosider@gmail.com']
));
Person ZOFIA_SZAFRANEK = _register(const Person(
    name: 'Zofia Szafranek',
    rankHarc: RankHarc.zhpPionierka,
    druzyna: '39. Wielopoziomowa Drużyna Harcerska „Leśne Stwory” w Radlinie',
    hufiec: huf_zhp_ziemi_wodzislawskiej,
    org: Org.zhp,
    email: ['zofia.szafranek2008@gmail.com']
));
Person ZOFIA_ZAWADZKA = _register(const Person(
    name: 'Zofia Zawadzka',
    rankHarc: RankHarc.zhpTropicielka,
    hufiec: huf_zhp_warszawa_zoliborz,
    druzyna: '128. WDH',
    org: Org.zhp
));
Person ZOFIA_ZBRUK = _register(const Person(
    name: 'Zofia Zbruk',
    druzyna: '5. PDHS „Wagabunda” im. Kazimierza Nowaka',
    hufiec: huf_zhp_poznan_grunwald,
    org: Org.zhp,
    email: ['anonusiauvu@gmail.com']
));
Person ZUZANNA_ANDRZEJCZAK = _register(const Person(
    name: 'Zuzanna Andrzejczak',
    druzyna: '15. ZWDH „Atlantyda”',
    hufiec: huf_zhp_zgierz,
    email: ['zuzannaandrzejczak12@gmail.com']
));
Person ZUZANNA_BIALA = _register(const Person(
    name: 'Zuzanna Biała',
    email: ['zuzubiala08@gmail.com']
));
Person ZUZANNA_CHMIEL = _register(const Person(
    name: 'Zuzanna Chmiel',
    druzyna: '48. Lubelska Drużyna Harcerska ,,Araukanie"',
    hufiec: huf_zhp_lublin,
    org: Org.zhp,
    email: ['chmiel.zuzanna@zhp.pl']
));
Person ZUZANNA_DUDEK = _register(const Person(
    name: 'Zuzanna Dudek',
    druzyna: '8. Drużyna Harcerska „Tajne Śledzie”',
    hufiec: huf_zhp_olkusz,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ['z.dudek2011@gmail.com', 'zizigames2011@gmail.com']
));
Person ZUZANNA_DZIEDZIC = _register(const Person(
    name: 'Zuzia Dziedzic',
    druzyna: '128 WDH Orion',
    hufiec: huf_zhp_zary,
    org: Org.zhp,
    email: ['z_dziedzic@icloud.com', '5363@e-at.edu.pl']
));
Person ZUZANNA_EJSMONT = _register(const Person(
    name: 'Zuzanna Ejsmont',
    druzyna: '2. WDH „Aves”',
    hufiec: huf_zhp_olecko,
    email: ["vect0428m66@gmail.com"]
));
Person ZUZANNA_GRZESIAK = _register(const Person(
    name: 'Zuzanna Grzesiak',
    hufiec: huf_zhp_kepno,
    org: Org.zhp,
    email: ["gzuzia415@gmail.com"]
));
Person ZUZANNA_GUGALA = _register(const Person(
    name: 'Zuzanna Gugała',
    druzyna: '51 BDW „Silva”',
    hufiec: huf_zhp_bialystok,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ["zuzanna.gugala@zhp.pl"]
));
Person ZUZANNA_JANKOWSKA = _register(const Person(
    name: 'Zuzanna Jankowska',
    druzyna: '12. GWDH „Północ”',
    hufiec: huf_zhp_paluki,
    rankHarc: RankHarc.zhpPionierka,
    org: Org.zhp,
    email: ["niebieskizozolek@gmail.com"]
));

Person ZUZANNA_JAWORSKA = _register(const Person(
    name: 'Zuzanna Jaworska',
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    hufiec: huf_zhp_wroclaw
));
Person ZUZANNA_KOLIS = _register(const Person(
  name: 'Zuzanna Kolis',
  rankHarc: RankHarc.zhpOchotniczka,
  druzyna: '„Wilki”',
  hufiec: huf_zhp_glowno,
  org: Org.zhp,
  email: ['koliszuzia@gmail.com'],
));
Person ZUZANNA_KOWALCZYK = _register(const Person(
    name: 'Zuzanna Kowalczyk',
    rankHarc: RankHarc.zhpOchotniczka,
    hufiec: huf_zhp_stargard,
    druzyna: '1. Choszczeńska Drużyna Starszoharcerska „Regulus” im. Janusza Korczaka',
    org: Org.zhp
));
Person ZUZANNA_MIERZEJEWSKA = _register(const Person(
    name: 'Zuzanna Mierzejewska',
    rankHarc: RankHarc.zhpOchotniczka,
    druzyna: '13. Lubańska Drużyna Starszoharcerska „Brzask”',
    hufiec: huf_zhp_luban,
    org: Org.zhp
));
Person ZUZANNA_NAWROT = _register(const Person(
    name: 'Zuzanna Nawrot',
    druzyna: '9. BGZ „Pszczółki”',
    hufiec: huf_zhp_reduta,
    rankHarc: RankHarc.zhpSamarytanka,
    org: Org.zhp,
    email: ['zuzannanawrot5c@gmail.com']
));
Person ZUZANNA_NIEWEGLOWSKA = _register(const Person(
    name: 'Zuzanna Niewęgłowska',
    druzyna: '307. WDH-EK „Zorza”',
    hufiec: huf_zhp_warszawa_mokotow,
    rankInstr: RankInstr.pwd,
    rankHarc: RankHarc.zhpHOd,
    org: Org.zhp,
    email: ["zuzanna.nieweglowska@zhp.net.pl", 'z.nieweglowska01@gmail.com']
));
Person ZUZANNA_PIWKO = _register(const Person(
    name: 'Zuza Piwko',
    rankHarc: RankHarc.zhpHOc,
    rankInstr: RankInstr.pwd,
    druzyna: '46 Wrocławska Drużyna Harcerska „Arda”',
    hufiec: huf_zhp_wroclaw_wschod,
    org: Org.zhp,
    email: ['zuzanna.piwko@zhp.net.pl']
));
Person ZUZANNA_RELKOWSKA = _register(const Person(
    name: 'Zuzanna Rełkowska',
    druzyna: '5. DH Niebo w Kleszczowie',
    hufiec: huf_zhp_reduta,
    rankHarc: RankHarc.dhd,
    org: Org.zhp,
    email: ["zuzanna.relkowska@wp.pl"]
));
Person ZUZANNA_ROMANISZYN = _register(const Person(
    name: 'Zuzanna Romaniszyn',
    druzyna: '321 Teraz',
    hufiec: huf_zhp_krakow_nowa_huta,
    email: ['zuziarysia19@outlook.com', 'zuziarysia19@gmail.com']
));
Person ZUZANNA_RADKOWSKA = _register(const Person(
    name: 'Zuzanna Radkowska',
    druzyna: '21. ZDH',
    hufiec: huf_zhp_ziemi_zawiercianskiej,
    rankHarc: RankHarc.zhpTropicielka,
    org: Org.zhp,
    email: ['zuzanna.radkowska21.12@gmail.com']
));
Person ZUZANNA_WARCHOL = _register(const Person(name: 'Zuzanna Warchoł', druzyna: '113. TWDH „Pustynna Burza”', org: Org.zhp, hufiec: huf_zhp_szczecin_pogodno));

class Person{

  final String name;
  final RankHarc? rankHarc;
  final RankInstr? rankInstr;
  final String? druzyna;
  final String? hufiec;
  final Org? org;
  final String? comment;
  final List<String> email;

  const Person({
    required this.name,
    this.rankHarc,
    this.rankInstr,
    this.druzyna,
    this.hufiec,
    this.org,
    this.comment,
    this.email = const []
  });

  Map toApiJsonMap() =>
      {
        'name': name,
        'rankHarc': rankHarc?.apiParam,
        'rankInstr': rankInstr?.apiParam,
        'druzyna': druzyna,
        'hufiec': hufiec,
        'org': org?.asParam,
        'comment': comment,
        'email': email.isEmpty ? null : email
      };

  static Person fromApiJsonMap(Map<String, dynamic> json) => Person(
    name: json['name'] as String,
    rankHarc: json['rankHarc'] == null ? null : RankHarc.fromApiParam(json['rankHarc'] as String),
    rankInstr: json['rankInstr'] == null? null : RankInstr.fromApiParam(json['rankInstr'] as String),
    druzyna: json['druzyna'] as String?,
    hufiec: json['hufiec'] as String?,
    org: json['org'] == null ? null : Org.fromParam(json['org'] as String),
    comment: json['comment'] as String?,
    email: (json['email'] as List?)?.cast<String>() ?? [],
  );
}
