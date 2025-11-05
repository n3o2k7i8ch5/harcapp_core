import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common_attachments.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/wstep_do_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people/data.dart';

import 'common_wychowanie_duchowe.dart';
import 'czynniki_i_mechanizmy_ksztaltowania_duchowosci.dart';


const konspekt_kszt_name_warsztaty_wychowania_duchowego = 'warsztaty_wychowania_duchowego';
const konspekt_kszt_title_warsztaty_wychowania_duchowego = 'Warsztaty wychowania duchowego';


const String attach_html_scenariusz_fantomowe_dzialania_wychowawcze = '<a href="$attach_name_scenariusz_fantomowe_dzialania_wychowawcze@attachment">$attach_title_scenariusz_fantomowe_dzialania_wychowawcze</a>';
const String attach_name_scenariusz_fantomowe_dzialania_wychowawcze = 'scenariusz_fantomowe_dzialania_wychowawcze';
const String attach_title_scenariusz_fantomowe_dzialania_wychowawcze = 'Scenariusz fantomowe działania wychowawcze';
KonspektAttachment attach_scenariusz_fantomowe_dzialania_wychowawcze = KonspektAttachment(
  name: attach_name_scenariusz_fantomowe_dzialania_wychowawcze,
  title: attach_title_scenariusz_fantomowe_dzialania_wychowawcze,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego/$attach_name_scenariusz_fantomowe_dzialania_wychowawcze.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego/$attach_name_scenariusz_fantomowe_dzialania_wychowawcze.docx',
  },
);

const String attach_html_formy = '<a href="$attach_name_formy@attachment">$attach_title_formy</a>';
const String attach_name_formy = 'formy';
const String attach_title_formy = 'Formy';
KonspektAttachment attach_formy = KonspektAttachment(
  name: attach_name_formy,
  title: attach_title_formy,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego/$attach_name_formy.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego/$attach_name_formy.docx',
  },
);

const String attach_html_planowanie_strategii_i_dzialan = '<a href="$attach_name_planowanie_strategii_i_dzialan@attachment">$attach_title_planowanie_strategii_i_dzialan</a>';
const String attach_name_planowanie_strategii_i_dzialan = 'planowanie_strategii_i_dzialan';
const String attach_title_planowanie_strategii_i_dzialan = 'Planowanie strategii i działań';
KonspektAttachment attach_planowanie_strategii_i_dzialan = KonspektAttachment(
  name: attach_name_planowanie_strategii_i_dzialan,
  title: attach_title_planowanie_strategii_i_dzialan,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego/$attach_name_planowanie_strategii_i_dzialan.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_warsztaty_wychowania_duchowego/$attach_name_planowanie_strategii_i_dzialan.docx',
  },
);


KonspektMaterial material_poradnik_o_strukturze_duchowosci = KonspektMaterial(
  name: 'Dostępny do przygotowania merytorycznego $attach_title_poradnik_o_strukturze_duchowosci',
  attachmentName: attach_name_poradnik_o_strukturze_duchowosci,
);

KonspektMaterial material_poradnik_przykladowa_strategia_rozwoju_duchowego = KonspektMaterial(
  name: 'Dostępny do przygotowania merytorycznego $attach_title_poradnik_przykladowa_strategia_rozwoju_duchowego',
  attachmentName: attach_name_poradnik_przykladowa_strategia_rozwoju_duchowego,
);

KonspektMaterial material_identyfikator = KonspektMaterial(
  name: 'Identyfikator',
  amountAttendantFactor: 1,
);

KonspektMaterial material_dlugopis = KonspektMaterial(
  name: 'Długopis',
  amountAttendantFactor: 1,
);

KonspektMaterial material_notatnik = KonspektMaterial(
  name: 'Notatnik',
  amountAttendantFactor: 1,
);

KonspektMaterial material_nozyczki = KonspektMaterial(
  name: 'Nożyczki',
  amount: 2,
);

KonspektMaterial material_kartka_a4 = KonspektMaterial(
  name: 'Kartka A4',
  amount: 4,
);

KonspektMaterial material_obiad = KonspektMaterial(
  name: 'Obiad',
  amountAttendantFactor: 1,
);

