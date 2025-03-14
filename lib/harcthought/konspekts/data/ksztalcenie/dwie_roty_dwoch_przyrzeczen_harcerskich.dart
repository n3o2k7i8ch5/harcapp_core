import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

import '../common_attachments.dart';
import '../harcerskie/dwie_roty_dwoch_przyrzeczen_harcerskich.dart';

const konspekt_kszt_name_dwie_roty_dwoch_przyrzeczen_harcerskich = 'dwie_roty_dwoch_przyrzeczen_harcerskich';

const String attach_html_prawo_harcerskie = '<a href="$attach_name_prawo_harcerskie@attachment">$attach_title_prawo_harcerskie</a>';
const String attach_name_prawo_harcerskie = 'prawo_harcerskie';
const String attach_title_prawo_harcerskie = 'Prawo Harcerskie';
const KonspektAttachment attach_prawo_harcerskie = KonspektAttachment(
  name: attach_name_prawo_harcerskie,
  title: attach_title_prawo_harcerskie,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_dwie_roty_dwoch_przyrzeczen_harcerskich/$attach_name_prawo_harcerskie.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_dwie_roty_dwoch_przyrzeczen_harcerskich/$attach_name_prawo_harcerskie.docx',
  },
);

const String attach_html_przyrzeczenie_harcerskie = '<a href="$attach_name_przyrzeczenie_harcerskie@attachment">$attach_title_przyrzeczenie_harcerskie</a>';
const String attach_name_przyrzeczenie_harcerskie = 'przyrzeczenie_harcerskie';
const String attach_title_przyrzeczenie_harcerskie = 'Przyrzeczenie Harcerskie';
const KonspektAttachment attach_przyrzeczenie_harcerskie = KonspektAttachment(
  name: attach_name_przyrzeczenie_harcerskie,
  title: attach_title_przyrzeczenie_harcerskie,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_dwie_roty_dwoch_przyrzeczen_harcerskich/$attach_name_przyrzeczenie_harcerskie.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_dwie_roty_dwoch_przyrzeczen_harcerskich/$attach_name_przyrzeczenie_harcerskie.docx',
  },
);

const String attach_html_jak_przeprowadzic_przyrzeczenie = '<a href="$attach_name_jak_przeprowadzic_przyrzeczenie@attachment">$attach_title_jak_przeprowadzic_przyrzeczenie</a>';
const String attach_name_jak_przeprowadzic_przyrzeczenie = 'jak_przeprowadzic_przyrzeczenie';
const String attach_title_jak_przeprowadzic_przyrzeczenie = 'Jak przeprowadzić Przyrzeczenie';
const KonspektAttachment attach_jak_przeprowadzic_przyrzeczenie = KonspektAttachment(
  name: attach_name_jak_przeprowadzic_przyrzeczenie,
  title: attach_title_jak_przeprowadzic_przyrzeczenie,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_dwie_roty_dwoch_przyrzeczen_harcerskich/$attach_name_jak_przeprowadzic_przyrzeczenie.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_dwie_roty_dwoch_przyrzeczen_harcerskich/$attach_name_jak_przeprowadzic_przyrzeczenie.docx',
  },
);

const String attach_html_scenariusze = '<a href="$attach_name_scenariusze@attachment">$attach_title_scenariusze</a>';
const String attach_name_scenariusze = 'scenariusze';
const String attach_title_scenariusze = 'Scenariusze';
const KonspektAttachment attach_scenariusze = KonspektAttachment(
  name: attach_name_scenariusze,
  title: attach_title_scenariusze,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_dwie_roty_dwoch_przyrzeczen_harcerskich/$attach_name_scenariusze.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_dwie_roty_dwoch_przyrzeczen_harcerskich/$attach_name_scenariusze.docx',
  },
);

