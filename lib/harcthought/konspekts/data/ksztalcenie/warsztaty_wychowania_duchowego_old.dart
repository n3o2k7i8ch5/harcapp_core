import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common_attachments.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/warsztaty_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';



const konspekt_kszt_name_warsztaty_wychowania_duchowego_old = 'warsztaty_wychowania_duchowego_old';

const String attach_html_przyklady_poziomow_duchowosci = '<a href="$attach_name_przyklady_poziomow_duchowosci@attachment">$attach_title_przyklady_poziomow_duchowosci</a>';
const String attach_name_przyklady_poziomow_duchowosci = 'przyklady_poziomow_duchowosci';
const String attach_title_przyklady_poziomow_duchowosci = 'Przykłady poziomów duchowości';
KonspektAttachment attach_przyklady_poziomow_duchowosci = KonspektAttachment(
  name: attach_name_przyklady_poziomow_duchowosci,
  title: attach_title_przyklady_poziomow_duchowosci,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego_old/$attach_name_przyklady_poziomow_duchowosci.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego_old/$attach_name_przyklady_poziomow_duchowosci.docx',
  },
);

const String attach_html_mechanizmy_posrednie = '<a href="$attach_name_mechanizmy_posrednie@attachment">$attach_title_mechanizmy_posrednie</a>';
const String attach_name_mechanizmy_posrednie = 'mechanizmy_posrednie';
const String attach_title_mechanizmy_posrednie = 'Mechanizmy pośrednie';
KonspektAttachment attach_mechanizmy_posrednie = KonspektAttachment(
  name: attach_name_mechanizmy_posrednie,
  title: attach_title_mechanizmy_posrednie,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego_old/$attach_name_mechanizmy_posrednie.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego_old/$attach_name_mechanizmy_posrednie.docx',
  },
);

const String attach_html_antyprzyklady = '<a href="$attach_name_antyprzyklady@attachment">$attach_title_antyprzyklady</a>';
const String attach_name_antyprzyklady = 'antyprzyklady';
const String attach_title_antyprzyklady = 'Antyprzykłady';
KonspektAttachment attach_antyprzyklady = KonspektAttachment(
  name: attach_name_antyprzyklady,
  title: attach_title_antyprzyklady,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego_old/$attach_name_antyprzyklady.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego_old/$attach_name_antyprzyklady.docx',
  },
);

const String attach_html_scenariusze = '<a href="$attach_name_scenariusze@attachment">$attach_title_scenariusze</a>';
const String attach_name_scenariusze = 'scenariusze';
const String attach_title_scenariusze = 'Scenariusze';
KonspektAttachment attach_scenariusze = KonspektAttachment(
  name: attach_name_scenariusze,
  title: attach_title_scenariusze,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego_old/$attach_name_scenariusze.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego_old/$attach_name_scenariusze.docx',
  },
);

KonspektMaterial material_zal_przyklady_poziomow_duchowosci = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_przyklady_poziomow_duchowosci”',
    attachmentName: attach_name_przyklady_poziomow_duchowosci,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii i potasować w ramach wyciętych czwórek.',
    amount: 1
);

KonspektMaterial material_zal_mechanizmy_posrednie = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_mechanizmy_posrednie”',
    attachmentName: attach_name_mechanizmy_posrednie,
    additionalPreparation: 'Kartki należy przeciąć na pół wzdłuż przerywanych linii.',
    amount: 1
);

KonspektMaterial material_zal_antyprzyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_antyprzyklady”',
    attachmentName: attach_name_antyprzyklady,
    amount: 1
);

KonspektMaterial material_zal_scenariusze = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_scenariusze”',
    attachmentName: attach_name_scenariusze,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii.',
    amount: 1
);