KonspektMaterial material_przekaski = KonspektMaterial(
  name: 'Przekąski (jabłka, marchewki, ciastka)',
);

KonspektMaterial material_miski_na_przekaski = KonspektMaterial(
    name: 'Miski na przekąski',
    amount: 3
);

KonspektMaterial material_herbata = KonspektMaterial(
  name: 'Herbata',
);

KonspektMaterial material_kubek = KonspektMaterial(
  name: 'Kubek',
  amountAttendantFactor: 1,
);

KonspektMaterial material_czajnik = KonspektMaterial(
  name: 'Czajnik',
  amount: 1,
);

KonspektMaterial material_zal_kratka_minimow_rozwoju_duchowego = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_kratka_minimow_rozwoju_duchowego”',
    attachmentName: attach_name_kratka_minimow_rozwoju_duchowego,
    amount: 4
);

KonspektMaterial material_zal_scenariusz_fantomowe_dzialania_wychowawcze = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_scenariusz_fantomowe_dzialania_wychowawcze”',
    attachmentName: attach_name_scenariusz_fantomowe_dzialania_wychowawcze,
    additionalPreparation: 'Kartkę należy przeciąć na pół wzdłuż przerywanych linii.',
    amount: 1
);

KonspektMaterial material_zal_formy = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_formy”',
    attachmentName: attach_name_formy,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii.',
    amount: 1
);

KonspektMaterial material_zal_planowanie_strategii_i_dzialan = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_planowanie_strategii_i_dzialan”',
    attachmentName: attach_name_planowanie_strategii_i_dzialan,
    amount: 2,
    comment: 'Może się okazać, że chętni na jedną z metodyk będą tak liczni, że warto ich podzielić na dwie osobne grupy - dlatego warto wydrukować dwa razy.'
);

KonspektMaterial material_zal_przypinki = KonspektMaterial(
    name: 'Przypinki z logiem warsztatów',
    amountAttendantFactor: 1
);

