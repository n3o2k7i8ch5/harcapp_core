import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/warsztaty_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/poradnik/data.dart';
import 'package:harcapp_core/values/people.dart';

const konspekt_kszt_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci = 'czynniki_i_mechanizmy_ksztaltowania_duchowosci';

// Attachments

const String attach_html_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci = '<a href="$attach_name_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci@attachment">$attach_title_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci</a>';
const String attach_name_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci = 'poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci';
const String attach_title_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci = 'Poradnik "$poradnik_title_czynniki_i_mechanizmy_ksztaltowania_duchowosci"';
KonspektAttachment attach_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci = KonspektAttachment(
  name: attach_name_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
  title: attach_title_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
  assets: {
    FileFormat.urlPdf: urlToPoradnikFile(poradnik_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci, "$poradnik_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci.pdf"),
    FileFormat.urlDocx: urlToPoradnikFile(poradnik_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci, "$poradnik_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci.docx"),
  },
);

const String attach_html_scenariusze_czynnikow_duchowosci = '<a href="$attach_name_scenariusze_czynnikow_duchowosci@attachment">$attach_title_scenariusze_czynnikow_duchowosci</a>';
const String attach_name_scenariusze_czynnikow_duchowosci = 'scenariusze_czynnikow_duchowosci';
const String attach_title_scenariusze_czynnikow_duchowosci = 'Scenariusze czynników duchowości';
const KonspektAttachment attach_scenariusze_czynnikow_duchowosci = KonspektAttachment(
  name: attach_name_scenariusze_czynnikow_duchowosci,
  title: attach_title_scenariusze_czynnikow_duchowosci,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci/$attach_name_scenariusze_czynnikow_duchowosci.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci/$attach_name_scenariusze_czynnikow_duchowosci.docx',
  },
);

List<KonspektAttachment> attach_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci = [
  attach_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
  attach_scenariusze_czynnikow_duchowosci,
];

// Materials

KonspektMaterial material_zal_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci = KonspektMaterial(
    name: 'Wydrukowany $attach_title_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci',
    attachmentName: attach_name_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
    amount: 2
);

KonspektMaterial material_zal_scenariusze_czynnikow_duchowosci = KonspektMaterial(
  name: 'Dostępny załącznik “$attach_title_scenariusze_czynnikow_duchowosci”',
  attachmentName: attach_name_scenariusze_czynnikow_duchowosci,
  amount: 1
);

KonspektMaterial material_zetony = KonspektMaterial(
    name: 'Żetony (np. zapałki, akrylowe kryształki, pieniądze z monopoly)',
    amount: 200
);

KonspektMaterial material_nagroda = KonspektMaterial(
  name: 'Nagroda dla zwyciezkiego zespołu (np. paczka żelków)',
  amount: 1
);

List<KonspektMaterial> materials_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci = [
  material_zal_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
  material_zal_scenariusze_czynnikow_duchowosci,
  material_zetony,
  material_nagroda,
];

