import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

import '../common_attachments.dart';

Konspekt wstep_do_wychowania_duchowego = Konspekt(
    name: 'wstep_do_wychowania_duchowego',
    title: 'Wstęp do wychowania duchowego',
    category: KonspektCategory.ksztalcenie,
    type: KonspektType.zajecia,
    spheres: {},
    metos: [Meto.kadra],
    coverAuthor: 'Freepik (al17)',
    author: DANIEL_IWANICKI,
    aims: [
      'Przekazanie uczestnikom różnicy między rozwojem sfer funkcjonalnych od sfery ducha',
      'Przekazanie uczestnikom rozróżnienia poziomów i etapów rozwoju sfery ducha',
      'Zwrócenie uwagi uczestników na brak możliwości neutralności rozwoju duchowego',
      'Zrozumienie co wynika z oparcia wartości ZHP o chrześcijaństwo'
    ],
    attachments: [
      attach_o_strukturze_i_ksztaltowaniu_duchowosci,
      attach_neutralnosc_duchowa_przyklady,
      attach_cel_wychowania_duchowego_zhp_statut,
      attach_cel_wychowania_duchowego_zhp_uchwala,
      attach_kratka_minimow_rozwoju_duchowego,
    ],
    materials: [

      KonspektMaterial(
        name: 'Dostępny do przygotowania merytorycznego załącznik “$attach_title_o_strukturze_i_ksztaltowaniu_duchowosci”',
        attachmentName: attach_name_o_strukturze_i_ksztaltowaniu_duchowosci,
      ),

      KonspektMaterial(
        name: 'Duży arkusz papieru (flipchart)',
        amount: 1,
      ),

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_neutralnosc_duchowa_przyklady”',
        attachmentName: attach_name_neutralnosc_duchowa_przyklady,
      ),

      KonspektMaterial(
        name: 'Kartka A4',
        amount: 4,
      ),

      KonspektMaterial(
        name: 'Długopis',
        amount: 4,
      ),

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_cel_wychowania_duchowego_zhp_statut”',
        attachmentName: attach_name_cel_wychowania_duchowego_zhp_statut,
        amount: 4
      ),

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_cel_wychowania_duchowego_zhp_uchwala”',
        attachmentName: attach_name_cel_wychowania_duchowego_zhp_uchwala,
        amount: 4
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_kratka_minimow_rozwoju_duchowego”',
          attachmentName: attach_name_kratka_minimow_rozwoju_duchowego,
          amount: 4
      ),

    ],
    steps: [

      KonspektStep(
          title: 'Pytanie wstępne',
          duration: Duration(minutes: 10),
          required: false,
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Uczestnicy odpowiadają na pytanie:'
              '<br>'
              '<br><i>“Co najważniejszego chcecie przekazać harcerzom w procesie wychowawczym? W czym te sprawy, idee, czy wartości mają swoje źródło? Co sprawiło, że uważasz to za ważne?”</i>.'
              '<br>'
              '<br>W przypadku dużej liczby uczestników prowadzący dzieli uczestników na 5 osobowe grupy i prosi uczestników o wymienienie się swoimi odpowiedziami (po 1-2 minuty na uczestnika). Prowadzący, jeśli chce poznać odpowiedzi uczestników może między nimi “krążyć” i nadstawiać ucha - warto z grubsza poznać uczestników zajęć.'
              '</p>'
      ),

      KonspektStep(
          title: 'Skrót tematu zajęć',
          duration: Duration(minutes: 2),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący informuje uczestników o czym będą, a o czym nie będą niniejsze zajęcia.'
              '<br>'
              '<br>Zajęcia służą temu, żeby:'
              '</p>'

              '<ul>'

              '<li>'
              '<p style="text-align:justify;">Holistycznie zdefiniować i zrozumieć czym jest duchowość,</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">Określić relację między duchowością, a religijnością,</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">Określić relację między duchowością a wychowaniem,</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">Określić jaka jest i skąd się bierze duchowość harcerska.</p>'
              '</li>'

              '</ul>'
              '<p style="text-align:justify;">'
              'Podczas zajęć nie będzie poruszana kwestia tego jak konkretnie pracować z duchowością - nie starczy na to czasu. Pod koniec zajęć zostanie jednak udostępnione kompendium konspektów chętnym osobom.'
              '</p>'
      ),

      KonspektStep(
          title: 'Sfery rozwoju i ich relacje',
          duration: Duration(minutes: 15),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący opierając się na wiedzy z załącznika $attach_html_o_strukturze_i_ksztaltowaniu_duchowosci wprowadza podział człowieka na 5 sfer rozwoju - 4 sfery funkcjonalne: <b>ciało</b>, <b>umysł</b>, <b>emocje</b>, <b>relacje</b> i jedną sferę centralną: sferę <b>ducha</b>.'
              '<br>'
              '<br>Prowadzący opisuje zależności między sferami - sfery funkcjonalne dostarczają człowiekowi <b>zdolności</b>, zaś sfera ducha jest <b>sposobem</b> ich zarządzania.'
              '<br>'
              '<br>Jeżeli prowadzący uzna, że poprawi to poziom zrozumienia, może skorzystać z analogii opisanej sfer funkcjonalnych i centralnych do samochodu i kierowcy opisanego w załączniku $attach_html_o_strukturze_i_ksztaltowaniu_duchowosci.'
              '<br>'
              '<br>Następnie prowadzący hasłowo wymienia uczestnikom kilka elementów poszczególnych sfer i prosi uczestników o podanie do jakiej sfery należą, np.:'
              '</p>'

              '<ul>'

              '<li>'
              '<p style="text-align:justify;">'
              'Umiejętność gry na trąbce'
              '<br><i>Sfera umysłu (koordynacja) i ciała (płuca)</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Zdolność marszu przez tydzień przy -20°C'
              '<br><i>Sfera ciała</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Kontrolowanie swoich reakcji będąc wściekłym'
              '<br><i>Sfera emocji</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Umiejętność zdyskredytowania kogoś w oczach wspólnoty'
              '<br><i>Sfera relacji</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Postępowanie zgodnie ze swoimi przekonaniami w środowisku stresogennym'
              '<br><i>Sfera ducha (chęć postępowania) i emocji (panowanie nad stresem)</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Posiadanie spójnego światopoglądu'
              '<br><i>Sfera ducha</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Zdolność zbudowania ładnej bramy obozowej'
              '<br><i>Sfera umysłu</i>'
              '</p>'
              '</li>'

              '</ul>'
              '<p style="text-align:justify;">'
              'Prowadzący może zwrócić uwagę na fakt, że jest różnica między <b>emocjami</b> a <b>doświadczeniem duchowym</b>. Czasami przestrzenie te są mylone, ponieważ doświadczenie duchowe często rodzi silne emocje, ale jest doświadczeniem najgłębszego sensu bycia, jedności z Bogiem, etc..'
              '<br>'
              '<br>Ważne, by prowadzący na końcu wprowadzenia zaznaczył:'
              '<br>'
              '<br><b><i>“Duchowość nie jest umiejętnością, dlatego nie należy sądzić że można ją rozwinąć tymi samymi metodami co intelekt, ciało, czy emocje.”</i></b>'
              '<br>'
              '<br>Przechodząc do kolejnego punktu prowadzący oświadcza, że <b>przedmiotem tych zajęć będzie jedynie sfera ducha</b>. Inne sfery nie będą tutaj głębiej rozpatrywane.'
              '</p>'
      ),

      KonspektStep(
          title: 'Poziomy i etapy rozwoju duchowości',
          duration: Duration(minutes: 20),
          activeForm: false,
          contentBuilder: ({required bool isDark}) => '<p style="text-align:justify;">'
              'Prowadzący na podstawie załącznika $attach_html_o_strukturze_i_ksztaltowaniu_duchowosci opisuje <b>etapy rozwoju duchowego</b> - w pierwszym etapie dzieci są uczone jedynie zachowań, które budują u nich postawy, w wieku ok. 10 lat rozpoczyna się myślenie abstrakcyjne i konceptualizują się wartości, które następnie, w wieku ok. 15 lat są porządkowane w światopogląd i internalizowane jest pojęcie aksjomatu.'
              '<br>'
              '<br>Ważne, by w procesie opisu prowadzący narysował we wspólnym miejscu odwróconą piramidę, tak jak poniżej:</p>'
              '<br>${piramidaDuchowosciHtml(isDark: isDark)}'
              '<p style="text-align:justify;">'
              '<br>W dalszej kolejności prowadzący wprowadza pojęcie <b>integracji duchowości</b> - sposobu w jaki poziomy duchowości kształtują się w procesie rozwoju.'
              '<br>'
              '<br>Ważne, by prowadzący zaznaczył, że struktura wartości nie zależy jedynie od środowiska i wychowania, ale także od <b>natury człowieka</b>, m.in. od jego <b>temperamentu</b>.'
              '</p>'
      ),

      KonspektStep(
          title: 'Duchowość powszechna, mądrość, kultura i tradycja',
          duration: Duration(minutes: 15),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący na podstawie załącznika $attach_html_o_strukturze_i_ksztaltowaniu_duchowosci opisuje zjawisko <b>duchowości powszechnej</b>, związanej z nią <b>sztafetowością</b> i <b>selekcją naturalną</b>. Następnie definiuje w oparciu o duchowość powszechną pojęcie <b>mądrości</b> oraz jej implementacją i formą przekazu - <b>kulturą</b> i jej elementami - <b>tradycjami</b>. Prowadzący opisuje także zjawisko dualizmu tradycji - z jednej strony jej wiecznego niedoczasu względem rzeczywistości, z drugiej jej funkcji tworzenia norm i przekazywania sprawdzonych rozwiązań nowym pokoleniom.'
              '<br>'
              '<br>Prowadzący może zobrazować dylemat tego <i>"jak ściśle trzymać się tradycji"</i> w sposób następujący:'
              '<br>'
              '<br><i>Gdybyśmy zanegowali na raz wszystkie tradycje, w ciągu jednego pokolenia wrócilibyśmy do jaskiń. Ale gdybyśmy nigdy nie podważyli żadnej tradycji, nigdy z tych jaskiń byśmy nie wyszli.</i>'
              '</p>'
      ),

      KonspektStep(
          title: 'Duchowość, religia, religijność - opinie uczestników',
          duration: Duration(minutes: 10),
          activeForm: false,
          required: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący zadaje publicznie pytanie:'
              '<br>'
              '<br><b><i>“Jaka jest relacja między duchowością, religią, a religijnością?”</i></b>.'
              '<br>'
              '<br>Uczestnicy indywidualnie przez kilka minut na mini-kartkach zapisują hasłowo swoje odpowiedzi, które potem będą mogli rozwinąć.'
              '<br>'
              '<br>Prowadzący prosi uczestników kolejno o zaprezentowanie po jednej kartce i położeniu jej na środku - prezentacja w kręgu zachodzi dopóki ktoś jeszcze ma jakąś kartkę. Jeśli jakaś myśl została już przedstawiona, nie ma potrzeby jej ponownego rozwijania - można po prostu dołożyć kartkę do już położnej.'
              '</p>'
      ),

      KonspektStep(
          title: 'Duchowość, religia, religijność',
          duration: Duration(minutes: 20),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący na podstawie załącznika $attach_html_o_strukturze_i_ksztaltowaniu_duchowosci definiuje religię:'
              '<br>'
              '<br>Religia jest duchowością powszechną. <b>Religia nie jest “dodatkiem” do duchowości, ale jest określoną duchowością</b> - ma określone aksjomaty i wartości, określone sposoby jej (religii jako duchowość) integracji.'
              '<br>'
              '<br>Warto również, by prowadzący odniósł się do popularnego lecz zupełnie nietrafionego porównania, zgodnie z którym relacja między religią, a duchowością człowieka jest zdefiniowana jako relacja “zawierania”: <b>w obszernym zbiorze “duchowości” zawiera się mniejszy zbiór “religii”</b>, oraz że część osób ma duchowość “z religią”, a część “bez religii”. Relacja ta jest błędna: religia nie jest opcjonalną częścią duchowości, ale rodzajem, sposobem duchowości. Religia jest konkretną, całą duchowością.'
              '<br>'
              '<br>Trafniejszą analogią jest przestrzeń, w której występuje nieskończenie wiele różnych duchowości, z których każda ma swój aksjomat, wartości, postawy, zachowania. W przestrzeni tej istnieje rodzina duchowości religijnych, wśród tych zaś, istnieje ogromna rodzina duchowości chrześcijańskich: (np. chrześcijańska duchowość ludowa, jezuicka, franciszkańska, charyzmatyczna, dominikańska, etc.). Nie można jednak z duchowości “wyjąć” elementu religijnego i dalej mieć do czynienia z duchowością, tak samo jak nie można z psa wyjąć elementu “jamnik” i dalej uważać, że jest to pies. Jamnik nie jest dodatkiem do psa, tylko jest rodzajem całego, spójnego psa.'
              '<br>'
              '<br>Oznacza to, że błędnym jest myślenie, że możliwe jest prowadzenie wychowania w drużynie w oparciu o jedną, wybraną duchowość, i “wzbogacania” jej dla niektórych religią, a dla innych nie. Wynika to z faktu, że jeśli ktoś jest wychowywany w duchowości religijnej, ma określone religijne aksjomaty, co stoi w zupełnym kontraście do aksjomatów osób niereligijnych!'
              '<br>'
              '<br>Podobnie, błędnym jest pogląd jakoby istniała automatyczna symetria, między duchowością osób religijnych i niereligijnych: osoby religijne mają z góry określone aksjomaty, jednak aksjomaty osób niereligijnych dopiero wymagają określenia i doprecyzowania.'
              '<br>'
              '<br><b>Religijność</b> jest zestawem zachowań i postaw wynikających z duchowości religijnej. Religijność nie jest jednak zbiorem wartości, ani całą duchowością - religijność to jedynie wierzchnia warstwa duchowości, która pozwala (lecz sama w sobie niekoniecznie wystarcza) by duchowość religijną skutecznie integrować.'
              '</p>'
      ),

      // Add aim:
      // - Zaprezentowanie uczestnikom wartości i postaw (przebaczenie, prawdomówność, pomoc bliźnim, wierność w związku, ew. modlitwa), które choć pozornie uniwersalne, wynikają ze ściśle określonego światopoglądu.
      // - Przekonanie uczestników, że neutralność światopoglądowa w wychowaniu nie jest możliwa.
      KonspektStep(
          title: 'Neutralność światopoglądowa',
          duration: Duration(minutes: 25),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący przedstawia uczestnikom scenariusze z załącznika $attach_neutralnosc_duchowa_przyklady. Wszystkie scenariusze opisują sytuacje wychowawcze z udziałem instruktora harcerskiego. Zadaniem uczestników jest określenie:'
              '<br>'
              '<br><u>Czy zachowanie instruktora <b>było neutralne duchowo</b>, a jeśli nie, to <b>jakie wartości</b> lub postawy owa sytuacja wzmacnia?</u>'
              '<br>'
              '<br>Prowadzący prosi, by uczestnicy nie skupiali się na technikaliach, czyli czy instruktor zareagował w sposób efektywny. Ważniejsze jest, by uczestnicy skupili się na skutku duchowym jego działań - czyli na duchowości (postawa, wartościach), które działanie instruktora wzmocniło u wychowanków.'
              '<br>'
              '<br>Jeśli uczestników jest więcej niż 20, można podzielić ich na dwie grupy, które równolegle między sobą dyskutują o scenariuszach.'
              '<br>'
              '<br>Gdy wszystkie grupy przedyskutują swoje scenariusze, prowadzący zadaje pytanie:'
              '<br>'
              '<br><b><i>“Czy w ogóle istnieje neutralność światopoglądowa w wychowaniu?”</i></b>.'
              '<br>'
              '<br>W toku próby odpowiedzi na to pytanie może wywiązać się między uczestnikami dyskusja. Nie powinna ona trwać zbyt długo. Scenariusze, które zostały omówione przez uczestników powinny prowadzić do wniosku: w sposób oczywisty harcerskie <b>wychowanie nie jest neutralne duchowo</b>.'
              '</p>'
      ),

      // Add aim:
      // - Zbudowanie u uczestników zdolności wiązania wartości harcerskich z ich aksjomatami.
      // - Przebicie bańki fałszywej tezy relatywizmu wyznawanych w harcerstwie wartości.
      KonspektStep(
          title: 'Źródła wartości - dyskusje o scenariuszach',
          duration: Duration(minutes: 15),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący zaczyna od stwierdzenia:'
              '<br>'
              '<br><i>“Skoro wiadomo, że harcerstwo nie jest neutralne, to spróbujmy wgryźć się w esencję ducha harcerskiego wychowania. Może uda się to zrobić bez utonięcia w filozofii i teologii”</i>.'
              '<br>'
              '<br>Prowadzący znowu prezentuje uczestnikom scenariusze z załącznika $attach_neutralnosc_duchowa_przyklady - przykłady”. Prowadzący stawia przed nimi zadanie w formie pytania:'
              '<br>'
              '<br><i>“Wszystkie przedstawione w scenariuszach wartości mają swoje odzwierciedlenie w PH. Ale przecież PH nie spadło z nieba na kamiennych tablicach! Z jakiego aksjomatu wynikają prezentowane w scenariuszu postawy, przekonania i wartości?”</i>'
              '<br>'
              '<br>Prowadzący prosi uczestników, by dokopali się do najgłębszego źródła wartości (aksjomatu). Uczestnicy nie powinni bać się zanurkowania w przestrzeń <b>religii</b> i <b>filozofii</b>, a czasami <b>selekcji naturalnej</b>. Grupa nie musi być zgodna we wnioskach - może zaproponować zapisać kilka różnych aksjomatów, z których wynikają omawiane wcześniej wartości.'
              '<br>'
              '<br>Wskazane jest, by uczestnicy mieli możliwość swobodnej dyskusji. Dlatego, jeśli to możliwe, warto podzielić uczestników na grupy po nie więcej niż 7 osób i dać im po jednym ze scenariuszy. Dodatkowo każda grupa powinna dostać kartkę, na której powinna spisać swoje wnioski.'
              '<br>'
              '<br>Na końcu każda grupa w ciągu minuty prezentuje wyniki swojej pracy. Gdy skończy, prowadzący prosi, by położyli omawiany scenariusz oraz kartkę z aksjomatem przed sobą.'
              '</p>'
      ),

    ]
);