Konspekt konspekt_kszt_warsztaty_wychowania_duchowego = Konspekt(
    name: konspekt_kszt_name_warsztaty_wychowania_duchowego,
    title: konspekt_kszt_title_warsztaty_wychowania_duchowego,
    additionalSearchPhrases: [
      'wychowanie duchowe'
    ],
    category: KonspektCategory.ksztalcenie,
    type: KonspektType.zajecia,
    spheres: {},
    metos: [Meto.kadra],
    coverAuthor: 'Daniel Iwanicki',
    author: DANIEL_IWANICKI,
    aims: [
      ...wstep_do_wychowania_duchowego_aims,
      'Zapoznanie uczestników z mechanizmami i narzędziami kształtowania duchowości.',
      'Przekazanie uczestnikom wiedzy o oczekiwanych efektach wychowania duchowego w zależności od wieku.',
      'Przekazanie uczestnikom wiedzy o formach praktycznej pracy nad duchowością harcerzy w zależności od wieku.',
      'Wykształcenie u uczestników zrozumienia i zdolności do tworzenia strategii rozwoju duchowego.',
    ],
    attachments: [
      attach_poradnik_o_strukturze_duchowosci,
      attach_poradnik_przykladowa_strategia_rozwoju_duchowego,

      attach_karty_poziomow_duchowosci,
      attach_karty_zdolnosci_integracji_duchowosci,

      attach_aksjomaty_opisu_przyklady,
      attach_aksjomaty_opisu_i_sensu_przyklady,
      attach_aksjomaty_sensu_przyklady,
      attach_aksjomaty_bledne_przyklady,

      attach_meta_narracja_opis,
      attach_meta_narracja_przyklady,
      attach_neutralnosc_duchowa_przyklady,
      attach_cel_wychowania_duchowego_zhp_statut,
      attach_cel_wychowania_duchowego_zhp_uchwala,
      attach_kratka_minimow_rozwoju_duchowego,

      ...attach_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
      attach_scenariusz_fantomowe_dzialania_wychowawcze,
      attach_formy,
      attach_planowanie_strategii_i_dzialan,

      attach_szybkie_strzaly_dyskusyjne
    ],
    materials: [

      material_poradnik_o_strukturze_duchowosci,
      material_poradnik_przykladowa_strategia_rozwoju_duchowego,

      material_identyfikator,

      material_dlugopis,

      material_notatnik,

      material_nozyczki,

      material_mini_kartki_biurowe,

      material_kartka_a4,

      material_flipchart,

      material_marker,

      material_tasma_klejaca,

      material_obiad,

      material_przekaski,

      material_miski_na_przekaski,

      material_herbata,

      material_kubek,

      material_czajnik,

      material_zal_karty_poziomow_duchowosci,
      material_zal_karty_zdolnosci_integracji_duchowosci,

      material_zal_aksjomaty_opisu_przyklady,
      material_zal_aksjomaty_opisu_i_sensu_przyklady,
      material_zal_aksjomaty_sensu_przyklady,
      material_zal_aksjomaty_bledne_przyklady,

      material_budzik,
      material_zal_meta_narracja_opis,
      material_zal_meta_narracja_przyklady,

      material_zal_neutralnosc_duchowa_przyklady,

      material_zal_cel_wychowania_duchowego_zhp_statut,

      material_zal_cel_wychowania_duchowego_zhp_uchwala,

      material_zal_kratka_minimow_rozwoju_duchowego,

      ...materials_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci,

      material_zal_scenariusz_fantomowe_dzialania_wychowawcze,

      material_zal_formy,

      material_zal_planowanie_strategii_i_dzialan,

      material_zal_szybkie_strzaly_dyskusyjne,

      material_zal_przypinki,

    ],
    summary: 'Uczestnicy pochylają się nad zagadnieniem duchowości: co to jest? co ją różni od innych sfer? jakie mechanizmy nią rządzą, czy może być ona "neutralna", oraz jak ją kształtować u wychowanków?.',
    stepGroups: [

      KonspektStepGroup(
          title: 'Wstęp',
          steps: [
            KonspektStep(
                title: 'Przyjście i ogarnięcie się',
                duration: Duration(minutes: 15),
                required: false,
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Nim rozpocznie się właściwa część warsztatów, warto pozwolić uczestnikom przyjść, zrobić hebratę i porozmawiwać o głupotach.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Rozpoczęcie',
                duration: Duration(minutes: 30),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący rozdaje uczestnikom <b>identyfikatory</b>, <b>długopisy</b> i <b>notatniki</b> (do własnego użytku uczestników). Na identyfikatorach uczestnicy wpisują swoje imię i je zakładają.'
                    '<br>'
                    '<br>Następnie, w kręgu, uczestnicy się <b>przedstawiają</b>. Prowadzący prosi, by każdy krótko odpowiedział na następujące zagadnienia:'
                    '</p>'

                    '<ol>'
                    '<li><p style="text-align:justify;">Co robię w harcerstwie?</p></li>'
                    '<li><p style="text-align:justify;">Jakie mam harcerskie doświadczenie z duchowością i religią?</p></li>'
                    '<li><p style="text-align:justify;">Słowo lub fraza - skojarzenie z duchowością.</p></li>'
                    '</ol>'

                    '<p style="text-align:justify;">'
                    'Każdy uczestnik zapisuje przedstawione skojarzenia z duchowością na <b>mini-kartkach</b> i umieszcza je na wspólnej, widocznej przestrzeni.'
                    '</p>',
                materials: [
                  material_identyfikator,
                  material_dlugopis,
                  material_notatnik,
                  material_mini_kartki_biurowe,
                ]
            ),

            KonspektStep(
              title: 'Oświadczenie wstępne',
              duration: Duration(minutes: 5),
              activeForm: KonspektStepActiveForm.static,
              content: '<p style="text-align:justify;">'
                  'Prowadzący informuje uczestników o celu warsztatów:'
                  '<br>'
                  '<br><b><i>Warsztaty nie służą indywidualnej pracy nad duchowością uczestników. Służą umiejętności wychowania duchowego harcerzy z perspektywy instruktora.</i></b>'
                  '<br>'
                  '<br>Warsztaty dzielą się na trzy części:'
                  '</p>'

                  '<ol>'
                  '<li><p style="text-align:justify;">Pojęcia i opis rozwoju duchowego - forma statyczna.</p></li>'
                  '<li><p style="text-align:justify;">Duchowość w kontekście wychowania harcerskiego - forma dyskusyjna.</p></li>'
                  '<li><p style="text-align:justify;">Praca z duchowością w poszczególnych metodykach - forma pracy w małych grupach.</p></li>'
                  '</ol>'

                  '<p style="text-align:justify;">'
                  'Prowadzący może również zaznaczyć, że <b>przedstawiony na warsztatach sposób rozumienia duchowości jest propozycją - nie jest to mądrość dana z niebios, ani wyryta w kamieniu. Owa propozycja jest efektem wielu lat doświadczeń, rozmów i analiz i podlega stałemu rozwojowi.</b>'
                  '</p>',
            ),
          ]
      ),

      KonspektStepGroup(
          title: 'Sfery człowieka (sfery rozwoju)',
          steps: [

            KonspektStep(
                title: 'Podział człowieka na sfery',
                duration: Duration(minutes: 2),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący zapoznaje uczestników z powszechnym w harcerstwie podziałem człowieka na pięć sfer: '
                    '</p>'
                    '<ul>'
                    '<li><p style="text-align:justify;">Sfera ciała (fizyczna)</p></li>'
                    '<li><p style="text-align:justify;">Sfera umysłu (intelektualna)</p></li>'
                    '<li><p style="text-align:justify;">Sfera emocjonalna</p></li>'
                    '<li><p style="text-align:justify;">Sfera relacji (społeczna)</p></li>'
                    '<li><p style="text-align:justify;">Sfera ducha</p></li>'
                    '</ul>'
                    '<p style="text-align:justify;">'
                    'Ów podział jest dokładnie opisany w poradniku $attach_html_poradnik_o_strukturze_duchowosci.'
                    '<br>'
                    '<br>Jeżeli uczestnicy prawdopodobnie znają ów podział, prowadzący może skrócić ten punkt i dla porządku poprosić uczestników o wymienienie wszystkich sfer.'
                    '</p>'

            ),

            KonspektStep(
                title: 'Sfera ciała (fizyczna)',
                duration: Duration(minutes: 1),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący po krótce wyjaśnia uczestnikom, czym jest sfera ciała:'
                    '<br>'
                    '<br><i>Sfera ciała jest wszystkim tym, co stwarza <b>zdolności</b> fizycznej interakcji z rzeczywistością, np.:</i>'
                    '</p>'
                    '<ul>'
                    '<li><p style="text-align:justify;"><i>Zdolność biegania</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Zdolność skakania</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Zdrowie</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Zdolność wyraźnego mówienia</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Zdolność widzenia, słyszenia, wąchania</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Zdolność wytrzymania w niskiej temperaturze</i></p></li>'
                    '</ul>'
            ),

            KonspektStep(
                title: 'Sfera umysłu (intelektualna)',
                duration: Duration(minutes: 1),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący po krótce wyjaśnia uczestnikom, czym jest sfera umysłu:'
                    '<br>'
                    '<br><i>Sfera umysłu jest wszystkim tym, co stwarza <b>zdolności</b> analizy, rozumienia, syntezy, wiedzy np.:</i>'
                    '</p>'
                    '<ul>'
                    '<li><p style="text-align:justify;"><i>Zdolność analitycznego myślenia</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Zdolność klarownego wysławiania się</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Umiejętność czytania</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Umiejętność szukania i zdobywania wiedzy</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Znajomość faktów</i></p></li>'
                    '</ul>'
            ),

            KonspektStep(
                title: 'Sfera relacji (społeczna)',
                duration: Duration(minutes: 1),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący po krótce wyjaśnia uczestnikom, czym jest sfera relacji:'
                    '<br>'
                    '<br><i>Sfera relacji jest wszystkim tym, co stwarza <b>zdolności</b> do skutecznego życia w społeczności (we wspólnocie wiedzy, we wspólnocie ekonomicznej, w rodzinie) np.:</i>'
                    '</p>'
                    '<ul>'
                    '<li><p style="text-align:justify;"><i>Zdolność negocjowania swojej roli społecznej</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Zdolność budowania więzi zależności i wsparcia</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Zdolność kompromitacji pozycji drugiej osoby w oczach społeczności</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Posiadanie rodziny</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Posiadanie znajomych</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Bycie w związku</i></p></li>'
                    '</ul>'
            ),

            KonspektStep(
                title: 'Sfera emocji',
                duration: Duration(minutes: 1),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący po krótce wyjaśnia uczestnikom, czym jest sfera emocji:'
                    '<br>'
                    '<br><i>Sfera emocji jest wszystkim tym, co stwarza <b>zdolności</b> do skutecznego życia w społeczności (we wspólnocie wiedzy, we wspólnocie ekonomicznej, w rodzinie) np.:</i>'
                    '</p>'
                    '<ul>'
                    '<li><p style="text-align:justify;"><i>Zdolność określenia własnego stanu emocjonalnego</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Zdolność określenia przyczyn własnego stanu emocjonalnego</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Umiejętność panowania nad swoimi emocjami (np. hamowania złości, działania mimo stresu)</i></p></li>'
                    '</ul>'
            ),

            KonspektStep(
                title: 'Sfery funkcjonalne',
                duration: Duration(minutes: 2),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący zwraca uwagę, że wszystkie wymienione dotąd 4 sfery (ciała, umysłu, relacji i emocji) są źródłami umiejętnościami, czy zdolności. Sprawiają, że człowiek "może więcej", jednak żadna z tych sfer, nawet rozwinięta do perfekcji, <b>nie określa kiedy, czy, ani jak należy jakąś zdolność wykorzystać</b>.'
                    '<br>'
                    '<br>Z tego powodu sfery <b>ciała</b>, <b>umysłu</b>, <b>relacji</b> i <b>emocji</b> są <b>sferami funkcjonalnymi</b> - są jak zestaw dostępnych narzędzi leżących w garażu.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Sfera ducha',
                duration: Duration(minutes: 1),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący definiuje sferę ducha:'
                    '<br>'
                    '<br><i>Sfera ducha jest wszystkim tym, co kształtuje sposób postępowania: określa kiedy i jak się zachować, jak korzystać z dostępnych zdolności, które dają sfery funkcjonalne. Co ważne, <b>sfera ducha sama w sobie nie stwarza żadnych zdolności</b> - rozwinięty duch nie pozwala ani dalej skakać, ani lepiej widzieć, ani więcej rozumieć.</i>'
                    '</p>'
            ),

            KonspektStep(
                title: 'Analogia samochodu',
                duration: Duration(minutes: 1),
                activeForm: KonspektStepActiveForm.static,
                required: true,
                content: '<p style="text-align:justify;">'
                    'Prowadzący, by podać intuicyjny przykład relacji między sferami funkcjonalnymi a sferą ducha, może posłużyć się następującą analogią:'
                    '<br>'
                    '<br><i>Sfery funkcjonalne można porównać do <b>funkcjonalności samochodu</b> - jego silnika, opon, zwrotności, głośników, ładowności, etc. Sfera ducha to <b>kierowca samochodu</b>: to on wybiera kierunek jazdy, prędkość, muzykę, rodzaj świateł, odczytuje prędkość i awarie z tablicy rozdzielczej. Samochód, nieważne jak dobry, bez kierowcy nigdzie nie pojedzie. Kierowca, nieważne jak doświadczony, w zepsutym samochodzie też donikąd nie dojedzie.</i>'
                    '</p>'
            ),

          ]),

      step_group_poziomy_duchowosci,

      step_group_integracja_duchowosci,

      step_group_metanarracja,

      step_group_duchowosc_powszechna_madrosc_kultura_tradycja,

      step_group_zdolnosc_integracji_duchowosci,

      KonspektStepGroup(
          steps: [
            KonspektStep(
                title: 'Przerwa',
                duration: Duration(minutes: 10),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Przerwa na rozprostowanie nóg, przewietrzenie się, siku itp..'
                    '</p>'
            ),
          ]
      ),

      KonspektStepGroup(
          title: 'Czynniki i mechanizmy kształtowania duchowości',
          steps: steps_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci.map((step) => step.copyWithNamePrefix('Czynniki duchowości - ')).toList()
      ),

      KonspektStepGroup(
          steps: [
            KonspektStep(
                title: 'Obiad',
                duration: Duration(minutes: 45),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Najlepiej już wcześniej zamówić pizzę, żeby jedzenie trwało niewiele czasu i by można było po nim chwilę odpocząć.'
                    '</p>',
                materials: [
                  material_obiad,
                ]
            ),
          ]
      ),

      step_group_neutralnosc_duchowa,

      step_group_duchowosc_w_zhp,

      KonspektStepGroup(
          title: 'Praktyka wychowania duchowego',
          steps: [
            KonspektStep(
                title: 'Praktyka wychowania duchowego - kratka i formy',
                duration: Duration(minutes: 30),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Uczestnicy otrzymują w grupach po jednym załączniku $attach_html_kratka_minimow_rozwoju_duchowego. Otrzymują również wydrukowane i wycięte formy z załącznika $attach_html_formy.'
                    '<br>'
                    '<br>Na podstawie zdobytej dotychczas wiedzy oraz załącznika $attach_html_kratka_minimow_rozwoju_duchowego, zadaniem uczestników jest przyporządkowanie poszczególnych form do <b>grupy</b> lub <b>grup wiekowych</b>, określenie jakie <b>poziomy duchowości</b> rozwijają oraz, jeśli to możliwe, w jaki <b>mechanizm</b> wykorzystują.'
                    '<br>'
                    '<br>Warto uczestników podzielić na grupy po 3-4 osoby, aby jak najbardziej zaangażować ich w dyskusję nad formami.'
                    '</p>',
                materials: [
                  material_zal_kratka_minimow_rozwoju_duchowego,
                  material_zal_formy,
                ]
            ),

            KonspektStep(
                title: 'Praktyka wychowania duchowego - kratka i formy - podsumowanie',
                duration: Duration(minutes: 10),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący zbiera na powrót wszystkie grupy w jedno miejsce i prosi, by każda z grup przestawiła po kilka wybranych form które:'
                    '</p>'

                    '<ul>'
                    '<li><p style="text-align:justify;">Najbardziej przypadły im do gustu.</p></li>'
                    '<li><p style="text-align:justify;">Najbardziej ich zaskoczyły.</p></li>'
                    '<li><p style="text-align:justify;">Wydały im się najbardziej kontrowersyjne.</p></li>'
                    '</ul>'

                    '<p style="text-align:justify;">'
                    'Prowadzący może skorzystać z okazji, po przedstawieniu najbardziej kontrowesyjnych form zauważyć, że harcerstwo opiera się na <b>wychowaniu poprzez stawianie wyzwań</b> i nie należy się łudzić, że można wychować kogoś w ciągłym, bezgranicznym bezpieczeństwie i komforcie. Lepiej, aby rozwój duchowy zakładał budowanie odporności na trudy i nieprzyjemne sytuacje, niż od nich izolował - harcerstwo nie wychowuje <b>pod kloszem</b>.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Fantomowe działania wychowawcze i skuteczność wychowawcza',
                duration: Duration(minutes: 10),
                activeForm: KonspektStepActiveForm.static,
                required: false,
                content: '<p style="text-align:justify;">'
                    'Prowadzący prezentuje krótki opis obozu drużyny z załącznika $attach_html_scenariusz_fantomowe_dzialania_wychowawcze i podejmowanych tam działań duchowych, które są zupełnie losowe. Na tej podstawie zapoczątkowuje krótką dyskusję zadając pytanie: “co jest nie tak z tą strategią?”. Po krótkiej wymianie opinii prowadzący odpowiada wprowadzając pojęcie “<b>fantomowych działań wychowawczych</b>”.'
                    '<br>'
                    '<br>W oparciu o dotychczasowe pojęcia powinno paść hasło “<b>skuteczności wychowawczej</b>”.'
                    '<br>'
                    '<br>Prowadzący może posiłkować się pytaniami:'
                    '<br>'
                    '<br><b>Czy któraś z tych form nie kształtuje duchowości?</b>'
                    '<br>'
                    '<br><b>Jaki jest problem z tak skonstruowanym planem wychowania duchowego?</b>'
                    '</p>',
                materials: [
                  material_zal_scenariusz_fantomowe_dzialania_wychowawcze,
                ]
            ),
          ]
      ),

      KonspektStepGroup(
          steps: [
            KonspektStep(
                title: 'Przerwa',
                duration: Duration(minutes: 10),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Przerwa na rozprostowanie nóg, przewietrzenie się, siku itp..'
                    '</p>'
            ),
          ]
      ),

      step_strategia_wychowania_duchowego,

      KonspektStepGroup(
          title: 'Planowanie wychowania duchowego',
          steps: [

            KonspektStep(
                title: 'Planowanie wychowania duchowego - podział na grupy',
                duration: Duration(minutes: 5),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Uczestnicy w grupach są dzieleni na 4 grupy. Każda grupa otrzymuje krótki opis drużyny z załącznika $attach_html_planowanie_strategii_i_dzialan. Zadaniem każdej grupy jest stworzyć plan rozwoju duchowego jednostki.'
                    '<br>'
                    '<br>Każda z opisanych na karce drużyn jest w innej metodyce (Z, H, HS, W). Prowadzący może podzielić uczestników tak, by każdy był w grupie pracującej nad metodyką, która jest uczestnikom najbliższa.'
                    '<br>'
                    '<br>Na początku prowadzący prosi każdą z grup, by zapoznałą się z opisami.'
                    '</p>',
                materials: [
                  material_zal_planowanie_strategii_i_dzialan,
                ]
            ),

            KonspektStep(
                title: 'Planowanie wychowania duchowego - przykladowa strategia',
                duration: Duration(minutes: 15),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący prezentuje uczestnikom przykładową strategię rozwoju duchowego drużyny, która jest opisana w załączniku $attach_html_poradnik_przykladowa_strategia_rozwoju_duchowego.'
                    '<br>'
                    '<br>Zadaniem uczestników jest stworzenie strategii o podobnej formie dla jednostek, które wybrali w poprzednim kroku.'
                    '<br>'
                    '<br>Prowadzący po zakończeniu przedstawiania przykładowej strategii mówi, że <b>jest dostępna w aplikacji HarcApp jako poradnik</b> i uczestnicy mogą w każdej chwili do niej zajrzeć.'
                    '</p>',
                materials: [
                  material_poradnik_przykladowa_strategia_rozwoju_duchowego
                ]
            ),

            KonspektStep(
                title: 'Planowanie wychowania duchowego - cele',
                duration: Duration(minutes: 15),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący prosi każdą z grup, by wskazała, jakie <b>cele w pracy duchowej</b> chce osiągnąć dla opisanej drużyny. Należy założyć, że praca z opisaną grupą bedzie trwała 3 lata.'
                    '</p>',
                materials: [
                  material_zal_planowanie_strategii_i_dzialan,
                ]
            ),

            KonspektStep(
                title: 'Planowanie wychowania duchowego - czynniki duchowości',
                duration: Duration(minutes: 15),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący prosi każdą z grup, by wskazała mechanizmy oparte o trzy czynniki duchowości, za pomocą których można zrealizować wyłonione uprzednio cele.'
                    '<br>'
                    '<br>Wszystkie czynniki duchowości powinny być wyłożone w widocznym miejscu na kartkach z załącznika $attach_html_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci.'
                    '<br>'
                    '<br>Na tym etapie zadaniem grup <b>nie jest wymyślanie żadnych zajęć</b> dla harcerzy. Chodzi o podjęcie działania w stylu: <i>przekonanie rodziców zuchów, aby do 14 roku życia miały one na wyłączność dostęp tylko do prostych telefonów bez funkcji dotykowych, aby zwiększyć częstotliwość ich interakcji z niecyfrowym światem, który stawia większe wyzwania.</i>'
                    '<br>'
                    '<br>Prowadzący może zasugerować, by grupy skoncentrowały się na następujących czynnikach:'
                    '</p>'

                    '<ul>'
                    '<li><p style="text-align:justify;">Przykład własny autorytetów</p></li>'
                    '<li><p style="text-align:justify;">Oczekiwania uznanych autorytetów</p></li>'
                    '<li><p style="text-align:justify;">Normy</p></li>'
                    '</ul>'

                    '<p style="text-align:justify;">'
                    'Jeżeli jednak grupy uznają, że są w stanie wykorzystać inne czynniki do osiągnięcia celów, mogą ich użyć.'
                    '<br>'
                    '<br>Jeżeli w ramach grup pojawi się konflikt poglądów, który nie zostanie ujednolicony wskutek dyskusji, należy zachować wszystkie perspektywy do późniejszego ich omówienia na forum.'
                    '</p>',
                materials: [
                  material_zal_planowanie_strategii_i_dzialan,
                  material_zal_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
                ]
            ),

            KonspektStep(
                title: 'Planowanie wychowania duchowego - omówienie postępu prac',
                duration: Duration(minutes: 10),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący zbiera na chwilę w jedno miejsce wszystkich uczestników i prosi każdą z grup, by przedstawiła swoje opisane cele, wybrane czynniki duchowości i mechanizmy kształtowania duchowości. Po każdej z prezentacji może się odbyć krótka dyskusja nad planami.'
                    '<br>'
                    '<br>Ten punkt służy temu, aby prowadzący miał możliwość zareagować, jeśli któraś z grup zacznie błądzić w założeniach.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Planowanie wychowania duchowego - działania bezpośrednie',
                duration: Duration(minutes: 20),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący prosi każdą z grup, by jako ostatni element planowania strategii rozwoju duchowego wskazała <b>działania śródroczne</b> i <b>działania obozowe</b> z uwzględnieniem <b>niedzieli na obozie</b>. Można się w tym celu posiłkować pomysłami z załącznika $attach_html_formy, które są dostępne w apliakcji <b>HarcApp</b>.'
                    '<br>'
                    '<br>Jeżeli w ramach grup pojawi się konflikt poglądów, który nie zostanie ujednolicony wskutek dyskusji, należy zachować wszystkie perspektywy do późniejszego ich omówienia na forum.'
                    '<br>'
                    '<br>Grupy pracujące na opisie jednostek H, HS i W mogą także określić oczekiwania wychowawcze od jednostek niższego pionu, które przekazują im harcerzy w ciągu wychowawczym.'
                    '</p>',
                materials: [
                  material_zal_formy,
                ]
            ),

            KonspektStep(
                title: 'Planowanie wychowania duchowego - prezentacja',
                duration: Duration(minutes: 40),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Każda z grup ma kilka minut, aby <b>zaprezentować</b> swoje strategie i działania.'
                    '<br>'
                    '<br>Po każdej z prezentacji może się odbyć krótka dyskusja nad planami - prowadzący powinien zachęcać do krytyki, jeżeli ktoś się z czymś nie zgadza.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Niedziela na obozie',
                duration: Duration(minutes: 20),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący zanotowawszy plany i strategie rozwoju duchowego związane z niedzielą obozową prezentowane w poprzednim punkcie przez grupy podsumowuje je. Uczestnicy mają możliwość dodania proponowanych form - ważne, by prowadzący prosił o podanie mechanizmu ich działania.'
                    '<br>'
                    '<br>Na końcu prowadzący uzupełnia zbiorczy plan niedzieli o elementy obecne w formie <i>“Msza (obozowa, lecz nie tylko)”</i> z załącznika $attach_html_formy i krótko je omawia.'
                    '</p>'
            ),

          ]
      ),

      KonspektStepGroup(
          steps: [

            step_szybkie_strzaly_dyskusyjne,

            KonspektStep(
                title: 'Podsumowanie warsztatów',
                duration: Duration(minutes: 20),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący zaprasza uczestników do wspólnego kręgu w celu podsumowania warsztatów. Przy tej okazji warto skupić się na następujących rzeczach:'
                    '</p>'

                    '<ul>'
                    '<li><p style="text-align:justify;">Rozdanie dyplomów i przypinek uczestnikom.</p></li>'
                    '<li><p style="text-align:justify;">Poproszenie uczestników o podzielenie się wrażeniami związanymi z warsztatami.</p></li>'
                    '<li><p style="text-align:justify;">Prośba o uzupełnienie szczegółowej ankiety ewaluacyjnej - przesłanie jej uczestnikom na maila.</p></li>'
                    '<li><p style="text-align:justify;">Wspólne zdjęcie.</p></li>'
                    '<li><p style="text-align:justify;">Oddanie indetyfikatorów przez uczestników.</p></li>'
                    '</ul>'
            ),
          ]
      ),
    ]
);