Konspekt konspekt_kszt_dwie_roty_dwoch_przyrzeczen_harcerskich = Konspekt(
    name: konspekt_kszt_name_dwie_roty_dwoch_przyrzeczen_harcerskich,
    title: 'Dwie roty dwóch przyrzeczeń',
    additionalSearchPhrases: [
      'przyrzeczenie harcerskie',
    ],
    category: KonspektCategory.ksztalcenie,
    type: KonspektType.zajecia,
    spheres: {},
    metos: [Meto.kadra],
    coverAuthor: 'Daniel Iwanicki',
    author: DANIEL_IWANICKI,
    aims: [
      'Przedstawienie uczestnikom roli Przyrzeczenia Harcerskiego w procesie wychowawczym.',
      'Przedstawienie uczestnikom metody na określenie treści Przyrzeczenia Harcerskiego, które składał będzie harcerz.',
      'Przedstawienie uczestnikom różnic wychowawczych wynikających z różnych wersji złożonego Przyrzeczenia Harcerskiego.',
      'Przedstawienie uczestnikom rozwiązań na część powszechnych problemów związanych z przyjęciem dwóch treści Przyrzeczenia Harcerskiego.',
    ],
    attachments: [
      attach_cel_wychowania_duchowego_zhp_statut,
      attach_cel_wychowania_duchowego_zhp_uchwala,
      attach_prawo_harcerskie,
      attach_przyrzeczenie_harcerskie,
      attach_jak_przeprowadzic_przyrzeczenie,
      attach_scenariusze,
    ],
    materials: [
      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_cel_wychowania_duchowego_zhp_statut”',
          attachmentName: attach_name_cel_wychowania_duchowego_zhp_statut,
          amount: 2
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_cel_wychowania_duchowego_zhp_uchwala”',
          attachmentName: attach_name_cel_wychowania_duchowego_zhp_uchwala,
          amount: 2
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_prawo_harcerskie”',
          attachmentName: attach_name_prawo_harcerskie,
          amount: 2
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_przyrzeczenie_harcerskie”',
          attachmentName: attach_name_przyrzeczenie_harcerskie,
          amount: 2
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_jak_przeprowadzic_przyrzeczenie”',
          attachmentName: attach_name_jak_przeprowadzic_przyrzeczenie,
          amount: 2,
          additionalPreparation: 'Kartki pociąć wzdłuż przerywanych linii i potasować w ramach każdego zestawu.'
      ),

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_scenariusze”',
        attachmentName: attach_name_scenariusze,
      )

    ],
    summary: 'Uczestnicy warsztatów poznają rolę PH, różnice i ich konsekwencje między dwiema rotami PH, oraz praktyczne metody pracy z PH w drużynach.',
    steps: [

      KonspektStep(
          title: 'Wstęp',
          duration: Duration(minutes: 1),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący rozpoczyna krótkim wyjaśnieniem tego, co będzie na tych warsztatach:'
              '<br>'
              '<br><i>“Mniej więcej przez pierwszą połowę będzie niewiele o samym Przyrzeczeniu Harcerskim, ale jest to zabieg celowy. Aby dobrze zrozumieć jaką pełni rolę, jak się nim posługiwać i co wynika z jego obecnego kształtu, najlepiej jest uporządkować kilka fundamentalnych, kluczowych dla całego wychowania harcerskiego aspektów związanych z duchowością i wówczas pozwolić, aby Przyrzeczenie wjechało na gotowe.”</i>'
              '</p>'
      ),

      KonspektStep(
          title: 'Po co jest harcerstwo?',
          duration: Duration(minutes: 3),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący rozpoczyna od pytania w zasadzie retorycznego: <i>“Po co jest harcerstwo?”</i>.'
              '<br>'
              '<br>Naturalnie, odpowiedź wynika z misji ZHP: <b>Harcerstwo jest po to, żeby wychować młodego człowieka.</b>'
              '<br>'
              '<br>Prowadzący może pozwolić na krótką dyskusję na ten temat, ale powinien tak nią moderować, aby w końcu padła prawidłowa odpowiedź.'
              '</p>'
      ),

      KonspektStep(
          title: 'Kto decyduje, do czego wychowujemy?',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący rzuca kolejne pytanie: <i>“Kto decyduje o tym, do czego wychowujemy młodego człowieka w harcerstwie?”</i>.'
              '<br>'
              '<br>Odpowiedzi od uczestników mogą tutaj padać różne:'
              '</p>'
              '<ul>'
              '<li><p style="text-align:justify;">Drużynowy</p></li>'
              '<li><p style="text-align:justify;">Rodzice</p></li>'
              '<li><p style="text-align:justify;">Harcerz</p></li>'
              '<li><p style="text-align:justify;">Szkoła</p></li>'
              '<li><p style="text-align:justify;">...</p></li>'
              '</ul>'
              '<p style="text-align:justify;">'
              '<br>Warto, aby prowadzący zebrał od uczestników jak najwięcej różnych odpowiedzi.'
              '<br>'
              '<br>Na koniec, jeśli ktoś wskazał poprawną odpowiedź, prowadzący ją potwierdza - jeśli nikt jej nie wskazał, to sam ją podaje:'
              '<br>'
              '<br><i><b>O tym, do czego wychowujemy młodego człowieka w harcerstwie decyduje <u>statut ZHP</u></b>.'
              '<br>W szczególności są to:</i>'
              '</p>'
              '<ul>'

              '<li>'
              '<p style="text-align:justify;">'
              '<i>Artykuł 3, w którym zdefiniowano zbiór wartości harcerskich'
              '<br>$attach_html_cel_wychowania_duchowego_zhp_statut</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<i>Prawo Harcerskie'
              '<br>$attach_html_prawo_harcerskie</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<i>Przyrzeczenie Harcerskie'
              '<br>$attach_html_przyrzeczenie_harcerskie</i>'
              '</p>'
              '</li>'

              '</ul>'

              '<p style="text-align:justify;">'
              'Prowadzący przekazuje uczestnikom treść wydrukowanych części statutu, by mogli się z nim zapoznać.'
              '<br>'
              '<br>Prowadzący może także dodać wydrukowany fragment uchwały o celach wychowania duchowego ZHP ($attach_html_cel_wychowania_duchowego_zhp_uchwala).'
              '</p>'
      ),

      KonspektStep(
          title: 'Konieczność pracy ze źródłem wartości - aksjomatem',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący przedstawia historię:'
              '<br>'
              '<br><i>Na obozie jeden z wędrowników, Radek, zaszedł drugiemu, Adamowi, za skórę. W odwecie Adam zaczął prześladować Radka. Trwało to już od miesiąca. Drużynowy wziął Adama na rozmowę. Powiedział, że zgodnie z harcerskimi wartościami należy traktować innych jak bliźnich i braci, dlatego uważa, że Adam powinien przebaczyć Radkowi ich niedawną sprzeczkę.'
              '<br>'
              '<br>Adam jednak stwierdził:'
              '<br>'
              '<br>"Okej. Mogę dać mu spokój, ale po tym, co Radek zrobił, nie zasługuje na traktowanie jak brata. Ja zresztą nie jestem już dzieckiem, dlaczego mam wierzyć w jakieś Prawo Harcerskie, które garstka ludzi nazywających się Radą Naczelną może w każdym momencie zmienić? Kto powiedział, że akurat ich wartości są dobre? Przecież to banda starych dziadów rodem z poprzedniej epoki".</i>'

              '<br>Prowadzący wciela się w postać Adama i prosi uczestników, aby przedstawili Adamowi: dorosłemu, wykształconemu, inteligentnemu wędrownikowi powód, dla którego <b>powinien w życiu kierować się wartością przebaczania</b>.'
              '<br>'
              '<br>'
              '<br>Wcześniej jednak prowadzący powinien zwrócić uwagę na następujące możliwości i ich konsekwencje:'
              '</p>'

              '<ol>'
              '<li><p style="text-align:justify;">Drużynowy może machnąć ręką na tę sytuację, ale wtedy <b>utwierdzi wędrownika w przekonaniu, że można łamać Prawo Harcerskie</b> i że nie ma to żadnego znaczenia. Ewidentna <b>porażka wychowawcza</b>.</p></li>'
              '<li><p style="text-align:justify;">Z drugiej strony drużynowy może powiedzieć: <i>"kolego - w ZHP takie są zasady, że wybaczamy. Jeśli tego nie akceptujesz - to nie miejsce dla Ciebie"</i>. Jeśli jednak Adam odejdzie, to <b>ZHP również poniesie porażkę</b>: harcerstwo ma wychowywać, zmieniać ludzi - a nie być skupiskiem dla ludzi już wychowanych.</p></li>'
              '</ol>'

              '<p style="text-align:justify;">'
              '<br>Zadaniem prowadzącego jest relatywizowanie argumentów uczestników, odpowiedziami w stylu:'
              '</p>'

              '<ul>'
              '<li><p style="text-align:justify;">Okej, dla was wybaczanie jest ważne - uważajcie sobie co chcecie. Ja uważam inaczej.</p></li>'
              '<li><p style="text-align:justify;">To, że akurat w waszej kulturze większość uważa, że warto wybaczać o niczym nie świadczy. W innych kultrach, na przykład japońskiej, honorowym wyjściem z popełnienia znaczącego błędu jest sepuku, rytualne samobójstwo. Dzięki temu ludzie robią wszystko, by nie czynić zła. Wybaczanie tylko zachęca do łamania zasad.</p></li>'
              '<li><p style="text-align:justify;">Niby dlaczego uważacie, że wasze wartości są lepsze? Dlaczego mam się do nich stosować?</p></li>'
              '</ul>'

              '<p style="text-align:justify;">'
              'Gdy uczestnicy wyraźnie dojdą do ściany, prowadzący może przedstawić im wniosek i rozwiązanie:'
              '<br>'
              '<br>Świadomy człowiek nie będzie miał powodu uznawać wartości tylko dlatego, że ktoś mu tak powiedział. Musi wiedzieć, <b>dlaczego warto zgodnie z nimi żyć</b>, a to oznacza, że muszą one wypływać ze <b>źródła wartości</b>, w które ów człowiek wierzy, czyli z <b>aksjomatu jego duchowości</b>: najgłębszej prawdy, którą kieruje się w życiu, np. filozofią, czy religią.'
              '<br>'
              '<br>Przykładowo, jeśli wędrownik wierzy w zbawczą śmierć i zmartwychwstanie Chrystusa, odpowiedzią na pytanie: <i>"dlaczego mam komuś wybaczać"</i> może być stwierdzenie:'
              '<br>'
              '<br><i>Skoro Bóg zszedł na Ziemię i dobrowolnie dał się zabić za każdego, nawet najpodlejszego człowieka, by dać każdemu szansę doznać zbawienia i życia w pełni szczęścia, to prawdopodobnie my także, jesteśmy winni przebaczenia tym, którzy o to proszą</i>.'
              '<br>'
              '<br>Jeśli jednak wędrownik nie wierzy w śmierć i zmartychwstanie Chrystusa, to nie przekona go do przebaczania.'
              '<br>'
              '<br>Być może większość osób w społeczeństwie kieruje się w życiu tymi wartościami, które wyznaje większość ich otoczenia: bo to wygodne, łatwe, nie wymaga myślenia i gwarantuje akceptację grupy. Tylko co z tego? ZHP nie wychowuje idących na łatwiznę ludzi podlegających owczemu pędowi. ZHP wychowuje silne, świadome, wszechstronnie rozwinięte jednostki, które wiedzą czemu wartości, w które wierzą są dobre, umieją ich bronić i zgodnie z nimi żyć pomimo trudności!'
              '<br>'
              '<br>Wniosek z tego punktu jest następujący:'
              '<br>'
              '<br><b>Jeśli harcerstwo ma być wychowawczo skuteczne, musi uwzględniać w wychowaniu pracę z aksjomatami: budowanie swojej tożsamości na podstawie wiary, religii, filozofii itd.!</b>'
              '<br>'
              '<br>Jeżeli harcerstwo tego zaniecha, to owszem, w rozwoju zuchów i harcerzy nie będzie widać większych problemów. Ale już HSi i wędrownicy nie będą traktowali poważnie wartości, które "są, bo tak".'
              '<br>'
              '<br>Praca z aksjomatami nie zaczyna się, gdy ktoś ma lat 15 (wtedy bowiem każdy jest święcie przekonany, że jest najmądrzejszy na świecie). Praca nad budowaniem fundamentów pod aksjomaty musi się zacząć od zucha, by potem było się do czego odnieść.'
              '</p>'
      ),

      KonspektStep(
          title: 'Aksjomaty - przykłady i pytania',
          duration: Duration(minutes: 5),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący szybko podaje kilka przykładów tego, co może być aksjomatem, aby uczestnicy mogli zbudować wokół pojęcia aksjomatu intuicję:'
              '</p>'
              '<ul>'
              '<li><p style="text-align:justify;">Świat stworzył przypadek. Świadomość człowieka jest iluzją fizyki, nie ma żadnego celu.</p></li>'
              '<li><p style="text-align:justify;">Świat stworzyła wróżka. Ludzie są powiewami meta-powietrza jej tchnienia.</p></li>'
              '<li><p style="text-align:justify;">Wszystko jest iluzją. Istnieję tylko ja, reszta to zaprogramowane postaci w mojej głowie.</p></li>'
              '<li><p style="text-align:justify;">Świat stworzył trójjedyny Bóg, powołał człowieka na swój obraz, by doświadczył miłości.</p></li>'
              '<li><p style="text-align:justify;">Świat został stworzony przez Gigantów. Ludzie będą zbawieni, jeśli będą im składali ofiary. Kto tego nie robi musi się nawrócić lub zostać samemu złożonym w ofierze - tylko w ten sposób uniknie wiecznej nicości.</p></li>'
              '</ul>'

              '<p style="text-align:justify;">'
              'Nie wszystkie przykłady aksjomatów są kompatybilne z wychowaniem w ZHP.'
              '<br>'
              '<br>Jeśli uczestnicy pytania, to dobry moment, by je zadali.'
              '</p>'
      ),

      KonspektStep(
          title: 'Kompatybilne aksjomaty - jak to działa w ZHP?',
          duration: Duration(minutes: 5),
          activeForm: false,
          content: 'Prowadzący zauważa, że każde dalekosiężne, holistyczne wychowanie musi zakładać pracę nad aksjomatem ducha (czyli źródłem wartości) młodego człowieka. Jakie więc są aksjomaty, z których wypływa harcerskie wychowanie? Niestety, model wychowawczy w ZHP ich nie nazywa. Zamiast tego ogranicza dopuszczalne aksjomaty poprzez narzucenie, jakie wartości mają z nich wynikać. Z pozoru to rozwiązanie może działać, ale w praktyce, wyobraźcie sobie pewną sytuację wychowawczą.'
              '<br>'
      ),

      KonspektStep(
          title: 'Kompatybilne aksjomaty - przykłady',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
            'Prowadzący zauważa, że:'
            '<br>'
            '<br><i>Każde dalekosiężne, holistyczne wychowanie musi zakładać pracę nad aksjomatem ducha (czyli źródłem wartości) młodego człowieka. Jakie więc są aksjomaty, z których wypływa harcerskie wychowanie? Niestety, model wychowawczy w ZHP ich nie nazywa. Zamiast tego ogranicza dopuszczalne aksjomaty poprzez narzucenie, jakie wartości mają z nich wynikać.</i>'
            '<br>'
            '<br>Jakie ma to przełożenie na praktykę? Prowadzący przedstawia uczestnikom kilka scenariuszy do dyskusji, które powinny tę konstrukcję wyjaśnić:'
            '<ol>'
            '<li><p style="text-align:justify;">'
            '<i><b>Do ZHP trafia 7-latek, którego rodzice są katolikami i którym zależy na wychowaniu dzieci w wierze.</b>'
            '<br>Czy ów potencjalny zuch może rozwijać się w duchowości katolickiej w ZHP?</i>'
            '<br>'
            '<br>Odp.: <b>Tak</b>. Wartości wynikające z wiary katolickiej są zgodne z wartościami harcerskimi - są z definicji, bo ZHP wychowuje do wartości wynikających z chrześcijaństwa.'
            '</p></li>'

            '<li><p style="text-align:justify;">'
            '<i><b>Do ZHP trafia dogmatyczny darwinista. Wierzy w to, że słabym nie wolno pomagać - to zaburza mechanizm selekcji naturalnej, przetrwać powinni tylko najsilniejsi.</b>'
            '<br>Czy ów człowiek może liczyć na rozwój w rzeczonej duchowości w ZHP?</i>'
            '<br>'
            '<br>Odp.: <b>Nie</b>. ZHP nie prowadzi wychowania do warunkowania godności każdego człowieka od jego zdrowia, czy do widzenia bliźniego tylko w niektórych ludziach. Harcerstwo nie ma w wychowaniu do darwinizmu niczego do zaoferowania.'
            '</p></li>'

            '<li><p style="text-align:justify;">'
            '<i><b>Do ZHP trafia 12-latek, którego rodzice wierzą w energię kosmosu oraz w to, że Powszechna Deklaracja Praw Człowieka nie została napisana, ale została zesłana z wyższego wymiaru i że jest świętym wskazaniem tego, jak należy postępować w życiu.</b>'
            '<br>Czy ów 12-latek może rozwijać się w owej "kosmicznej" duchowości w ZHP?</i>'
            '<br>'
            '<br>Odp.: <b>Tak</b>, pod warunkiem, że w kwestiach nieregulowanych Powszechną Deklaracją Praw Człowieka rodzice nie będą się sprzeciwiali przyjęciu wartości harcerskich.'
            '</p></li>'

            '<li><p style="text-align:justify;">'
            '<i><b>Do ZHP trafia 18-latek z Palestyny, ateista wierzący, że żydzi są i zawsze byli przyczyną wszelkiego zła na świecie, oraz że na świecie nie będzie wojen jeśli wszyscy Żydzi zostaną zgładzeni.</b>'
            '<br>Czy ów młodzian może dołączyć do ZHP?</i>'
            '<br>'
            '<br>Odp.: <b>Tak</b>. ZHP nie ogranicza nikomu możliwości dołączenia do organizacji. Ogranicza jedynie duchowości, do których wychowuje swoich członków. Jeśli ów Palestyńczyk zgodzi się porzucić swoją wiarę i zastąpić ją czymś, z czego wypływają wartości harcerskie, może z powodzeniem liczyć na wsparcie swojego rozwoju ze strony Związku. W przeciwnym wypadku ZHP nie ma mu niczego do zaoferowania.'
            '</p></li>'

            '</ol>'
      ),

      KonspektStep(
          title: 'Kompatybilne aksjomaty - kto je wybiera?',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący stawia pytanie:'
              '<br>'
              '<br><i>Przychodzi do nas do drużyny nowy harcerz. Jak określić, który aksjomat powinien lec u podstaw jego wychowania, aby w przyszłości potrafił sam z niego czerpać?</i>'
              '<br>'
              '<br>Prowadzący powinien pozwolić uczestnikom na krótką dyskusję. Nie ma tu metody na wyklarowanie jednoznacznej odpowiedzi, ale jedyną racjonalną wydaje się być następujący mechanizm:'
              '</p>'

              '<ul>'
              '<li><p style="text-align:justify;">Dopóki to rodzice posyłają dziecko do harcerstwa, to oni decydują w jakiej wierze (aksjomatach) ma być wychowywany harcerz.</p></li>'
              '<li><p style="text-align:justify;">Gdy harcerz jest dorosły i sam o sobie stanowi, to on sam decyduje o tym, w jakiej wierze (aksjomatach) będzie się dalej rozwijał.</p></li>'
              '<li><p style="text-align:justify;">Jeśli wolą rodziców harcerza lub jego samego jest wychowanie w aksjomacie, z którego wypływają wartości niezgodne z wartościami harcerskimi, harcerstwo nie jest miejscem dla takiej osoby.</li>'
              '</ul>'
      ),

      KonspektStep(
          title: 'Szybkie podsumowanie',
          duration: Duration(minutes: 1),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący podsumowuje dotychczasowe (oczywiste) ustalenia:'
              '</p>'

              '<ul>'
              '<li><p style="text-align:justify;">Harcerstwo jest po to, żeby wychować młodego człowieka w konkretnym kierunku.</p></li>'
              '<li><p style="text-align:justify;">Harcerstwo wychowuje do określonych wartości, które są opisane w statucie ZHP.</p></li>'
              '<li><p style="text-align:justify;">Poważne i skuteczne wychowanie musi uwzględniać pracę z aksjomatem duchowości (wiarą). Kształtu tego aksjomatu ZHP jednoznacznie nigdzie nie definiuje.</p></li>'
              '</ul>'

              '<p style="text-align:justify;">'
              'Warto, by prowadzący dodał, że harcerstwo nie jest platformą, w której rodzice wybierają sobie dowolne wartości i aksjomaty. Instruktorzy również nie są od tego, by te wartości zmieniać - są tymi, którzy dowożą wychowanie w określonych statutem ramach.'
              '</p>'
      ),

      KonspektStep(
          title: 'Przerwa',
          duration: Duration(minutes: 5),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Krótka przerwa.'
              '</p>'
      ),

      KonspektStep(
        title: 'Po co jest Przyrzeczenie Harcerskie?',
        duration: Duration(minutes: 10),
        activeForm: false,
        content: '<p style="text-align:justify;">'
          'Prowadzący zadaje uczestnikom kolejne pytanie: <i>“Po co jest Przyrzeczenie Harcerskie?”</i>.'
          '<br>'
          '<br>Dyskusja powinna doprowadzić do dwóch konkluzji:'
          '</p>'
          '<ul>'
          '<li><p style="text-align:justify;">Po to, aby harcerz mógł dobrowolnie zadeklarować chęć przynależności do harcerstwa.</p></li>'
          '<li><p style="text-align:justify;">Po to, aby harcerz mógł zgodzić się na klarowne źródło zasad, które będą go kształtowały.</p></li>'
          '</ul>'
          '<p style="text-align:justify;">'
          'Przyrzeczenie nie jest "świętą formułą", nie jest "podstawową wolnością", ani "niezbywalnym prawem harcerza". Przyrzeczenie jest <b>narzędziem wychowawczym</b> - tak jak mundur, gawęda, namiot, sprawność, czy ognisko - służy temu, aby harcerza ukształtować w konkretnym kierunku.'
          '</p>'
      ),

      KonspektStep(
        title: 'Kto wybiera treść Przyrzeczenia?',
        duration: Duration(minutes: 5),
        activeForm: false,
        content: '<p style="text-align:justify;">'
            'Prowadzący stawia pytanie: <i>“Kto wybiera treść Przyrzeczenia, które złoży harcerz?”</i>.'
            '<br>'
            '<br>Bazując na poprzednich wnioskach, rozróżnieniem, na które powinni wpaść uczestnicy jest: <i>"zależy o której metodyce mówimy"</i>.'
            '<br>'
            '<br>W przypadku metodyki wędrowniczej, treść Przyrzeczenia wybiera sam wędrownik.'
            '<br>'
            '<br>W przypadku metodyki harcerskiej i często starszoharcerskiej, treść przyrzeczenia powinna być zgodna z tym, czy harcerz jest wychowywany w wierze. Z tego względu warto, aby harcerz podjął taką decyzję wspólnie z rodzicem.'
            '</p>'
      ),

      KonspektStep(
          title: 'Kiedy wybrana powinna być treść Przyrzeczenia?',
          duration: Duration(minutes: 5),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący stawia pytanie: <i>“Kiedy powinna być wybrana treść Przyrzeczenia, które złoży harcerz?”</i>.'
              '<br>'
              '<br>Prowadzący może poprowadzić moderowaną dyskusję, która powinna doprowadzić do dwóch wniosków:'
              '<ul>'
              '<li><p style="text-align:justify;">Nigdy, ale to przenigdy harcerz nie powinien wybierać treści Przyrzeczenia stojąc przy ognisku, przy którym za 35 sekund złoży Przyrzeczenie.</p></li>'
              '<li><p style="text-align:justify;">Wybór treści Przyrzeczenia powinien być dokonany najpóźniej w momencie zamykania Próby Harcerza.</p></li>'
              '</ul>'
              '</p>'
      ),

      KonspektStep(
          title: 'Jak przeprowadzić Przyrzeczenie Harcerskie?',
          duration: Duration(minutes: 10),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący stawia pytanie: <i>“Jak przeprowadzić cały proces związany z Przyrzeczeniem Harcerskim?”</i>.'
              '<br>'
              '<br>Ponieważ składanie Przyrzeczenia dotyczy w ponad 90% metodyki harcerskiej, prowadzący informuje, że ta część skupi się na tylko jednym scenariuszu:'
              '<br>'
              '<br><i>Do drużyny przychodzi 10-latek, który właśnie rozpoczął 4-tą klasę podstawówki. Co teraz?</i>'
              '<br>'
              '<br>Prowadzący dzieli uczestników na dwie grupy i rozdaje im po jednym przygotowanym i pociętym załączniku “$attach_html_jak_przeprowadzic_przyrzeczenie”.'
              '<br>'
              '<br>Zadaniem każdej grupy jest ułożenie w odpowiedniej kolejności kawałków załącznika, tak aby powstał z niego spójny scenariusz. Jeśli grupa ma pomysły jak ów scenariusz można wzbogacić, powinna to zapisać.'
              '</p>'
      ),

      KonspektStep(
          title: 'Omówienie',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący omawia z grupami wyniki ich pracy oraz ich ewentualne pomysły na wzbogacenie procesu przeprowadzenia Przyrzeczenia.'
              '<br>'
              '<br>Na końcu prowadzący może zaznaczyć, że cały materiał, którego fragmenty właśnie układali wraz z szablonem listu do harcerza i rodzica jest dostępny jako konspekt w HarcAppce.'
              '<br>'
              '<br><a href="$konspekt_harc_name_dwie_roty_dwoch_przyrzeczen_harcerskich@harcerskie.konspekt">$konspekt_harc_title_dwie_roty_dwoch_przyrzeczen_harcerskich</a>'
              '</p>'
      ),

      KonspektStep(
          title: 'Scenariusze',
          duration: Duration(minutes: 40),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący po kolei przedstawia uczestnikom kilka scenariuszy z wydrukowanego załącznika $attach_html_scenariusze związanych z problematyką dwóch możliwych do wyboru rot Przyrzeczenia.'
              '<br>'
              '<br>Aby wprowadzić pewną dynamikę, warto, aby to uczestnicy czytali scenariusze.'
              '<br>'
              '<br>Do części scenariuszy prowadzący powinien zadać pytania dodatkowe, gdy dyskusja nad nimi się zakończy.'
              '</p>'
              '<ol>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>Scenariusz 1:</b>'
              '<br><i>Wędrownik w wieku 10 lat złożył przyrzeczenie "bez Boga", lecz w trakcie nauki w liceum się nawrócił. Na początku obozu zapytał drużynowego, czy mógłby kiedyś złożyć ponownie Przyrzeczenie Harcerskie.'
              '<br>'
              '<br>Jak powinien zadziałać drużynowy?</i>'
              '<br>'
              '<br><b>Rozwiązanie:</b>'
              '<br>'
              '<br>Ceremoniały w procesie wychowawczym mają znaczenie - z tego powodu obrzędowi złożenia Obietnicy Zucha, Przyrzeczenia Harcerskiego, nadania barw drużyny, czy złożenia zobowiązania instruktorskiego towarzyszy odpowiednia podniosłość.'
              '<br>'
              '<br>Jeżeli wędrownikowi zależy na tym, aby móc złożyć Przyrzeczenie w nowej formule, dobrze, aby drużynowy to zorganizował. Można to przykładowo połączyć z inną ważną ceremonią, np. nadania naramiennika wędrowniczego.'
              '<br>'
              '<br><u>Pytanie dodatkowe 1.1:</u>'
              '<br><i>A może nie ma co powtarzać Przyrzeczenia, bo to tak, jakby ktoś złożył je w języku angielskim, a potem przeprowadził do Polski i z tego powodu chciał je złożyć w innym języku?</i>'
              '<br>'
              '<br><u>Rozwiązanie:</u>'
              '<br>'
              '<br>Nie. Zmiana języka jest jedynie zmianą formy wygłoszenia tej samej treści. W przypadku alternatywnych Przyrzeczeń mamy do czynienia z dwoma różnymi treściami, które istotnie się różnią. Jeśli harcerz zmienia swoje przekonania, zmiana Przyrzeczenia jest uzasadniona.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>Scenariusz 2:</b>'
              '<br><i>Podczas biwaku dwie harcerki się posprzeczały. Jedna z nich zamiast wyrzucić śmieci do kosza, zostawiła je pod drzewem, na co druga, Zosia, zaczęła ją pouczać, że złamała 6. punkt PH. Pierwsza z dziewczyn się zdenerwowała i powiedziała kadrze, że od kiedy Zosia dostała krzyż, strasznie się wymądrza w sprawach harcerskich. Zosia odpowiedziała, że nie lubi tego robić, ale miesiąc temu złożyła Przyrzeczenie, że będzie <u>"stała na straży harcerskich zasad"</u> i traktuje to serio. Dodała też, że nie rozumie dlaczego inne dziewczyny, które składały Przyrzeczenie na służbę Bogu nie muszą stać na straży harcerskich zasad.'
              '<br>'
              '<br>Jak drużynowy powinien zareagować względem Zosi?</i>'
              '<br>'
              '<br><b>Rozwiązanie:</b>'
              '<br>'
              '<br>Dwie różne roty alternatywnych Przyrzeczeń Harcerskich są w istocie fatalnie niesymetryczne. Wersja "z Bogiem" odwołuje się do osobowego Boga, będącego źródłem harcerskich wartości. Z kolei wersja "ze staniem na straży harcerskich zasad" nie dość, że nie odwołuje się w żaden sposób do poszukiwania źródła zasad, to jeszcze obliguje harcerza do obowiązku, któremu nie podlegają harcerze składający Przyrzeczenie "z Bogiem".'
              '<br>'
              '<br>Gdyby Rada Naczelna potraktowała wychowanie duchowe związane z Przyrzeczeniem holistycznie, zamiast <i>"(...) stać na straży harcerskich zasad (...)"</i> znalazła by się tam formuła w stylu "(...) zawsze dążyć do prawdy i sensu (...) lub coś podobnego."'
              '<br>'
              '<br>W tej sytuacji najlepsze, co może zrobić drużynowy, to:'
              '</p>'
              '<ul>'

              '<li>'
              '<p style="text-align:justify;">'
              'Z jednej strony przyznać rację Zosi i pomówić ze śmiecącą harcerką - nie ma żadnej wymówki dla lekceważenia Prawa Harcerskiego.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Z drugiej strony, jeśli Zosia planuje jeszcze mieć jakiekolwiek koleżanki, dobrze będzie jeśli do czasu pełnienia funkcji zastępowej lub drużynowej, nie będzie sama wytykała innym błędów. Zamiast tego niech porozmawia o tym z przełożonym lub wspólnie z innymi harcerkami grzecznie zwróci komuś uwagę.'
              '</p>'
              '</li>'

              '</ul>'

              '<p style="text-align:justify;">'
              'Najgorsze, co może zrobić w tej sytuacji drużynowy, to zrelatywizować Przyrzeczenie Harcerskie tekstem w stylu <i>"tak naprawdę stania na straży nie można rozumieć tak dosłownie"</i>, czy </i>"chodzi o to, żebyś pilnowała tylko samą siebie"</i>. Jeśli w Przyrzeczeniu miało chodzić o coś innego, to powinno się to tam było znaleźć.'
              '<br>'
              '<br>Uczenie harcerzy, że mogą zmieniać sens tego, do czego się zadeklarowali tylko dlatego, że innym się to nie podoba jest <b>skrajnie demoralizujące</b>.'
              '<br>'
              '<br><u>Pytanie dodatkowe 1.1:</u>'
              '<br>Po tej sytuacji przy kolacji wybucha dyskusja o tym, czy Zosia może mówić innym jak mają się zachowywać. Przecież Przyrzeczenie jest prywatną sprawą każdego harcerza. Czy tak jest w istocie?'
              '<br>'
              '<br><u>Rozwiązanie:</u>'
              '<br>'
              '<br>Gdyby Przyrzeczenie było prywatną sprawą każdego harcerza, to powinien je sobie wyszeptać sam w zamkniętym pokoju. Przyrzeczenie jest, owszem, <b>kwestią <u>indywidualną</u> każdego harcerza, ale jest kwestią <u>publiczną</u></b> - jest składane w obecności drużyny i dotyczy drużyny oraz wspólnoty harcerskiej.'
              '<br>'
              '<br><u>Pytanie dodatkowe 1.2:</u>'
              '<br>Czy skoro Zosia złożyła Przyrzeczenie "ze staniem na straży harcerskich zasad", to czy oznacza to, że powinna chodzić po szkole i pilnować, żeby każdy kogo spotka zachowywał harcerskie zasady?'
              '<br>'
              '<br><u>Rozwiązanie:</u>'
              '<br>'
              '<br>Jeśli będzie umiała to robić skutecznie - czemu nie. W praktyce jednak jej nie-harcerscy znajomi nigdy nie deklarowali, że będą przestrzegali harcerskich zasad - dlatego w zupełności wystarczy, jeśli będzie stała na ich straży w drużynie.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>Scenariusz 3:</b>'
              '<br><i>Rodzice 11-letniego harcerza chcą, aby złożył on Przyrzeczenie "z Bogiem", lecz sam harcerz się uparł i chce złożyć przyrzeczenie "bez Boga".'
              '<br>'
              '<br>Jak powinien zadziałać drużynowy?</i>'
              '<br>'
              '<br><b>Rozwiązanie:</b>'
              '<br>'
              '<br>Przyrzeczenie Harcerskie nie jest świętością, prawem, ani absolutem - jest narzędziem wychowawczym. W pierwszej kolejności dobrze, jeśli drużynowy podejmie nienachalną próbę porozmawiania z harcerzem na temat powodów, dla których nie zgadza się on ze swoimi rodzicami.'
              '<br>'
              '<br>Jeżeli harcerz będzie cały czas uparty - nie zmuszanie go do czegokolwiek będzie wychowawczo nieskuteczne (warto przedstawić ten argument rodzicom). Najlepiej pozwolić harcerzowi złożyć Przyrzeczenie w takiej formule, w jakiej będzie chciał. Jeśli rodzice uznają to za zbyt daleko idące - zawsze mogą zabrać dziecko z harcerstwa.'
              '<br>'
              '<br>Warto, by drużynowy w takim wypadku i tak podejmował pracę nad duchowością harcerza w kontekście religijnym w trakcie dalszego procesu wychowawczego (przygotowanie do i chodzenie na mszę, kontakt z tradycjami religijnymi, kapelanami, wychowanie przez śpiewanie, etc.).'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>Scenariusz 4:</b>'
              '<br><i>W jednej z Warszawskich drużyn wszystkie nowe osoby chcą złożyć przyrzeczenie "bez Boga" poza jednym harcerzem. Po miesiącu ów harcerz zaczął mówić, że i on woli wersję "bez Boga", choć wcześniej twierdził inaczej - drużynowy łatwo wybadał, że po prostu uległ presji większości grupy (zadziałała wzajemność oddziaływań).'
              '<br>'
              '<br>Jak powinien zadziałać drużynowy?</i>'
              '<br>'
              '<br><b>Rozwiązanie:</b>'
              '<br>'
              '<br>Wybór roty Przyrzeczenia powinien odbyć się we współpracy rodziców i harcerza właśnie po to, żeby to oni, a nie grupa, miała największy wpływ na decyzję. Uleganie presji jest normalnym zjawiskiem, często korzystnym wychowawczo - jednak w niektórych przypadkach rolą drużynowego jest tak moderować dynamikę relacji w drużynie, aby harcerz nauczył się jej nie podlegać.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>Scenariusz 5:</b>'
              '<br><i>Harcerz najpierw złożył Przyrzeczenie o jednym brzmieniu, a potem po latach doszedł do wniosku, że woli drugie. Czy pozwalanie na to, aby harcerz zmienił Przyrzeczenie, nie jest uczeniem tego, że można dać komuś słowo, coś przyrzec, lub wziąć z kimś ślub, a potem się wykręcić tekstem <i>"no ale teraz jestem innym człowiekiem, zmieniłem zdanie, sory!"?</i>'
              '<br>'
              '<br><b>Rozwiązanie:</b>'
              '<br>'
              '<br>Nie. Nazywanie Przyrzeczenia Harcerskiego "Przyrzeczeniem" jest w istocie semantycznym błędem - zawsze zaczyna się ono bowiem nie od "przyrzekam", ale od "mam szczerą wolę". W istocie jest to zatem raczej Deklaracja Harcerska niż Przyrzeczenie Harcerskie - nie jest daniem słowa, a jedynie wyrażeniem woli.'
              '</p>'
              '</li>'

              '</ol>'
      ),

      KonspektStep(
          title: 'Podsumowanie i wnioski',
          duration: Duration(minutes: 5),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący krótko podsumowuje wnioski:'
              '</p>'
              '<ul>'

              '<li>'
              '<p style="text-align:justify;">'
              'Przyrzeczenie Harcerskie w istocie nie jest przyrzeczeniem, tylko <b>deklaracją chęci</b>. Zaczyna się to od <i>"mam szczerą wolę"</i>, a wola może uleć zmianie. Jeśli to możliwe, <b>warto, by członek ZHP złożył je drugi raz w innej formule</b>, gdy dojdzie do wniosku, że takowe woli.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Przyrzeczenie jest narzędziem wychowawczym do kształtowania duchowości harcerza i jest jedynie pierwszym krokiem maratonu wychowania duchowego, które harcerz powinien w harcerstwie otrzymać.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Wybór Przyrzeczenia w wieku przed-wędrowniczym, które złoży harcerz powinien być dokonany przede wszystkim <b>przez jego rodziców z jego udziałem</b>.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Wybór Przyrzeczenia, które złoży harcerz powinien być dokonany <b>przed obrzędem jego złożenia</b>. Absolutnie nigdy przy ognisku.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Przyrzeczenie "z Bogiem" oraz Przyrzeczenie "bez Boga" to nie są dwie formy tego samego Przyrzeczenia. To <b>dwa różne Przyrzeczenia</b>, z których wynikają nieco inne powinności, ale z których przede wszystkim to pierwsze definiuje źródło wartości (aksjomat), zaś to drugie nawet się do niego nie odnosi.'
              '<br>'
              '<br>Drużynowy, którego harcerz składa Przyrzeczenie "bez Boga" <b>musi dopiero ustalić źródło</b>, na podstawie którego ów harcerz ma w przyszłości budować swoją duchowość.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Przyrzeczenie <b>nie jest prywatną sprawą harcerza</b>. Jest sprawą indywidualną, ale dotyczy całej wspólnoty.'
              '</p>'
              '</li>'

              '</ul>'
      )

]
);