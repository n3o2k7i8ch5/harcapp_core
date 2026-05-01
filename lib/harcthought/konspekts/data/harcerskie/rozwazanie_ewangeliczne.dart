import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';


const String konspekt_harc_name_rozwazanie_ewangeliczne = 'rozwazanie_ewangeliczne';
const String konspekt_harc_title_rozwazanie_ewangeliczne = 'Rozważanie ewangeliczne';
const String konspekt_harc_html_rozwazanie_ewangeliczne = '<a href="$konspekt_harc_name_rozwazanie_ewangeliczne@harcerskie.konspekt">$konspekt_harc_title_rozwazanie_ewangeliczne</a>';


/// Krótki, ogólny opis czym jest "Rozważanie ewangeliczne" (zwane też "apelem ewangelicznym").
const String rozwazanie_ewangeliczne_html_opis_ogolny =
    '<p style="text-align:justify;">'
    '<b>Rozważanie ewangeliczne</b> (zwane też <i>„apelem ewangelicznym”</i>) to krótka forma duchowa polegająca na rozważeniu fragmentu <b>Ewangelii</b> z pomocą prostych, praktycznych pytań.'
    '</p>';

/// Dla jakich metodyk forma jest przygotowywana - z podziałem na dwie grupy wiekowe.
const String rozwazanie_ewangeliczne_html_title_dla_jakich_metodyk = '<p style="text-align:justify;"><b>Dla jakich metodyk?</b></p>';
const String rozwazanie_ewangeliczne_html_dla_jakich_metodyk =
    '<p style="text-align:justify;">'
    'Pytania pomocnicze są przygotowywane osobno dla dwóch grup wiekowych:'
    '</p>'
    '<ul>'
    '<li><p style="text-align:justify;">dla <b>młodszych</b> - metodyki <i>zuchowa</i> i <i>harcerska</i>,</p></li>'
    '<li><p style="text-align:justify;">dla <b>starszych</b> - metodyki <i>starszoharcerska</i> i <i>wędrownicza</i>.</p></li>'
    '</ul>';

/// Czy formę można zaproponować całej drużynie - również osobom poszukującym.
const String rozwazanie_ewangeliczne_html_title_dla_calej_druzyny = '<p style="text-align:justify;"><b>Czy formę można zaproponować całej drużynie?</b></p>';
const String rozwazanie_ewangeliczne_html_dla_calej_druzyny =
    '<p style="text-align:justify;">'
    'Tak. Dla osób wychowywanych w wierze chrześcijańskiej jest to okazja do pogłębienia znajomości Pisma Świętego, relacji z Bogiem oraz przygotowania do głębszego przeżycia <b>Mszy Świętej</b> w daną niedzielę. Osoby poszukujące znajdą w niej okazję do refleksji nad postawami i wartościami, które ukształtowały naszą kulturę i cywilizację.'
    '</p>';

/// Sugerowany moment przeprowadzenia formy.
const String rozwazanie_ewangeliczne_html_title_kiedy_przeprowadzic = '<p style="text-align:justify;"><b>Kiedy przeprowadzić?</b></p>';
const String rozwazanie_ewangeliczne_html_kiedy_przeprowadzic =
    '<p style="text-align:justify;">'
    'Formę najlepiej przeprowadzić w niedzielę przed Mszą lub w sobotę wieczorem. Sprawdza się ona także w trakcie roku harcerskiego - przy ognisku, czy na biwaku.'
    '</p>';

/// Tytuł sekcji "Przygotowanie" - obejmuje materiały, opiekunów i miejsce.
const String rozwazanie_ewangeliczne_html_title_przygotowanie = '<p style="text-align:justify;"><b>Przygotowanie</b></p>';

/// Materiały, które należy przygotować przed przeprowadzeniem formy.
const String rozwazanie_ewangeliczne_html_title_przygotowanie_materialy = '<p style="text-align:justify;"><b>Materiały</b></p>';
const String rozwazanie_ewangeliczne_html_przygotowanie_materialy =
    '<p style="text-align:justify;">'
    'Rozważanie ewangeliczne należy wcześniej <b>wydrukować - po jednym egzemplarzu na uczestnika</b>. Pytania trzeba dobrać do grupy wiekowej (młodsi: zuch + harc; starsi: HS + wędro).'
    '</p>';

