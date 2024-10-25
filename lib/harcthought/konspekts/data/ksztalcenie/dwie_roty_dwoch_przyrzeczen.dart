import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

import '../common_attachments.dart';

const konspekt_name_dwie_roty_dwoch_przyrzeczen = 'dwie_roty_dwoch_przyrzeczen_harcerskich';

const String attach_html_prawo_harcerskie = '<a href="$attach_name_prawo_harcerskie@attachment">$attach_title_prawo_harcerskie</a>';
const String attach_name_prawo_harcerskie = 'o_strukturze_i_ksztaltowaniu_duchowosci';
const String attach_title_prawo_harcerskie = 'O strukturze i ksztaltowaniu duchowosci';
const KonspektAttachment attach_prawo_harcerskie = KonspektAttachment(
  name: attach_name_prawo_harcerskie,
  title: attach_title_prawo_harcerskie,
  assets: {
    KonspektAttachmentFormat.pdf: 'ksztalcenie/$konspekt_name_dwie_roty_dwoch_przyrzeczen/$attach_name_prawo_harcerskie.pdf',
    KonspektAttachmentFormat.docx: 'ksztalcenie/$konspekt_name_dwie_roty_dwoch_przyrzeczen/$attach_name_prawo_harcerskie.docx',
  },
);

const String attach_html_przyrzeczenie_harcerskie = '<a href="$attach_name_przyrzeczenie_harcerskie@attachment">$attach_title_przyrzeczenie_harcerskie</a>';
const String attach_name_przyrzeczenie_harcerskie = 'o_strukturze_i_ksztaltowaniu_duchowosci';
const String attach_title_przyrzeczenie_harcerskie = 'O strukturze i ksztaltowaniu duchowosci';
const KonspektAttachment attach_przyrzeczenie_harcerskie = KonspektAttachment(
  name: attach_name_przyrzeczenie_harcerskie,
  title: attach_title_przyrzeczenie_harcerskie,
  assets: {
    KonspektAttachmentFormat.pdf: 'ksztalcenie/$konspekt_name_dwie_roty_dwoch_przyrzeczen/$attach_name_przyrzeczenie_harcerskie.pdf',
    KonspektAttachmentFormat.docx: 'ksztalcenie/$konspekt_name_dwie_roty_dwoch_przyrzeczen/$attach_name_przyrzeczenie_harcerskie.docx',
  },
);

