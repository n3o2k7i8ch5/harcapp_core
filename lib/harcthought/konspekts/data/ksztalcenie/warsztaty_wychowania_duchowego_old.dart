import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common_attachments.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/warsztaty_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

import 'common_wychowanie_duchowe.dart';

const String _assetPath = 'asset:packages/harcapp_core/assets/konspekty/ksztalcenie/warsztaty_wychowania_duchowego_old';
const String _imgStyle = 'object-fit: contain; width: 100%; height: auto;';

String _piramidaDuchowosci1HtmlLight = '<img src="$_assetPath/piramida_duchowosci_1_light.svg" style="$_imgStyle" alt="Piramida duchowości part"/>';
String _piramidaDuchowosci1HtmlDark = '<img src="$_assetPath/piramida_duchowosci_1_dark.svg" style="$_imgStyle" alt="Piramida duchowości part"/>';
String piramidaDuchowosci1Html({required bool isDark}) => isDark?_piramidaDuchowosci1HtmlDark:_piramidaDuchowosci1HtmlLight;

String _piramidaDuchowosci2HtmlLight = '<img src="$_assetPath/piramida_duchowosci_2_light.svg" style="$_imgStyle" alt="Piramida duchowości"/>';
String _piramidaDuchowosci2HtmlDark = '<img src="$_assetPath/piramida_duchowosci_2_dark.svg" style="$_imgStyle" alt="Piramida duchowości"/>';
String piramidaDuchowosci2Html({required bool isDark}) => isDark?_piramidaDuchowosci2HtmlDark:_piramidaDuchowosci2HtmlLight;

String _piramidaDuchowosci3HtmlLight = '<img src="$_assetPath/piramida_duchowosci_3_light.svg" style="$_imgStyle" alt="Piramida duchowości"/>';
String _piramidaDuchowosci3HtmlDark = '<img src="$_assetPath/piramida_duchowosci_3_dark.svg" style="$_imgStyle" alt="Piramida duchowości"/>';
String piramidaDuchowosci3Html({required bool isDark}) => isDark?_piramidaDuchowosci3HtmlDark:_piramidaDuchowosci3HtmlLight;

String _cyklIntegracjiDuchowosciHtmlLight = '<img src="$_assetPath/cykl_integracji_duchowosci_light.svg" style="$_imgStyle" alt="Cykl integracji duchowości"/>';
String _cyklIntegracjiDuchowosciHtmlDark = '<img src="$_assetPath/cykl_integracji_duchowosci_dark.svg" style="$_imgStyle" alt="Cykl integracji duchowości"/>';
String cyklIntegracjiDuchowosciHtml({required bool isDark}) => isDark?_cyklIntegracjiDuchowosciHtmlDark:_cyklIntegracjiDuchowosciHtmlLight;

const konspekt_kszt_name_warsztaty_wychowania_duchowego_old = 'warsztaty_wychowania_duchowego_old';

// Przykłady aksjomatów

const String _attach_html_aksjomaty_opisu_przyklady = '<a href="$_attach_name_aksjomaty_opisu_przyklady@attachment">$_attach_title_aksjomaty_opisu_przyklady</a>';
const String _attach_name_aksjomaty_opisu_przyklady = 'aksjomaty_opisu_przyklady';
const String _attach_title_aksjomaty_opisu_przyklady = 'Aksjomaty opisu przykłady';
KonspektAttachment _attach_aksjomaty_opisu_przyklady = KonspektAttachment(
  name: _attach_name_aksjomaty_opisu_przyklady,
  title: _attach_title_aksjomaty_opisu_przyklady,
  assets: {
    FileFormat.pdf: null,
    FileFormat.docx: null,
  },
);

const String _attach_html_aksjomaty_sensu_przyklady = '<a href="$_attach_name_aksjomaty_sensu_przyklady@attachment">$_attach_title_aksjomaty_sensu_przyklady</a>';
const String _attach_name_aksjomaty_sensu_przyklady = 'aksjomaty_sensu_przyklady';
const String _attach_title_aksjomaty_sensu_przyklady = 'Aksjomaty sensu przykłady';
KonspektAttachment _attach_aksjomaty_sensu_przyklady = KonspektAttachment(
  name: _attach_name_aksjomaty_sensu_przyklady,
  title: _attach_title_aksjomaty_sensu_przyklady,
  assets: {
    FileFormat.pdf: null,
    FileFormat.docx: null,
  },
);

const String _attach_html_aksjomaty_bledne_przyklady = '<a href="$_attach_name_aksjomaty_bledne_przyklady@attachment">$_attach_title_aksjomaty_bledne_przyklady</a>';
const String _attach_name_aksjomaty_bledne_przyklady = 'aksjomaty_bledne_przyklady';
const String _attach_title_aksjomaty_bledne_przyklady = 'Aksjomaty błedne przykłady';
KonspektAttachment _attach_aksjomaty_bledne_przyklady = KonspektAttachment(
  name: _attach_name_aksjomaty_bledne_przyklady,
  title: _attach_title_aksjomaty_bledne_przyklady,
  assets: {
    FileFormat.pdf: null,
    FileFormat.docx: null,
  },
);

// Przykłady poziomów duchowości

const String _attach_html_przyklady_poziomow_duchowosci = '<a href="$_attach_name_przyklady_poziomow_duchowosci@attachment">$_attach_title_przyklady_poziomow_duchowosci</a>';
const String _attach_name_przyklady_poziomow_duchowosci = 'przyklady_poziomow_duchowosci';
const String _attach_title_przyklady_poziomow_duchowosci = 'Przykłady poziomów duchowości';
KonspektAttachment _attach_przyklady_poziomow_duchowosci = KonspektAttachment(
  name: _attach_name_przyklady_poziomow_duchowosci,
  title: _attach_title_przyklady_poziomow_duchowosci,
  assets: {
    FileFormat.pdf: null,
    FileFormat.docx: null,
  },
);

const String _attach_html_mechanizmy_posrednie = '<a href="$_attach_name_mechanizmy_posrednie@attachment">$_attach_title_mechanizmy_posrednie</a>';
const String _attach_name_mechanizmy_posrednie = 'mechanizmy_posrednie';
const String _attach_title_mechanizmy_posrednie = 'Mechanizmy pośrednie';
KonspektAttachment _attach_mechanizmy_posrednie = KonspektAttachment(
  name: _attach_name_mechanizmy_posrednie,
  title: _attach_title_mechanizmy_posrednie,
  assets: {
    FileFormat.pdf: null,
    FileFormat.docx: null,
  },
);

const String _attach_html_antyprzyklady = '<a href="$_attach_name_antyprzyklady@attachment">$_attach_title_antyprzyklady</a>';
const String _attach_name_antyprzyklady = 'antyprzyklady';
const String _attach_title_antyprzyklady = 'Antyprzykłady';
KonspektAttachment _attach_antyprzyklady = KonspektAttachment(
  name: _attach_name_antyprzyklady,
  title: _attach_title_antyprzyklady,
  assets: {
    FileFormat.pdf: null,
    FileFormat.docx: null,
  },
);