/// Zasady doboru i pracy opiekunów zastępów prowadzących Rozważanie ewangeliczne.
const String rozwazanie_ewangeliczne_html_title_przygotowanie_opiekunowie = '<p style="text-align:justify;"><b>Opiekunowie zastępów</b></p>';
const String rozwazanie_ewangeliczne_html_przygotowanie_opiekunowie =
    '<p style="text-align:justify;">'
    'Każdy zastęp w ramach tej formy powinien mieć swojego opiekuna - może to być ktoś z kadry lub zastępowy. Opiekunów warto wcześniej przygotować, np. przeprowadzając z nimi „na rozgrzewkę” dowolne Rozważanie ewangeliczne, by poczuli się w roli swobodnie.'
    '<br>'
    '<br><b>Zasady dla opiekunów:</b>'
    '</p>'
    '<ul>'
    '<li><p style="text-align:justify;">Jeśli opiekun nie chce prowadzić formy - <b>nie należy go zmuszać</b>.</p></li>'
    '<li><p style="text-align:justify;">Opiekun pełni rolę <b>animatora</b> - tłumaczy formę zastępowi, pilnuje czasu, stwarza każdemu przestrzeń, by mógł się wypowiedzieć.</p></li>'
    '<li><p style="text-align:justify;">Opiekun <b>nie powinien kwestionować ani podważać przemyśleń uczestników</b> - może jednak „z wyczuciem” o coś dopytać.</p></li>'
    '<li><p style="text-align:justify;">Opiekun również <b>bierze udział</b> w formie.</p></li>'
    '<li><p style="text-align:justify;">Każdy uczestnik dzieli się tym, czym chce - <b>bez presji</b>.</p></li>'
    '<li><p style="text-align:justify;"><b>Wszystko, co zostało powiedziane podczas Rozważania ewangelicznego, zostaje w zastępie!</b></p></li>'
    '</ul>';

/// Wskazówki dotyczące miejsca i atmosfery przeprowadzenia formy.
const String rozwazanie_ewangeliczne_html_title_przygotowanie_miejsce = '<p style="text-align:justify;"><b>Miejsce i atmosfera</b></p>';
const String rozwazanie_ewangeliczne_html_przygotowanie_miejsce =
    '<p style="text-align:justify;">'
    'Odpowiedni czas, miejsce i komfort są kluczowe. Warto zadbać o spokojne miejsce i ciszę - może sprzyjający refleksji piękny widok na jezioro lub leśna polana?'
    '</p>';

/// Pytania ewaluacyjne, które warto zadać po przeprowadzeniu formy.
const String rozwazanie_ewangeliczne_html_title_ewaluacja = '<p style="text-align:justify;"><b>Ewaluacja</b></p>';
const String rozwazanie_ewangeliczne_html_ewaluacja =
    '<p style="text-align:justify;">'
    'Po przeprowadzeniu formy warto sprawdzić z opiekunami, czy wszystko gra:'
    '</p>'
    '<ul>'
    '<li><p style="text-align:justify;">Jak opiekunowie odnajdują się w przeprowadzaniu formy?</p></li>'
    '<li><p style="text-align:justify;">Czy harcerze są w stanie skupić się i poważnie potraktować pytania?</p></li>'
    '<li><p style="text-align:justify;">Czy są jakieś przeszkody lub rozpraszacze? Co można zrobić, aby je rozwiązać?</p></li>'
    '</ul>';

/// Fragmenty Ewangelii dostępne w aplikacji jako gotowe materiały.
const String rozwazanie_ewangeliczne_html_zrodla_w_aplikacji =
    '<p style="text-align:justify;">'
    'Fragmenty Ewangelii na każdy dzień roku liturgicznego są dostępne w aplikacji w sekcji <i>Rozważania ewangeliczne</i>.'
    '</p>';


/// Krótkie streszczenie 4 kroków przebiegu formy w jednym bloku HTML.
/// Używane do zwięzłego opisu w innych miejscach (sam konspekt korzysta z rozbudowanych [steps]).
const String rozwazanie_ewangeliczne_html_title_przebieg_praktyczny = '<p style="text-align:justify;"><b>Jak przeprowadzić to w praktyce?</b></p>';
const String rozwazanie_ewangeliczne_html_przebieg_praktyczny =
    '<ol>'
    '<li><p style="text-align:justify;">W <b>zastępach</b> każdy harcerz otrzymuje kartkę z fragmentem Ewangelii oraz z pytaniami pomocniczymi.</p></li>'
    '<li><p style="text-align:justify;">Harcerze mają indywidualnie <b>10-15 minut</b> na przeczytanie fragmentu i refleksję nad pytaniami - mogą zapisywać swoje myśli.</p></li>'
    '<li><p style="text-align:justify;">Po wyznaczonym czasie zastęp się schodzi - tę część <b>animuje zastępowy lub osoba z kadry</b>. Każdy może (ale nie musi) podzielić się swoimi przemyśleniami. Gdy każdy chętny się wypowie, może wywiązać się dalsza rozmowa.</p></li>'
    '<li><p style="text-align:justify;">Zastęp może się krótko, wspólnie pomodlić - własnymi słowami lub np. modlitwą <i>„Ojcze nasz”</i>.</p></li>'
    '</ol>';