Konspekt konspekt_kszt_warsztaty_wychowania_duchowego_old = Konspekt.oldFrom(
  konspekt_kszt_warsztaty_wychowania_duchowego,
  attachments: [
    attach_przyklady_poziomow_duchowosci,
    attach_mechanizmy_posrednie,
    attach_antyprzyklady,
    attach_scenariusze
  ],
  materials: [
    material_zal_przyklady_poziomow_duchowosci,
    material_zal_mechanizmy_posrednie,
    material_zal_antyprzyklady,
    material_zal_scenariusze,
  ],
  steps: [

    // Poziomy duchowości
    KonspektStep(
        title: 'Poziomy (warstwy) rozwoju duchowego - sprawdzenie',
        duration: Duration(minutes: 15),
        activeForm: true,
        required: false,
        content: '<p style="text-align:justify;">'
            'Prowadzący dzieli uczestników na pięć grup. Rozdaje każdej grupie po jednym komplecie przygotowanych kartek z załącznika $attach_html_przyklady_poziomow_duchowosci i prosi grupy o <b>posegregowanie kartek na zachowania, postawy, wartości i aksjomaty.</b>'
            '<br>'
            '<br>Gdy dana grupa jest gotowa, zgłasza się do prowadzącego, który podchodzi i sprawdza. Jeśli coś jest nie tak, prowadzący mówi który poziom duchowości wymaga poprawy. Gdy wszystkie grupy są gotowe, niezależnie od poprawności segregacji, prowadzący omawia na forum poprawne przyporządkowanie.'
            '</p>',
        materials: [
          material_zal_przyklady_poziomow_duchowosci,
        ]
    ),

    // Mechanizmy pośrednie
    KonspektStep(
        title: 'Praktyka wychowania duchowego - mechanizmy pośrednie',
        duration: Duration(minutes: 20),
        activeForm: false,
        materials: [
          material_zal_mechanizmy_posrednie,
        ],
        content: '<p style="text-align:justify;">'
            'Prowadzący zaczyna od zadania oczywistego pytania:'
            '<br>'
            '<br><b><i>“Czyli tak: ustaliliśmy czym jest duchowość, jej poziomy i jej integracja, cel wychowania duchowego w ZHP - czyli wystarczy teraz powiedzieć zuchom jakie postawy, harcerzom jakie wartości, a wędrownikom jakie aksjomaty są dobre i essa? Co nie? Czy nie?”</i></b>'
            '<br>'
            '<br>Oczywiście ta propozycja jest absurdalna - celem jest rozpoczęcie dyskusji prowadzącej do wniosku, że od różnych pionów należy oczekiwać różnych celów w rozwoju duchowym.'
            '<br>'
            '<br><b><i>“Duchowość nie jest umiejętnością, dlatego nie należy sądzić że można ją rozwinąć tymi samymi metodami co intelekt, ciało, czy emocje.”</i></b>'
            '<br>'
            '<br>Prowadzący zwraca uwagę, że wychowanie duchowe zaczyna się od sposobu myślenia. Przedstawia trzy punkty wyjścia i przy omawianiu każdego kładzie w widocznym miejscu odpowiadającą mu kartkę z załącznika $attach_html_mechanizmy_posrednie.'
            '</p>'

            '<ol>'

            '<li>'
            '<p style="text-align:justify;">'
            '<b>Duchowość jest najważniejszą sferą człowieka</b>.'
            '<br>Nadaje sens każdemu działaniu.'
            '</p>'
            '</li>'

            '<li>'
            '<p style="text-align:justify;">'
            '<b>Nie istnieje próżnia duchowa</b>.'
            '<br>Jeśli duchowości nie ukształtuja rodzice, harcerstwo, czy Kościół, to zrobi to ulica, reklamy i internet.'
            '</p>'
            '</li>'

            '<li>'
            '<p style="text-align:justify;">'
            '<b>Duchowość nie jest sprawą prywatną. Nie należy jej cenzurować.</b>'
            '<br>Duchowość jest sprawą indywidualną i osobistą, ale dotyczy całego otoczenia, w którym człowiek żyje.'
            '</p>'
            '</li>'
            '</ol>'

            '<p style="text-align:justify;">'
            'Następnie prowadzący przedstawia <b>mechanizmy pośrednie</b>, które wpływają na duchowość. W celu wejścia w interakcję z uczestnikami przedstawia krótkie scenariusze na podstawie których uczestnicy powinni wywnioskować określony mechanizm (podobnie jak poprzednio, gdy uczestnicy poprawnie nazwą mechanizm, prowadzący kładzie w widocznym miejscu odpowiadającą mu kartkę z załącznika $attach_html_mechanizmy_posrednie):'
            '</p>'

            '<ul>'

            '<li>'
            '<p style="text-align:justify;">'
            '<b>[Przykład własny kadry]</b>'
            '<br>'
            '<br><i>Mamy harcerza z domu, gdzie poruszenie tematu światopoglądowego lub politycznego zawsze kończy się gigantyczną kłótnią. Chcemy wychować go w przekonaniu, że warto wyrażać swoje zdanie oraz dyskutować na ważne sprawy, zwłaszcza dotyczące Polski, geopolityki, społeczeństwa i wiary. Czy jeżeli ów harcerz będzie świadkiem jak jego drużynowy prowadzi takie dyskusje ze swoimi kumplami z kadry szczepu, to czy pomoże to w osiągnięciu założonego celu wychowawczego, czy nie? Dlaczego?</i>'
            '</p>'
            '</li>'

            '<li>'
            '<p style="text-align:justify;">'
            '<b>[Wpływ rodziców]</b>'
            '<br>'
            '<br><i>Mamy harcerza, którego chcemy wychować w sumienności i odpowiedzialności za powierzone mu zadania. Kadra drużyny robi w tym kierunku ile może, ale gdy młody wraca do domu, rodzice za niego sprzątają, gotują mu i pozwalają mu nie robić zadań domowych gdy mówi, że jest zmęczony. Czy doprowadzenie do sytuacji w której rodzice zaczynają koordynować swoje działania tym aspekcie wychowania z kadrą drużyny pomoże  w osiągnięciu założonego celu wychowawczego, czy nie? Dlaczego?</i>'
            '</p>'
            '</li>'

            '<li>'
            '<p style="text-align:justify;">'
            '<b>[Wzajemność oddziaływań]</b>'
            '<br>'
            '<br><i>Mamy harcerza z blokowisk z Łódzkiego Widzewa. Jego typowi koledzy albo siedzą w domu i grają na kompie, albo chodzą na mecze, organizują ustawki, dealują marychą i piją wódkę za szkołą. Chcemy wychować go w duchu szacunku dla prawa. Czy zwiększenie wśród jego bliskich znajomych liczby osób, które szanują prawo w tym pomoże, czy nie? Dlaczego?</i>'
            '</p>'
            '</li>'

            '<li>'
            '<p style="text-align:justify;">'
            '<b>[Wspólnota zasad, wspólnota wartości i wspólnota aksjomatu]</b>'
            '<br>'
            '<br><i>Mamy białoruskiego, prawosławnego harcerza, którego najbliższe otoczenie (poza rodziną) jest laickie. Chcemy wychować go w wierze prawosławnej. W harcerstwie część wartości i postaw jest z jego wiarą zgodna, część niekoniecznie. Czy sprawienie, że pozna i polubi ludzi z prawosławnego duszpasterstwa w cerkwii i będzie częścią ich wspólnoty pomoże w osiągnięciu celu wychowawczego? Dlaczego?</i>'
            '</p>'
            '</li>'

            '<li>'
            '<p style="text-align:justify;">'
            '<b>[Kultura, media i technologia]</b>'
            '<br>'
            '<br><i>Mamy harcerkę starszą, która, od kiedy poszła do technikum, zaczęła tak jak jej nowe koleżanki oglądać Netflixa, kiczowate reality-show typu “Trudne sprawy” i słuchać depresyjnej muzyki. W szkole idzie jej średnio, marnuje dużo czasu na fejsie i tik-toku. Chcemy wychować ją do pozytywnego myślenia, zaradności i sumienności. Czy sprawienie, że z Netflixa i “Trudnych spraw” przerzuci się na “Ojca Mateusza” i “Pingwiny z Madagaskaru", oraz że drużyna zainspiruje ją szantami, T.Love i Kaczmarskim, a w miejsce fejsa i tik-toka zacznie czytać Dukaja pomoże w osiągnięciu celu wychowawczego? Dlaczego?</i>'
            '</p>'
            '</li>'

            '<li>'
            '<p style="text-align:justify;">'
            '<b>[Normalizacja]</b>'
            '<br>'
            '<br><i>Jeden z naszych harcerzy, pochodzi z Białorusi i jest wychowywany w wierze prawosławnej. Na razie jest jednak zbyt młody, aby w pełni rozumieć sens i esencję swojej wiary. Czy jeśli ów harcerz będzie śpiewał z kolegami prawosławne piosenki dla dzieci, zaś w harcówce będzie wisiała ikona świętego Jerzego, to czy pomoże mu to w przyszłości poważnie potraktować i zrozumieć swoją wiarę? Dlaczego?</i>'
            '</p>'
            '</li>'

            '</ul>'

            '<p style="text-align:justify;">'
            'Jako ostatni element, już bez scenariusza, prowadzący opisuje zjawisko "<b>trzeciego miejsca</b>", z którym wychowanek może być zwiazany, które może budować jego tożsamość, które nie jest ani jego pracą (obowiazkiem), ani jego domem. Miejscem takim może być wspólnota religijna, drużyna, zespół muzyczny, czy hipisowski skłot.'
            '<br>'
            '<br>Na końcu prowadzący może dodać, że wszystkie te mechanizmy nie są wzięte z sufitu - są obecne w <b>stopniach harcerskich</b>.'
            '</p>',
    ),

    KonspektStep(
        title: 'Praktyka wychowania duchowego - Metanarracja',
        duration: Duration(minutes: 10),
        activeForm: false,
        materials: [
          material_zal_mechanizmy_posrednie,
        ],
        content: '<p style="text-align:justify;">'
            'Prowadzący opisuje ostatni pośredni mechanizm kształtowania duchowości, czyli <b>Metanarrację</b> na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci. Podobnie jak w przypadku poprzednich mechanizmów, do pozostałych dodaje przy tym odpowiadającą kartkę z załącznika $attach_html_mechanizmy_posrednie'
            '<br>'
            '<br><i>Metanarracja jest szczególnie silnym mechanizmem w momencie <b>rozpoczęcia integracji świadomej</b>, jednak gra rolę także później. Jest to opowieść, nadająca człowiekowi tożsamość, sens i cel.'
            '<br>'
            '<br>Na przykład:</i>'
            '</p>'

            '<ul>'
            '<li><p style="text-align:justify;"><i>“Bóg umarł z miłości do każdego człowieka. Za mnie także. Tego doświadczenia raz poznanego nie da się zakopać - jest tak głębokie i dojmujące, że muszę się nim podzielić z każdym człowiekiem.”</i></p></li>'
            '<li><p style="text-align:justify;"><i>“Jesteśmy na skraju katastrofy klimatycznej - jeżeli nie zrobimy czegoś natychmiast, cały świat spłonie i na Ziemi nie będzie się dało dłużej żyć. Muszę działać. Natychmiast.”</i></p></li>'
            '<li><p style="text-align:justify;"><i>“Jestem Polakiem. Spadkobiercą tysiącletniego narodu i wielo-tysiącletniej cywilizacji judeo-chrześcijańskiej. Potomkiem poległych w obronie ojczyzny mężów i kobiet. Muszę od siebie wymagać, by kiedyś dźwignąć naszą polską, poszarpaną państwowość - w obecnej sytuacji geopolitycznej to jest być albo nie być polskiego narodu.”</i></p></li>'
            '<li><p style="text-align:justify;"><i>“Społeczeństwo jest rasistowskie, mizoginiczne i homofobiczne do szpiku kości. Codziennie przez falę hejtu i działań eksterminacyjnych giną niewinne kobiety, geje, osoby trans i inni ludzie LGBTQIAP2+. Muszę coś z tym zrobić. Muszę manifestować, zmienić język, obalić patriarchat i heteronormatywność, zmienić społeczeństwo nawet jeśli oznaczałoby to poświęcenie temu całego swojego życia. Krew się leje w tym momencie.”</i></p></li>'
            '</ul>'

            '<p style="text-align:justify;">'
            'Prowadzący zwraca uwagę, że harcerstwo też może nosić znamiona elementów <b>metanarracji</b>, szczególnie dla młodej kadry i instruktorów, którzy wierzą, że na ich barkach spoczywa wychowanie i szczęście młodych ludzi.'
            '<br>'
            '<br>Warto także zwrócić uwagę, że harcerstwo może nosić znamiona subkutlury: ma swoje obrzędy, symbole, wartości i ścisłe gorono. Widać to przykładowo po harcerzach, którzy chodzą na każdą zbiórkę, jeżdżą na każdy wyjazd, uczą się po nocach grać Kaczmarskiego na gitarze, a do szkoły w bojówkach i harcerskim pasie. Owo zaangażowanie i tożsamość może być niezwykle efektywnym mechanizmem kształtowania duchowości.'
            '</p>',
    ),

    // Antyprzykłady
    KonspektStep(
        title: 'Antyprzykłady',
        duration: Duration(minutes: 30),
        activeForm: false,
        materials: [
          material_zal_antyprzyklady,
        ],
        content: '<p style="text-align:justify;">'
            'Prowadzący dzieli uczestników na dwie grupy i daje im po jednej kartce z załącznika $attach_html_antyprzyklady. Zadaniem uczestników jest szczegółowo przeanalizować opisaną w nim postać i wskazać jakie są problemy z duchowością, którą kształtuje u swoich wychowanków opisana postać.'
            '</p>',
    ),

    // Scenariusze
    KonspektStep(
        title: 'Scenariusze w grupach',
        duration: Duration(minutes: 40),
        activeForm: true,
        content: '<p style="text-align:justify;">'
            'Prowadzący dzieli uczestników na grupy po ok. 4 osób. Każda z grup otrzymuje po 2-4 scenariusze z $attach_html_scenariusze i w swoim gronie je omawia. Celem omówienia każdego scenariusza jest zaproponowanie rozwiązania zgodnego z harcerskimi celami wychowania duchowego. Na jeden scenariusz grupa powinna poświęcić 10-15 min. Ważne, by prowadzący zaznaczył, że <b>grupy nie muszą osiągnąć jednomyślności</b>.'
            '<br>'
            '<br>Po zakończeniu dyskusji grupy referują scenariusze i wnioski z nich płynące na forum wszystkich uczestników. Jeżeli któryś scenariusz zakończył się różnicą stanowisk dyskutujących, może zostać poruszony wspólnie przez wszystkich uczestników.'
            '</p>',
        materials: [
          material_zal_scenariusze,
        ]
    ),
  ]
);