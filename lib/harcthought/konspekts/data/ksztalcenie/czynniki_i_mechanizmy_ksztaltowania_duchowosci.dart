import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/poradnik/data.dart';
import 'package:harcapp_core/values/people.dart';

const konspekt_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci = 'czynniki_i_mechanizmy_ksztaltowania_duchowosci';

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
    FileFormat.pdf: 'ksztalcenie/$konspekt_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci/$attach_name_scenariusze_czynnikow_duchowosci.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci/$attach_name_scenariusze_czynnikow_duchowosci.docx',
  },
);


// Materials

KonspektMaterial material_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci = KonspektMaterial(
    name: 'Wydrukowany $attach_title_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci',
    attachmentName: attach_name_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
    amount: 2
);

KonspektMaterial material_scenariusze_czynnikow_duchowosci = KonspektMaterial(
  name: 'Dostępny załącznik “$attach_title_scenariusze_czynnikow_duchowosci”',
  attachmentName: attach_name_scenariusze_czynnikow_duchowosci,
  amount: 1
);

KonspektMaterial material_totem = KonspektMaterial(
    name: 'Totem do chwytania (np. czapka, chusta harcerska, maskotka)',
    amount: 1
);

KonspektMaterial material_nagroda = KonspektMaterial(
  name: 'Nagroda dla zwyciezkiego zespołu (np. paczka żelków)',
  amount: 1
);

// Konspekt

Konspekt czynniki_i_mechanizmy_ksztaltowania_duchowosci = Konspekt(
  name: konspekt_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
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
  attachments: [
    attach_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
    attach_scenariusze_czynnikow_duchowosci,
  ],
  materials: [
    material_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
    material_scenariusze_czynnikow_duchowosci,
    material_totem,
    material_nagroda,
  ],
  summary: 'Uczestnicy rozgrywają między sobą familiadę, by na podstawie krótkich historii określić, które czynniki rozwoju duchowości są w nich opisane.',
  steps: [

    KonspektStep(
        title: 'Czynniki duchowości - wyjaśnienie',
        duration: Duration(minutes: 5),
        activeForm: false,
        materials: [
          material_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
        ],
        content: '<p style="text-align:justify;">'
            'Prowadzący, na podstawie załącznika $attach_html_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci wyjaśnia uczestnikom czym są czynniki duchowości.'
            '<br>'
            '<br>Kwestie te są opisane w części "wstęp", oraz "analogie" poradnika i wystarczy je opowiedzieć uczestnikom własnymi słowami.'
            '</p>'
    ),

    KonspektStep(
        title: 'Tłumaczenie zasad',
        duration: Duration(minutes: 5),
        activeForm: false,
        content: '<p style="text-align:justify;">'
            'Prowadzący wyjaśnia uczestnikom zasady gry, ktorą za chwilę rozegrają:'
            '<br>'
            '<br>Uczestnicy zostaną podzieleni na dwie grupy. Co turę grupy będą wyznaczały kolejnego swojego uczestnika, ktory będzie ich reprezentował. Następnie prowadzący przeczyta którką historię.'
            '<br>'
            '<br>Gdy prowadzący skończy czytać,  będą mieli za zadanie określić, ktore czynniki rozwoju duchowego są w niej opisane.'
            '</p>'
    ),

    KonspektStep(
        title: 'Podział na grupy',
        duration: Duration(minutes: 5),
        activeForm: false,
        content: '<p style="text-align:justify;">'
            'Prowadzący dzieli uczestników na dwie grupy.'
            '</p>'
    ),

    KonspektStep(
        title: 'Zapoznanie się uczestników z poradnikami',
        duration: Duration(minutes: 10),
        activeForm: false,
        content: '<style="text-align:justify;">'
            'Prowadzący wręcza każdej z grup po jednym egzemplarzu poradnika $attach_html_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci.'
            '<br>'
            '<br>Jeśli poradnik jest wydrukowany w formie luźnych kartek, uczestnicy mogą czytać "każdy po jednej kartce", po czym się nimi okrężnie wymieniać.'
            '<br>'
            '<br>Uczestnicy mają 10 minut na zapoznanie się z poradnikiem. Gdy to zrobią, mogą zostawić go na widoku, by móc do niego wracać w trakcie gry.'
            '</p>'
    ),

    KonspektStep(
        title: 'Familiada',
        duration: Duration(minutes: 40),
        activeForm: true,
        materials: [
          material_scenariusze_czynnikow_duchowosci,
          material_totem,
        ],
        content: '<p style="text-align:justify;">'
            'Prowadzący prosi uczestników, by zajęli w grupach dwie strony wspólnej przestrzeni. Sam prowadzący staje na srodku i kładzie ok. 1-2 metry od siebie totem, tak, by każda grupa miała do niego taki sam dystans.'
            '<br>'
            '<br>Uczestnicy ustawiają się w dwóch "kolejkach", a pierwsza osoba w każdej z kolejek zostaje pierwszym <b>reprezentantem</b> swojej grupy.'
            '<br>'
            '<br>Co turę prowadzący odczytuje kolejną historię z załącznika $attach_html_scenariusze_czynnikow_duchowosci. Gdy skończy czytać, robi krótką przerwę i zadaje pytanie zapisane pod historią.'
            '<br>'
            '<br>W tym momencie reprezentanci każdej z grup mogą wystartować w kierunku totemu. Ten, który pierwszy dotknie totemu, ma prawo odpowiedzieć na pytanie.'
            '<br>'
            '<br>Udzielić odpowiedzi należy na pytanie zadane przez prowadzacego, który następnie pyta o to, "który czynnik duchowości jest opisany w opowiedzianej historii?".'
            '<br>'
            '<br>Jeśli reprezentant odpowie poprawnie, jego drużyna otrzymuje jeden punkt. Jeśli odpowiedź jest błędna, prawo do odpowiedzi na to pytanie ma reprezentant drużyny przeciwnej i jeśli mu się uda, to jego drużyna otrzymuje punkt.'
            '<br>'
            '<br>Po każdej turze reprezentanci wracają na końce swoich kolejek, a kolejna osoba z przodu kolejki zostaje reprezentantem swojej grupy.'
            '<br>'
            '<br>Gdy reprezentanci wrócą na swoje miejsca, mogą z prowadzącym wspólnie <b>omówić niejasności</b> wynikające z przeczytanej historii. Następnie prowadzący może jeszcze zapytać o to, <b>jakiego poziomu (warstwy) duchowości</b> dotyczyła przeczytana historia, jednak za to pytanie nie przewidziane są punkty.'
            '<br>'
            '<br>Gra trwa do momentu, gdy prowadzący przeczyta wszystkie historie.'
            '<br>'
            '<br>Warto, aby prowadzący nie czytał historii po kolei, jako że są ułożone w tej samej kolejności, co czynniki opisane w poradnikach.'
            '</p>'
    ),

    KonspektStep(
        title: 'Wręcznie nagrody',
        duration: Duration(minutes: 5),
        activeForm: false,
        materials: [
          material_nagroda,
        ],
        content: '<p style="text-align:justify;">'
            'Prowadzący zlicza punkty każdej z grup i wyłania zwycięzką grupę, następnie wręcza nagrodę.'
            '</p>'
    ),

  ]
);