const String rozwEwanStandaloneDescription = '$rozwazanie_ewangeliczne_html_opis_ogolny'
    '$rozwazanie_ewangeliczne_html_title_dla_jakich_metodyk'
    '$rozwazanie_ewangeliczne_html_dla_jakich_metodyk'
    '<br>'
    '$rozwazanie_ewangeliczne_html_title_dla_calej_druzyny'
    '$rozwazanie_ewangeliczne_html_dla_calej_druzyny'
    '<br>'
    '$rozwazanie_ewangeliczne_html_title_kiedy_przeprowadzic'
    '$rozwazanie_ewangeliczne_html_kiedy_przeprowadzic'
    '$rozwazanie_ewangeliczne_html_title_przygotowanie'
    '<ol>'
    '<li>$rozwazanie_ewangeliczne_html_title_przygotowanie_materialy$rozwazanie_ewangeliczne_html_przygotowanie_materialy</li>'
    '<li>$rozwazanie_ewangeliczne_html_title_przygotowanie_opiekunowie$rozwazanie_ewangeliczne_html_przygotowanie_opiekunowie</li>'
    '<li>$rozwazanie_ewangeliczne_html_title_przygotowanie_miejsce$rozwazanie_ewangeliczne_html_przygotowanie_miejsce</li>'
    '</ol>'
    '$rozwazanie_ewangeliczne_html_title_ewaluacja'
    '$rozwazanie_ewangeliczne_html_ewaluacja';


