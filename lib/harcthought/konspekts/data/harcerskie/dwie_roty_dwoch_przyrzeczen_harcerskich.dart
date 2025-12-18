import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../level_examples.dart';

const konspekt_harc_name_dwie_roty_dwoch_przyrzeczen_harcerskich = 'dwie_roty_dwoch_przyrzeczen_harcerskich';
const konspekt_harc_title_dwie_roty_dwoch_przyrzeczen_harcerskich = 'Dwie roty dwóch Przyrzeczeń';

const String attach_html_list_do_harcerza_i_rodzicow = '<a href="$attach_name_list_do_harcerza_i_rodzicow@attachment">$attach_title_list_do_harcerza_i_rodzicow</a>';
const String attach_name_list_do_harcerza_i_rodzicow = 'list_do_harcerza_i_rodzicow';
const String attach_title_list_do_harcerza_i_rodzicow = 'List do harcerza i rodziców';
const KonspektAttachment attach_list_do_harcerza_i_rodzicow = KonspektAttachment(
  name: attach_name_list_do_harcerza_i_rodzicow,
  title: attach_title_list_do_harcerza_i_rodzicow,
  assets: {
    FileFormat.pdf: null,
    FileFormat.docx: null,
  },
);

Konspekt dwie_roty_dwoch_przyrzeczen_harcerskich = Konspekt(
  name: konspekt_harc_name_dwie_roty_dwoch_przyrzeczen_harcerskich,
  title: konspekt_harc_title_dwie_roty_dwoch_przyrzeczen_harcerskich,
  additionalSearchPhrases: [
    'przyrzeczenie harcerskie',
  ],
  category: KonspektCategory.harcerskie,
  type: KonspektType.projekt,
    spheres: {
      KonspektSphere.duch: KonspektSphereDetails(
        levels: {
          KonspektSphereLevel.duchPostawy: KonspektSphereFields(
              fields: {
            postawaPostepowanieZgodnieZPH: {
              KonspektSphereFactor.duchPerspektywa_Normalizacja,
              KonspektSphereFactor.duchPrzykladWlasnyAutorytetow,
              KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan
            }
          }
          )
        }
      ),
      KonspektSphere.umysl: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.other: KonspektSphereFields(
                fields: {
              umyslZnajomoscPIP: null,
            }
            )
          }
      ),
    },
  metos: [Meto.kadra],
  coverAuthor: 'Daniel Iwanicki',
  author: DANIEL_IWANICKI,
  customDuration: Duration(days: 180),
  aims: [
    'Wyłonienie roty Przyrzeczenia Harcerskiego, które złoży harcerz.',
    'Uświadomienie harcerza co wynika z treści rot Przyrzeczenia Harcerskiego.'
  ],
  attachments: [
    attach_list_do_harcerza_i_rodzicow,
  ],
  materials: [
    KonspektMaterial(
        name: 'Wydrukowany list na podstawie załącznika “$attach_title_list_do_harcerza_i_rodzicow”',
        attachmentName: attach_name_list_do_harcerza_i_rodzicow,
    ),
  ],
  summary: 'Harcerze wraz ze swoimi rodzicami poznają treść i sens PH oraz wybierają rotę PH, które złoży harcerz.',
  steps: [

    KonspektStep(
        title: 'Spotkanie z rodzicami',
        duration: Duration(hours: 2),
        activeForm: KonspektStepActiveForm.static,
        content: '<p style="text-align:justify;">'
            'Drużynowy organizuje spotkanie z rodzicami „nowych harcerzy”, podczas którego poruszane są co najmniej następujące kwestie:'
            '</p>'
            '<ul>'
            '<li><p style="text-align:justify;">Wyjaśnienie rodzicom na czym polega wychowanie w ZHP.</p></li>'
            '<li><p style="text-align:justify;">Wyjaśnienie rodzicom czym jest Przyrzeczenie Harcerskie.</p></li>'
            '<li><p style="text-align:justify;">Wyjaśnienie rodzicom sytuacji dwóch możliwych do wyboru rot Przyrzeczenia, które złoży harcerz.</p></li>'
            '<li><p style="text-align:justify;">Zebranie kontaktów do rodziców.</p></li>'
            '</ul>'
    ),

    KonspektStep(
      title: 'Otwarcie przez harcerza Próby Harcerza',
      duration: Duration(minutes: 15),
      activeForm: KonspektStepActiveForm.static,
      content: '<p style="text-align:justify;">'
          'Drużynowy w rozkazie otwiera harcerzowi Próbę Harcerza (bądź czyni to w inny obrzędowy sposób). Warto przy tej okazji mianować kogoś opiekunem jego Próby Harcerza – najlepiej, jeśli harcerz sam sobie taką osobę wybierze.'
          '</p>'
    ),

    KonspektStep(
        title: 'Zbiórka o Prawie i Przyrzeczeniu',
        duration: Duration(hours: 2),
        activeForm: KonspektStepActiveForm.static,
        content: '<p style="text-align:justify;">'
            'Drużyna organizuje zbiórkę o Prawie i Przyrzeczeniu Harcerskim. Harcerze, którzy już złożyli Przyrzeczenie mogą pomóc w jej organizacji (np. każdy zastęp może dostać konkretne zadanie związane ze zbiórką).'
            '</p>'
    ),

    KonspektStep(
        title: 'Poinformowanie rodziców o Próbie Harcerza',
        duration: Duration(hours: 2),
        activeForm: KonspektStepActiveForm.static,
        content: '<p style="text-align:justify;">'
            'Drużynowy uprzedza rodziców (np. SMSem), że „nowi harcerze” otrzymali list, z którym powinni zapoznać się wspólnie z nimi - rodzicami. Prosi, by w ciągu najbliższego tygodnia rodzice znaleźli chwilę (15-30 minut), by go z harcerzami przeczytać.'
            '<br>'
            '<br>Drużynowy pisze, że w liście jest kilka słów o Przyrzeczeniu Harcerskim z prośbą o wybór roty Przyrzeczenia, które harcerz będzie mógł złożyć po zakończeniu Próby Harcerza.'
            '<br>'
            '<br>Drużynowy dodaje, że w istocie to rodzice powinni podjąć decyzję, jako że to oni są głównymi wychowawcami harcerza. Ważne jednak, aby harcerz miał poczucie udziału w wyborze. Pomoże mu to utożsamić się z treścią Przyrzeczenia, które złoży.'
            '</p>'
    ),

    KonspektStep(
        title: 'List do harcerza i rodzica',
        duration: Duration(minutes: 5),
        activeForm: KonspektStepActiveForm.static,
        content: '<p style="text-align:justify;">'
            'Drużynowy wręcza „nowym harcerzom” po kopercie zaadresowanej do nich i ich rodziców.'
            '<br>'
            '<br>W każdej kopercie są dwie rzeczy: pusta kartka i list na podstawie załącznika $attach_html_list_do_harcerza_i_rodzicow. Drużynowy zwraca się w nim jednocześnie do harcerza i jego rodziców. Pisze, z czym wiąże się złożenie Przyrzeczenia i przytacza dwa warianty, w jakich może ono być złożone. Prosi, aby harcerz i rodzice wspólnie pomówili o tym, który z wariantów jest dla harcerza stosowny.'
            '<br>'
            '<br>Gdy dokonają wyboru, harcerz powinien własnoręcznie zapisać pełną treść wybranego Przyrzeczenia na pustej kartce załączonej do listu i oddać ją na zbiórce drużynowemu.'
            '</p>'
    ),

    KonspektStep(
        title: 'Zrealizowanie wszystkich wymagań Próby Harcerza',
        duration: Duration(days: 120),
        activeForm: KonspektStepActiveForm.static,
        content: '<p style="text-align:justify;">'
            'Harcerz realizuje wszystkie wymagania Próby Harcerza.'
            '</p>'
    ),

    KonspektStep(
        title: 'Ceremonia złożenia Przyrzeczenia Harcerskiego',
        duration: Duration(minutes: 20),
        activeForm: KonspektStepActiveForm.static,
        content: '<p style="text-align:justify;">'
            'Harcerz składa Przyrzeczenie Harcerskie. Podczas ceremonii złożenia Przyrzeczenia <u>nie pada pytanie, którą rotę harcerz wybiera</u>. Została ona wybrana w trakcie Próby Harcerza.'
            '<br>'
            '<br>Najlepiej, jeśli harcerz składający Przyrzeczenie będzie znał jego treść na pamięć.'
            '<br>'
            '<br>Jeśli tak nie jest, może powtarzać treść Przyrzeczenia za instruktorem przyjmującym zobowiązanie. Dobrze, by <u>instruktor nie czytał treści Przyrzeczenia z kartki</u> – kto jak kto, ale instruktorzy powinni móc je wyrecytować o każdej porze dnia i nocy.'
            '</p>'
    ),

    KonspektStep(
        title: 'Praca z duchowością wynikającą z Przyrzeczenia',
        duration: Duration(days: 4015),
        activeForm: KonspektStepActiveForm.static,
        content: '<p style="text-align:justify;">'
            'Jeśli harcerz złożył Przyrzeczenie ze „służbą Bogu”, drużynowy powinien zadbać, aby harcerz rozwijał zarówno relację z Bogiem, budował zrozumienie treści swojej wiary.'
            '<br>'
            '<br>Jeśli harcerz złożył Przyrzeczenie ze „staniem na straży harcerskich zasad”, przed drużynowym otwiera się niebagatelne wyzwanie określenia, skąd harcerz będzie czerpał uzasadnienie dla harcerskich wartości i znalezienia narzędzi pracy z owym aksjomatem.'
            '</p>'
    ),

  ]

);