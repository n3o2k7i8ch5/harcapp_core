import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/harcthought/konspekts/data/utils.dart';
import 'package:harcapp_core/values/people/person.dart';

import '../../konspekt.dart';

const String _konspekt_name = 'druzynowe_przekazanie_bsp';

const String _attach_html_odznaka_bsp = '<a href="${_attach_name_odznaka_bsp}@attachment">${_attach_title_odznaka_bsp}</a>';
const String _attach_name_odznaka_bsp = "odznaka_bsp";
const String _attach_title_odznaka_bsp = "Odznaka BŚP";
KonspektAttachment _attach_odznaka_bsp = KonspektAttachment(
    name: _attach_name_odznaka_bsp,
    title: _attach_title_odznaka_bsp,
    assets: {
      FileFormat.urlPdf: urlToGitlabFile(_konspekt_name, 'odznaka_bsp.pdf'),
      FileFormat.urlDocx: urlToGitlabFile(_konspekt_name, 'odznaka_bsp.docx'),
    },
    print: KonspektAttachmentPrint(color: KonspektAttachmentPrintColor.color, side: KonspektAttachmentPrintSide.double)
);


KonspektMaterial material_zal_odznaka_bsp = KonspektMaterial(
    name: 'Dostępny załącznik “$_attach_title_odznaka_bsp”',
    attachmentName: _attach_name_odznaka_bsp,
    amount: 1
);