// Steps
List<KonspektStep> steps_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci = [

  KonspektStep(
      title: 'Wyjaśnienie merytoryczne',
      duration: Duration(minutes: 5),
      activeForm: KonspektStepActiveForm.static,
      materials: [
        material_zal_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
      ],
      content: '<p style="text-align:justify;">'
          'Prowadzący, na podstawie załącznika $attach_html_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci wyjaśnia uczestnikom czym są czynniki duchowości.'
          '<br>'
          '<br>Kwestie te są opisane w części "wstęp" poradnika i wystarczy je opowiedzieć uczestnikom własnymi słowami.'
          '</p>'
  ),

  KonspektStep(
      title: 'Zasady postaw na milion',
      duration: Duration(minutes: 5),
      activeForm: KonspektStepActiveForm.static,
      content: '<p style="text-align:justify;">'
          'Prowadzący wyjaśnia uczestnikom zasady gry, ktorą za chwilę rozegrają:'
          '<br>'
          '<br>Uczestnicy zostaną podzieleni na grupy. Każda grupa otrzyma na początku 5 żetonów i karty z możliwymi do obstawienia odpowiedziami dotyczącymi czynników duchowości.'
          '<br>'
          '<br>Co turę prowadzący będzie czytał krótką historię. Gdy skończy, każda grupa będzie miała możliwość zastanowić się, które czynniki rozwoju duchowego są w niej opisane - może być ich więcej niż jeden.'
          '<br>'
          '<br>Gdy grupy się zastanowią, mogą na każdej z kart położyć od 0 do 3 żetonów, obstawiając prawidłowe odpowiedzi. Gdy żetony zostaną rozdysponowane na kartach, grupy pokazują sobie nazwajem obstawione karty i prowadzący odczytuje odpowiedzi. Dobrze obstawione żetony są podwajane, źle obstawione są zabierane.'
          '<br>'
          '<br>Grupa, która zdobędzie najwięcej punktów, wygrywa.'
          '</p>'
  ),

  KonspektStep(
      title: 'Podział na grupy',
      duration: Duration(minutes: 5),
      activeForm: KonspektStepActiveForm.active,
      content: '<p style="text-align:justify;">'
          'Prowadzący dzieli uczestników na dwie grupy.'
          '</p>'
  ),

  KonspektStep(
      title: 'Zapoznanie się z poradnikami',
      duration: Duration(minutes: 10),
      activeForm: KonspektStepActiveForm.static,
      content: '<style="text-align:justify;">'
          'Prowadzący wręcza każdej z grup po jednym egzemplarzu poradnika $attach_html_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci. Ważne, aby dało się go rozłożyć na osobne kartki - na tych kartkach każda grupa będzie kładła swoje żetony.'
          '<br>'
          '<br>Uczestnicy mają czas, aby zapoznać się z treściami kartek. Mogą przeczytać je sobie na głos, po cichu na raz, każdy po jednej kartce, po czym się nimi okrężnie wymieniać.'
          '<br>'
          '<br>Gdy to zrobią, uczestnicy kładą kartki w rzędzie przed sobą na widoku, by móc do nich wracać w trakcie gry oraz obstawiać kartki z poprawnymi czynnikami za pomocą żetonów.'
          '</p>'
  ),

  KonspektStep(
      title: 'Postaw na milion',
      duration: Duration(minutes: 40),
      activeForm: KonspektStepActiveForm.active,
      materials: [
        material_zal_scenariusze_czynnikow_duchowosci,
        material_zetony,
      ],
      content: '<p style="text-align:justify;">'
          'Co turę prowadzący odczytuje kolejną historię z załącznika $attach_html_scenariusze_czynnikow_duchowosci. Gdy skończy czytać, zadaje pytanie punktowane o to, "który czynnik duchowości jest opisany w opowiedzianej historii?".'
          '<br>'
          '<br>Grupy obstawiają swoje odpowiedzi. Gdy wszyscy skończą obstawiać, odsłaniają je i prowadzący odczytuje poprawne odpowiedzi.'
          '<br>'
          '<br>Następuje chwila na wspólne <b>omówienie niejasności</b> wynikających z przeczytanej historii i udzielonych odpowiedzi. Jeśli jakaś drużyna obstawi niepunktowaną odpowiedź, ale będzie w stanie przekonać prowadzącego, że mają oni rację, prowadzący może nie zabierać im żetonów za to obstawienie.'
          '<br>'
          '<br>Po wyjaśnieniu niejasności, prowadzący przyznaje żetony za poprawne odpowiedzi i zabiera żetony za błędne wskazania.'
          '<br>'
          '<br>Następnie, jeśli jest na to czas, prowadzący może jeszcze zapytać o to, <b>jakiego poziomu (warstwy) duchowości</b> dotyczyła przeczytana historia, jednak za to pytanie nie przewidziane są punkty.'
          '<br>'
          '<br>Gra trwa do momentu, gdy prowadzący przeczyta wszystkie historie, lub aż skończy się czas.'
          '<br>'
          '<br>Warto, aby prowadzący nie czytał historii po kolei, jako że są ułożone w tej samej kolejności, co czynniki opisane w poradnikach.'
          '</p>'
  ),

  KonspektStep(
      title: 'Wręcznie nagrody',
      duration: Duration(minutes: 5),
      activeForm: KonspektStepActiveForm.static,
      materials: [
        material_nagroda,
      ],
      content: '<p style="text-align:justify;">'
          'Prowadzący zlicza punkty każdej z grup i wyłania zwycięzką grupę, następnie wręcza nagrodę.'
          '</p>'
  ),

];

// Konspekt
Konspekt konspekt_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci = Konspekt(
  name: konspekt_kszt_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
  title: 'Czynniki i mechanizmy kształtowania duchowości',
  category: KonspektCategory.ksztalcenie,
  type: KonspektType.zajecia,
  spheres: {},
  metos: [Meto.kadra],
  coverAuthor: 'Freepik (freepik)',
  author: DANIEL_IWANICKI,
  aims: [
    'Przedstawienie uczestnikom czynników duchowości.',
    'Przedstawienie uczestnikom mechanizmów kształtowania duchowości.',
  ],
  attachments: attach_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
  materials: materials_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
  summary: 'Uczestnicy rozgrywają między sobą bieganą familiadę, by na podstawie krótkich historii określić, które czynniki rozwoju duchowości są w nich opisane.',
  steps: steps_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
  partOf: konspekt_kszt_warsztaty_wychowania_duchowego
);