const String _attach_html_scenariusze = '<a href="$_attach_name_scenariusze@attachment">$_attach_title_scenariusze</a>';
const String _attach_name_scenariusze = 'scenariusze';
const String _attach_title_scenariusze = 'Scenariusze';
KonspektAttachment _attach_scenariusze = KonspektAttachment(
  name: _attach_name_scenariusze,
  title: _attach_title_scenariusze,
  assets: {
    FileFormat.pdf: null,
    FileFormat.docx: null,
  },
);

KonspektMaterial _material_zal_aksjomaty_opisu_przyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik “$_attach_title_aksjomaty_opisu_przyklady”',
    attachmentName: _attach_name_aksjomaty_opisu_przyklady,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii i pomieszać ich kolejność.',
    amount: 1
);

KonspektMaterial _material_zal_aksjomaty_sensu_przyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik “$_attach_title_aksjomaty_sensu_przyklady”',
    attachmentName: _attach_name_aksjomaty_sensu_przyklady,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii i pomieszać ich kolejność.',
    amount: 1
);

KonspektMaterial _material_zal_aksjomaty_bledne_przyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik “$_attach_title_aksjomaty_bledne_przyklady”',
    attachmentName: _attach_name_aksjomaty_bledne_przyklady,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii i pomieszać ich kolejność.',
    amount: 1
);

KonspektMaterial material_zal_przyklady_poziomow_duchowosci = KonspektMaterial(
    name: 'Wydrukowany załącznik "$_attach_title_przyklady_poziomow_duchowosci"',
    attachmentName: _attach_name_przyklady_poziomow_duchowosci,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii i potasować w ramach wyciętych czwórek.',
    amount: 1
);

KonspektMaterial material_zal_mechanizmy_posrednie = KonspektMaterial(
    name: 'Wydrukowany załącznik "$_attach_title_mechanizmy_posrednie"',
    attachmentName: _attach_name_mechanizmy_posrednie,
    additionalPreparation: 'Kartki należy przeciąć na pół wzdłuż przerywanych linii.',
    amount: 1
);

KonspektMaterial material_zal_antyprzyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik "$_attach_title_antyprzyklady"',
    attachmentName: _attach_name_antyprzyklady,
    amount: 1
);

KonspektMaterial material_zal_scenariusze = KonspektMaterial(
    name: 'Wydrukowany załącznik "$_attach_title_scenariusze"',
    attachmentName: _attach_name_scenariusze,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii.',
    amount: 1
);