Konspekt rozwazanie_ewangeliczne = const Konspekt(
    name: konspekt_harc_name_rozwazanie_ewangeliczne,
    title: konspekt_harc_title_rozwazanie_ewangeliczne,
    additionalSearchPhrases: ['rozważania ewangeliczne', 'ewangelia', 'apel ewangeliczny', 'pismo święte', 'biblia'],
    category: KonspektCategory.harcerskie,
    type: KonspektType.zwyczaj,
    spheres: {
      KonspektSphere.duch: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.duchAksjomaty: KonspektSphereFields(
                fields: {
                  aksjoSwietoscHistoriiBiblijnych: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                    KonspektSphereFactor.duchPerspektywa_Normalizacja,
                    KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan,
                  },
                  aksjoRozwazanieSensuICeluZycia: {
                    KonspektSphereFactor.duchWlasnaRefleksja,
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  },
                  aksjoAksjomatyChrzescijanskie: {
                    KonspektSphereFactor.duchWlasnaRefleksja,
                    KonspektSphereFactor.duchPerspektywa_Normalizacja,
                  },
                }
            ),
            KonspektSphereLevel.duchPostawy: KonspektSphereFields(
                fields: {
                  postawaSpojnoscZWartosciamiChrzescijanskimi: {
                    KonspektSphereFactor.duchWlasnaRefleksja,
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  },
                  postawaWyciszenie: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                    KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan,
                  },
                  postawaSkupienie: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  },
                }
            ),
          }
      )
    },
    metos: [Meto.harc, Meto.hs, Meto.wedro],
    coverAuthor: 'Freepik (fijulanam468)',
    author: DANIEL_IWANICKI,
    aims: [
      'Stworzenie uczestnikom czasu do budowania ich relacji z Bogiem',
      'Budowanie u uczestników nawyku regularnego sięgania po Słowo Boże',
      'Normalizacja wspólnotowego rozważania fragmentów Ewangelii',
      'Kształtowanie u uczestników zdolności refleksji nad treściami biblijnymi i ich odniesieniem do własnego życia',
      'Budowanie wspólnoty aksjomatu wokół chrześcijańskiej wizji świata',
    ],
    materials: [
      KonspektMaterial(
        amountAttendantFactor: 1,
        name: 'Wydrukowana kartka z fragmentem Ewangelii i pytaniami pomocniczymi',
        additionalPreparation: 'Po jednym egzemplarzu na uczestnika. Pytania należy dobrać do grupy wiekowej (młodsi: zuch + harc; starsi: HS + wędro).',
      ),
    ],
    summary: 'Uczestnicy w zastępach indywidualnie czytają krótki fragment Ewangelii i odpowiadają na pytania pomocnicze, a następnie wspólnie - w atmosferze zaufania - dzielą się swoimi przemyśleniami i kończą krótką modlitwą.',
    intro:
        '$rozwazanie_ewangeliczne_html_opis_ogolny'
        '$rozwazanie_ewangeliczne_html_title_dla_jakich_metodyk'
        '$rozwazanie_ewangeliczne_html_dla_jakich_metodyk'
        '$rozwazanie_ewangeliczne_html_title_dla_calej_druzyny'
        '$rozwazanie_ewangeliczne_html_dla_calej_druzyny'
        '$rozwazanie_ewangeliczne_html_title_kiedy_przeprowadzic'
        '$rozwazanie_ewangeliczne_html_kiedy_przeprowadzic'
        '$rozwazanie_ewangeliczne_html_title_przygotowanie'
        '<ol>'
        '<li>$rozwazanie_ewangeliczne_html_title_przygotowanie_materialy$rozwazanie_ewangeliczne_html_przygotowanie_materialy</li>'
        '<li>$rozwazanie_ewangeliczne_html_title_przygotowanie_opiekunowie$rozwazanie_ewangeliczne_html_przygotowanie_opiekunowie</li>'
        '<li>$rozwazanie_ewangeliczne_html_title_przygotowanie_miejsce$rozwazanie_ewangeliczne_html_przygotowanie_miejsce</li>'
        '</ol>',
    steps: [

      KonspektStep(
        title: 'Wprowadzenie i rozdanie kartek',
        duration: Duration(minutes: 5),
        activeForm: KonspektStepActiveForm.static,
        content: '<p style="text-align:justify;">Drużyna dzieli się na <b>zastępy</b>. Opiekun zastępu krótko tłumaczy uczestnikom, na czym polega forma i jak będzie przebiegać, a następnie rozdaje każdemu harcerzowi kartkę z fragmentem Ewangelii oraz z pytaniami pomocniczymi.</p>',
      ),

      KonspektStep(
        title: 'Indywidualna refleksja',
        duration: Duration(minutes: 15),
        activeForm: KonspektStepActiveForm.static,
        content: '<p style="text-align:justify;">Każdy z uczestników <b>indywidualnie</b> czyta fragment Ewangelii i odpowiada sobie na załączone pytania pomocnicze - może swobodnie zapisywać swoje myśli na kartce. W tym czasie zastęp pracuje w ciszy.'
            '<br>'
            '<br>Również opiekun bierze udział w refleksji.</p>',
      ),

      KonspektStep(
        title: 'Wspólne dzielenie się w zastępie',
        duration: Duration(minutes: 20),
        activeForm: KonspektStepActiveForm.static,
        content: '<p style="text-align:justify;">Po wyznaczonym czasie zastęp zbiera się razem. Tę część <b>animuje opiekun zastępu</b> (członek kadry lub zastępowy):</p>'
            '<ul>'
            '<li><p style="text-align:justify;">stwarza każdemu przestrzeń, by się wypowiedział,</p></li>'
            '<li><p style="text-align:justify;">nie kwestionuje ani nie ocenia tego, co mówią uczestnicy - może natomiast „z wyczuciem” o coś dopytać.</p></li>'
            '</ul>'
            '<p style="text-align:justify;">Każdy może (ale nie musi) podzielić się swoimi przemyśleniami - <b>bez presji</b>. Gdy każdy chętny się wypowie, może wywiązać się dalsza, swobodna rozmowa.'
            '<br>'
            '<br><b>Wszystko, co zostało powiedziane podczas Rozważania ewangelicznego, zostaje w zastępie!</b></p>',
      ),

      KonspektStep(
        title: 'Wspólna modlitwa',
        duration: Duration(minutes: 5),
        activeForm: KonspektStepActiveForm.static,
        content: '<p style="text-align:justify;">Zastęp może się krótko, wspólnie pomodlić - własnymi słowami lub np. modlitwą <i>„Ojcze nasz”</i>.</p>',
      ),

      KonspektStep(
          title: 'Ewaluacja',
          duration: Duration.zero,
          activeForm: KonspektStepActiveForm.static,
          content: rozwazanie_ewangeliczne_html_ewaluacja,
      ),

    ],
    howToFail: [
      'Zmusić opiekuna zastępu do prowadzenia formy, jeśli ten nie chce.',
      'Kwestionować, podważać lub oceniać przemyślenia uczestników.',
      'Wywierać presję na to, by uczestnik dzielił się swoimi refleksjami.',
      'Wynieść poza zastęp to, co zostało powiedziane w czasie formy.',
      'Przeprowadzić formę w hałaśliwym lub rozpraszającym miejscu.',
      'Pominąć przygotowanie opiekunów - wrzucić ich „na głęboką wodę”.',
    ]
);