Konspekt dwie_roty_dwoch_przyrzeczen = Konspekt(
    name: konspekt_name_dwie_roty_dwoch_przyrzeczen,
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
      attach_przyrzeczenie_harcerskie
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
          name: 'Wydrukowany załącznik “$attach_name_prawo_harcerskie”',
          attachmentName: attach_name_prawo_harcerskie,
          amount: 2
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_name_przyrzeczenie_harcerskie”',
          attachmentName: attach_name_przyrzeczenie_harcerskie,
          amount: 2
      ),

    ],
    steps: [

      KonspektStep(
          title: 'Wstęp',
          duration: Duration(minutes: 5),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący rozpoczyna krótkiim wyjaśnieniem tego, co będzie na tych warsztatach:'
              '<br>'
              '<br><i>“Mniej więcej przez połowę tych zajęć będze bardzo niewiele o samym Przyrzeczeniu Harcerskim, ale jest to zabieg celowy. Po prostu, aby dobrze zrozumieć jaką pełni rolę, jak się nim posługiwać i co wynika z jego obecnego kształtu, najlepiej jest uporządkować kilka fundamentalnych, kluczowych dla całego wychowania harcerskiego aspektów związanych z duchowością.”</i>'
              '</p>'
      ),

      KonspektStep(
          title: 'Po co jest harcerstwo?',
          duration: Duration(minutes: 5),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący rozpoczyna od pytania wstępnego: <i>“Po co jest harcerstwo?”</i>.'
              '<br>'
              '<br>Naturalnie, odpowiedź wynika z misji ZHP: Harcerstwo jest po to, żeby wychować młodego człowieka.'
              '<br>'
              '<br>Prowadzący może pozwolić na krótką dyskusję na ten temat, ale powinien tak nią moderować, aby w końcu padła prawidłowa odpowiedź.'
              '</p>'
      ),

      KonspektStep(
          title: 'Kto decyduje, do czego wychowujemy?',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący stawia kolejny temat pod dyskusję: <i>“Kto decyduje o tym, do czego wychowujemy młodego człowieka w harcerstwie?”</i>.'
              '<br>'
              '<br>Odpowiedzi od uczestników mogą tutaj padać różne:'
              '</p>'
              '<ul>'
              '<li><p style="text-align:justify;">Drużynowy</p></li>'
              '<li><p style="text-align:justify;">Rodzice</p></li>'
              '<li><p style="text-align:justify;">Harcerz</p></li>'
              '<li><p style="text-align:justify;">...</p></li>'
              '</ul>'
              '<p style="text-align:justify;">'
              '<br>Warto, aby prowadzacy zebrał od uczestników jak najwięcej różnych odpowiedzi.'
              '<br>'
              '<br>Na koniec, jeśli ktoś wskazał poprawną odpowiedź, prowadzący ją potwierdza - jeśli zaś nikt jej nie wskazał, to sam ją podaje:'
              '<br>'
              '<br><b>o tym, do czego wychowujemy młodego człowieka w harcerstwie decyduje <u>statut ZHP</u></b>.'
              '<br>W szczególności są to:'
              '</p>'
              '<ul>'

              '<li>'
              '<p style="text-align:justify;">'
              'Artykuł 3, w którym zdefiniowano zbiór wartości harcerskich'
              '<br>$attach_html_cel_wychowania_duchowego_zhp_statut'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Prawo Harcerskie'
              '<br>$attach_html_prawo_harcerskie'
              '<br>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Przyrzeczenie Harcerskie'
              '<br>$attach_html_przyrzeczenie_harcerskie'
              '<br>'
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
          title: 'Kompatybilne aksjomaty',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
            'Prowadzący zwraca uwagę na to, że statut ZHP określa wartości, do których harcerstwo wychowuje, ale nie określa jednego źródła wartości, z których mają one wynikać.'
            '<br>'
            '<br>Co to oznacza? Prowadzący przedstawia uczestnikom kilka scenariuszy do dyskusji, które powinny tę konstrukcję wyjaśnić:'
            '<ol>'

            '<li><p style="text-align:justify;">'
            '<i><b>Do ZHP trafia 9-latek, którego rodzice są katolikami i którym zależy na wychowaniu dzieci w wierze.</b>'
            '<br>Czy ów potencjalny zuch może rozwijać się w duchowości katolickiej w ZHP?</i>'
            '<br>'
            '<br>Odp.: <b>Tak</b>. Wartości wynikające z wiary katolickiej są zgodne z wartościami harcerskimi - są z definicji, bo ZHP wychowuje do wartości wynikających z chrześcijaństwa.'
            '</p></li>'

            '<li><p style="text-align:justify;">'
            '<i><b>Do ZHP trafia dogmatyczny darwinista. Wierzy w to, że słabym nie wolno pomagać - to zaburza mechanizm selekcji naturalnej, przetrwać powinni tylko najsilniejsi.</b>'
            '<br>Czy ów człowiek może liczyć na rozwój w rzeczonej duchowości w ZHP?</i>'
            '<br>'
            '<br>Odp.: <b>Nie</b>. ZHP nie prowadzi wychowania do nie uznawania godności każdego człowieka lub widzenia bliźniego tylko w niektórych ludziach. Harcerstwo nie ma tu niczego do zaoferowania.'
            '</p></li>'

            '<li><p style="text-align:justify;">'
            '<i><b>Do ZHP trafia 12-latek, którego rodzice wierzą w energię kosmosu oraz w to, że Powszechna Deklaracja Praw Człowieka nie została napisana, ale została zesłana z wyższego wymiaru i że jest świętym wskazaniem tego, jak należy postępować w życiu.</b>'
            '<br>Czy ów 12-latek może rozwijać się w owej "kosmicznej" duchowości w ZHP?</i>'
            '<br>'
            '<br>Odp.: <b>Tak</b>, pod warunkiem, że w kwestiach nie regulowanych Powszechną Deklaracją Praw Człowieka rodzice nie bedą się sprzeciwiali przyjęciu wartości harcerskich.'
            '</p></li>'

            '<li><p style="text-align:justify;">'
            '<i><b>Do ZHP trafia 18-latek z Palestyny, ateista wierzący, że żydzi są i zawsze byli przyczyną wszelkiego zła na świecie.</b>'
            '<br>Czy ów młodzian może dołączyć do ZHP?</i>'
            '<br>'
            '<br>Odp.: <b>Tak</b>. ZHP nie ogranicza nikomu możliwości dołączenia do organizacji. Ogranicza jedynie duchowości, do których wychowuje swoich członków. Jeśli ów Palestyńczyk zgodzi się porzucić swoją wiarę i zastąpić ją czymś, z czego wypływają wartości harcerskie, może z powodzeniem liczyć na wsparcie ZHP w swoim rozwoju. W przeciwnym wypadku ZHP nie ma mu niczego do zaoferowania.'
            '</p></li>'

            '</ol>'
      ),

      KonspektStep(
          title: 'Konieczność pracy z aksjomatem',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący zaczyna od stwierdzenia:'
              '<br>'
              '<br><i>Wychowanie na poziomie zucha czy harcerza może się ograniczyć do zachowań, postaw i wartości. Ale wychowanie HSa, czy wędrownika musi pójść dalej - włączyć do pracy wychowawczej <b>źródło wartości</b></i>.'
              '<br>'
              '<br>Prowadzący obrazuje to na przykładzie następującej sytuacji:'
              '<br>'
              '<br><i>Na obozie jeden z wędrowników zaszedł drugiemu za skórę, za co ten drugi zaczął go notorycznie prześladować. Trwało to już kilka miesięcy. Drużynowy wziął go na rozmowę. Powiedział, że harcerską postawą jest wyjść z dobą wolą, spróbować się pogodzić i wzajemnie przebaczyć winy.'
              '<br>'
              '<br>Gdyby drużynowy rozmawiał z zuchem, czy harcerzem, powołanie się na Prawo Zucha, czy Prawo Harcerskie by wystarczyło: skoro drużynowy, rodzice, księża i nauczyciele mówią, że jakaś wartość jest dobra - to dla zucha, czy harcerza jest dobra i cześć.'
              '<br>'
              '<br>Ale tutaj mowa jest o wędrowniku, który na pewnym etapie swojego życia może zadać (sobie lub komuś) pytanie:'
              '<br>'
              '<br>Dlaczego niby mam komuś wybaczyć? Ja uważam, że wybaczanie jest oznaką słabości. Jeśli ktoś mi podpadł, uważam, że należy go przykładnie i doszczętnie zgnoić - dla mnie wartością jest siła, a nie przebaczenie. Dlaczego mam wierzyć w jakieś zapiski Prawa Harcerskiego, które garstka ludzi nazywających się Radą Naczelną może w każdym momencie zmienić? Kto powiedział, że akurat ich wartości są dobre?</i>'
              '<br>'
              '<br>Każdy dorastajacy człowiek w trakcie swojego rozwoju duchowego zada kiedyś pytanie "dlaczego mam wierzyć akurat w takie a nie inne wartości? Czemu te są lepsze od tamtych?"'
              '<br>'
              '<br>Na pytanie o to <i>"dlaczego te wartości"</i>, albo <i>"które wartości są lepsze"</i> nie istnieje obiektywna odpowiedź. Odpowiedź ta zawsze wynika z <b>aksjomatu duchowości</b>, którą harcerz wyznaje - czyli z jego religii, filozofii, etc.. Zawsze owe aksjomaty są arbitralne, nie da się ich porównać, można po prostu wierzyć w ich słusznosć lub nie.'
              '<br>'
              '<br>Dla wędrownika odpowiedź "rób tak, bo tak mówi Prawo Harcerskie" jest śmieszna. Wędrownik potrzebuje powiązania wartości z aksjomatem, w który wierzy.'
              '<br>'
              '<br>Przykładowo, jeśli wędrownik wierzy w to, że Chrystus dobrowolnie umarł na krzyżu za każdego człowieka i powstał z martwych, odpowiedzią na pytanie: "dlaczego mam komuś wymaczać", którą uzna może być następujące stwierdzenie:'
              '<br>'
              '<br><i>Skoro Bóg zszedł na Ziemię i dobrowolnie zdecydwał dać się zabić za każdego, nawet najpodlejszego człowieka, żeby każdy, nawet ten najgorszy z ludzi miał szansę doznać zbawienia i życia w pełni szczęścia, to prawdopodobnie zarówno ja, jak i Ty, którzy sami zostaliśmy odkupieni przez Chrystusa, jesteśmy winni przebaczenia tym, którzy o nie proszą.'
              '</p>'
      ),

      KonspektStep(
          title: 'Kompatybilne aksjomaty - kto je wybiera?',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący stawia pytanie:'
              '<br>'
              '<br>W jaki sposób okreslić który aksjomat leży u podstaw duchowości danego harcerza?</i>'
              '</p>'
      ),

      KonspektStep(
          title: 'Szybkie podsumowanie',
          duration: Duration(minutes: 1),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący podsumowuje dotychczasowe (oczywiste) ustalenia:'
              '<br>'
              '<br><i><b>Harcerstwo jest po to, żeby <b>wychować młodego człowieka w konkretnym kierunku</b> określonym w statucie ZHP.</b></i>'
              '<br>'
              '<br>Warto, by prowadzący dodał, że harcerstwo nie jest platformą wychowawczą, w której rodzice, czy instruktorzy wybierają sobie dowolne wartości. Jeśli rodzice chcą posłać dziecko do harcerstwa, to muszą się zgodzić na wartości harcerskie, z kolei instrukotrzy są tymi, którzy dowożą wychowanie w tychże wartościach.'
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
            '<li><p style="text-align:justify;">Po to, aby harcerz mógł dobrowolniie zadeklarować chać przynależności do harcerstwa.</p></li>'
            '<li><p style="text-align:justify;">Po to, aby harcerz mógł zgodzić się i klarowne źródło zasad, które będą go kształtowały.</p></li>'
            '</ul>'
            '<p style="text-align:justify;">'
            'Przyrzeczenie nie jest "świętą formułą", nie jest "podstawową wolnością", ani "niezbywalnym prawem harcerza". Przyrzeczenie jest <b>narzędziem wychowawczym</b> - tak jak mundur, gawęda, namiot, sprawność, czy ognisko - służy temu, aby harcerza ukształtować w konkretnym kierunku.'
            '</p>'
      ),

      KonspektStep(
        title: 'Kto i kiedy wybiera treść Przyrzeczenia?',
        duration: Duration(minutes: 10),
        activeForm: false,
        content: '<p style="text-align:justify;">'
            'Prowadzący stawia pytanie: <i>“Kto wybiera treść Przyrzeczenia, które złoży harcerz?”</i>.'
            '<br>'
            '<br>Pierwszym rozróżnieniem, na które powinni wpaść uczestnicy jest: <i>"zależy o której metodyce mówimy"</i>.'
            '<br>'
            '<br>W przypadku metodyki wędrowniczej, treść Przyrzeczenia wybiera sam wędrownik.'
            '<br>'
            '<br>W przypadku metodyki harcerskiej i często starszoharcerskiej, treść przyrzeczenia powinna być zgodna z tym, czy harcerz jest wychowywany w wierze. Z tego względu warto, aby harcerz podjął taką decyzję wspólnie z rodzicem.'
            '<br>'
            '<br>'
            '</p>'
      ),

    ]
);