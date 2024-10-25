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
          title: 'Kto decyduje, do czego wychowujemy? - Aksjomaty',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący zwraca uwagę na to, że statut ZHP określa wartości, do których harcerstwo wychowuje, ale nie określa jednego źródła wartości, z których mają one wynikać.'
              '<br>'
              '<br>Co to oznacza? Prowadzący przedstawia uczestnikom kilka scenariuszy do dyskusji:'
              '<ul>'

              '<li><p style="text-align:justify;">'
              'Do ZHP trafia 9-latek, którego rodzice są katolikami i którym zależy na wychowaniu dzieci w wierze. Czy ów potencjalny zuch może rozwijać się w duchowości katolickiej w ZHP?'
              '<br>'
              '<br>Odp.:'
              '<br>Tak. Wartości wynikające z wiary katolickiej są zgodne z wartościami harcerskimi - są z definicji, bo ZHP wychowuje do wartości wynikających z chrześcijaństwa.'
              '</p></li>'

              '<li><p style="text-align:justify;">'
              'Do ZHP trafia osoba, która jest dogmatycznym darwinistą. Wierzy, że jedynie dobry porządek świata wiedzie przez przetrwanie najsilniejszych, oraz że słabym nie wolno pomagać - to zaburza mechanizm selekcji naturalnej. Czy ów człowiek może liczyć na rozwój w rzeczonej duchowości w ZHP?'
              '<br>'
              '<br>Odp.:'
              '<br>Nie. ZHP nie prowadzi wychowania do nie uznawania godności każdego człowieka lub widzenia bliźniego tylko w niektórych ludziach. Harcerstwo nie ma tu niczego do zaoferowania.'
              '</p></li>'

              '<li><p style="text-align:justify;">'
              'Do ZHP trafia 12-latek, którego rodzice wierzą w energię kosmosu oraz w to, że Powszechna Deklaracja Praw Człowieka nie została napisana, ale została zesłana z wyższego wymiaru i że jest świętym wskazaniem tego, jak należy postępować w życiu. Czy ów 12-latek może rozwijać się w owej "kosmicznej" duchowości w ZHP?'
              '<br>'
              '<br>Odp.:'
              '<br>Tak, pod warunkiem, że w kwestiach nie regulowanych Powszechną Deklaracją Praw Człowieka rodzice nie bedą się sprzeciwiali przyjęciu wartości harcerskich.'
              '</p></li>'

              '</ul>'
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
            'Przyrzeczenie nie jest "świętą formułą", nie jest "podstawową wolnością", ani "niezbywalnym prawem harcerza". Przyrzeczenie jest <b>narzędziem wychowawczym</b> - takim samym jak mundur, namiot, sprawność, czy ognisko - służy temu, aby harcerza ukształtować w konkretnym kierunku.'
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