Konspekt druzynowe_przekazanie_bsp = Konspekt(
    name: _konspekt_name,
    title: 'Drużynowe przekazanie Betlejemskiego Światła Pokoju',
    additionalSearchPhrases: ['bśp'],
    category: KonspektCategory.harcerskie,
    type: KonspektType.projekt,
    spheres: {
      KonspektSphere.duch: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.duchPostawy: KonspektSphereFields(
              fields: {
              postawaOtwartoscNaLudzi: {KonspektSphereFactor.duchBezposrednieDoswiadczenie},
              postawaPrzebaczenie: {KonspektSphereFactor.duchPerspektywa_Normalizacja}
            }
            ),
            KonspektSphereLevel.duchWartosci: KonspektSphereFields(
              fields: {
              wartoscPokoj: {KonspektSphereFactor.duchPerspektywa_Normalizacja},
              wartoscPrzynaleznoscDoHarcerstwa: {KonspektSphereFactor.duchBezposrednieDoswiadczenie},
            }
            ),
            KonspektSphereLevel.duchAksjomaty: KonspektSphereFields(
              fields: {
              aksjoNarodzinyChrystusa: {KonspektSphereFactor.duchPerspektywa_Normalizacja, KonspektSphereFactor.duchPrzykladWlasnyAutorytetow},
              aksjoZbawczaRolaChrystusa: {KonspektSphereFactor.duchPerspektywa_Normalizacja, KonspektSphereFactor.duchPrzykladWlasnyAutorytetow},
              aksjoZbawienie: {KonspektSphereFactor.duchPerspektywa_Normalizacja, KonspektSphereFactor.duchPrzykladWlasnyAutorytetow}
            }
            ),
          },
      ),
    },

    metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
    coverAuthor: 'PAP/M. Marek',
    author: Person(name: 'Zespół Wychowania Duchowego i Religijnego Chorągwi Stołecznej ZHP'),
    customDuration: Duration(days: 30),
    aims: [
      'Kształtowanie postawy przebaczenia',
      'Kształtowanie postawy otwartości na ludzi',
      'Kształtowanie wartości pokoju',
      'Zapoznanie z historią narodzin Chrystusa',
      'Zapoznanie ze zbawczą rolą Chrystusa',
      'Zapoznanie z historią zbawienia człowieka',

      'Kształtowanie poczucia przynależności do wspólnoty harcerskiej i skautowej',
    ],

    materials: [material_zal_odznaka_bsp],

    summary: 'Harcerze w gronie drużyny przygotowują się, a nastepnie uczestniczą w przekazaniu Betlejemskiego Światła Pokoju.',

    description:
        '<h1>Cel materiału</h1>'
        '<ol>'
        '<li><p style="text-align:justify;">Określenie tego, czym jest i jakie szanse wychowawcze stwarza BŚP.</p></li>'
        '<li><p style="text-align:justify;">Zaproponowanie działań pozwalających skutecznie wykorzystać BŚP w pracy drużyny.</p></li>'
        '<li><p style="text-align:justify;">Zaproponowanie działań dla ponad-drużynowych poziomów struktury ZHP w celu wsparcia drużyn w wykorzystaniu BŚP w pracy wychowawczej.</p></li>'
        '</ol>'

        '<h1>Czym jest BŚP?</h1>'
        '<p style="text-align:justify;">'
        'Betlejemskie Światło Pokoju jest corocznym wydarzeniem, w ramach którego Światło zapalane jest w Betlejem, w Grocie Narodzenia Pańskiego, skąd leci samolotem do Austrii, zaś dalej jest przekazywane jest w formie “sztafety” do innych krajów. Dla chrześcijan Światło jest symbolem narodzonego Chrystusa niosącego pokój dla całego świata. Jest to unikatowe przedsięwzięcie, co roku angażujące harcerzy i skautów z wielu krajów z całego świata.'
        '</p>'
        '<h1>Cechy BŚP w kontekście przydatności wychowawczej</h1>'
        '<ul>'

          '<li>'
          '<p style="text-align:justify;">'
          '<b>Zakorzenienie w wierze i filozofii chrześcijańskiej</b>'
          '<br>BŚP jest wydarzeniem wynikającym z wiary chrześcijańskiej. Pozwala ono wejść w refleksję nad wydarzeniem narodzin i życia Jezusa, jego misji, zmianą, jaką wywarł na świat i na życie miliardów ludzi. BŚP pozwala także na refleksję nad pojęciem „pokoju” – nie tylko jako zjawisko międzypaństwowe, ale przede wszystkim personalne związane z:'
          '</p>'
          '<ul>'
            '<li><p style="text-align:justify;">przebaczeniem,</p></li>'
            '<li><p style="text-align:justify;">chrześcijańskim miłosierdziem,</p></li>'
            '<li><p style="text-align:justify;">przybieraniem przyjaznych postaw względem ludzi,</p></li>'
            '<li><p style="text-align:justify;">pojęciem „bliźniego”,</p></li>'
            '<li><p style="text-align:justify;">domniemaniem dobrych intencji drugiego człowieka w myśl św. Ignacego Loyoli: <i>„chrześcijanin winien być bardziej skory do ocalenia wypowiedzi bliźniego, niż do jej potępienia”</i>.</p></li>'
          '</ul>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<b>Ucieleśnienie wartości do zrozumiałych czynów</b>'
          '<br>BŚP skupia się na powszechnych dla cywilizacji łacińskiej i łatwych do zrozumienia (zwłaszcza przez członków metodyki zuchowej i harcerskiej) aspektach filozofii chrześcijańskiej takich jak pokój, przebaczenie, wspólnota, współpraca, wrażliwość na potrzebujących etc.. Czyni to korzystając z działań takich jak:'
          '</p>'

          '<ul>'
            '<li><p style="text-align:justify;">stwarzanie naturalnych okazji do rozmowy o narodzinach Jezusa Chrystusa,</p></li>'
            '<li><p style="text-align:justify;">stwarzanie naturalnych okazji do rozmowy o pokoju,</p></li>'
            '<li><p style="text-align:justify;">stwarzanie okazji do udziału w i pomocy w oprawie uroczystej mszy przekazania Światła,</p></li>'
            '<li><p style="text-align:justify;">próba znalezienia osób potrzebujących, którym można zaoferować pomoc,</p></li>'
            '<li><p style="text-align:justify;">zaniesienie Światła do osób potrzebujących.</p></li>'
          '</ul>'
          '</li>'

          '<li>'
            '<p style="text-align:justify;">'
            '<b>Powszechność i tożsamość harcerska</b>'
            '<br>BŚP jest wydarzeniem powszechnym w środowisku harcerskim w Polsce, będąc jednocześnie wydarzeniem ogólnoświatowym. Pozwala to kształtować u uczestników tożsamość harcerską związaną z byciem częścią wspólnoty, skoordynowanego wydarzenia, budowanego wysiłkiem i zaangażowaniem tysięcy osób, których liczba przekracza możliwość indywidualnego poznania każdego z nich.'
            '</p>'
          '</li>'

          '<li>'
            '<p style="text-align:justify;">'
            '<b>Podniosłość świętowania</b>'
            '<br>BŚP jest organizowane w formie podniosłego święta, co (jeśli dobrze wykorzystane) pozwala budować przekonanie o wartości płynącej z wydarzeń religijnych. Stwarza okazję do zorganizowania w katedrze lub innym ważnym kościele uroczystej Mszy Świętej, w oprawie której harcerze mogą uczestniczyć. Cecha ta może skutecznie nakłonić harcerzy do refleksji, że coś musi być w narodzinach Chrystusa i zmianie, którą dał światu, skoro warto się porządnie ubrać, zorganizować chór i stawić tłumnie na uroczystości przekazania Światła.'
            '</p>'
          '</li>'

          '<li>'
            '<p style="text-align:justify;">'
            '<b>Okazja do służby na rzecz drugiego, obcego człowieka</b>'
            '</p>'
          '</li>'

        '</ul>'
        '<p style="text-align:justify;">'
        'Ponadto BŚP jako duże, cykliczne wydarzenie skierowane w dużej mierze na zewnątrz pozwala na osiągnięcie dodatkowych korzyści dla Związku:'
        '</p>'

        '<ul>'
          '<li><p style="text-align:justify;">budowanie pozytywnego wizerunku harcerstwa jako wychodzącego do społeczeństwa,</p></li>'
          '<li><p style="text-align:justify;">nawiązywanie i podtrzymywanie relacji z innymi organizacjami, strukturami etc., które mogą wspierać działalność harcerską.</p></li>'
        '</ul>'

        '<h1>Co może zrobić drużyna, by dobrze przygotować się do BŚP?</h1>'
        '<p style="text-align:justify;">'
        'Przygotowań do BŚP nie można zacząć w grudniu - należy to uczynić z odpowiednim wyprzedzeniem.'
        '<br>'
        '<br>Przede wszystkim warto wpisać plany związane z BŚP oraz przygotowaniem się do niego do rocznego planu pracy drużyny.'
        '<br>'
        '<br>Przygotowania do BŚP mogą być podzielone na trzy etapy:'
        '</p>'
        '<ul>'

          '<li>'
          '<p style="text-align:justify;">'
          '<b>Wprowadzenie merytoryczne do BŚP</b>'
          '<br>Zbiórka o BŚP przybliżająca ideę, historię, znaczenie BŚP oraz wartości, które z niego płyną. Wprowadzenie merytoryczne może oprzeć się na następujących elementach:'
          '</p>'
          '<ul>'
            '<li><p style="text-align:justify;">Znaczenia narodzin i życia Jezusa Chrystusa,</p></li>'
            '<li><p style="text-align:justify;">Trasa, jaką odbywa Światło od Groty Narodzenia Pańskiego w Betlejem, aż do Polski (lub konkretniej do miejsca, w którym mieszkają harcerze),</p></li>'
            '<li><p style="text-align:justify;">Gawęda o BŚP,</p></li>'
            '<li><p style="text-align:justify;">Czym jest pokój? Na czym polega idea pokoju dotycząca serca każdego człowieka?</p></li>'
          '</ul>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<b>Wewnętrzne przygotowanie się drużyny do BŚP</b>'
          '<br>Zbiórka (lub zbiórki) pozwalające uczestnikom przygotować siebie samych do BŚP jak również przygotować się do służby na rzecz potrzebujących, która (służba) zostanie zakończona przekazaniem im Światła.'
          '</p>'

          '<ul>'
            '<li><p style="text-align:justify;">nauczenie uczestników piosenki „światło z Betlejem” [Z, H],</p></li>'
            '<li><p style="text-align:justify;">sąd nad sprawą: „Czym jest pokój? Jaki jest jego związek z indywidualnym życiem każdego człowieka? Co konkretnie oznacza życie w pokoju i jakie postawy musi człowiek tak żyjący przyjać?” [W],</p></li>'
            '<li><p style="text-align:justify;">ustalenie z uczestnikami, kto może potrzebować pomocy w okolicy? Gdzie można zanieść Światło jako drużyna? [Z, H, HS, W],</p></li>'
            '<li><p style="text-align:justify;">planowanie służby np. w czasie adwentu, która zostanie zwieńczona przekazaniem światła. [H, HS, W],</p></li>'
            '<li><p style="text-align:justify;">przygotowanie podarków dla osób, którym zaniesione zostanie Światło (np. lampiony, kartki, bombki choinkowe, ciasteczka) [Z, H, HS, W].</p></li>'
            '<li><p style="text-align:justify;">realizacja wyzwania (duchowego instrumentu metodycznego) opartego o BŚP (warto wykorzystać sprawność BŚP z „starego SIM”),</p></li>'
          '</ul>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<b>Działania zewnętrzne drużyny w ramach BŚP</b>'
          '<br>Warto, aby drużyna podjęła służbę, która zostanie zwieńczona przekazaniem światła osobom, którym niesiona jest służba.'
          '</p>'
          '<ul>'
            '<li><p style="text-align:justify;">wzięcie udziału w akcji „Szlachetna Paczka”,</p></li>'
            '<li><p style="text-align:justify;">wzięcie udziału w akcji „Paczuszka dla maluszka”,</p></li>'
            '<li><p style="text-align:justify;">wzięcie udziału w nowennie i modlitwie za rodzinę,</p></li>'
            '<li><p style="text-align:justify;">wzięcie udziału w roratach porannych,</p></li>'
            '<li><p style="text-align:justify;">wsparcie domu dziecka,</p></li>'
            '<li><p style="text-align:justify;">wsparcie domu spokojnej starości,</p></li>'
          '</ul>'
          '</li>'

        '</ul>'

        '<h1>Co może zrobić drużyna, by dobrze wziąć udział w BŚP?</h1>'

        '<p style="text-align:justify;">'
        'Wartość wychowawcza BŚP zależy przede wszystkim od przygotowania członków drużyny do BŚP. Uczestnictwo drużyny w akcjach związanych z BŚP powinno być jak najbardziej aktywne – członkowie drużyny powinni być w nie możliwie bezpośrednio zaangażowani. Samo „odstanie” w szeregu podczas mszy, czy podczas wręczania Światła burmistrzowi niesie ze sobą mizerne skutki wychowawcze.'
        '</p>'
        '<ol>'

          '<li>'
          '<p style="text-align:justify;">'
          '<b>Uczestnictwo we mszy przekazania światła</b>'
          '<br>Zaangażowanie uczestników w oprawę mszy przekazania (czytania, śpiew, służba przy ołtarzu, modlitwa wiernych, procesja z darami).'
          '</p>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<b>Uczestnictwo w hufcowych obchodach przekazania światła</b>'
          '<br>Warto je rozważyć jedynie, jeśli są one wychowawczo przystosowane dla drużyn.'
          '</p>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<b>Rozniesienie światła potrzebującym</b>'
          '<br>Rozniesienie światła powinno zostać uprzednio umówione, zaś lista miejsc powinna zostać przygotowana. Warto udokumentować zdjęciowo każde z odwiedzonych miejsc.'
          '</p>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<b>Lokalne/sąsiedzkie kolędowanie</b>'
          '<br>W przypadku starszych drużyn warto zorganizować lokalne kolędowanie w przestrzeni publicznej (np. w harcówce, kościele, w szkole, OSP, świetlicy wiejskiej etc.) i zaprosić na nie lokalną, znajomą społeczność.'
          '</p>'
          '</li>'

          '<li>'
            '<p style="text-align:justify;">'
            '<b>Wigilia środowiska ze Światłem</b>'
            '<br>Przeprowadzenie Wigilii środowiska (np. drużyny lub szczepu) i zapewnienie, żeby światło było obecne na wigilii środowiska. Warto sprawić, by podczas łamania się opłatkiem harcerze (HS, W) skorzystali z okazji i przeprosili lub podziękowali sobie nawzajem - w duchu zarówno harcerskiego braterstwa jak i pokoju w rozumieniu BŚP.'
            '</p>'
          '</li>'

        '</ol>'

        '<h1>Jak wspierać drużyny?</h1>'
        '<p style="text-align:justify;">'
        'Z uwagi na to, że BŚP jest wydarzeniem międzynarodowym, struktury organizacji wyższe niż drużyna mogą znacząco wesprzeć drużyny w osiąganiu celów wychowawczych przy okazji pracy z BŚP. Wspierać drużyny można w tym zakresie na szereg sposobów:'
        '</p>'

        '<ul>'
          '<li><p style="text-align:justify;">Zorganizować wyjazd polskiej delegacji do Austrii dla drużyn,</p></li>'
          '<li><p style="text-align:justify;">Zorganizować wyjazd na Zlot Betlejemski w Zakopanem dla drużyn,</p></li>'
          '<li><p style="text-align:justify;">Zorganizować centralne lub regionalne uroczystości przekazania światła, zaprosić przedstawicieli innych wyznań chrześcijańskich.</p></li>'
          '<li><p style="text-align:justify;">Zorganizowanie konkursu, który wyłoni patrole, które zanoszą Światło do najważniejszych instytucji lokalnych lub państwowych (np. konkurs „Ambasadorzy Światła”),</p></li>'
        '</ul>'

        '<h1>Odznaka BŚP</h1>'
        '<p style="text-align:justify;">'
        'Motywacją dla harcerzy dla przygotowań do BŚP może być przygotowana przez ZHP propozycja Odznaki BŚP. Szczegóły dotyczące zasad i wymagań dostępne są w załączniku ${_attach_html_odznaka_bsp}.'
        '</p>'

        '<h1>Przykładowe pomysły (miejsca i inicjatywy) na służbę w Warszawie</h1>'

        '<ul>'
        '<li><p style="text-align:justify;">Szlachetna paczka (<a href="https://www.szlachetnapaczka.pl/">szlachetnapaczka.pl</a>),</p></li>'
        '<li><p style="text-align:justify;">Paczuszka dla maluszka (<a href="https://paczuszkadlamaluszka.pl/">paczuszkadlamaluszka.pl</a>),</p></li>'
        '<li><p style="text-align:justify;">Domy dziecka,</p></li>'
        '<li><p style="text-align:justify;">Domy spokojnej starości,</p></li>'
        '<li><p style="text-align:justify;">Świąteczna Zbiórka Żywności organizowana przez Bank Żywności SOS (<a href="https://bzsos.pl/">bzsos.pl</a>),</p></li>'
        '<li><p style="text-align:justify;">"Warszawska paczka świąteczna",</p></li>'
        '<li><p style="text-align:justify;">"Warszawska wigilia z dostawą",</p></li>'
        '<li><p style="text-align:justify;">Stowarzyszenie "Otwarte Drzwi" (<a href="https://otwartedrzwi.pl/">otwartedrzwi.pl</a>),</p></li>'
        '<li><p style="text-align:justify;">Wigilia dla ubogich,</p></li>'
        '<li><p style="text-align:justify;">Inicjatywy na platformie ochotnicy.waw.pl,</p></li>'

        '</ul>',

    howToFail: [
      'Potraktować jako cel sam akt przekazania Światła, bez wcześniejszego przygotowania drużyny do duchowej strony tego wydarzenia.',
    ],
    attachments: [
      _attach_odznaka_bsp,
    ]
);