Konspekt konspekt_kszt_warsztaty_wychowania_duchowego_old = Konspekt.oldFrom(
    konspekt_kszt_warsztaty_wychowania_duchowego,
    attachments: [

      _attach_aksjomaty_opisu_przyklady,
      _attach_aksjomaty_sensu_przyklady,
      _attach_aksjomaty_bledne_przyklady,

      _attach_przyklady_poziomow_duchowosci,
      _attach_mechanizmy_posrednie,
      _attach_antyprzyklady,
      _attach_scenariusze
    ],
    materials: [

      _material_zal_aksjomaty_opisu_przyklady,
      _material_zal_aksjomaty_sensu_przyklady,
      _material_zal_aksjomaty_bledne_przyklady,

      material_zal_przyklady_poziomow_duchowosci,
      material_zal_mechanizmy_posrednie,
      material_zal_antyprzyklady,
      material_zal_scenariusze,
    ],
    stepGroups: [

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
                    'Prowadzący pokrótce wyjaśnia uczestnikom, czym jest sfera ciała:'
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
                    'Prowadzący pokrótce wyjaśnia uczestnikom, czym jest sfera umysłu:'
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
                    'Prowadzący pokrótce wyjaśnia uczestnikom, czym jest sfera relacji:'
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
                    'Prowadzący pokrótce wyjaśnia uczestnikom, czym jest sfera emocji:'
                    '<br>'
                    '<br><i>Sfera emocji jest wszystkim tym, co stwarza <b>zdolności</b> do rozumienia i panowania nad własnym systemem emocjonalnym np.:</i>'
                    '</p>'
                    '<ul>'
                    '<li><p style="text-align:justify;"><i>Zdolność określenia własnego stanu emocjonalnego</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Zdolność określenia przyczyn własnego stanu emocjonalnego</i></p></li>'
                    '<li><p style="text-align:justify;"><i>Umiejętność panowania nad swoimi emocjami (np. hamowania złości, działania mimo stresu)</i></p></li>'
                    '</ul>'
            ),

            KonspektStep(
                title: 'Sfery zdolności',
                duration: Duration(minutes: 2),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący zwraca uwagę, że wszystkie wymienione dotąd 4 sfery (ciała, umysłu, relacji i emocji) są źródłami umiejętności, czy zdolności. Sprawiają, że człowiek "może więcej", jednak żadna z tych sfer, nawet rozwinięta do perfekcji, <b>nie określa kiedy, czy, ani jak należy jakąś zdolność wykorzystać</b>.'
                    '<br>'
                    '<br>Z tego powodu sfery <b>ciała</b>, <b>umysłu</b>, <b>relacji</b> i <b>emocji</b> są <b>sferami zdolności</b> - są jak zestaw dostępnych narzędzi leżących w garażu.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Sfera ducha',
                duration: Duration(minutes: 1),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący definiuje sferę ducha:'
                    '<br>'
                    '<br><i>Sfera ducha jest wszystkim tym, co kształtuje sposób postępowania: określa kiedy i jak się zachować, jak korzystać z dostępnych zdolności, które dają sfery zdolności. Co ważne, <b>sfera ducha sama w sobie nie stwarza żadnych zdolności</b> - rozwinięty duch nie pozwala ani dalej skakać, ani lepiej widzieć, ani więcej rozumieć.</i>'
                    '</p>'
            ),

            KonspektStep(
                title: 'Analogia samochodu',
                duration: Duration(minutes: 1),
                activeForm: KonspektStepActiveForm.static,
                required: true,
                content: '<p style="text-align:justify;">'
                    'Prowadzący może posłużyć się następującą analogią:'
                    '<br>'
                    '<br><i>Sfery zdolności można porównać do <b>funkcjonalności samochodu</b> - jego silnika, opon, zwrotności, głośników, ładowności, etc. Sfera ducha to <b>kierowca samochodu</b>: to on wybiera kierunek jazdy, prędkość, muzykę, rodzaj świateł, odczytuje prędkość i awarie z tablicy rozdzielczej. Samochód, nieważne jak dobry, bez kierowcy nigdzie nie pojedzie. Kierowca, nieważne jak doświadczony, w zepsutym samochodzie też donikąd nie dojedzie.</i>'
                    '</p>'
            ),

          ]),

      KonspektStepGroup(
        title: 'Poziomy rozwoju duchowego - rozroznienie aksjomatow',
        steps: [

          KonspektStep(
              title: 'Poziomy rozwoju duchowego - rozroznienie aksjomatow',
              aims: [
                'Zbudowanie u uczestników intuicji dotyczącej tego, co jest, a co nie jest aksjomatem.',
              ],
              materials: [
                _material_zal_aksjomaty_opisu_przyklady,
                _material_zal_aksjomaty_sensu_przyklady,
                _material_zal_aksjomaty_bledne_przyklady,
              ],
              duration: Duration(minutes: 10),
              activeForm: KonspektStepActiveForm.active,
              content: '<p style="text-align:justify;">'
                  'Aby uczestnicy oswoili się z aksjomatami, prowadzący rozdaje im wycięte i pomieszane kartki z przykładami z załączników $_attach_html_aksjomaty_opisu_przyklady, $_attach_html_aksjomaty_sensu_przyklady i $_attach_html_aksjomaty_bledne_przyklady.'
                  '<br>'
                  '<br>Zadaniem uczestników jest pogrupować przykłady aksjomatów odpowiednio jako <b>aksjomaty opisu</b> oraz <b>aksjomaty sensu</b> - mając na uwadze, że <b>kilka przykładów nie jest aksjomatem</b> w ogóle. W trakcie ćwiczenia uczestnicy mogą prosić prowadzącego o pomoc.'
                  '<br>'
                  '<br>Kartki z przykładowymi aksjomatami powinny zostać ułożone w trzech kolumnach pod wyłożoną podczas prezentowania poziomów duchowości kartką "Aksjomat". Przykłady, które nie są aksjomatami należy odłożyć gdzieś z boku.'
                  '<br>'
                  '<br>Na końcu prowadzący pokrótce omawia z uczestnikami poprawność ich dopasowania.'
                  '</p>'
          )

]
      ),

      KonspektStepGroup(
          title: 'Poziomy duchowości',
          steps: [
            KonspektStep(
                title: 'Poziomy (warstwy) rozwoju duchowego - sprawdzenie',
                duration: Duration(minutes: 15),
                activeForm: KonspektStepActiveForm.active,
                required: false,
                content: '<p style="text-align:justify;">'
                    'Prowadzący dzieli uczestników na pięć grup. Rozdaje każdej grupie po jednym komplecie przygotowanych kartek z załącznika $_attach_html_przyklady_poziomow_duchowosci i prosi grupy o <b>posegregowanie kartek na zachowania, postawy, wartości i aksjomaty.</b>'
                    '<br>'
                    '<br>Gdy dana grupa jest gotowa, zgłasza się do prowadzącego, który podchodzi i sprawdza. Jeśli coś jest nie tak, prowadzący mówi który poziom duchowości wymaga poprawy. Gdy wszystkie grupy są gotowe, niezależnie od poprawności segregacji, prowadzący omawia na forum poprawne przyporządkowanie.'
                    '</p>',
                materials: [
                  material_zal_przyklady_poziomow_duchowosci,
                ]
            ),
          ]
      ),


      KonspektStepGroup(
          title: 'Integracja duchowości',
          steps: [
            KonspektStep(
              title: 'Integracja duchowości - osie współrzędnych',
              duration: Duration(minutes: 1),
              activeForm: KonspektStepActiveForm.static,
              content: '<p style="text-align:justify;">'
                  'Prowadzący bierze dużą kartkę (np. flipchart) i rysuje na niej dwie prostopadłe osie współrzędnych. Na osi X zaznacza <b>czas</b>, zaś na osi Y <b>poziom duchowości</b>. Tłumaczy przy tym, że przejdzie teraz z uczestnikami krok po kroku przez sposób, w jaki kształtuje się duchowość człowieka.'
                  '</p>',
            ),
            KonspektStep(
                title: 'Integracja duchowości - etapy kształtowania duchowości',
                duration: Duration(minutes: 3),
                activeForm: KonspektStepActiveForm.static,
                materials: [
                  material_flipchart,
                  material_marker,
                ],
                contentBuilder: ({required bool isDark}) => '<p style="text-align:justify;">'
                    'Prowadzący na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci opisuje właściwe <b>etapy rozwoju duchowego</b>. Przy każdym etapie prowadzący zaznacza na osi czasu <b>orientacyjny wiek</b> człowieka, którego omawiany etap dotyczy.'
                    '</p>'

                    '<ol>'
                    '<li>'
                    '<p style="text-align:justify;">'
                    '<i>Etap dziecięcy + zuchowy:</i>'
                    '<br>Od dnia narodzin, aż do ok. 10. roku życia duchowość człowieka nie wykracza poza <b>poziom zachowań</b> i <b>postaw</b>. Z perspektywy dziecka jedne zachowania są dobre, a inne złe - i kropka. To m.in. dlatego Prawo Zucha opowiada "co zuch robi", a nie "jakimi wartościami zuch się kieruje". Abstrakcyjne określenia jak "bycie grzecznym" są rozumiane jako "worek na zachowania": np. mówienie dzień dobry, dziękuję i przepraszam, mycie rąk po wejściu do domu i odkładanie zabawek na miejsce.'
                    '</p>'
                    '</li>'

                    '<li>'
                    '<p style="text-align:justify;">'
                    '<i>Etap harcerski:</i>'
                    '<br>W wieku ok. 10 lat można zacząć mówić u dzieci o zdolności abstrakcyjnego myślenia. Zaczynają rozumieć, że dobre zachowania nie są "dobre, bo tak", ale są dobre, bo wynikają z określonych <b>wartości</b>. Nie trzeba wtedy już mówić: "zawsze przywitaj się i podziękuj", można zamiast tego powiedzieć: "odnoś się z szacunkiem".'
                    '<br>'
                    '<br>Wartości, które młody człowiek świadomie przyjmie jako pierwsze są zazwyczaj <b>spójne z zachowaniami i postawami, którymi na tym etapie żyje</b>. Np. jeśli człowiek w grze w piłkę był nauczony podawać często do kolegów, naturalną wartością będzie dla niego współpraca.'
                    '</p>'
                    '</li>'

                    '<li>'
                    '<p style="text-align:justify;">'
                    '<i>Etap starszoharcersko-wędrowniczy + dorosły:</i>'
                    '<br>W wieku ok. 13-15 lat wartości przestają być luźnymi bytami i są porządkowane w spójne światopoglądy, które mają swoje przyczyny. Przyczynami tymi są <b>aksjomaty</b>, czyli przyjęte, fundamentalne, nieweryfikowalne założenia o świecie. Towarzyszy temu zdolność do zrozumienia, że różni ludzie mogą mieć różny światopogląd i czerpać swoje wartości z różnych źródeł. Pojawia się też <u>zdolność</u> do zrozumienia, że nie ma możliwości jednoznacznego określenia który światopogląd czy które aksjomaty są słuszne, a które błędne.'
                    '<br>'
                    '<br>Podobnie jak wcześniej, pierwsze świadomie przyjęte aksjomaty nie są losowe. Człowiek ma tendencję do przyjęcia aksjomatów, <b>o których wcześniej słyszał</b> i <b>z których wynikają wartości, którymi na tym etapie żyje</b>. Np., jeśli dla młodego człowieka wartością była współpraca i koleżeństwo, naturalnym aksjomatem może być dla niego zbawcza i powszechna rola odkupienia każdego człowieka przez Chrystusa, z której wynika niezbywalna godność każdego człowieka.'
                    '</p>'
                    '</li>'

                    '</ol>'

                    '<p style="text-align:justify;">'
                    'Prowadzący opisując przejście między kolejnymi etapami rozwoju duchowego rysuje <b>kolejne poziomy duchowości</b> na flipcharcie, tak jak poniżej:'
                    '<br>${piramidaDuchowosci1Html(isDark: isDark)}'
                    '</p>'
            ),
            KonspektStep(
                title: 'Integracja duchowości - jak duchowość nie jest kształtowana',
                duration: Duration(minutes: 2),
                activeForm: KonspektStepActiveForm.static,
                materials: [
                  material_flipchart.copyWith(amount: 1),
                  material_marker,
                ],
                content: '<p style="text-align:justify;">'
                    'Prowadzący opisuje <b>dla zbudowania kontekstu</b> intuicyjny, ale <b>zupełnie nieprawdziwy</b> sposób kształtowania duchowości. Zaczyna od zwrócenia uwagi:'
                    '<br>'
                    '<br><i>Najlepiej byłoby, gdyby każdy człowiek najpierw ustalał swoje aksjomaty - czyli fundament duchowości, następnie wnioskował z nich spójne wartości, zaś z wartości wnioskował właściwe postawy i zachowania. Potem żyłby długo i szczęśliwie, postępując zawsze w zgodzie z samym sobą, czasem tylko odkryłby jakąś nową wartość, albo nowe właściwe zachowanie.'
                    '<br>'
                    '<br>Wszystko fajnie - ale próbował ktoś porozmawiać z niemowlakiem o filozofii egzystencjalnej, aksjomatach, albo chociaż wyższości jednych wartości nad drugimi? A przecież każdy niemowlak jakoś się już zachowuje, czyli ma już określoną duchowość!</i>'
                    '<br>'
                    '<br>Prowadzący zauważa, że w sposób oczywisty kształtowanie duchowości <b>nie odbywa się</b> od poziomów głębokich (aksjomaty, wartości) do wymiernych (postawy i zachowania). Kształtowanie duchowości zaczyna się od końca: czyli <b>od poziomu zachowań</b>.'
                    '</p>'
            ),
            KonspektStep(
                title: 'Integracja duchowości - integracja wstępna wartości',
                duration: Duration(minutes: 5),
                activeForm: KonspektStepActiveForm.static,
                materials: [
                  material_flipchart,
                  material_marker,
                ],
                contentBuilder: ({required bool isDark}) => '<p style="text-align:justify;">'
                    'Prowadzący opisuje zjawisko <b>integracji duchowości</b>, czyli sposobu w jaki kształtowana jest duchowość człowieka. Robi to na przykładzie <b>wstępnej integracji duchowości</b>, jednak nie powinien od razu wprowadzać tego pojęcia.'
                    '<br>'
                    '<br>Przykładowy sposób opisu:'
                    '<br>'
                    '<br><i>Człowiek od urodzenia jakoś się zachowuje. W trakcie, gdy człowiek dorasta, otoczenie buduje w nim przekonanie, że jedne zachowania są dobre, a inne złe.'
                    '<br>'
                    '<br>W wieku ok. 10 lat człowiek zaczyna postrzegać świat przez pojęcie "wartości". Zazwyczaj szybko orientuje się, że część jego zachowań nie jest zgodna z deklarowanymi przez siebie wartościami. W konsekwencji, jeśli dobrze pójdzie, człowiek z czasem koryguje swoje zachowania.'
                    '<br>'
                    '<br>Zmiana zachowań sprawia jednak, że dotychczasowy świat zaczyna prezentować mu się inaczej. Nowe doświadczenia weryfikują przyjętą hierarchię wartości. Nowa hierarchia wartości wpływa z powrotem na nowe zachowania, zachowania na wartości i tak w kółko.'
                    '<br>'
                    '<br>Ów cykliczny mechanizm jest sposobem w jaki kształtuje się duchowość każdego człowieka. Duchowość nie jest <b>budowana</b>, ani <b>wznoszona</b>, ale raczej stopniowo uspójniana. Z biegiem czasu kolejne przestrzenie życia są do niej włączane i z nią integrowane. Rozwój duchowy zawsze odbywa się w procesie <b>integracji duchowości</b></i>.'
                    '<br>'
                    '<br>Po opisaniu tego zjawiska prowadzący jeszcze raz skrótowo przechodzi przez etapy integracji duchowości, tym razem rysując kolejne kroki na nowym, dużym arkuszu flipcharta. Warto przy tym prosić uczestników o wymienienie kolejnych etapów, by ich zaangażować. Na końcu powinien powstać niniejszy diagram:'
                    '<br>${cyklIntegracjiDuchowosciHtml(isDark: isDark)}'
                    '</p>'
            ),
            KonspektStep(
              title: 'Integracja duchowości - integracja wstępna aksjomatów',
              duration: Duration(minutes: 3),
              activeForm: KonspektStepActiveForm.static,
              materials: [
                material_flipchart,
                material_marker,
              ],
              contentBuilder: ({required bool isDark}) => '<p style="text-align:justify;">'
                  'W dalszej kolejności prowadzący obrazuje proces integracji duchowości w momencie przejścia człowieka na kolejny etap, czyli etap internalizacji aksjomatów:'
                  '<br>'
                  '<br><i>Mija kilka wiosen i w końcu w wieku ok. 13-15 lat, człowiek zaczyna orientować się w świecie według świadomie przyjmowanych <b>fundamentalnych prawd</b>. Te prawdy to nic innego jak <b>aksjomaty</b>. Młody człowiek zazwyczaj stopniowo dostrzega, że część jego dotychczasowych wartości (a wraz z nimi zachowań) jest niezgodna z przyjętymi fundamentalnymi prawdami (aksjomatami) i rusza powolna machina ich uspójniania. Tym razem owa integracja odbywa się na dużo głębszym poziomie - ewolucji ulegają nie tylko zachowania, ale cała duchowość - od aksjomatów, poprzez całą strukturę wartości, aż na zachowaniach skończywszy.</i>'
                  '<br>'
                  '<br>Prowadzący zaznacza, że okres od narodzin do momentu, w którym człowiek po raz pierwszy świadomie orientuje się według fundamentalnych prawd, nosi nazwę <b>wstępnej integracji duchowości</b>.'
                  '<br>'
                  '<br>Prowadzący wraca do rysunku z etapami kształtowania duchowości i rysuje tam strzałkę "integracji wstępnej":'
                  '<br>${piramidaDuchowosci2Html(isDark: isDark)}'
                  '<br>'
                  '<br><i>Podczas integracji wstępnej duchowość człowieka jest integrowana "po raz pierwszy". Mało tu jest głębokich, życiowych rozważań, a więcej chłonięcia otoczenia. <b>Wartości wyłaniają się z nauczonych zachowań</b>. <b>Aksjomaty wyłaniają się z wcześniej przyjętych wartości</b>. Kształt duchowości zależy tu przede wszystkim od <b>środowiska</b> i <b>temperamentu</b> człowieka.</i>',
            ),
            KonspektStep(
              title: 'Integracja duchowości - integracja świadoma',
              duration: Duration(minutes: 5),
              activeForm: KonspektStepActiveForm.static,
              materials: [
                material_flipchart,
                material_marker,
              ],
              contentBuilder: ({required bool isDark}) => '<p style="text-align:justify;">'
                  'Prowadzący na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci opisuje ostatni, najdłuższy etap rozwoju duchowego, czyli <b>integrację świadomą</b> duchowości.'
                  '<br>'
                  '<br><i>Integracja wstępna duchowości jest ściśle zależna od otoczenia człowieka i łatwo można ją kształtować - człowiek nie ma punktu odniesienia swojej duchowości, czyli aksjomatów.'
                  '<br>'
                  '<br>Integracja świadoma zastępuje proces integracji wstępnej w momencie, w którym człowiek świadomie oprze swoją duchowość o konkretne aksjomaty. Od tego momentu bezpośredni wpływ na człowieka staje się trudniejszy, bo człowiek każdą potencjalną zmianę odnosi do ostatecznej definicji dobra i zła - czyli do przyjętych aksjomatów.</i>'
                  '<br>'
                  '<br>Prowadzący na osi czasu rysuje wielką, grubą kropkę, która kończy etap integracji wstępnej i rozpoczyna etap integracji świadomej. Dodaje, że łatwo ten punkt rozpoznać u człowieka, bo ten zaczyna się wówczas poważnie martwić się pytaniami o <b>sens istnienia</b> i <b>podważać utarte założenia</b>. Towarzyszą temu pytania w stylu:'
                  '</p>'

                  '<ul>'
                  '<li><p style="text-align:justify;">“Jaki jest sens życia, o ile w ogóle jakiś jest?”</p></li>'
                  '<li><p style="text-align:justify;">“Czy istnieje obiektywne dobro i zło, czy może wszystko jest jedynie subiektywne?”</p></li>'
                  '<li><p style="text-align:justify;">“Dlaczego powinienem wierzyć w Boga? Przecież gdybym urodził się w Iranie, wierzyłbym w Allaha?”</p></li>'
                  '</ul>'

                  '<p style="text-align:justify;">'
                  'Prowadzący opisując to, rysuje liczne "oscylujące" strzałki i podpisuje je jako "integracja świadoma", tak jak poniżej:'
                  '<br>${piramidaDuchowosci3Html(isDark: isDark)}'
                  '</p>',
            ),
            KonspektStep(
              title: 'Integracja duchowości - implikacja dla wychowawców',
              duration: Duration(minutes: 1),
              activeForm: KonspektStepActiveForm.static,
              content: '<p style="text-align:justify;">'
                  'O ile można skutecznie wpływać na wartości, zachowania i postawy młodego człowieka, o tyle wpływ na aksjomat jest już bardziej subtelny. Do aksjomatów można młodego człowieka najwyżej "podprowadzić": owszem, są one kształtowane na podstawie własnych doświadczeń, znanych poglądów i przyjętych uprzednio wartości, jednak przyjąć aksjomat za własny można jedynie samemu, wedle własnego, osobistego przekonania. W tym procesie nie da się komuś towarzyszyć do końca.'
                  '</p>',
            ),
          ]
      ),


      KonspektStepGroup(
          title: 'Meta-narracja',
          steps: [

            KonspektStep(
                title: 'Meta-narracja - scenka - wprowadzenie',
                duration: Duration(minutes: 5),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący przedstawia uczestnikom krótką historię:'
                    '<br>'
                    '<br>'
                    '<i>Na obozie dwóch wędrowników, Radek i Adam, weszło ze sobą w konflikt. Zaczęło się od żartów i docinków, ale w ciągu kilku tygodni eskalowało w celowe robienie sobie na złość. Pewnego razu Radek podciął Adamowi linki do hamaka - gdy wieczorem Adam kładł się spać, cały hamak runął. Wybuchła afera.'
                    '<br>'
                    '<br>Drużynowy wziął chłopaków na rozmowę. Radkowi było głupio — wiedział, że przesadził. Po kilku dniach przeprosił Adama za wszystkie dotychczasowe niesnaski, jednak Adam wzruszył tylko ramionami.'
                    '<br>'
                    '<br>Radek zaprzestał docinków, ale Adam wciąż go ignorował i co jakiś czas rzucał kąśliwe uwagi. Po miesiącu drużynowy wziął Adama na rozmowę: zgodnie z Prawem Harcerskim należy traktować innych jak bliźnich i braci, a skoro Radek przeprosił, Adam powinien mu wybaczyć.'
                    '<br>'
                    '<br>Adam jednak stwierdził:'
                    '<br>'
                    '<br>"Mogę dać mu spokój, ale po tym co zrobił nie zasługuje na traktowanie jak brata. Czemu mam wierzyć w Prawo Harcerskie, które garstka starych dinozaurów z poprzedniej epoki, czyli Rada Naczelna, może w każdym momencie zmienić? Braterstwo jest dla niekumatych dzieci. Ja mam inne zasady — nie ma drugiej szansy. To tylko zachęca do nadużyć z myślą, że potem wystarczy przeprosić. Konsekwencje win powinny trwać całe życie."'
                    '</i>'
                    '<br>'
                    '<br>Prowadzący informuje uczestników, że za chwilę wcielą się oni w najlepszej jakości, światowej klasy kadrę wędrowniczą. Ich zadaniem będzie odbyć rozmowę z Adamem i spróbować <b>przekonać go w ciągu 15 minut, że harcerską postawą jest wybaczyć Radkowi, kierując się 4. punktem PH.</b>'
                    '<br>'
                    '<br>Uwagi:'
                    '</p>'
                    '<ul>'
                    '<li><p style="text-align:justify;">Jeśli prowadzący nie jest sam, najlepiej, jeśli aktorem grającym Adama będzie ktoś inny niż osoba czytająca opis.</p></li>'
                    '<li><p style="text-align:justify;">Jeśli uczestników jest wielu (ponad 10), a prowadzący nie jest sam, można podzielić uczestników na grupy i odegrać scenkę niezależnie w grupach przez różnych prowadzących.</p></li>'
                    '<li><p style="text-align:justify;">Jeśli prowadzący bardzo nie chce wcielać się w rolę, formę można przeprowadzić w postaci aktywnej dyskusji, gdzie prowadzący wciela się w "adwokata diabła" i stara się argumentować tak, jak robiłby Adam.</p></li>'
                    '</ul>'
            ),

            KonspektStep(
                title: 'Meta-narracja - scenka - przygotowanie',
                duration: Duration(minutes: 5),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Uczestnicy mają pięć minut, aby ustalić między sobą strategię rozmowy.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Meta-narracja - scenka',
                duration: Duration(minutes: 15),
                activeForm: KonspektStepActiveForm.active,
                materials: [
                  material_budzik
                ],
                content: '<p style="text-align:justify;">'
                    'Prowadzący ustawia budzik na 15 minut i wciela się w Adama. Zadaniem uczestników jest wcielić się w najlepszej klasy instruktorów harcerskich i przekonać prowadzącego, że powinien (jako Adam) być posłusznym PH i przebaczyć Radkowi ich sprzeczkę.'
                    '<br>'
                    '<br>Prowadzący informuje uczestników, że jeżeli uda im się przekonać Adama przed upływem 15 minut, to wyłączy on stoper wcześniej. Jeśli zaś uczestnicy dojdą do wniosku, że nie jest to w ich wykonaniu możliwe, to oni mogą zatrzymać stoper.'
                    '<br>'
                    '<br>Prowadzący w roli Adama aż do końca ma <b>nie dać się przekonać</b>. Kluczowe jest to, by stał ciągle na stanowisku, że <b>uczestnicy mogą sobie wierzyć w PH, ale według Adama ono jest bez sensu i jest wyrazem słabości</b>.'
                    '<br>'
                    '<br>Filozofia (aksjomatyczne przekonanie) Adama jest następująca:'
                    '<br>'
                    '<br><i>Kultura wybaczania jest kulturą słabości. Zachęca do wyrządzania innym krzywd wiedząc, że można potem przeprosić, trochę zadośćuczynić, a po jakimś czasie znowu wrócić do nadużyć. Prowadzi to do patologii, niszczenia zaufania i niszczenia tkanki społecznej. Jedynym wyjściem z tego dylematu jest nie dawać drugiej szansy nikomu, kto świadomie i z premedytacją przekracza granice. Wina raz popełniona nie może być nigdy zmazana - tylko to będzie motywowało ludzi do przestrzegania zasad.</i>'
                    '</p>'
            ),

            KonspektStep(
                title: 'Meta-narracja - omówienie scenki',
                duration: Duration(minutes: 10),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący pyta uczestników: <i>"jak Wam poszło?"</i>.'
                    '<br>'
                    '<br>Oczywiście poszło im <b>fatalnie</b> — nie przekonali Adama. Prowadzący zadaje kolejne pytania:'
                    '</p>'
                    '<ol>'
                    '<li><p style="text-align:justify;"><i>"Jakich argumentów używaliście?"</i></p></li>'
                    '<li><p style="text-align:justify;"><i>"Dlaczego nie działały?"</i></p></li>'
                    '<li><p style="text-align:justify;"><i>"Czego Wam brakowało, żeby go przekonać?"</i></p></li>'
                    '</ol>'
                    '<p style="text-align:justify;">'
                    'Prowadzący podsumowuje: Adamowi brakowało <b>powodu</b>, żeby wyznawać harcerskie wartości — brakowało mu aksjomatu, z którego te wartości by wypływały. Tylko skąd miałby ten aksjomat wziąć?'
                    '</p>'
            ),

            KonspektStep(
                title: 'Meta-narracja - opowieści niosą prawdę',
                duration: Duration(minutes: 3),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący kontynuuje:'
                    '<br>'
                    '<br><i>Wyobraźcie sobie świat w którym ludzie żyli przez ostatnie sto tysięcy lat:</i>'
                    '</p>'
                    '<ol>'
                    '<li><p style="text-align:justify;"><i>Czy tygrysy były śmiertelnym zagrożeniem?</i></p></li>'
                    '<li><p style="text-align:justify;"><i>A czy węże były śmiertelnym zagrożeniem?</i></p></li>'
                    '<li><p style="text-align:justify;"><i>A czy ogień wymykający się spod kontroli był śmiertelnym zagrożeniem?</i></p></li>'
                    '<li><p style="text-align:justify;"><i>A czy chcąc opisać największe możliwe zło, miałoby sens użyć obrazu potwora będącego na raz tygrysem, wężem, w dodatku ze skrzydłami i plującego ogniem?</i></p></li>'
                    '<li><p style="text-align:justify;"><i>A czy w obliczu zła, lepiej jest uciekać, czy walczyć?</i></p></li>'
                    '<li><p style="text-align:justify;"><i>A czy chcąc wygrać ze złem, wystarczy czekać aż przyjdzie, czy może trzeba wyjść mu naprzeciw w nieznane?</i></p></li>'
                    '<li><p style="text-align:justify;"><i>A czy największe zagrożenia i zło da się przezwyciężyć starymi metodami, czy trzeba wymyślić coś zupełnie nowego? A może trzeba sięgnąć do starego i nowego jednocześnie?</i></p></li>'
                    '<li><p style="text-align:justify;"><i>A czy człowiek, który przezwycięży zło, jest dalej tym, kim był, czy staje się kimś nowym?</i></p></li>'
                    '</ol>'

                    '<p style="text-align:justify;">'
                    'Prowadzący mówi uczestnikom:'
                    '<br>'
                    '<br><i>Najlepszą strategię radzenia sobie z chaosem, złem i zagrożeniami można próbować opisać tomami precyzyjnych, wyrafinowanych prac analitycznych, tyle że prawie nikt ich nie zrozumie.'
                    '<br>'
                    '<br>Prowadzący proponuje inną metodę: odwołać się do ludzkich mechanizmów postrzegania świata i opisać to w formie opowieści w stylu: <i>była kiedyś spokojna kraina, którą zaczął nękać smok. Pożarł najlepszych, najbardziej doświadczonych wojowników, którzy chcieli go zgładzić. W końcu, mimo strachu, decyduje się z nim zmierzyć zwykły młodzieniec imieniem Jerzy, który odrzuca zbroję, ale bierze miecz starszych wojowników, wchodzi do jamy potwora i podstępem wbija mu miecz między łuski prosto w serce. W konsekwencji Jerzy zdobywa ogromny skarb, najpiękniejsza dziewczyna w królestwie zgadza się go poślubić, a on zostaje królem.</i>'
                    '<br>'
                    '<br>Prowadzący zwraca uwagę, że to oczywiste, że Jerzy z opowieści nigdy nie żył, oraz że żaden smok nigdy nie zaatakował żadnej wioski. W opowieści nie chodzi o bohaterów, tylko o pokazanie sposobu działania rzeczywistości, do której opowiedzenia ci bohaterowie są potrzebni: człowiek, który dobrowolnie mierzy się z tym, czego się boi może zwyciężyć, a jeśli to zrobi, będzie kimś innym niż był wcześniej.'
                    '<br>'
                    '<br>Archetypiczna opowieść to nie bajka z morałem, ale wyraz głębokiej prawdy o naturze człowieka.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Meta-narracja - opowieści są wszędzie',
                duration: Duration(minutes: 1),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący zwraca uwagę, że ludzie zawsze postrzegali i dalej postrzegają świat w formie opowieści.'
                    '<br>'
                    '<br>Te same historie są dziś opowiadane innym językiem, innymi postaciami. Dziś historia o pokonaniu smoka funkcjonuje jako Władca Pierścieni, czy Gwiezdne Wojny. Zamiast opowieści o królestwach i wioskach widzimy instytucje i państwa, wierzymy w swoją życiową misję względem rodziny, widzimy walkę wielkich, złych korporacji z dobrymi, zwykłymi ludźmi, wierzymy w oświeceniową opowieść o niezbywalnej godności człowieka, w opowieści o bohaterach poległych za ojczyznę, w kapłańską rolę naukowców obcujących z najczystszą formą prawdy. To nie jest atawizm — to sposób, w jaki homo sapiens postrzega rzeczywistość.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Meta-narracja - opowieści o opowieściach',
                duration: Duration(minutes: 1),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący zwraca uwagę na to, że istnieją opowieści, które nie kończą się na sobie samych, lecz funkcjonują w spójnym kontekście innych opowieści: np. mitologia grecka, mitologia egipska, starotestamentalna historia ludu wybranego. Poza prawdami płynącymi z pojedynczych historii opisują one, jak różne aspekty rzeczywistości na siebie oddziałują — np. jak sprawiedliwość współgra z losem, miłość z obowiązkiem, pycha z karą.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Meta-narracja - definicja i przykłady',
                duration: Duration(minutes: 3),
                activeForm: KonspektStepActiveForm.static,
                materials: [
                  material_zal_meta_narracja_opis,
                  material_zal_meta_narracja_przyklady,
                ],
                content: '<p style="text-align:justify;">'
                    'Prowadzący mówi:'
                    '<br>'
                    '<br><i>Wśród wszystkich zbiorów opowieści istnieje bardzo wąska, ale szczególna kategoria — opowieści tak fundamentalne, że porządkują całość rzeczywistości. Opowieść, która mówi ci kim jesteś, jak działa świat, co jest dobre i jaki jest sens. To jest <b>meta-narracja</b>.</i>'
                    '<br>'
                    '<br>Prowadzący kładzie przed uczestnikami (obok kartki "Aksjomat") opis meta-narracji z załącznika $attach_html_meta_narracja_opis i odczytuje go:'
                    '<br>'
                    '<br><i>Meta-narracja to opowieść o świecie, obok której nie można przejść obojętnie. To opowieść tak głęboka, tak wielka, tak dojmująca i fundamentalna, że niejako chwyta człowieka za samo serce i staje się dla niego głównym punktem odniesienia jego obecności w świecie.'
                    '<br>'
                    '<br>Meta-narracja jest opowieścią o świecie, jego aktorach, o osobistej roli przyjmującego ją człowieka.'
                    '<br>'
                    '<br>Prowadzący natychmiast przedstawia uczestnikom kilka przykładów meta-narracji z załącznika $attach_html_meta_narracja_przyklady i kładzie je obok karty "Meta-narracja".'
                    '</p>'
            ),

            KonspektStep(
                title: 'Meta-narracja - powrót do scenki i implikacja',
                duration: Duration(minutes: 2),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący wraca do scenki:'
                    '<br>'
                    '<br><i>Jeśli Adam miałby kiedyś wybaczyć Radkowi, to nie dlatego, że tak mówi Prawo Harcerskie, ale dlatego, że zobaczy i przyjmie świat w perspektywie meta-narracji, z której wynikną jego aksjomaty – a z nich naturalnie wyniknie wartość przebaczenia.</i>'
                    '<br>'
                    '<br>Prowadzący kończy wyjaśnieniem implikacji dla wychowawców:'
                    '<br>'
                    '<br><i>Ograniczając się do pracy jedynie nad postawami i wartościami wychowanków, można dojść jedynie do etapu <b>wstępnej integracji duchowości</b>. Później, na etapie <b>świadomej integracji duchowości</b>, dojrzały duchowo człowiek nie przyjmie zbioru wartości „bo tak". Będzie potrzebował <b>powodu</b>, by je przyjąć — <b>źródła wartości</b>, na którym będzie mógł oprzeć swoją duchowość.'
                    '<br>'
                    '<br>Człowiek prędzej uwierzy w największą głupotę, niż nie będzie wierzył w nic. Jeśli chcemy jako wychowawcy skutecznie i długotrwale ukształtować młodego człowieka, nie możemy abstrahować od kwestii najbardziej osobistych. Musimy wejść w interakcję z jego przestrzenią aksjomatyczną: opowieścią, która stanie się dla niego fundamentalnym rdzeniem jego ducha.</i>'
                    '</p>'
            ),

            KonspektStep(
                title: 'Meta-narracja - pytania',
                duration: Duration(minutes: 10),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Uczestnicy mogą dopytać o niejasne kwestie związane z meta-narracją.'
                    '</p>'
            ),

          ]
      ),

      KonspektStepGroup(
          title: 'Mechanizmy pośrednie',
          steps: [
            KonspektStep(
              title: 'Praktyka wychowania duchowego - mechanizmy pośrednie',
              duration: Duration(minutes: 20),
              activeForm: KonspektStepActiveForm.static,
              materials: [
                material_zal_mechanizmy_posrednie,
              ],
              content: '<p style="text-align:justify;">'
                  'Prowadzący zaczyna od zadania oczywistego pytania:'
                  '<br>'
                  '<br><b><i>"Czyli tak: ustaliliśmy czym jest duchowość, jej poziomy i jej integracja, cel wychowania duchowego w ZHP - czyli wystarczy teraz powiedzieć zuchom jakie postawy, harcerzom jakie wartości, a wędrownikom jakie aksjomaty są dobre i essa? Co nie? Czy nie?"</i></b>'
                  '<br>'
                  '<br>Oczywiście ta propozycja jest absurdalna - celem jest rozpoczęcie dyskusji prowadzącej do wniosku, że od różnych pionów należy oczekiwać różnych celów w rozwoju duchowym.'
                  '<br>'
                  '<br><b><i>"Duchowość nie jest umiejętnością, dlatego nie należy sądzić że można ją rozwinąć tymi samymi metodami co intelekt, ciało, czy emocje."</i></b>'
                  '<br>'
                  '<br>Prowadzący zwraca uwagę, że wychowanie duchowe zaczyna się od sposobu myślenia. Przedstawia trzy punkty wyjścia i przy omawianiu każdego kładzie w widocznym miejscu odpowiadającą mu kartkę z załącznika $_attach_html_mechanizmy_posrednie.'
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
                  'Następnie prowadzący przedstawia <b>mechanizmy pośrednie</b>, które wpływają na duchowość. W celu wejścia w interakcję z uczestnikami przedstawia krótkie scenariusze na podstawie których uczestnicy powinni wywnioskować określony mechanizm (podobnie jak poprzednio, gdy uczestnicy poprawnie nazwą mechanizm, prowadzący kładzie w widocznym miejscu odpowiadającą mu kartkę z załącznika $_attach_html_mechanizmy_posrednie):'
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
                  '<br><i>Mamy harcerkę starszą, która, od kiedy poszła do technikum, zaczęła tak jak jej nowe koleżanki oglądać Netflixa, kiczowate reality-show typu "Trudne sprawy" i słuchać depresyjnej muzyki. W szkole idzie jej średnio, marnuje dużo czasu na fejsie i tik-toku. Chcemy wychować ją do pozytywnego myślenia, zaradności i sumienności. Czy sprawienie, że z Netflixa i "Trudnych spraw" przerzuci się na "Ojca Mateusza" i "Pingwiny z Madagaskaru", oraz że drużyna zainspiruje ją szantami, T.Love i Kaczmarskim, a w miejsce fejsa i tik-toka zacznie czytać Dukaja pomoże w osiągnięciu celu wychowawczego? Dlaczego?</i>'
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
              activeForm: KonspektStepActiveForm.static,
              materials: [
                material_zal_mechanizmy_posrednie,
              ],
              content: '<p style="text-align:justify;">'
                  'Prowadzący opisuje ostatni pośredni mechanizm kształtowania duchowości, czyli <b>Metanarrację</b> na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci. Podobnie jak w przypadku poprzednich mechanizmów, do pozostałych dodaje przy tym odpowiadającą kartkę z załącznika $_attach_html_mechanizmy_posrednie'
                  '<br>'
                  '<br><i>Metanarracja jest szczególnie silnym mechanizmem w momencie <b>rozpoczęcia integracji świadomej</b>, jednak gra rolę także później. Jest to opowieść, nadająca człowiekowi tożsamość, sens i cel.'
                  '<br>'
                  '<br>Na przykład:</i>'
                  '</p>'

                  '<ul>'
                  '<li><p style="text-align:justify;"><i>"Bóg umarł z miłości do każdego człowieka. Za mnie także. Tego doświadczenia raz poznanego nie da się zakopać - jest tak głębokie i dojmujące, że muszę się nim podzielić z każdym człowiekiem."</i></p></li>'
                  '<li><p style="text-align:justify;"><i>"Jesteśmy na skraju katastrofy klimatycznej - jeżeli nie zrobimy czegoś natychmiast, cały świat spłonie i na Ziemi nie będzie się dało dłużej żyć. Muszę działać. Natychmiast."</i></p></li>'
                  '<li><p style="text-align:justify;"><i>"Jestem Polakiem. Spadkobiercą tysiącletniego narodu i wielo-tysiącletniej cywilizacji judeo-chrześcijańskiej. Potomkiem poległych w obronie ojczyzny mężów i kobiet. Muszę od siebie wymagać, by kiedyś dźwignąć naszą polską, poszarpaną państwowość - w obecnej sytuacji geopolitycznej to jest być albo nie być polskiego narodu."</i></p></li>'
                  '<li><p style="text-align:justify;"><i>"Społeczeństwo jest rasistowskie, mizoginiczne i homofobiczne do szpiku kości. Codziennie przez falę hejtu i działań eksterminacyjnych giną niewinne kobiety, geje, osoby trans i inni ludzie LGBTQIAP2+. Muszę coś z tym zrobić. Muszę manifestować, zmienić język, obalić patriarchat i heteronormatywność, zmienić społeczeństwo nawet jeśli oznaczałoby to poświęcenie temu całego swojego życia. Krew się leje w tym momencie."</i></p></li>'
                  '</ul>'

                  '<p style="text-align:justify;">'
                  'Prowadzący zwraca uwagę, że harcerstwo też może nosić znamiona elementów <b>metanarracji</b>, szczególnie dla młodej kadry i instruktorów, którzy wierzą, że na ich barkach spoczywa wychowanie i szczęście młodych ludzi.'
                  '<br>'
                  '<br>Warto także zwrócić uwagę, że harcerstwo może nosić znamiona subkutlury: ma swoje obrzędy, symbole, wartości i ścisłe gorono. Widać to przykładowo po harcerzach, którzy chodzą na każdą zbiórkę, jeżdżą na każdy wyjazd, uczą się po nocach grać Kaczmarskiego na gitarze, a do szkoły w bojówkach i harcerskim pasie. Owo zaangażowanie i tożsamość może być niezwykle efektywnym mechanizmem kształtowania duchowości.'
                  '</p>',
            ),
          ]
      ),

      KonspektStepGroup(
          title: 'Antyprzykłady',
          steps: [
            KonspektStep(
              title: 'Antyprzykłady',
              duration: Duration(minutes: 30),
              activeForm: KonspektStepActiveForm.static,
              materials: [
                material_zal_antyprzyklady,
              ],
              content: '<p style="text-align:justify;">'
                  'Prowadzący dzieli uczestników na dwie grupy i daje im po jednej kartce z załącznika $_attach_html_antyprzyklady. Zadaniem uczestników jest szczegółowo przeanalizować opisaną w nim postać i wskazać jakie są problemy z duchowością, którą kształtuje u swoich wychowanków opisana postać.'
                  '</p>',
            ),
          ]
      ),

      KonspektStepGroup(
          title: 'Scenariusze',
          steps: [
            KonspektStep(
                title: 'Scenariusze w grupach',
                duration: Duration(minutes: 40),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący dzieli uczestników na grupy po ok. 4 osób. Każda z grup otrzymuje po 2-4 scenariusze z $_attach_html_scenariusze i w swoim gronie je omawia. Celem omówienia każdego scenariusza jest zaproponowanie rozwiązania zgodnego z harcerskimi celami wychowania duchowego. Na jeden scenariusz grupa powinna poświęcić 10-15 min. Ważne, by prowadzący zaznaczył, że <b>grupy nie muszą osiągnąć jednomyślności</b>.'
                    '<br>'
                    '<br>Po zakończeniu dyskusji grupy referują scenariusze i wnioski z nich płynące na forum wszystkich uczestników. Jeżeli któryś scenariusz zakończył się różnicą stanowisk dyskutujących, może zostać poruszony wspólnie przez wszystkich uczestników.'
                    '</p>',
                materials: [
                  material_zal_scenariusze,
                ]
            ),
          ]
      ),
    ]
);
