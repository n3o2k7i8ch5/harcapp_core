import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people/data.dart';

Konspekt bibliodrama = const Konspekt(
    name: 'bibliodrama',
    title: 'Bibliodrama',
    category: KonspektCategory.harcerskie,
    type: KonspektType.zajecia,
    spheres: {
      KonspektSphere.duch: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.duchAksjomaty: KonspektSphereFields(
                fields: {
                  aksjoSwietoscHistoriiBiblijnych: {KonspektSphereFactor.duchBezposrednieDoswiadczenie},
                }
            ),
          }
      )
    },

    metos: [Meto.wedro],
    coverAuthor: 'freepik.com (freepik)',
    author: MIKOLAJ_WITKOWSKI,
    aims: [
      'Doświadczenie Słowa Bożego poprzez zbudowanie empatycznej relacji z bohaterami biblijnych historii',
      'Doświadczenie Słowa Bożego poprzez wymianę z innymi osobami punktów widzenia interpretowanej historii biblijnej',
      'Doświadczenie Słowa Bożego poprzez cielesne przeżycie historii biblijnej odgrywając ją w scence'
    ],
    materials: [
      KonspektMaterial(
        amountAttendantFactor: 1,
        name: 'Wydrukowane fragmenty Pisma Świętego z planem bibliodramy. Przykłady w załącznikach.',
      ),
    ],
    summary: 'Forma teatralna, w której uczestnicy w grupach medytują nad fragmentem Pisma Świętego i wchodzą w rolę pozwalającą zadawać pytania bohaterom biblijnych wydarzeń oraz na nie odpowiadać.',
    description: '<p style="text-align:justify;">By zachować precyzję, forma zawarta w niniejszym konspekcie powinna być nazwana "<b>Warsztatami z elementami bibliodramy</b>". Żeby jednak tę nazwę skrócić, używana jest hasłowa nazwa "<b>bibliodrama</b>".'
        '<br>'
        '<br>Bibliodrama składa się z dwóch etapów:</p>'
        '<ul>'
        '<li><p>praca ze Słowem Bożym</p></li>'
        '<li><p>przygotowanie i przedstawienie scenki</p></li>'
        '</ul>'
        '<p style="text-align:justify;">Najważniejszym elementem bibliodramy jest praca duchowa poprzedzająca scenki. Należy mieć to na uwadze, jeśli rozważa się skrócenie czasu bibliodramy.</p>',
    attachments: [
      KonspektAttachment(
        name: 'fragment_przykladowy_1',
        title: 'Przykładowy fragment Pisma Świętego (nr 1)',
        assets: {
          FileFormat.pdf: null,
          FileFormat.docx: null
        },
      ),
      KonspektAttachment(
        name: 'fragment_przykladowy_2',
        title: 'Przykładowy fragment Pisma Świętego (nr 2)',
        assets: {
          FileFormat.pdf: null,
          FileFormat.docx: null
        },
      ),
      KonspektAttachment(
        name: 'fragment_przykladowy_3',
        title: 'Przykładowy fragment Pisma Świętego (nr 3)',
        assets: {
          FileFormat.pdf: null,
          FileFormat.docx: null
        },
      )
    ],
    steps: [

      KonspektStep(
          title: 'Podział na grupy',
          duration: Duration(minutes: 5),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Prowadzący dzieli uczestników na grupy. Liczba grup zależy od liczby uczestników - w jednej grupie powinno być ok. 6-10 osób. Ważne, by powstały przynajmniej dwie grupy, by przygotowane na końcu przez każdą grupę scenki mogły zostać komuś przedstawione. Zbyt wiele osób w grupie niepotrzebnie wydłuża pracę, zbyt mało ogranicza dynamikę spacerów pytań.'
              '<br>'
              '<br>Każda osoba otrzymuje po jednym fragmencie Pisma Świętego - w ramach jednej grupy wszyscy otrzymują ten sam fragment. Ważne, by każdy z fragmentów był różny. Fragmenty Biblii muszą mieć potencjał fabularny – możliwość ich przedstawienia.'
              '<br>'
              '<br>Przykłady fragmentów można znaleźć w załącznikach:</p>'
              '<ul>'
              '<li><p style="text-align:justify;"><a href="fragment_przykladowy_1@attachment">Przykładowy fragment Pisma Świętego (nr 1)</a></p></li>'
              '<li><p style="text-align:justify;"><a href="fragment_przykladowy_2@attachment">Przykładowy fragment Pisma Świętego (nr 2)</a></p></li>'
              '<li><p style="text-align:justify;"><a href="fragment_przykladowy_3@attachment">Przykładowy fragment Pisma Świętego (nr 3)</a></p></li>'
              '</ul>'
              '<p style="text-align:justify;">Wskazane jest także, by w każdej z grup znalazła się przynajmniej jedna doświadczona osoba, która będzie ją animować: pilnowała czasu, decydowała o przejściach między kolejnymi etapami, wyczuwając atmosferę w grupie.</p>'
      ),


      KonspektStep(
          title: 'Medytacja fragmentu Pisma Świętego',
          duration: Duration(minutes: 20),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Prowadzący rozdaje uczestnikom wydrukowane fragmenty Pisma Świętego wraz z krótką instrukcją medytacji.'
              '<br>'
              '<br>Uczestnicy w ciszy zapoznają się z fragmentem Biblii, jego bohaterami i ich historią. Ważne, by podjęli refleksję dotyczącą tego, co przykuwa ich uwagę, co ich porusza, z czym się nie zgadzają, czego nie rozumieją oraz o co chcielibyśmy zapytać samych bohaterów historii.</p>'
      ),


      KonspektStep(
          title: 'Wstępny krąg dzielenia',
          duration: Duration(minutes: 20),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Pierwsze dzielenie jest najbardziej uporządkowane. Uczestnicy kolejno w kręgu dzielą się swoimi refleksjami dotyczącymi przeczytanego fragmentu Biblii. Po zakończeniu wypowiedzi uczestnik mówi „dzięki” - w dobrym tonie jest, aby wówczas reszta również odpowiada „dzięki” - wówczas głos wędruje do następnej osoby. Gdy wszyscy się wypowiedzą i zostanie jeszcze czas, każdy może dodać coś jeszcze.'
              '<br>'
              '<br>Uczestnicy nie powinni się odnosić do swoich wzajemnych wypowiedzi w sposób krytyczny lub polemiczny.</p>'
      ),


      KonspektStep(
          title: 'Wstępny krąg dzielenia',
          duration: Duration(minutes: 20),
          activeForm: KonspektStepActiveForm.active,
          content: '<p style="text-align:justify;">Spacer jest najbardziej specyficzną formą bibliodramy. Odbywa się w grupach, jednak dobrze jest przed podziałem przećwiczyć go ze wszystkimi uczestnikami na popularnej biblijnej postaci.'
              '<br>'
              '<br>Uczestnicy chodzą powoli w kręgu i kontemplują w myślach bohatera z czytanego fragmentu wskazanego przez prowadzącego. Kiedy komuś pojawia się w głowie pytanie które chciałby owej postaci zadać, wchodzi do środka kręgu, krąg zatrzymuje się, po czym osoba w kręgu zadaje głośno pytanie do postaci. Następnie wraca do kręgu i krąg rusza dalej, tyle, że w przeciwnym kierunku. Uczestnicy w kręgu odpowiadają na pytanie (krótko i zwięźle) w pierwszej osobie wcielając się w bohatera, któremu zostało ono zadane. Odpowiedzi mogą być dowolne: to praca zbiorowej (nie)świadomości.'
              '<br>'
              '<br>Przykład pytania zadanego w środku kręgu:</p>'
              '<ul>'
              '<li><p><i>Józefie, jak się czułeś kiedy Maryja urodziła Ci syna?</i></p></li>'
              '</ul>'
              '<p style="text-align:justify;">Przykład odpowiedzi na pytanie od uczestników idących w kręgu:</p>'
              '<ul>'
              '<li><p><i>Byłem szczęśliwy.</i></p></li>'
              '<li><p><i>Czułem niepokój.</i></p></li>'
              '<li><p><i>Miałem dziwne poczucie podniosłości tego momentu.</i></p></li>'
              '<li><p><i>Martwiłem się, że zmarznie.</i></p></li>'
              '<li><p><i>...</i></p></li>'
              '</ul>'
              '<p style="text-align:justify;">Warto uczulić uczestników, że nie należy się przejmować poprawnością teologiczną pytań i odpowiedzi. Odpowiedzi mogą być ze sobą sprzeczne. Być może każdemu zapadnie w sercu coś innego. Gdy odpowiedzi zaczną się wyczerpywać, kolejna osoba mająca pytanie wchodzi do kręgu, zadaje je, krąg znowu zmienia kierunek i podąża dalej, formułując odpowiedzi na nowe pytanie.</p>'
      ),


      KonspektStep(
          title: 'Krąg dzielenia z pierwszym bohaterem',
          duration: Duration(minutes: 20),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Drugi krąg dzielenia jest luźniejszy od pierwszego. Uczestnicy dzielą się swoimi obserwacjami i doświadczeniami w formie dyskusji. Na tym etapie tworzy się wspólne rozumienie historii, nad którą uczestnicy pracują.</p>'
      ),


      KonspektStep(
          title: 'Spacer pytań z drugim bohaterem',
          duration: Duration(minutes: 20),
          activeForm: KonspektStepActiveForm.active,
          content: '<p style="text-align:justify;">Forma analogiczna do <i>spaceru pytań z pierwszym bohaterem</i>, tyle, że dotycząca drugiego, wybranego przez prowadzącego bohatera.</p>'
      ),


      KonspektStep(
          title: 'Krąg dzielenia z drugim bohaterem',
          duration: Duration(minutes: 20),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Forma analogiczna do <i>kręgu pytań z pierwszym bohaterem</i>, tyle, że dotycząca drugiego, wybranego przez prowadzącego bohatera.</p>'
      ),


      KonspektStep(
          title: 'Kontemplacja końcowa',
          duration: Duration(minutes: 20),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Uczestnicy po raz ostatni siadają z fragmentem sami. Kontemplacja powinna mieć formę jak najgłębszego wejścia w tę sytuację, bez nadmiernego analizowania.</p>'
      ),


      KonspektStep(
          title: 'Przygotowanie scenki',
          duration: Duration(minutes: 20),
          activeForm: KonspektStepActiveForm.active,
          content: '<p style="text-align:justify;">Uczestnicy na podstawie poprzednich form przygotowują scenkę, którą później odegrają - tworzą scenariusz, scenografię i kostiumy, dzielą się rolami i ćwiczą. Prowadzący nie musi przygotowywać żadnych rekwizytów - uczestnicy korzystają z rzeczy znajdujących się w miejscu, w którym się znajdują. Nie potrzeba im niczego więcej ponad to, co mają wokół siebie i ze sobą.'
              '<br>'
              '<br>Podczas przygotowywania scenki uczestnicy zazwyczaj wychodzą z nastroju skupienia i powagi – jest to dla nich forma rozładowania napięcia zgromadzonego podczas długotrwałej pracy wewnętrznej. Często towarzyszy temu rodzaj „odpału” – uczestnicy zaczynają żartować co ma pozytywny wpływ na liczbę i jakość pomysłów na formę przedstawienia historii. Dobrze jest dbać o to, żeby scenka uobecniała owoce duchowej pracy, jeśli jednak tak się nie stanie, nie trzeba się tym przejmować.</p>'
      ),


      KonspektStep(
          title: 'Przedstawienie scenek',
          duration: Duration(minutes: 10),
          activeForm: KonspektStepActiveForm.active,
          content: '<p style="text-align:justify;">Gdy wszystkie grupy są gotowe, rozpoczynają się przedstawienia. Po każdym przedstawieniu organizator powinien zachęcić grupę do podzielenia się z resztą owocami ich pracy oraz tym, w jaki sposób owoce te uobecniły się w scence.</p>'
      ),


    ]
);