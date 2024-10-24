import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

import '../common_attachments.dart';

const konspekt_name_dwie_roty_dwoch_przyrzeczen = 'dwie_roty_dwoch_przyrzeczen';

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

Konspekt wstep_do_wychowania_duchowego = Konspekt(
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
          duration: Duration(minutes: 5),
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
              '<br>Na koniec, jeśli ktoś wskazał poprawną odpowiedź, prowadzący ją potwierdza - jeśli zaś nikt jej nie wskazał, to sam ją podaje: <b>o tym, do czego wychowujemy młodego człowieka w harcerstwie decyduje <u>statut ZHP</u></b>, a w szczególności:'
              '</p>'
              '<ul>'
              '<li><p style="text-align:justify;">Artykuł 3, w którym zdefiniowano zbiór wartości harcerskich</p></li>'
              '<li><p style="text-align:justify;">Prawo Harcerskie</p></li>'
              '<li><p style="text-align:justify;">Przyrzeczenie Harcerskie</p></li>'
              '</ul>'
              '<p style="text-align:justify;">'
              'Prowadzący przekazuje uczestnikom treść wydrukowanych .'
              '<br>Prowadzący może dodać'
              '</p>'
      ),

    ]
);