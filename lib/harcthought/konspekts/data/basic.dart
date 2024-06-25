import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/asset_gallery_viewer.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/values/people.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../konspekt.dart';


const String aimPraktykaModlitwy = 'Praktyka modlitwy przez uczestników';


const String aimUmiejetnoscDyskusji = 'Kształtowanie u uczestników umiejetności krytycznego myślenia, argumentowania, dyskuskutowania i wypowiedzi';
const String aimUmiejetnoscNegocjowania = 'Kształtowanie u uczestników umiejetności negocjowania';
const String aimUmiejetnoscWedrowania = 'Kształtowanie u uczestników umiejętności sprawnego wędrowania';


const String aimHartDuchaWedrowanie = 'Hartowanie uczestników hartu ducha przez trudy wędrówki (dystans, pogoda, noszenie plecaków)';
const String aimHartDuchaZimno = 'Kształtowanie u uczestników hartu ducha przez wychodzenie z komfortu termicznego';
const String aimPostawaOdpowiedzialnosciZaCzynny = 'Kształtowanie u uczestników postawy odpowiedzialności za swoje czyny i decyzje';
const String aimWlasnaSprawczosc = 'Kształtowanie u uczestników wiary w swoją sprawczość';
const String aimOtwartoscNaInterakcje = 'Ksztaltowanie u uczestników postawy otwartości na interakcję z innymi ludźmi';


const String aimPostawaWspolpracy = 'Kształtowanie u uczestników postawy współpracy';
const String aimSzacunekDlaSprawnosciFizycznej = 'Kształtowanie u uczestników szacunku dla sprawności fizycznej';
const String aimSzacunekDlaSkutecznegoDzialania = 'Kształtowanie u uczestników szacunku dla skuteczności w działaniu';




List<Konspekt> allBasicKonspekts = [


  // Done
  const Konspekt(
      name: 'beretowa',
      title: 'Beretówa',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.cialo: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha, KonspektSphereMechanism.duchOtwartoscNaLudzi]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (vecstock)',
      author: DANIEL_IWANICKI,
      aims: [
        aimPostawaWspolpracy,
        aimSzacunekDlaSprawnosciFizycznej,
        aimSzacunekDlaSkutecznegoDzialania,
        'Kształtowanie u uczestników hartu ducha - działania pomimo drobnych zadrapań, wybitych palców, etc.'
      ],
      materials: [
        KonspektMaterial(
          amountAttendantFactor: 1,
          name: 'Beret',
        ),
        KonspektMaterial(
          amountAttendantFactor: 1,
          name: 'Znacznik przynależności do grupy',
        ),
      ],
      summary: 'Leśna gra harcerska, w której drużyny mają za zadanie wyeliminować przeciwne drużyny ściągając im berety z głów.',
      description: '<p style="text-align:justify;">Aby forma była skuteczna, uczestnicy muszą być w nią zaangażowani i nie mieć nic przeciwko rywalizacji (częściej jest to domeną chłopców niż dziewczyn). Forma bywa kontuzjogenna.'
          '<br>'
          '<br>Forma powinna być toczona na dużym terenie lesistym zapewniającym możliwość łatwego skrycia się.'
          '<br>'
          '<br>Zachowując opisane niżej zasady gry można nieznacznie zmienić jej cel dla uczestników, np:</p>'
          '<ul>'
          '<li>'
          '<p style="text-align:justify;">Drużyny są dzielone na <b>atakującą</b> i <b>broniącą</b>. Drużyna <b>broniąca</b> ma wyznaczony <b>teren krytyczny</b> (np. między pięcioma drzewami). Drużyna atakująca ma wyznaczonego <b>sapera</b> - osobę, która posiada przedmiot będący <b>bombą</b> (np. menażkę).'
          '<br>'
          '<br>Drużyna <b>atakująca</b> wygrywa, jeśli <b>saper</b> położy <b>bombę</b> w <b>terenie krytycznym</b>, przy czym <b>bombą</b> nie wolno rzucać.'
          '<br>'
          '<br>Drużyna <b>broniąca</b> wygrywa, jeśli zabije <b>sapera</b> lub jeśli obroni <b>teren krytyczny</b> przez 20 minut od rozpoczęcia gry.'
          '</p>'
          '</li>'
          '<li><p style="text-align:justify;">Każda drużyna ma wyznaczoną <b>królową</b>. Drużyna przegrywa, jeśli straci <b>królową</b> niezależnie od tego ile osób pozostanie na końcu przy życiu. Przegrana drużyna natychmiast kończy grę.</p></li>'
          '</ul>',
      steps: [

        KonspektStep(
            title: 'Przedstawienie zasad',
            duration: Duration(minutes: 10),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący przedstawia uczestnikom zasady gry:</p>'
                '<ul>'
                '<li><p style="text-align:justify;">W brze biorą udział co najmniej dwie grupy. Wygrywa grupa, której w której jako ostatniej zostaną "żywi" uczestnicy.</p></li>'
                '<li><p style="text-align:justify;">Każdy uczestnik rozpoczyna mając na głowie beret. Jak uczestnik ma na głowie beret, tak długo jest "żywy".</p></li>'
                '<li><p style="text-align:justify;">Berety można (a nawet trzeba) sobie wzajemnie ściągać z głowy.</p></li>'
                '<li><p style="text-align:justify;">W grze nie wolno uderzać, gryźć, kopać, ani dotykać twarzy drugiej osoby.</p></li>'
                '<li><p style="text-align:justify;">Gra toczy się na wybrany, jasny znak (np. trzykrotny gwizdek prowadzącego).</p></li>'
                '</ul>'
        ),


        KonspektStep(
            title: 'Podział na grupy',
            duration: Duration(minutes: 10),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący dzieli uczestników na wybraną liczbę grup. Ważne, by każda grupa charakteryzowała się podobną sprawnością ruchową.</p>'
        ),


        KonspektStep(
            title: 'Oznaczenie grup',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Każdy uczestnik zostaje oznaczenie przynależności do swojej grupy. Może to być szarfa naramienna o innym kolorze dla każdej grupy lub po prostu może to być beret o wybranym kolorze.'
                '<br>'
                '<br>Jeżeli do gry używane są berety harcerskie, ważne jest, by nie miały one na sobie lilijek lub by berety były "wywrócone na lewą stronę" - inaczej łatwo o pocięte dłonie.</p>'
        ),


        KonspektStep(
            title: 'Gra',
            duration: Duration(minutes: 30),
            activeForm: true,
            content: '<p style="text-align:justify;">Grupy rozchodzą się po lesie i rozpoczyna się gra zgodnie z opisanymi wcześniej zasadami.</p>'
        ),


        KonspektStep(
            title: 'Podsumowanie',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący po zakończeniu gry podsumowuje jej przebieg z uczestnikami.</p>'
        ),


        KonspektStep(
            title: 'Rewanż',
            duration: Duration(minutes: 30),
            activeForm: true,
            content: '<p style="text-align:justify;">Grupy rozchodzą się po lesie i rozpoczyna się druga gra zgodnie z opisanymi wcześniej zasadami.</p>'
        ),


        KonspektStep(
            title: 'Podsumowanie',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący po zakończeniu rewanżu podsumowuje jej przebieg z uczestnikami.</p>'
        ),

      ]
  ),


  // Done
  const Konspekt(
      name: 'bibliodrama',
      title: 'Bibliodrama',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty],
            mechanism: [KonspektSphereMechanism.duchBezposrednia]
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
          name: 'Wydrukowane fragmenty Pisma Świętego z planem bibliodramy. Przykłady można w załącznikach.',
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
            KonspektAttachmentFormat.pdf: 'fragment_przykladowy_1.pdf',
            KonspektAttachmentFormat.docx: 'fragment_przykladowy_1.docx'
          },
        ),
        KonspektAttachment(
          name: 'fragment_przykladowy_2',
          title: 'Przykładowy fragment Pisma Świętego (nr 2)',
          assets: {
            KonspektAttachmentFormat.pdf: 'fragment_przykladowy_2.pdf',
            KonspektAttachmentFormat.docx: 'fragment_przykladowy_2.docx'
          },
        ),
        KonspektAttachment(
          name: 'fragment_przykladowy_3',
          title: 'Przykładowy fragment Pisma Świętego (nr 3)',
          assets: {
            KonspektAttachmentFormat.pdf: 'fragment_przykladowy_3.pdf',
            KonspektAttachmentFormat.docx: 'fragment_przykladowy_3.docx'
          },
        )
      ],
      steps: [


        KonspektStep(
            title: 'Podział na grupy',
            duration: Duration(minutes: 5),
            activeForm: false,
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
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący rozdaje uczestnikom wydrukowane fragmenty Pisma Świętego wraz z krótką instrukcją medytacji.'
                '<br>'
                '<br>Uczestnicy w ciszy zapoznają się z fragmentem Biblii, jego bohaterami i ich historią. Ważne, by podjęli refleksję dotyczącą tego, co przykuwa ich uwagę, co ich porusza, z czym się nie zgadzają, czego nie rozumieją oraz o co chcielibyśmy zapytać samych bohaterów historii.</p>'
        ),


        KonspektStep(
            title: 'Wstępny krąg dzielenia',
            duration: Duration(minutes: 20),
            activeForm: false,
            content: '<p style="text-align:justify;">Pierwsze dzielenie jest najbardziej uporządkowane. Uczestnicy kolejno w kręgu dzielą się swoimi refleksjami dotyczącymi przeczytanego fragmentu Biblii. Po zakończeniu wypowiedzi uczestnik mówi „dzięki” - w dobrym tonie jest, aby wówczas reszta również odpowiada „dzięki” - wówczas głos wędruje do następnej osoby. Gdy wszyscy się wypowiedzą i zostanie jeszcze czas, każdy może dodać coś jeszcze.'
                '<br>'
                '<br>Uczestnicy nie powinni się odnosić do swoich wzajemnych wypowiedzi w sposób krytyczny lub polemiczny.</p>'
        ),


        KonspektStep(
            title: 'Wstępny krąg dzielenia',
            duration: Duration(minutes: 20),
            activeForm: true,
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
            activeForm: false,
            content: '<p style="text-align:justify;">Drugi krąg dzielenia jest luźniejszy od pierwszego. Uczestnicy dzielą się swoimi obserwacjami i doświadczeniami w formie dyskusji. Na tym etapie tworzy się wspólne rozumienie historii, nad którą uczestnicy pracują.</p>'
        ),


        KonspektStep(
            title: 'Spacer pytań z drugim bohaterem',
            duration: Duration(minutes: 20),
            activeForm: true,
            content: '<p style="text-align:justify;">Forma analogiczna do <i>spaceru pytań z pierwszym bohaterem</i>, tyle, że dotycząca drugiego, wybranego przez prowadzącego bohatera.</p>'
        ),


        KonspektStep(
            title: 'Krąg dzielenia z drugim bohaterem',
            duration: Duration(minutes: 20),
            activeForm: false,
            content: '<p style="text-align:justify;">Forma analogiczna do <i>kręgu pytań z pierwszym bohaterem</i>, tyle, że dotycząca drugiego, wybranego przez prowadzącego bohatera.</p>'
        ),


        KonspektStep(
            title: 'Kontemplacja końcowa',
            duration: Duration(minutes: 20),
            activeForm: false,
            content: '<p style="text-align:justify;">Uczestnicy po raz ostatni siadają z fragmentem sami. Kontemplacja powinna mieć formę jak najgłębszego wejścia w tę sytuację, bez nadmiernego analizowania.</p>'
        ),


        KonspektStep(
            title: 'Przygotowanie scenki',
            duration: Duration(minutes: 20),
            activeForm: true,
            content: '<p style="text-align:justify;">Uczestnicy na podstawie poprzednich form przygotowują scenkę, którą później odegrają - tworzą scenariusz, scenografię i kostiumy, dzielą się rolami i ćwiczą. Prowadzący nie musi przygotowywać żadnych rekwizytów - uczestnicy korzystają z rzeczy znajdujących się w miejscu, w którym się znajdują. Nie potrzeba im niczego więcej ponad to, co mają wokół siebie i ze sobą.'
                '<br>'
                '<br>Podczas przygotowywania scenki uczestnicy zazwyczaj wychodzą z nastroju skupienia i powagi – jest to dla nich forma rozładowania napięcia zgromadzonego podczas długotrwałej pracy wewnętrznej. Często towarzyszy temu rodzaj „odpału” – uczestnicy zaczynają żartować co ma pozytywny wpływ na liczbę i jakość pomysłów na formę przedstawienia historii. Dobrze jest dbać o to, żeby scenka uobecniała owoce duchowej pracy, jeśli jednak tak się nie stanie, nie trzeba się tym przejmować.</p>'
        ),


        KonspektStep(
            title: 'Przedstawienie scenek',
            duration: Duration(minutes: 10),
            activeForm: true,
            content: '<p style="text-align:justify;">Gdy wszystkie grupy są gotowe, rozpoczynają się przedstawienia. Po każdym przedstawieniu organizator powinien zachęcić grupę do podzielenia się z resztą owocami ich pracy oraz tym, w jaki sposób owoce te uobecniły się w scence.</p>'
        ),


      ]
  ),


  // Done
  const Konspekt(
      name: 'biwak_bez_nadzoru',
      title: 'Biwak bez nadzoru',
      category: KonspektCategory.harcerskie,
      type: KonspektType.projekt,
      spheres: {
        KonspektSphere.relacje: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha, KonspektSphereMechanism.duchOtwartoscNaLudzi, KonspektSphereMechanism.duchSumiennosc]
        )
      },
      metos: [Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      aims: [
        'Kształtowanie u uczestników postawy i umiejętności odpowiedzialności',
        'Kształtowanie u uczestników postawy sumienności, zaradności i proaktywnej postawy',
        'Kształtowanie u uczestników postawy uważności na kwestie poza bezpośrednim polem swoich obowiązków',
        'Kształtowanie u uczestników umiejętności pracy w grupie',
        'Kształtowanie u uczestników umiejętności komunikacji i podziału zadań',
      ],

      summary: 'Harcerze bez udziału kadry organizują biwak, na który jadą (kadra jedzie jako opieka) i ponoszą wszystkie konsekwencje swoich niedociągnięć.',
      description: '<p style="text-align:justify;">Forma polega na przeprowadzeniu biwaku drużyny (lub zastępu), tyle że z niemal zerowym zaangażowaniem kadry drużyny. Rola kadry powinna się ograniczyć do przeprowadzenia zbiórki, podczas której pomogą ustalić w drużynie (lub zastępie), co trzeba zrobić, by zorganizować biwak oraz pomogą rozdzielić zadania i wybrać spośród uczestników głównego koordynatora biwaku.'
          '<br>'
          '<br>Forma swoje główne walory czerpie z tego, że liczba i poziom skomplikowania problemów, z którymi uczestnicy się zmierzą jest ściśle zależna od tego jak skutecznie zorganizują biwak jako grupa:</p>'
          '<ul>'
          '<li><p style="text-align:justify;">Jeżeli wszyscy zapomną kupić jedzenie - drużyna będzie głodować dwa dni, albo będzie zmuszona załatwić jedzenie na miejscu,</p></li>'
          '<li><p style="text-align:justify;">Jeżeli ktoś pomyli kierunek marszu lub miejsce docelowe - będzie trzeba spać na dworcu lub iść przez noc,</p></li>'
          '<li><p style="text-align:justify;">Jeśli ktoś nie sprawdzi, czy autobus powrotny jeździ także w niedzielę - będzie trzeba łapać stopa, albo iść pieszo.</p></li>'
          '</ul>'
          '<p style="text-align:justify;">Rola kadry sprowadza się przede wszystkim do dwóch kwestii:</p>'
          '<ul>'
          '<li><p style="text-align:justify;">Reagowania tylko i wyłącznie gdy sytuacja będzie groźna dla życia uczestników,</p></li>'
          '<li><p style="text-align:justify;">Podsumowaniu biwaku po jego zakończeniu.</p></li>'
          '</ul>'
  ),


  // Done
  Konspekt(
      name: 'budowanie_kapliczki',
      title: 'Budowanie kapliczki',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.duch: const KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty],
            mechanism: [KonspektSphereMechanism.duchNormalizacja]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'deon.pl (Zielone Parafie)',
      author: DANIEL_IWANICKI,
      aims: [
        'Normalizacja tematów związanych z religią chrześcijańską',
        'Sprowokowanie refleksji nad znaczeniem symboliki chrześcijańskiej poprzez jej tworzenie',
      ],
      materials: [
        KonspektMaterial(
            name: 'Przykładowe zdjęcia kapliczek',
            bottomBuilder: (context) => Material(
              color: backgroundIcon_(context),
              child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Dimen.iconMarg),
                      child: Icon(MdiIcons.gestureTap),
                    ),
                    const Text('Zobacz przykładowe zdjęcia', style: AppTextStyle(fontSize: Dimen.textSizeNormal))
                  ]
              ),
            ),
            onTap: (context) => openAssetGalleryViewer(
                context,
                [
                  ('packages/harcapp_core/assets/konspekty/budowanie_kapliczki/kapliczka_1.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_kapliczki/kapliczka_2.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_kapliczki/kapliczka_3.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_kapliczki/kapliczka_4.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_kapliczki/kapliczka_5.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_kapliczki/kapliczka_6.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_kapliczki/kapliczka_7.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_kapliczki/kapliczka_8.webp', ''),
                ]
            )
        ),
      ],

      summary: 'Harcerze mając do dyspozycji materiały i narzędzia projektują, a później budują kapliczkę w wybranej formie. Może ona powstać na obozie, przy harcówce lub w innym miejscu.',
      steps: [

        const KonspektStep(
            title: 'Przejrzenie przykładów kapliczek',
            duration: Duration(minutes: 20),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący daje uczestnikom trochę czasu, by zapoznali się z przykładowymi kapliczkami oraz by zastanowili się jaki styl kapliczki (krzyża, figurki na cokole, kolumny, etc.) chcą zbudować oraz na jaki styl kapliczki mają wystarczające środki (zdolności, czas, materiały).</p>'
        ),


        const KonspektStep(
            title: 'Stworzenie projektu',
            duration: Duration(minutes: 30),
            activeForm: false,
            content: '<p style="text-align:justify;">Uczestnicy tworzą projekt kapliczki. Projekt powinien zawierać szczegółowe informacje o:</p>'
                '<ul>'
                '<li><p style="text-align:justify;">Elementach kapliczki, które zostaną potem złączone w całość,</p></li>'
                '<li><p style="text-align:justify;">Wymiarach każdego z elementów,</p></li>'
                '<li><p style="text-align:justify;">Materiałach potrzebnych do zbudowania kapliczki,</p></li>'
                '<li><p style="text-align:justify;">Narzędzi niezbędnych do zbudowania kapliczki,</p></li>'
                '<li><p style="text-align:justify;">Miejscu, w którym stanie kapliczka (miejsce to musi być legalne).</p></li>'
                '</ul>'
        ),


        const KonspektStep(
            title: 'Konsultacja projektu',
            duration: Duration(minutes: 20),
            activeForm: false,
            content: '<p style="text-align:justify;">Uczestnicy przedstawiają gotowy projektu drużynowemu w celu zweryfikowania sensowności technicznej konstrukcji i, jeśli to możliwe, zaprzyjaźnionemu księdzu lub kapelanowi w celu zweryfikowania religijnej spójności kapliczki.'
                '<br>'
                '<br>Prawdopodobnie niektóre elementy będą wymagały poprawy - poprawianie i ponowne konsultowanie projektu powtarza się aż zostanie on zaakceptowany przez drużynowego.</p>'
        ),


        const KonspektStep(
            title: 'Budowa',
            duration: Duration(hours: 6),
            activeForm: true,
            content: '<p style="text-align:justify;">Uczestnicy mając do dyspozycji dostępne materiały (drewno, zaprawę, kamienie) i narzędzia budują kapliczkę.</p>'
        ),


        const KonspektStep(
            title: 'Dbanie z czasem',
            duration: Duration(minutes: 30),
            activeForm: true,
            content: '<p style="text-align:justify;">Uczestnicy ustalają w jaki sposób będą dbali o kapliczkę. Ważne, by po jej zbudowaniu nie została ona porzucona.</p>'
        ),


      ]
  ),


  // Done
  Konspekt(
      name: 'budowanie_szopki_bozonarodzeniowej',
      title: 'Budowanie szopki bożonarodzeniowej',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.duch: const KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty],
            mechanism: [KonspektSphereMechanism.duchNormalizacja]
        )
      },
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (Flatiron)',
      author: DANIEL_IWANICKI,
      aims: [
        'Normalizacja tematów związanych z religią chrześcijańską i jej symboliką',
        'Sprowokowanie refleksji nad historią narodzin Jezusa poprzez jej własne przedstawienie',
      ],
      materials: [
        KonspektMaterial(
            name: 'Przykładowe zdjęcia szopek',
            bottomBuilder: (context) => Material(
              color: backgroundIcon_(context),
              child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Dimen.iconMarg),
                      child: Icon(MdiIcons.gestureTap),
                    ),
                    const Text('Zobacz przykładowe zdjęcia', style: AppTextStyle(fontSize: Dimen.textSizeNormal))
                  ]
              ),
            ),
            onTap: (context) => openAssetGalleryViewer(
                context,
                [
                  ('packages/harcapp_core/assets/konspekty/budowanie_szopki_bozonarodzeniowej/szopka_1.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_szopki_bozonarodzeniowej/szopka_2.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_szopki_bozonarodzeniowej/szopka_3.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_szopki_bozonarodzeniowej/szopka_4.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_szopki_bozonarodzeniowej/szopka_5.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_szopki_bozonarodzeniowej/szopka_6.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_szopki_bozonarodzeniowej/szopka_7.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_szopki_bozonarodzeniowej/szopka_8.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_szopki_bozonarodzeniowej/szopka_9.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_szopki_bozonarodzeniowej/szopka_10.webp', ''),
                  ('packages/harcapp_core/assets/konspekty/budowanie_szopki_bozonarodzeniowej/szopka_11.webp', ''),
                ]
            )
        ),
      ],


      summary: 'Harcerze mając do dyspozycji materiały i narzędzia projektują, a później budują szopkę bożonarodzeniową w wybranej formie.',
      steps: [

        const KonspektStep(
            title: 'Przejrzenie przykładów szopek',
            duration: Duration(minutes: 20),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący daje uczestnikom trochę czasu, by zapoznali się z przykładowymi szopkami oraz by zastanowili się jaki styl szopki chcą zbudować.</p>'
        ),

        const KonspektStep(
            title: 'Stworzenie projektu',
            duration: Duration(minutes: 30),
            activeForm: false,
            content: '<p style="text-align:justify;">Uczestnicy tworzą projekt szopki bożonarodzeniowej. Projekt powinien zawierać szczegółowe informacje o:</p>'
                '<ul>'
                '<li><p style="text-align:justify;">Elementach szopki, które zostaną potem złączone w całość</p></li>'
                '<li><p style="text-align:justify;">Wymiarach każdego z elementów</p></li>'
                '<li><p style="text-align:justify;">Materiałach potrzebnych do zbudowania szopki</p></li>'
                '<li><p style="text-align:justify;">Narzędzi niezbędnych do zbudowania szopki</p></li>'
                '</ul>'
                '<p style="text-align:justify;">Na tym etapie <b>bardzo ważne</b> jest, aby przedyskutować z harcerzami plan, jaki mają na szopkę ze szczególnym uwzględnieniem elementów takich jak żłóbek, postać Jezusa, Maryi i Józefa, ew. trzech królów.</p>'
        ),

        const KonspektStep(
            title: 'Konsultacja projektu',
            duration: Duration(minutes: 20),
            activeForm: false,
            content: '<p style="text-align:justify;">Uczestnicy przedstawiają gotowy projektu drużynowemu w celu zweryfikowania sensowności technicznej konstrukcji. W zależności od wieku można oczekiwać szopki o różnym stopniu zaawansowania. W przypadku zuchów i harcerzy szopka można być budowana z kartonów i farb, jednak w przypadku harcerzy starszych i wędrowników szopka może powstać z np. z desek.'
                '<br>'
                '<br>Prawdopodobnie niektóre elementy będą wymagały poprawy - poprawianie i ponowne konsultowanie projektu powtarza się aż zostanie on zaakceptowany przez drużynowego.</p>'
        ),

        const KonspektStep(
            title: 'Budowa',
            duration: Duration(hours: 6),
            activeForm: false,
            content: '<p style="text-align:justify;">Uczestnicy mając do dyspozycji dostępne materiały (drewno, zaprawę, kamienie) i narzędzia budują kapliczkę.</p>'
        ),

      ],

      howToFail: [
        'Potraktować formę jedynie jak majsterkę',
        'Pominąć lub pozwolić na pominięcie przygotowania postaci Maryi, Józefa i Jezusa'
      ]
  ),

  // Done
  const Konspekt(
      name: 'druzynowe_mycie_w_jeziorze',
      title: 'Drużynowe mycie w jeziorze',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zwyczaj,
      spheres: {
        KonspektSphere.cialo: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: '',
      author: DANIEL_IWANICKI,
      aims: [
        aimHartDuchaZimno
      ],
      summary: 'Drużyna podczas wyjazdu myje się w jeziorze zamiast w cywilizowanych warunkach.',

      description: '<p style="text-align:justify;">Podczas formy wyjazdowej (obóz lub zimowisko) drużyna aby się umyć kąpie się w jeziorze. Jeziora w Polsce są wieczorami chłodne co kształtuje hart ducha. Forma ta pozwala także zaobserwować prowadzącemu łatwość, z jaką harcerze przełamują się i wskakują do wody, działa przy tym efekt wzajemności oddziaływań.'
          '<br>'
          '<br>Należy mieć na uwadze, że z czasem uczestnicy przyzwyczają się wskakiwać do zimnej wody. Wówczas forma ta przestanie spełniać swój cel.</p>'
  ),


  // Done
  const Konspekt(
      name: 'ekstremalna_droga_krzyzowa',
      title: 'Ekstremalna Droga Krzyżowa',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty],
            mechanism: [KonspektSphereMechanism.duchBezposrednia]
        )
      },
      metos: [Meto.wedro],
      coverAuthor: 'Radio Olsztyn',
      author: DANIEL_IWANICKI,
      aims: [
        aimUmiejetnoscWedrowania,
        aimHartDuchaWedrowanie,
        aimPraktykaModlitwy
      ],
      summary: 'Uczestnicy przechodzą w nocy drogę krzyżową rozłożoną na dystansie kilkudziesięciu kilometrów.',
      description: '<p style="text-align:justify;">Uczestnicy przechodzą w nocy drogę krzyżową rozłożoną na dystansie kilkudziesięciu kilometrów. Poza-harcerski zasięg formy jest także korzystnym z wychowawczego punktu widzenia doświadczeniem powszechności Kościoła.'
          '<br>'
          '<br>Trasa kończy się Mszą Świętą u celu w kościele. Warto poruszać się grupami nie większymi niż zastęp. Do każdej stacji przygotowane są rozważania.'
          '<br>'
          '<br>Forma jest organizowana przez księdza Jacka Stryczka. Szczegóły dotyczące tras można znaleźć na stronie <a href="www.edk.org.pl">EDK</a></p>'
  ),


  // Done
  const Konspekt(
    name: 'gang_potencjalnych_porywaczy',
    title: 'Gang potencjalnych porywaczy',
    category: KonspektCategory.harcerskie,
    type: KonspektType.zajecia,
    spheres: {
      KonspektSphere.umysl: null,
      KonspektSphere.relacje: null
    },


    metos: [Meto.harc, Meto.hs],
    coverAuthor: 'freepik.com (vector_corp)',
    author: JULIA_JAROSZ,
    customDuration: Duration(hours: 3),
    aims: [
      'Poprawa umiejętności pracy w zespole i przyjmowania potrzebnych w zespole ról.',
      'Poprawa umiejętności koordynowania działań w zespole.',
      'Poprawa umiejętności analizy i dyskryminowania między informacjami ważnymi i nieważnymi.',
    ],
    summary: 'Harcerze dowiadują się, że dokonano porwania. Zdobywają liczne informacje na ten temat, po czym ich zadaniem jest dokonać ich syntezy i ustalić tożsamość porywaczy.',

    intro: '<p style="text-align:justify;">Harcerze dowiadują się, że <b>nad ranem</b> w <b>weekend</b> dokonano porwania ważnej osoby. Policja ustaliła już, że za porwaniem stoi jeden z działających w okolicy gangów.'
        '<br>'
        '<br>Harcerze wyruszają, by zdobyć informacje o gangach. Ich zadaniem jest zebrać jak najwięcej informacji, przeanalizować je i wskazać, który gang, ich zdaniem, dokonał porwania. Wnioski harcerzy muszą być poparte argumentami.</p>',
    description: '<p style="text-align:justify;">Lista okolicznych gangów:</p>'
        '<ul>'
        '<li><p>Gang Olszaka</p></li>'
        '<li><p>Szajka Łysego</p></li>'
        '<li><p>Świnki trzy</p></li>'
        '<li><p>Łaciata paczka</p></li>'
        '<li><p>Grupa Mariana</p></li>'
        '<li><p>Nowa ekipa</p></li>'
        '<li><p>Dzika wataha</p></li>'
        '<li><p>Robaczek i spółka</p></li>'
        '<li><p>Kolorowe irokezy</p></li>'
        '</ul>'
        '<p style="text-align:justify;">Harcerze mają do zdobycia 64 wycinki informacji (załącznik: <a href="wycinki_informacji@attachment">wycinki informacji</a>). Spośród nich jedynie 8 wycinków ma znaczenie dla sprawy, ponieważ dają alibi niektórym gangom - pozostałe wycinki nie mają żadnego znaczenia.'
        '<br>'
        '<br>Alibi posiadają następujące gangi:</p>'
        '<ul>'
        '<li><p>Gang Olszaka</p></li>'
        '<li><p>Szajka Łysego</p></li>'
        '<li><p>Świnki trzy</p></li>'
        '<li><p>Łaciata paczka</p></li>'
        '<li><p>Dzieci ulicy</p></li>'
        '<li><p>Grupa Mariana</p></li>'
        '<li><p>Nowa ekipa</p></li>'
        '<li><p>Dzika wataha</p></li>'
        '</ul>'
        '<p style="text-align:justify;">Alibi nie posiadają następujące gangi:</p>'
        '<ul>'
        '<li><p>Robaczek i spółka</p></li>'
        '<li><p>Kolorowe irokezy</p></li>'
        '</ul>'
        '<p style="text-align:justify;">Trudność gry polega na odpowiednim skoordynowaniu działań przez harcerzy i uporządkowaniu zebranych informacje.'
        '<br>'
        '<br><b>Grę można uprościć</b> podając harcerzom wskazówkę: wycinki informacji są opatrzone kolorami i w każdej grupie danego koloru kluczowy jest tylko jeden wycinek.'
        '<br>'
        '<br><b>Grę można utrudnić</b> sprawiając, by żadna osoba lub grupa nie zdobyła zbyt dużej liczby wycinków informacji i by była skazana na współpracę z innymi.'
        '<br>'
        '<br>Forma zdobywania wycinków informacji jest dowolna: mogą one być nagrodą w innej grze za wykonane zadania, mogą być schowane na określonym terenie, itp..</p>',
    attachments: [
      KonspektAttachment(
        name: 'wycinki_informacji',
        title: 'Wycinki informacji',
        assets: {
          KonspektAttachmentFormat.pdf: 'wycinki_informacji.pdf'
        },
      )
    ],
  ),


  // Done
  // TODO: dodać jakiś przykład
  const Konspekt(
      name: 'gaweda_o_swietym',
      title: 'Gawęda o świętym',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty, KonspektSphereLevel.duchWartosci],
            mechanism: [KonspektSphereMechanism.duchNormalizacja]
        )
      },
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (vecstock)',
      author: DANIEL_IWANICKI,
      aims: [
        'Przedstawienie uczestnikom kokretnych sposobów postępowań charakteryzujących świętych'
      ],

      description: '<p style="text-align:justify;">Prowadzący przygotowuje i opowiada (najlepiej przy ognisku) gawędę o wybranym świętym, którego postawa lub inne cechy są dla uczestników w szczególny sposób godne naśladowania.'
          '<br>'
          '<br>Kluczowe jest, by opowiedzieć o bohaterze i realiach jego życia w sposób aktualnie zrozumiały, aby uczestnicy formy mogli się z nim utożsamić.</p>',
      howToFail: [
        'Przeczytać gawędę z kartki'
      ]
  ),


  // Done
  const Konspekt(
      name: 'ignacjanski_rachunek_sumienia',
      title: 'Ignacjański rachunek sumienia',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.emocje: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty, KonspektSphereLevel.duchWartosci],
            mechanism: [KonspektSphereMechanism.duchBezposrednia]
        ),
      },
      metos: [Meto.wedro],
      coverAuthor: 'Freepik (vecstock)',
      author: DANIEL_IWANICKI,
      aims: [
        'Poznanie przez uczestników własnych emocji i ich motywacji',
        'Uświadomienie sobie przez uczestników związku między ich emocjami a czynami'
      ],
      materials: [
        KonspektMaterial(
            amountAttendantFactor: 2,
            name: 'Wydrukowany załącznik "kroki".',
            attachmentName: 'kroki',
            additionalPreparation: 'Każdy uczestnik powinien dostać 6 przygotowanych elementów: jeden "wstęp" oraz 6 "kroki".'
                '\n'
                '\nWydrukowany załącznik należy pociąć na części i zagiąć we wskazanych miejscach tak, by dolna część każdej wyciętej części kartki przykrywała treść kroku, lecz by odsłaniała nagłówek.'
        ),
      ],
      summary: 'Forma medytacyjna polegająca na refleksji nad swoimi emocjami celem obiektywnej oceny swoich czynów.',
      intro: 'Forma nie przygotowuje do spowiedzi. Jest to paradoksalna forma medytacyjna - skupiająca się z jednej strony na emocjach celem przejścia do obiektywnej oceny czynów. Szczegóły dotyczące formy można znaleźć na <a href="jezuici.pl/rachunek">tej stronie</a>.'
          '<br>'
          '<br>Każdy z uczestników otrzymuje zestaw pięciu kartek przygotowanych zgodnie z załącznikiem <a href="kroki@attachment">kroki</a>.'
          '<br>'
          '<br>Każdy uczestnik znajduje ustronne miejsce, gdzie może w spokoju pomyśleć bez rozpraszania swojej uwagi. Może również udać się na spacer.'
          '<br>'
          '<br>Harcerze otwierają kartkę z pierwszym krokiem, czytają ją i przez kolejne 15 minut wykonują zapisane polecenie. Gdy czas ten upłynie, przechodzą do kolejnego kroku, nad którym również spędzają 15 minut. Proces ten jest powtarzany analogicznie dla pozostałych kroków.',
      steps: [
        KonspektStep(
            title: 'Dziękowanie Bogu za otrzymane dobro',
            duration: Duration(minutes: 15),
            activeForm: false,
            content: 'Podziękuj Bogu za to co masz: za łaski, relacje, naturalne zdolności. Każdą czynność warto w życiu rozpoczynać od westchnienia z wdzięcznością do Boga.'
        ),
        KonspektStep(
            title: 'Prośba o łaskę poznania grzechów',
            duration: Duration(minutes: 15),
            activeForm: false,
            content: 'Poproś Boga o skuteczne dostrzeżenie swoich poruszeń duchowych, ograniczeń i grzechów. Łatwiej jest wielbłądowi przejść przez ucho igielne, niż Tobie, zwykłemu śmiertelnikowi przyłapać się na „wypieraniu, intelektualizowaniu czy projekcji”.'
        ),
        KonspektStep(
            title: 'Żądanie od swojej duszy zdania sprawy',
            duration: Duration(minutes: 15),
            activeForm: false,
            content: 'Skup się na swoich uczuciach takich jak smutek, agresja, czy zazdrość, które mogą być powodem głupich działań i decyzji (czyli grzechu). Zdystansuj się od nich, spójrz na nie szczerze i uświadom sobie co w Tobie siedzi.'
        ),
        KonspektStep(
            title: 'Prośba o przebaczenie win',
            duration: Duration(minutes: 15),
            activeForm: false,
            content: 'Proś Boga o przebaczenie za popełnione grzechy. Odróżnij poczucie winy od żalu za grzechy - Bóg oczekuje od nas żalu za grzechy, a nie poczucia winy.'
        ),
        KonspektStep(
            title: 'Postanowienie poprawy przy Jego łasce',
            duration: Duration(minutes: 15),
            activeForm: false,
            content: 'Co musisz zmienić, by Twoje życie stało się lepsze? Skup się znowu na swoich uczuciach - przy odpowiedniej pokorze i subtelności pozwala się to wewnętrznie uporządkować. Świat wokół Ciebie wymaga radykalnej poprawy - zacznij od wyjęcia belki z własnego oka.'
        ),
      ],
      attachments: [
        KonspektAttachment(
          name: 'kroki',
          title: 'Kroki',
          assets: {
            KonspektAttachmentFormat.pdf: 'kroki.pdf',
            KonspektAttachmentFormat.docx: 'kroki.docx'
          },
        ),
      ]
  ),


  // Done
  const Konspekt(
      name: 'kadrowe_msze',
      title: 'Kadrowe msze',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty],
            mechanism: [KonspektSphereMechanism.duchBezposrednia]
        )
      },
      metos: [Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      aims: [
        'Uczestniczenie we wspólnocie Kościoła',
        'Normalizacja spraw wiary jako kwestii otwartej i wspólnej',
        'Stworzenie możliwości znalezienia potencjalnego kapelana'
      ],
      customDuration: Duration(hours: 2),
      description: '<p style="text-align:justify;">Forma polega na wspólnym, okresowym (np. co drugi tydzień lub raz na miesiąc) wyjściu kadrą drużyny (drużynowy, przyboczni, zastępowi) na mszę. Forma ma sens tylko, jeśli relacje w drużynie są ku temu stosowne.'
          '<br>'
          '<br>Sens formy polega przede wszystkim na wyniesieniu religii ze sfery “prywatnej” to “wspólnej” oraz na możliwości zbudowania wokół formy tradycji (gadanie o wrażeniach po mszy na kebaba, frytach, lodach - np. za fundusze drużyny).'
          '<br>'
          '<br>Forma w szczególnych przypadkach pozwala też na uczestniczeniu po mszach w życiu duszpasterstwa - np. akademickiego działającego przy kościele i możliwości wysondowania, czy ksiądz byłby “dobrym materiałem” na kapelana drużyny, czy środowiska.</p>'
  ),


  // Done
  const Konspekt(
      name: 'kalambury_z_prawa_harcerskiego',
      title: 'Kalambury z Prawa Harcerskiego',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.umysl: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchWartosci],
            mechanism: [KonspektSphereMechanism.duchNormalizacja]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      customDuration: Duration(hours: 2),
      aims: [
        'Utrwalenie wśród uczestników treści Prawa Harcerskiego',
        'Lepsze zrozumienie przez uczestników Prawa Harcerskiego'
      ],
      description: '<p style="text-align:justify;">Uczestnicy są dzieleni na grupy (np. na zastępy) i otrzymują po jednym punkcie Prawie Harcerskiego na kartce. Ich zadaniem jest przygotować kalambury przedstawiające owe prawo, które zaprezentują pozostałej części uczestników.'
          '<br>'
          '<br>Grupa, której członek poprawie zgarnie prezentowany punkt Prawa jako kolejna prezentuje. Jeżeli już prezentowała, osoba, która zgadła wskazuje kolejną prezentującą grupę.</p>'
  ),


  // Done
  const Konspekt(
      name: 'kalambury_z_prawa_zucha',
      title: 'Kalambury z Prawa Zucha',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.umysl: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchWartosci],
            mechanism: [KonspektSphereMechanism.duchNormalizacja]
        )
      },
      metos: [Meto.zuch],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      customDuration: Duration(hours: 2),
      aims: [
        'Utrwalenie wśród uczestników treści Prawa Zucha',
        'Lepsze zrozumienie przez uczestników Prawa Zucha'
      ],
      description: '<p style="text-align:justify;">Uczestnicy są dzieleni na grupy (np. na szóstki zuchowe) i otrzymują po jednym punkcie Prawie Zucha na kartce. Ich zadaniem jest przygotować kalambury przedstawiające owe prawo, które zaprezentują pozostałej części uczestników.'
          '<br>'
          '<br>Grupa, której członek poprawie zgarnie prezentowany punkt Prawa jako kolejna prezentuje. Jeżeli już prezentowała, osoba, która zgadła wskazuje kolejną prezentującą grupę.</p>'
  ),


  // Done
  const Konspekt(
      name: 'kilkutygodniowe_obozowanie_w_lesie',
      title: 'Kilkutygodniowe obozowanie w lesie',
      category: KonspektCategory.harcerskie,
      type: KonspektType.projekt,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy, KonspektSphereLevel.duchWartosci],
            mechanism: [
              KonspektSphereMechanism.duchHartDucha,
              KonspektSphereMechanism.duchOtwartoscNaLudzi,
              KonspektSphereMechanism.duchKsztaltowanieUwaznosci
            ]
        )
      },
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      aims: [
        'Hart ducha poprzez funkcjonowanie w warunkach trudów lasu',
        'Budowanie wspólnoty poprzez eliminację elektroniki i ciągłe funkcjonowanie w grupie',
        'Kształtowanie uważności poprzez niemal całkowitą możliwość eliminacji szumu informacyjnego i technologii',
        'Stworzenie przestrzeni na realizację znaczącej liczby zajęć',
      ],
      description: '<p style="text-align:justify;">Drużyna, najczęściej w okresie letnich wakacji i najlepiej razem z innymi drużynami (np. szczepu) wyjeżdża na obóz do lasu, gdzie buduje infrastrukturę obozową (sanitariaty, kuchnię, magazyn, etc.) i spędza kilka tygodni pod namiotami.'
          '<br>Forma ta jest jedną z najskuteczniejszych harcerskich form wychowawczych i stwarza możliwość realizacji licznych zajęć i zwyczajów podczas jej trwania.'
          '<br>'
          '<br>Obozowanie w lesie pozwala na niemal dowolne wyeliminowanie czynnika technologicznego z życia uczestników formy: mediów społecznościowych, internetu, reklam, komunikatorów, syntetycznej muzyki, przez co pozwala na niemal dowolne kształtowanie uważności.'
          '<br>'
          '<br>Forma ma również oczywisty i bardzo łatwy do zrealizowania potencjał tworzenia wspólnoty - wspólnego jedzenia, mycia, mieszkania, modlenia, śpiewania, dyskutowania, negocjowania, rozwiązywania sporów, robienia sobie wzajem kawałów i realizacji kreatywnych pomysłów, które harcerze sami wymyślą, gdy przejdą przez proces odpływu szumu informacyjnego.'
          '<br>'
          '<br>Dodatkowo funkcjonowanie w lesie ma zalety formy o obniżonym komforcie funkcjonowania.'
          '<br>'
          '<br>Forma wymaga znaczących nakładów materiałowych, logistycznych i osobowych, jak również wymaga odpowiednio wysokiej kultury organizacyjnej w środowisku.</p>'
  ),


  // Done
  const Konspekt(
      name: 'koledowanie_z_quizem_interpretacyjnym',
      title: 'Kolędowanie z quizem interpretacyjnym',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty, KonspektSphereLevel.duchWartosci],
            mechanism: [KonspektSphereMechanism.duchBezposrednia, KonspektSphereMechanism.duchNormalizacja]
        )
      },
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (mengsilinxi)',
      author: DANIEL_IWANICKI,
      customDuration: Duration(minutes: 90),
      aims: [
        'Refleksja nad historiami i wynikającymi z nich wartościami i postawami w piosenkach.',
      ],
      materials: [
        KonspektMaterial(
          amountAttendantFactor: 1,
          name: 'Teksty śpiewanych piosenek',
        ),
      ],
      description: '<p style="text-align:justify;">Szczególna wersja formy <a href="spiewogranie_z_quizem_interpretacyjnym@konspekt">Śpiewogranie z quizem interpretacyjnym</a>, gdzie zbiorem piosenek są kolędy.</p>'
  ),

  // Done
  const Konspekt(
      name: 'kontrowersyjna_dyskusja',
      title: 'Kontrowersyjna dyskusja',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.umysl: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty, KonspektSphereLevel.duchWartosci],
            mechanism: [KonspektSphereMechanism.duchNormalizacja]
        ),
      },
      metos: [Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      aims: [
        'Poznanie przez kadrę drużyny poglądów harcerzy i ich rodziców',
        aimUmiejetnoscDyskusji,
        'Nienahalne zwrócenie uwagi harcerzy na naturę skomplikowanych rzeczywistości',
        'Kształtowanie poglądów harcerzy'
      ],
      description: '<p style="text-align:justify;">Harcerze (lub kadra) wybierają kontrowersyjny temat i rozpoczyna się dyskusja. Dobrym pomysłem jest zainicjować tę dyskusję przy okazji - na przykład wieczorem na obozie, czy podczas wędrówki - niekoniecznie w formalny sposób. Rolą prowadzącego formę jest moderowanie dyskusji - niekoniecznie granie w niej pierwszych skrzypiec. Zamiast narzucać swoją opinię, drużynowy powinien raczej wpływać na dyskusję kierując rozmową i odpowiednio stawiając pytania, zaś na końcu ją podsumować. Pozwoli mu to także określić poglądy harcerzy na różne tematy.'
          '<br>'
          '<br>Jeżeli drużyna nie ma znormalizowanych postaw religijnych, drużynowy nie powinien odnosić się do argumentów teologicznych (jeżeli uczestnicy chcą, mogą się odnosić). Jeżeli drużyna ma znormalizowane postawy religijne - kwestie wiary są dopuszczalnym a nawet pożądanym argumentem, jednak nie powinny być argumentem wyłącznym.'
          '<br>'
          '<br>Przykładowe tematy:</p>'
          '<ul>'
          '<li><p style="text-align:justify;">mieszkanie przed ślubem</p></li>'
          '<li><p style="text-align:justify;">aborcja</p></li>'
          '<li><p style="text-align:justify;">seks</p></li>'
          '<li><p style="text-align:justify;">polityka</p></li>'
          '<li><p style="text-align:justify;">religia</p></li>'
          '<li><p style="text-align:justify;">Kościół</p></li>'
          '<li><p style="text-align:justify;">formalna legalizacja związków wieloosobowych</p></li>'
          '</ul>',
      howToFail: [
        'Jako drużynowy lub kadra zmonopolizować dyskusję.',
        'Nie wysłuchiwać opinii harcerzy',
        'Poprawiać poglądy harcerzy lub je jawnie i krytycznie oceniać jak błędne z powodu niezgodności z własnym poglądem.',
        'Zaniedbać symetrię postulatów, jeśli któraś ze stron nie zmienia poglądów, ale jednocześnie sądzi, że nie ma sensu się już wypowiadać.',
      ]
  ),


  // Done
  const Konspekt(
      name: 'modlitwa_przed_posilkiem',
      title: 'Modlitwa przed posiłkiem',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zwyczaj,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty, KonspektSphereLevel.duchWartosci, KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchNormalizacja]
        )
      },
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (freepik)',
      author: DANIEL_IWANICKI,
      aims: [
        'Budowanie relacji z Bogiem',
        'Budowanie przekonania o ważności modlitwy',
        'Budowanie wspólnoty wiary',
      ],
      description: '<p style="text-align:justify;">Forma jest pokrewna do formy <a href="rozpoczynanie_posilku_wspolnym_spiewaniem@konspekt">Rozpoczynanie posiłku wspólnym śpiewaniem</a>.'
          '<br>'
          '<br>W przypadku zuchów lub harcerzy modlitwa przed posiłkiem pełni przede wszystkim rolę normalizacyjną - buduje przekonanie, że modlitwa jest ważna. Warto jednak mieć na uwadze, że sprowadzanie modlitwy do roli konkursu piosenki "kto głośniej zaśpiewa" jest niewychowawcze i normalizuje przekonanie, że modlitwa to folklor.'
          '<br>'
          '<br>W przypadku drużyn starszych, modlitwa w stylu <i>"Panie Boże, nasze słonko, pobłogosław to jedzonko"</i> będzie także traktowana jako folklor - nie pełni roli religijnej.'
          '<br>'
          '<br>Warto uświadamiać harcerzom, że modlitwa to nie pusta formułka i że warto, by poświęcili oni pół sekundy na refleksję, że nie każdy ma co jeść, nie każdy ma z kim jeść i nie każdy umie doceniać to, co ma.'
          '<br>'
          '<br>Uniwersalną formułą może być nieśpiewana modlitwa: <i>"Pobłogosław Panie Boże nas, pobłogosław te dary i tych, którzy go przygotowali i naucz nas dzielić się chlebem i radością, przez Chrystusa, Pana naszego - Amen!"</i>.'
          '<br>'
          '<br>Przykłady piosenek:</p>'
          '<ul>'
          '<li><p style="text-align:justify;">Pobłogosław Panie</p></li>'
          '<li><p style="text-align:justify;">Chodźcie jeść, zbawca woła chodźcie jeść</p></li>'
          '</ul>'
  ),


  // Done
  const Konspekt(
      name: 'musztra_i_dbalosc_o_umundurowanie',
      title: 'Musztra i dbałość o umundurowanie',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zwyczaj,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchWartosci, KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha]
        )
      },
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      aims: [
        'Kształtowanie u uczestników szacunku dla porządku kosztem własnej indywidualności',
        'Budowanie u uczestników doświadczenia bycia częścią większej wspólnoty (nie tylko indywidualną jednostką)',
        'Budowanie u uczestników poczucia elitarności środowiska',
        'Budowanie reprezentatywności środowiska'
      ],
      description: '<p style="text-align:justify;">Dbałość o musztrę odbywa się poprzez jej regularną praktykę, oczekiwanie od harcerzy wysokich standardów i dbanie o to, by znaczenie komend było dla nich jasne, klarowne i zrozumiałe.'
          '<br>'
          '<br>Dbałość o umundurowanie odbywa się po pierwsze przez przykład własny kadry, po drugie przez regularne sprawdzanie jakości umundurowania harcerzy (np. noszenie jednolitych spodni, butów, posiadanie beretów, pierścieni, porządne przyszywanie plakietek i sprawności, odpowiednie wkładanie dołu noszonej koszulki mundurowej do spodni lub spódnicy, zapinanie wszystkich guzików, także w spodniach). Można uwzględniać z tego tytułu punkty do współzawodnictwa indywidualnego.'
          '<br>'
          '<br>Musztra i umundurowanie jest dla harcerzy emanacją tego, że sposób funkcjonowania wspólnoty może rządzić się jasnymi, określonymi zasadami oraz, że prócz tego, jak drużyna działa w środku, ważne jest także to jak się prezentuje na zewnątrz.</p>'
  ),


  // Done
  const Konspekt(
      name: 'negocjowanie_koalicji_wlasnych_partii_politycznych',
      title: 'Negocjowanie koalicji własnych partii politycznych',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.umysl: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchWartosci],
            mechanism: []
        ),
        KonspektSphere.relacje: null,
      },
      metos: [Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      aims: [
        'Refleksja uczestników nad fundamentami swoich poglądów i wartości',
        aimUmiejetnoscNegocjowania,
        aimUmiejetnoscDyskusji
      ],
      materials: [
        KonspektMaterial(name: 'Kartki'),
        KonspektMaterial(name: 'Długopisy'),
      ],
      summary: 'Uczestnicy zawiązują partie polityczne, wymyślają swoje postulaty, po czym negocjują koalicję - jeśli im się nie uda, państwo pogrąży się w chaosie.',
      description:'<p style="text-align:justify;">Forma opiera się ona na założeniu, że uczestnicy wyznają podobne aksjomaty i mają podobne punkty wyjścia, np.: “każdy człowiek powinien móc godnie żyć”, “dobre są jedynie relacje oparte o sprawiedliwość” itd..'
          '<br>'
          '<br>Aby móc skutecznie przeprowadzić formę, konieczne jest by uczestnicy byli skłonni do poważnej dyskusji - samo posiadanie poglądów politycznych nie wystarczy (zwłaszcza, jeśli towarzyszy tą temu ciągłe “heheszki”, zaś polityka jest dla harcerzy jedynie memem).'
          '<br>'
          '<br>Forma ma sens jedynie w przypadku występowania jasnych różnic światopoglądowych między uczestnikami formy.'
          '<br>'
          '<br>Prowadzący pełni w tej formie rolę mediatora: gdy negocjacje nad którymś z postulatów utykają, proponuje rozwiązania, zadaje pytania pomagające rozłożyć postulaty na części pierwsze, rozstrzyga przypadku sporów o fakty itd..</p>',
      steps: [

        KonspektStep(
            title: 'Podział na grupy',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący dzieli uczestników na wybraną liczbę grup, z których każda powinna być spójna światopoglądowo.</p>'
        ),


        KonspektStep(
            title: 'Podział na grupy',
            duration: Duration(minutes: 45),
            activeForm: false,
            content: '<p style="text-align:justify;">Każda z grup zakłada swoją mini-partię. Każda mini-patria wymyśla swoją <b>nazwę</b>, wybiera spośród siebie <b>przedstawiciela</b>, <b>skrybę</b> oraz spisuje swoje <b>postulaty</b>. Jeśli wystarczy czasu, może stworzyć swoje logo.</p>'
        ),


        KonspektStep(
            title: 'Negocjacje - wstęp',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący informuje uczestników, że ich zadaniem jest zawiązanie koalicji. Koalicja może być zawiązana tylko, jeśli wszystkie partie zgodzą się na wspólną listę postulatów politycznych, społecznych i gospodarczych w państwie którym rządzą. Żadne postulaty poza tymi koalicyjnymi nie będą zrealizowane.'
                '<br>'
                '<br>Umowa koalicyjna musi zostać spisana do czasu zakończenia ostatniej rundy negocjacji i podpisana przez przedstawicieli wszystkich partii. W przeciwnym razie <b>państwo pogrąży się w chaosie</b>.'
                '<br>'
                '<br>Prowadzący informuje uczestników, że negocjacje odbędą się w trzech rundach, między którymi odbędą się przerwy na naradę wewnątrz partii.'
                '<br>'
                '<br>Podczas pierwszej rundy wszystkie strony przedstawią swoje postulaty.'
                '<br>'
                '<br>Podczas drugiej i trzeciej rundy strony mają czas by wypracować umowę koalicyjną.'
                '<br>'
                '<br>Na każdym etapie rolą partii (w szczególności skryby) jest dbanie o to, by zapisywać kluczowe ustalenia oraz postulaty innych partii.</p>'
        ),


        KonspektStep(
            title: 'Negocjacje - runda 1',
            duration: Duration(minutes: 15),
            activeForm: false,
            content: '<p style="text-align:justify;">Partie siadają naprzeciw siebie i kolejni przedstawiciele referują postulaty swoich partii. Po zakończeniu wszystkich wystąpień każda partia może zadać każdej innej partii po jednym pytaniu.</p>'
        ),


        KonspektStep(
            title: 'Narada',
            duration: Duration(minutes: 15),
            activeForm: false,
            content: '<p style="text-align:justify;">Partie udają się w swoje odrębne miejsca i naradzają się nad strategią komunikacji.'
                '<br>'
                '<br>Prowadzący co jakiś czas przypomina ile zostało czasu do końca fazy narady.</p>'
        ),


        KonspektStep(
            title: 'Negocjacje - runda 2',
            duration: Duration(minutes: 30),
            activeForm: false,
            content: '<p style="text-align:justify;">Partie siadają naprzeciw siebie i przedstawiciele przy współudziale i konsultowaniu się z pozostałymi członkami partii negocjują między sobą koalicję.'
                '<br>'
                '<br>Prowadzący co jakiś czas przypomina ile zostało czasu do końca rundy negocjacji.</p>'
        ),


        KonspektStep(
            title: 'Narada',
            duration: Duration(minutes: 15),
            activeForm: false,
            content: '<p style="text-align:justify;">Partie udają się w swoje odrębne miejsca i naradzają się nad strategią komunikacji.'
                '<br>'
                '<br>Prowadzący co jakiś czas przypomina ile zostało czasu do końca fazy narady.</p>'
        ),


        KonspektStep(
            title: 'Negocjacje - runda 2',
            duration: Duration(minutes: 45),
            activeForm: false,
            content: '<p style="text-align:justify;">Partie siadają naprzeciw siebie i przedstawiciele przy współudziale i konsultowaniu się z pozostałymi członkami partii negocjują między sobą koalicję.'
                '<br>'
                '<br>Na końcu tej rundy musi powstać umowa koalicyjna - w przeciwnym razie państwo pogrąży się w chaosie.'
                '<br>'
                '<br>Prowadzący co jakiś czas przypomina ile zostało czasu do końca rundy negocjacji.</p>'
        ),


      ],
      howToFail: [
        'Jako prowadzący być stronniczym'
      ]
  ),


  // Done
  const Konspekt(
    name: 'nocne_podkradanie',
    title: 'Nocne podkradanie',
    category: KonspektCategory.harcerskie,
    type: KonspektType.zwyczaj,
    spheres: {
      KonspektSphere.duch: KonspektSphereDetails(
          level: [KonspektSphereLevel.duchPostawy],
          mechanism: []
      )
    },
    metos: [Meto.harc, Meto.hs, Meto.wedro],
    coverAuthor: 'Daniel Iwanicki',
    author: DANIEL_IWANICKI,
    aims: [
      'Budowanie u uczestników wspólnoty poprzez mechanizm rywalizacji',
      'Kształtowanie u uczestników szacunku dla skuteczności w działaniu',
    ],
    description: '<p style="text-align:justify;">Uczestnicy podczas formy wyjazdowej podczas której śpią w grupach osobnych miejscach (np. w osobnych podobozach podczas obozu letniego) w nocy podkradają się do drugiej grupy. Ich celem jest dostać się na teren obozowania przeciwnej grupy nie będąc zauważonymi przez wartę nocna i podkraść rzeczy jakieś symboliczne rzeczy (np. proporce zastępów, menażki, chusty z mundurów).'
        '<br>'
        '<br>Podkradanie do innej grupy powinno zostać poprzedzone skonsultowaniem tego zamiaru z kadrą owej grupy (np. z kadrą podobozu), tak, by nie zaszło podejrzenie, że zupełnie obce osoby próbują się dostać na teren obozowania.'
        '<br>'
        '<br>W przypadku, gdy podczas podkradania warta nocna złapie kogoś z podkradających się, może przywiązać go w pozycji siedzącej do drzewa (izolując od ziemi i samego drzewa karimatą). Upewniwszy się, że osoba nie jest zbyt ciasno związana i że nie ma ryzyka niedokrwienia kończyn, grupa wystawiająca wartę może wysłać delegację do kadry osoby złapanej i uzyskać zgodę na to, by złapany spędził noc będąc przywiązanym do drzewa (zależy to głównie od tego, czy według kadry taka osoba nie będzie miała z tego powodu traumy).</p>',
  ),


  // Done
  const Konspekt(
      name: 'opieka_nad_roslinka',
      title: 'Opieka nad roślinką',
      category: KonspektCategory.harcerskie,
      type: KonspektType.projekt,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchSumiennosc]
        )
      },
      metos: [Meto.zuch, Meto.harc],
      coverAuthor: 'Freepik (freepik)',
      author: DANIEL_IWANICKI,
      aims: [
        'Kształtowanie u uczestników postawy sumienności'
      ],
      materials: [
        KonspektMaterial(amountAttendantFactor: 1, name: 'Doniczki'),
        KonspektMaterial(amountAttendantFactor: 1, name: 'Ziemia do roślin'),
        KonspektMaterial(amountAttendantFactor: 5, name: 'Nasiona roślin'),
      ],
      description: '<p style="text-align:justify;">Prowadzący na zbiórce daje uczestnikom doniczki, ziemię do roślin i nasiona. Uczestnicy sadzą roślinki do doniczki oraz dowiadują się jak o nie dbać. Uczestnicy dowiadują się, że po ustalonym czasie roślinki wrócą do harcówki, dlatego ważne, by harcerze zatroszczyli się o nie jak najlepiej.'
          '<br>'
          '<br>Po czym zabierają je do domu. Przez następny okres (między pół roku a rok) zadaniem uczestników jest regularnie dbać o roślinkę. Po tym czasie roślinki są przynoszone do harcówki, gdzie dalej dba o nią w każdym tygodniu zastęp służbowy.</p>'
  ),


  // Done
  const Konspekt(
      name: 'opowiedzenie_gawedy_o_autorytecie',
      title: 'Opowiedzenie gawędy o autorytecie',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchWartosci],
            mechanism: []
        )
      },
      metos: [Meto.hs, Meto.wedro],
      coverAuthor: '',
      author: DANIEL_IWANICKI,
      aims: [
        'Refleksja nad życiem i wartościami autorytetu'
      ],
      description: '<p style="text-align:justify;">Forma nie polega na tym, że prowadzący opowiada gawędę. Forma polega na tym, by prowadzący przygotował uczestnika do opowiedzenia gawędy.'
          '<br>'
          '<br>Zazwyczaj twórca dzieła więcej na nim korzysta niż jego odbiorca - tak samo jest z dobrą gawędą. Forma polega na znalezieniu postaci, która dla słuchaczy będzie autorytetem, zanurzeniu się w historię jej życia i pod okiem doświadczonego instruktora przygotowanie gawędy dla zuchów lub harcerzy, która pozwoli im się utożsamić z bohaterem.</p>',
      howToFail: [
        'Pozwolić na przeczytanie gawędy z kartki'
      ]
  ),


  // Done
  // TODO: dopisać info o tym, że karanie jest ok.
  const Konspekt(
      name: 'padnij_za_zbyt_wolno_wykonana_zbiorke',
      title: '“Padnij” za zbyt wolną zbiórkę',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zwyczaj,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: '',
      author: DANIEL_IWANICKI,
      aims: [
        'Budowanie u uczestników postawy szacunku dla dla wydawanych przez kadrę komend',
        aimSzacunekDlaSkutecznegoDzialania,
        aimPostawaWspolpracy,
      ],
      description: '<p style="text-align:justify;">Prowadzący po wydaniu komendy “zbiórka” (np. w szeregu), jeśli widzi, że harcerze się ociągają i nie traktują jego komendy z należytą powagą i dyscypliną odlicza od siedmiu do zera. Jeśli do tego czasu harcerze nie ustawią się na zbiórce, prowadzący wydaje całej drużynie komendę “padnij” (czyli przejście do podporu przodem).'
          '<br>'
          '<br>Forma ma na celu zbudowanie postawy szacunku dla wydawanych przez kadrę komend i postawy sprawnego działania - w przeciwnym razie w naturalny sposób harcerze, którzy sprawnie stawiają się na zbiórce są poszkodowani, gdyż czekają bezczynnie na tych, którzy komendę zignorowali. Jednocześnie forma pozwala zbudować przekonanie, że konieczność położenia trzymanych w ręku rzeczy na ziemi w celu wykonania komendy “padnij” oraz dotknięcie rękami podłogi lub ziemi nie jest “końcem świata”.'
          '<br>'
          '<br>Należy mieć na uwadze, że o ile słuszne jest egzekwowanie od harcerzy wykonywania komend i poleceń kadry, o tyle kadra ma obowiązek stosownie i w sposób otwarty reagować na formułowane przez harcerzy poglądy, pomysły i wątpliwości, nawet, jeśli mają one charakter zaczepny, żartobliwy, czy niepoważny.</p>'
  ),


  // Done
  const Konspekt(
      name: 'pielgrzymka_druzyny',
      title: 'Pielgrzymka drużyny',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.cialo: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty],
            mechanism: [KonspektSphereMechanism.duchBezposrednia, KonspektSphereMechanism.duchHartDucha, KonspektSphereMechanism.duchKsztaltowanieUwaznosci]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      aims: [
        aimPraktykaModlitwy,
        aimHartDuchaWedrowanie,
        aimUmiejetnoscWedrowania,
      ],
      description: '<p style="text-align:justify;">Wariant <a href="wedrowka@konspekt">Wędrówki</a> lub <a href="wedrowka_medytacyjna@konspekt">Wędrówki medytacyjnej</a> o tematyce religijnej.'
          '<br>'
          '<br>Wskazane jest, by cel pielgrzymki był określony i w jakiś sposób religijnie istotny. Samą wędrówkę warto podzielić na części i dywersyfikować ich formy wykorzystując np.: śpiewanie, rozważania, luźne rozmowy, milczenie.'
          '<br>'
          '<br>Warto w ramach formy stworzyć przestrzeń i okoliczności do realizacji przez harcerzy zadań na stopnie i sprawności.</p>',
      howToFail: [
        'Nie uświadomienie uczestnikom jaki jest sens pielgrzymki'
      ]
  ),


  // Done
  const Konspekt(
      name: 'post',
      title: 'Post',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zwyczaj,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (QuadGraphics)',
      author: DANIEL_IWANICKI,
      aims: [
        'Kształtowanie u uczestników hartu ducha'
      ],
      description: '<p style="text-align:justify;">Uczestnicy dobrowolnie wstrzymują się od jedzenia przez określony czas (np. przez dobę) w otoczeniu osób jedzących. Celem formy jest kształtowanie hartu ducha i siły woli - jest, przykładowo, częścią sprawności “trzy pióra”.'
          '<br>'
          '<br>Post nie musi dotyczyć całkowitego powstrzymania się od jedzenia. Może np. być realizowany poprzez jedzenie jedynie warzyw, jedzenie jedynie chleba, albo niejedzenie cukru.</p>'
  ),


  // Done
  const Konspekt(
      name: 'pozno_zyciowe_rozmowy',
      title: 'Późno-życiowe rozmowy',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty, KonspektSphereLevel.duchWartosci],
            mechanism: []
        ),
        KonspektSphere.relacje: null,
      },
      metos: [Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (vector_corp)',
      author: DANIEL_IWANICKI,
      aims: [
        'Podjęcie przez uczestników refleksji nad sensem i celem życia'
      ],
      description: '<p style="text-align:justify;">Uczestnik znajduje pięć osób po 60. roku życia o różnych przeszłościach i odbywa z nimi rozmowy na temat ich życia oraz (zwłaszcza!) tego, co według nich jest w życiu najważniejsze, z czego się najbardziej cieszą, czego najbardziej żałują. Forma ma na celu dać uczestnikowi możliwość spojrzenia na rzeczywistość oczami kogoś, kto dobrze ją zna i kto większość swojego życia ma już za sobą.'
          '<br>'
          '<br>Uczestnicy do tej formy muszą posiadać potrzebne umiejętności komunikacyjne, by umieli prowadzić rozmowę, a nie tylko “odpytkę”. Jeżeli nie uda im się nawiązać szczerej, mimo, że krótkiej relacji, forma będzie bezcelowa. Wskazane jest z tego względu, by wybrane osoby były otwarte na rozmowy z harcerzami - byli instruktorzy, kombatanci, osoby, które pełniły w ZHP w państwie Polskim funkcje. Wskazane jest także, aby uczestnik formy przygotował strategię rozmowy, która pozwoli mu przejść od tego, czym rozmówca się zajmował do jego ducha.</p>',
      howToFail: [
        'Pozwolić na realizowanie formy przez niedojrzałą osobę',
      ]
  ),


  // Done
  const Konspekt(
    name: 'refleksja_nad_aksjomatem_ducha',
    title: 'Refleksja nad aksjomatem ducha',
    category: KonspektCategory.harcerskie,
    type: KonspektType.zajecia,
    spheres: {
      KonspektSphere.duch: KonspektSphereDetails(
          level: [KonspektSphereLevel.duchAksjomaty],
          mechanism: [KonspektSphereMechanism.duchBezposrednia]
      )
    },
    metos: [Meto.hs, Meto.wedro],
    coverAuthor: 'freepik.com (vectorpouch)',
    author: DANIEL_IWANICKI,
    customDuration: Duration(minutes: 4 * 20 + 30),
    aims: [
      'Refleksja nad poziomem aksjomatycznym swojej duchowości',
    ],
    materials: [
      KonspektMaterial(
          amountAttendantFactor: 2,
          name: 'Wydrukowany załącznik "pytania".',
          attachmentName: 'pytania',
          additionalPreparation: 'Każdy uczestnik powinien dostać 5 przygotowanych elementów: jeden "wstęp" oraz 4 "pytania".'
              '\n'
              '\nWydrukowany załącznik należy pociąć na części i zagiąć we wskazanych miejscach tak, by dolna część każdej wyciętej części kartki przykrywała treść pytania, lecz by odsłaniała nagłówek.'
      ),
    ],
    summary: 'Uczestnicy indywidualnie i w ciszy podejmują refleksję nad pytaniami dotyczącymi sensu ich życia. Po zakończeniu podsumowują je między sobą.',
    description: '<p>Harcerze otrzymują wydrukowane i pocięte pytania z załącznika <a href="pytania@attachment">pytania</a>.'
        '<br>'
        '<br>Każdy uczestnik znajduje ustronne miejsce, gdzie może w spokoju pomyśleć bez rozpraszania swojej uwagi. Może również udać się na spacer.'
        '<br>'
        '<br>Harcerze otwierają pierwsze pytanie, czytają je i przez kolejne 20 minut podejmują nad nim refleksję. Gdy czas ten upłynie, przechodzą do kolejnego pytania, nad którym również spędzają 20 minut. Proces ten jest powtarzany analogicznie dla trzeciego i czwartego pytania.'
        '<br>'
        '<br>Gdy skończą, wszyscy wracają w jedno miejsce i w zastępach, lub innych małych grupach (najlepiej po około 4 osoby) omawiają swoje refleksje. Jeżeli nie chcą się czymś dzielić - nie ma takiej konieczności.'
        '<br>'
        '<br>Forma ta ma na celu pracę nad duchowością na poziomie aksjomatu (a więc na poziomie najgłębszym, w przeciwieństwie do poziomu zachowań, postaw i wartości). Forma ta może być stosowana jako forma zastępca dla osób które na obozie nie uczestniczą we Mszy Świętej.</p>',
    attachments: [
      KonspektAttachment(
        name: 'pytania',
        title: 'Pytania',
        assets: {
          KonspektAttachmentFormat.pdf: 'pytania.pdf',
          KonspektAttachmentFormat.docx: 'pytania.docx'
        },
      )
    ],
  ),


  // Done
  const Konspekt(
      name: 'rowerowe_nabozenstwo_majowe',
      title: 'Rowerowe nabożeństwo majowe',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.cialo: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty],
            mechanism: [KonspektSphereMechanism.duchBezposrednia, KonspektSphereMechanism.duchKsztaltowanieUwaznosci]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      aims: [
        'Wyciszenie poprzez podróż rowerową po niezurbanizowanym terenie',
        aimPraktykaModlitwy,
      ],
      customDuration: Duration(hours: 36),
      description: '<p style="text-align:justify;">Uczestnicy udają się na rowerach na wycieczkę po zaplanowanej trasie, podczas której odwiedzają znalezione wcześniej kapliczki. Przy każdej z kapliczek drużyna się zatrzymuje i kolejna z osób prowadzi krótką modlitwę.'
          '<br>'
          '<br>Warto, aby docelowym punktem podróży było miejsce, gdzie będzie można przenocować - szkoła, chata, las na hamakowisko, pole namiotowe nad rzeką, etc..</p>'
  ),


  // Done
  const Konspekt(
      name: 'rozpoczynanie_posilku_wspolnym_spiewaniem',
      title: 'Rozpoczynanie posiłku wspólnym śpiewaniem',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zwyczaj,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchWartosci, KonspektSphereLevel.duchPostawy],
            mechanism: [
              KonspektSphereMechanism.duchBezposrednia,
              KonspektSphereMechanism.duchNormalizacja,
              KonspektSphereMechanism.duchHartDucha,
              KonspektSphereMechanism.duchOtwartoscNaLudzi
            ]
        )
      },
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (veevc83)',
      aims: [
        'Kształtuje samodyscypliny uczestników na podstawie czekania z rozpoczęciem posiłku',
        'Budowanie wspólnoty u uczestników poprzez przekonanie, że jest ona na tyle ważna, że tylko wspólnie można rozpocząć posiłek',
        'Budowanie wspólnoty u uczestników poprzez rywalizację z innymi śpiewającymi przed posiłkiem drużynami na to, kto głośniej zaśpiewa'
      ],
      description: '<p style="text-align:justify;">Forma polega na rozpoczęciu posiłku wspólnym zaśpiewaniem krótkiej piosenki, przed którą żaden z uczestników nie może rozpocząć posiłku.'
          '<br>'
          '<br>Warto mieć świadomość, że tradycje śpiewania przed posiłkiem w harcerstwie wywodzą się tradycji wspólnej modlitwy przed posiłkiem (tradycja ta została powszechnie zmieniona w ZHP na skutek czasowego wcielenia ZHP do struktur komunistycznych).</p>'
  ),


  // Done
  const Konspekt(
      name: 'sad_nad_postawa',
      title: 'Sąd nad postawą',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.umysl: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty, KonspektSphereLevel.duchWartosci],
            mechanism: [KonspektSphereMechanism.duchBezposrednia]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (thetrimhub)',
      author: DANIEL_IWANICKI,
      customDuration: Duration(minutes: 90),
      aims: [
        'Stworzenie naturalnej okazji do poruszenia kluczowych aspektów dot. wartości i postaw',
        'Refleksja uczestników nad słusznością działań i postaw z perspektywy obserwatora',
        aimUmiejetnoscDyskusji,
      ],
      description: '<p style="text-align:justify;">Prowadzący opisuje hipotetyczną, problematyczną sytuację z perspektywy jakiejś osoby oraz sposób, w jaki jej uczestnicy ją rozwiązali. Następnie harcerze muszą ocenić jak owa sytuacja powinna zostać prawidłowo rozwiązana i dlaczego.'
          '<br>'
          '<br>Prowadzący powinien w ramach tej formy przygotować mównicę. Polemika powinna odbywać się jedynie z mównicy, zaś rolą prowadzącego jest pilnowanie porządku, udzielenia głosu i w kluczowych momentach zadawanie pytań kierujących uczestników na pomijane przez nich aspekty omawianego dylematu.'
          '<br>'
          '<br>Jeżeli prowadzącemu zależy na pracy z aksjomatem, drąży pytaniami “dlaczego” tak długo, aż harcerze osiągną poziom aksjomatu duchowego - i wówczas rozpoczyna się dyskusja o tym, jakie aksjomaty jak do tego podchodzą i dlaczego.'
          '<br>'
          '<br>Przykładowa treść sądu:'
          '<br>'
          '<br><i>“Na obozie jeden z zastępów harcerzy nie mył menażek. Drużynowa z powodów ideologicznych nigdy nie stosowała kar - jedynie rozmowy wychowawcze, jednak zastęp je ignorował. Po tygodniu obozu dwójka harcerzy się zatruła, zaś po półtorej tygodnia była to już połowa zastępu. Wskutek tych wydarzeń na obóz przyjechała kontrola sanepidu i nałożyła karę na komendanta obozu oraz rozwiązał obóz przed terminem, co zmusiło większość rodziców do zmiany swoich planów urlopowych i spowodowało nieprzyjemności w pracy. Komendant obarczył winą drużynową zastępu nie myjącego garów, jednak ona uparcie twierdziła, że kary są znęcaniem się i patologią.”</i></p>',
      howToFail: [
        'Jako prowadzący polemizować z uczestnikami występującymi na mównicy',
        'Pozwolić, by uczestnicy robili sobie jaja z formy poprzez odkrywanie ról wielkich mówców i posługiwanie się nienaturalnie pompatycznym językiem'
      ]
  ),


  const Konspekt(
      name: 'savoir_vivre_urzadzen_mobilnych',
      title: 'Savoir-vivre urządzeń mobilnych',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.umysl: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchWartosci, KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchBezposrednia]
        )
      },
      metos: [Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (freepik)',
      author: DANIEL_IWANICKI,
      aims: [
        'Zrozumienie przez uczestników mechanizmu szyfrowania danych w sieci',
        'Zrozumienie przez uczestników poziomu prywatności danych przechowywanych w sieci',
        'Uświadomienie uczestników o istnieniu komunikatorów i usług szyforwanych end-to-end',
        'Wypracowanie z uczestnikami zasad korzystania z telefonów podczas zbiórek oraz w dniu codziennym'
      ],
      attachments: [
        KonspektAttachment(
          name: 'komputer',
          title: 'Symulator komputera',
          assets: {
            KonspektAttachmentFormat.pdf: 'komputer.pdf',
            KonspektAttachmentFormat.docx: 'komputer.docx',
          },
        ),
      ],
      materials: [
        KonspektMaterial(
          name: 'Wydrukowany załącznik "Symulator komputera"',
          comment: 'Uwaga: prowadzący musi umieć grać w warcaby!',
          attachmentName: 'komputer',
          amountAttendantFactor: 1
        ),
        KonspektMaterial(
            name: 'Karteczki biurowe (kwadratowe, ok. 10 cm x 10 cm)',
            amountAttendantFactor: 3
        ),
        KonspektMaterial(
            name: 'Skrzynki zamykane na kłódkę na klucz',
            amount: 4,
            comment: 'Kłódki muszą móc się zamknąć bez użycia klucza. Ważne też, by prowadzący miał do każdej kłódki zapasowy klucz, w przypadku gdyby uczestnicy przypadkiem zatrzasnęli klucz w środku.'
        ),
        KonspektMaterial(
            name: 'Kartka A4',
            amount: 5
        ),
        KonspektMaterial(
            name: 'Długopis',
            amount: 5
        ),
      ],
      intro: 'Zajęcia i ich cele opierają się na założeniu, że zarówno z punktu widzenia procesu wychowawczego jak i z atrakcyjności harcerstwa i relacji dla samych harcerzy, sytuacja w której członkowie drużyny domyślnie spędzają czas na telefonie by szukać rozrywki jest gorsza względem sytuacji w której uczestnicy są skupieni na sobie.',
      steps: [
        KonspektStep(
            title: 'Internet i adresy w sieci - pytania',
            duration: Duration(minutes: 10),
            activeForm: false,
            content: '<p style="text-align:justify;">Uczestnicy zbierają się w kręgu i prowadzący wyjaśnia uczestnikom po krótce sposób, w jaki działa internet. Najlepiej, jeśli uczyni to poprzez zadawanie pytań, na które uczestnicy będą mieli możliwość odpowiedzieć, zaś prowadzący będzie dopowiadał brakujące elementy odpowiedzi:</p>'
                '<ol>'
                '<li>'
                '<p><b>Pytanie:</b>'
                '<br><i>Czym jest internet?</i>'
                '<br>'
                '<br><b>Odpowiedź:</b>'
                '<br><i>To sieć, w której urządzenia elektroniczne mogą się ze sobą wzajemnie komunikować.</i>'
                '<br>&nbsp</p>'
                '</li>'
                '<li>'
                '<p><b>Pytanie:</b>'
                '<br><i>Skąd wiadomo, od kogo i do kogo wiadomości w internecie są wysyłane?</i>'
                '<br>'
                '<br><b>Odpowiedź:</b>'
                '<br><i>Każdy komputer ma adres IP, który go identyfikuje w internecie.</i>'
                '<br>&nbsp</p>'
                '</li>'
                '<li>'
                '<p><b>Pytanie:</b>'
                '<br><i>Skąd bierze się adres IP danego urządzenia?</i>'
                '<br>'
                '<br><b>Odpowiedź:</b>'
                '<br><i>Każde urządzenie otrzymuje swój adres od sieci, dzięki czemu jest on unikalny. Gdyby każde urządzenie nadawało go sobie samo, mogłoby się powtórzyć z którymś z już istniejących przez co wiadomości mogłyby nie trafiać do właściwego urządzenia.</i>'
                '<br>&nbsp</p>'
                '</li>'
                '<li>'
                '<p><b>Pytanie:</b>'
                '<br><i>W jaki sposób wiadomość zaadresowana do konkretnego urządzenia w internecie do niego dociera?</i>'
                '<br>'
                '<br><b>Odpowiedź:</b>'
                '<br><i>Wiadomość jest przekazywana kolejnym "uczestnikom" internetu aż dotrze ona do właściwego urządzenia.</i></p>'
                '</li>'
                '</ol>'
        ),
        KonspektStep(
            title: 'Internet i adresy w sieci - podsumowanie',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący podsumowuje krótko to, co zostało powiedziane w formie odpowiedzi na pytania:'
                '<br>'
                '<br>Internet to sieć, w której komputery mogą się ze sobą komunikować. Każde urządzenie ma swój unikalny adres IP, który go identyfikuje. Wiadomości w sieci są przekazywane kolejnym urządzeniom aż dotrą do urządzenia z właściwym adresem.</p>'
        ),
        KonspektStep(
            title: 'Internet i adresy w sieci - symulacja',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p>Prowadzący podsumowuje krótko to, co zostało powiedziane w formie odpowiedzi na pytania:'
                '<br>'
                '<br>Internet to sieć, w której komputery mogą się ze sobą komunikować. Każde urządzenie ma swój unikalny adres IP, który go identyfikuje. Wiadomości w sieci są przekazywane kolejnym urządzeniom aż dotrą do urządzenia z właściwym adresem.</p>'
        ),

        KonspektStep(
            title: 'Internet i adresy w sieci - wyjaśnienie symulacji',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący rozdaje uczestnikom po jednej kopii wydrukowanego załącznika <a href="komputer@attachment">symulator komputera</a> i po kilka (np. po trzy) karteczek biurowych, po czym tłumaczy co one reprezentują:</p>'
                '<ul>'
                '<li><p style="text-align:justify;">Na kartce biurowej można napisać dowolną wiadomość - jest to informacja, którą można przechowywać w komputerze lub przesłać ją przez sieć. Aby ją wysłać, należy na jej odwrocie napisać adres IP odbiorcy, położyć w polu "Wyślij do" i zwrócić się do prowadzącego (czyli do internetu) z wnioskiem o wysyłkę.</p></li>'
                '<li><p style="text-align:justify;">Dolna część symulatora komputera to prywatna przestrzeń w komputerze, która nie jest udostępniona przez internet. Można w niej trzymać, tworzyć i edytować informacje (karteczki biurowe).</p></li>'
                '<li><p style="text-align:justify;">Górna część symulatora komputera to publiczna przestrzeń w komputerze, która jest udostępniona przez internet. Wszystkie informacje (karteczki biurowe) są w niej widoczne dla innych osób.</></li>'
                '<li><p style="text-align:justify;">W prawym górnym rogu części publicznej symulatora komputera znaduje się miejsce na adres IP, które jest nadawane komputerowi gdy podłączy się do sieci.</p></li>'
                '<li><p style="text-align:justify;">W prawym dolnym rogu części publicznej symulatora komputera znaduje się miejsce, w którym po podaniu adresu IP odbiorcy, można wysłać komuś przez internet wiadomość (karteczki biurowe). Poniżej zaś znajduje się przestrzeń, w której pojawiają się wiadomości (karteczki biurowe) od innych urządzeń.</p></li>'
                '</ul>'
        ),
        KonspektStep(
            title: 'Internet i adresy w sieci - symulacja',
            duration: Duration(minutes: 10),
            activeForm: true,
            content: '<p style="text-align:justify;">Prowadzący siada na środku kręgu i informuje uczestników, że od teraz reprezentuje sieć internetową - jest przekaźnikiem, pozwala przesyłać innym wiadomości i który nadaje adresy IP.'
                '<br>'
                '<br>Uczestnicy mają za zadanie stworzyć wiadomość, podpiąć się sieci i przesłać wiadomość do innego uczestnika. Nie muszą czekać aż inni będą gotowi do wysyłki swoich wiadomości.'
                '<br>'
                '<br><b>Od tej chwili aż do końca symulacji prowadzący nie komunikuje się werbalnie</b>.'
                '<br>'
                '<br>Ważne, by prowadzący pamiętał, że zanim ktoś wyśle jakąś wiadomość, musi uzyskać od internetu swój adres IP (czyli poprosić prowadzącego werbalnie o adres).'
                '<br>'
                '<br>Ważne też, by prowadzący pamiętał, że jeśli odbiorca nie ma swojego adresu IP, nie można do niego wysłać wiadomości. W takiej sytuacji bez słowa zwraca wiadomość do nadawcy.'
                '<br>'
                '<br>Uczestnicy wysyłają sobie wiadomości przez kilka minut tak długo, aż prowadzący zauważy, że każdy rozumie ten prosty mechanizm.</p>'
        ),

        KonspektStep(
            title: 'Czy i jak warto szyfrować wiadomości?',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący zaczyna od zapytania uczestników: <i>"Co wy na to, że każda wiadomość jaką przesłaliście była możliwa przeze mnie, czyli każdego w sieci, do odczytania?" Może były tam Wasze maile? Może wyznania miłosne do najładniejszej dziewczyny w szkole? Może problemy zdrowotne, albo leki na przykład zamówienie na czopki, które wkłada się do odbytu? Może hasło do mediów społecznościowych? Czy na pewno to wszystko powinno być jawne?</i>'
                '<br>'
                '<br>Następnie prowadzący pyta uczestników jak temu zaradzić?'
                '<br>'
                '<br>W trakcie dyskusji warto, by prowadzący zwrócił uwagę, że zaszyfrowanie wiadomości to nie wszystko - należy jeszcze umożliwić odbiorcy jej odszyfrowanie.'
                '<br>'
                '<br>Prowadzący prosi uczestników o podanie metod na zawszyfrowanie wiadomości - warto też, by potem zauważył, że metody typu "GADERYPOLUKI", alfabet Mose\'a są dla komputerów bardzo proste do złamania.</p>'
        ),

        KonspektStep(
            title: 'Szyfrowanie kluczem asymetrycznym',
            duration: Duration(minutes: 20),
            activeForm: true,
            content: '<p style="text-align:justify;">Prowadzący informuje uczestników, że istnieje metoda szyfrowania przesyłanych wiadomości, która nazywa się "szyfrowaniem kluczem asymetrycznym". Dlaczego asymetrycznym? Bo używa się przy nim dwóch <b>różnych</b> kluczy: jednego do zaszyfrowania, innego do odszyfrowania.'
                '<br>'
                '<br>Żeby jednak nie wchodzić w technikalia, uczestnicy będą mieli okazję sami wymyślić mechanizm tej metody.'
                '<br>'
                '<br>Prowadzący dzieli uczestników na cztery grupy. Każda grupa otrzymuje po jednej skrzynce, kłódce i kluczyku do kłódki. Każda grupa udaje się inne miejsce (np. do czterech osobnych sal lub do czeterach krańców jednej sali).'
                '<br>'
                '<br>Zadaniem każdej z grup jest wymyślenie metody na to, by doprowadzić do przesłąnia innej grupie tajnej wiadomości w taki sposób, by nie została ona po drodze odczytana. Prowadzący w tym ćwiczeniu pełni rolę internetu:</p>'
                '<ul>'
                '<li><p style="text-align:justify;">Tylko prowadzącemu można przekazać wiadomość do dostarczenia odbiorcy.</p></li>'
                '<li><p style="text-align:justify;">Prowadzący, ponieważ jest wścibski jak ludzie w internecie, będzie próbował odczytać przekazywaną wiadomość.</p></li>'
                '</ul>'
                '<p>Uczestnicy muszą skorzystać z internetu jako przekaźnika, ale nie pozwolić mu odczytać sensu przekazywanej wiadomości. Odczytać wiadomość może jedynie odbiorca.'
                '<br>'
                '<br><b>Prawidłowe rozwiązanie jest następujące:</b></p>'
                '<ol>'
                '<li><p style="text-align:justify;">Grupa A chce przesłać wiadomość grupie B.</p></li>'
                '<li><p style="text-align:justify;">Grupa A wysyła do grupy B publiczną, niezaszyfrowaną wiadomość o treści: <i>"Wyślijcie skrzynkę z otwartą kłódką w środku. Klucz zostawcie u siebie."</i></></li>'
                '<li><p style="text-align:justify;">Grupa B wysyła grupie A skrzynkę z kłódką w środku.</></li>'
                '<li><p style="text-align:justify;">Grupa A umieszcza tajną wiadomość w skrzynce grupy B, zatrzaskuje na skrzynce kłódkę i wysyła ją z powrotem do grupy B.</p></li>'
                '<li><p style="text-align:justify;">Grupa B jako jedyna ma klucz do swojej skrzynki, odbiera wiadomość, otwiera kłódkę kluczem i odczytuje wiadomość.</p></li>'
                '</ol>'
                '<p style="text-align:justify;">Prawdopodobnie grupy będą próbowały różnych nieskutecznych metod, typu:</p>'
                '<ul>'
                '<li><p style="text-align:justify;">Wysłanie drugiej grupie wiadomości w swojej zamkniętej skrzynce (wówczas odbiorca nie ma jak jej otworzyć)</p></li>'
                '<li><p style="text-align:justify;">Wysłanie drugiej grupie wiadomości w swojej zamkniętej skrzynce z kluczem przyklejonym do spodu skrzynki (wówczas prowadzący może ją otworzyć i odczytać)</p></li>'
                '<li><p style="text-align:justify;">Wysłanie drugiej grupie wiadomości zaszyfrowanej GADERYPOLUKI (wówczas prowadzący może ją odszyfrować na własną rękę)</p></li>'
                '</ul>'
                '<p style="text-align:justify;">W każdym z tych przypadków prowadzący nie może zaliczyć grupie zadania.'
                '<br>'
                '<br>Grupie, która rozgryzła rozwiązanie jako pierwsza można wręczyć jakąś niewielką nagrodę.</>'
        ),

        KonspektStep(
            title: 'Podsumowanie szyfrowania kluczem asymetrycznym',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący podsumowuje wykonane przez uczestników ćwiczenie z zamykanymi skrzynkami upewniając się, że każdy rozumie dlaczego takie wysłanie wiadomości jest bezpieczne.</p>'
        ),

        KonspektStep(
            title: 'Przykład szyfrowanej poczty',
            duration: Duration(minutes: 5),
            activeForm: true,
            content: '<p style="text-align:justify;">Gdy uczestnicy rozumieją już mechanizm ze skrzynką, kłódką i kluczem, prowadzący organizuje <b>scenkę</b> będącą przykładem wysyłania maila w formie z udziałem trzech chętnych uczestników.'
                '<br>'
                '<br>Scenka dotyczy następującej sytuacji: osoba A wysyła maila do osoby B używając poczty eletronicznej M. Zarówno osoba A, osoba B jak i poczta B odgrywane sa przez uczestników, każdy z których ma skrzynkę z kłódką i kluczem. W scence tej prowadzący gra rolę internetu i chodzi między uczestnikami obrazując ruch zaszyfrowanych informacji (skrzynek) po sieci.'
                '<br>'
                '<br>Scenka przebiega następująco:</p>'
                '<ol>'
                '<li><p style="text-align:justify;">Osoba A tworzy wiadomość email u siebie na komputerze.</p></li>'
                '<li><p style="text-align:justify;">Osoba A pobiera od poczty M kod do zaszyfrowania wiadomości (skrzynkę z kłódką bez klucza). Jeśli nawet ktoś podsłucha tę wiadomość, zobaczy jedynie ogólno dostępny klucz szyfrujący.</p></li>'
                '<li><p style="text-align:justify;">Osoba A szyfruje wiadomość email i wysyła ją do poczty M.</p></li>'
                '<li><p style="text-align:justify;">Poczta M odszyfrowuje wiadomość email, zapisuje jej treść i odbiorcę.</p></li>'
                '<li><p style="text-align:justify;">Osoba B loguje się do skrzynki pocztowej poczty M i pobiera od poczty M kod szyfrujący (skrzynkę z kłódką bez klucza).</p></li>'
                '<li><p style="text-align:justify;">Osoba B szyfruje zapytanie do poczty M: <li>"czy mam nowe wiadomości?".</p></li>'
                '<li><p style="text-align:justify;">Osoba B wysyła do poczty M zaszyfrowane zapytanie o nowe wiadomości.</></li>'
                '<li><p style="text-align:justify;">Poczta M pobiera od osoby M jej kod szyfrujący (skrzynkę z kłódką bez klucza).</></li>'
                '<li><p style="text-align:justify;">Poczta M szyfruje nowe wiadomości email jej kodem szyfrującym (skrzynką z kłódką bez klucza).</p></li>'
                '<li><p style="text-align:justify;">Poczta M wysyła zaszyfrowane wiadomości do osoby B.</p></li>'
                '<li><p style="text-align:justify;">Osoba B odszyfrowuje wiadomości od poczty M.</p></li>'
                '<li><p style="text-align:justify;">Koniec!</p></li>'
                '</ol>'
        ),

        KonspektStep(
            title: 'Kto widzi zaszyfrowane wiadomości?',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący zbiera uczestników z powrotem w kręgu i zadaje im pytanie: <i>"Kto może zobaczyć maila, którego wysyłacie do kolegi?"</i>'
                '<br>'
                '<br>Uczestnicy rzucają swoje pomysły. Prawidłowa odpowiedź brzmi: <i>"Wysyłający, odbierający oraz dostawca usługi poczty elektronicznej (np. Gmail)."</i>'
                '<br>'
                '<br>Prowadzący zwraca uwagę, że tak samo jest z innymi danymi: właściciele usług internetowych wiedzą kiedy używają telefonu, skąd się logują, co piszą w mediach społecznościowych, co polubili, co przykuło ich uwagę, z kim rozmawiają, co oglądają, jakie jedzenie zamówili, etc..</p>'
        ),

        KonspektStep(
            title: 'Czy można uwolnić się od śledzenia w sieci?',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący zadaje uczestnikom pytanie: <i>"W jaki sposób można byłoby teoretycznie wysłać wiadomość email tak, by poczta M nie widziała jaka jest treść wiadomości?"</i>'
                '<br>'
                '<br>Jeśli uczestnicy mają problem z wpadnięciem na pomysł, prowadzący podpowiada, że przed chwilą udało im się zabezpieczyć wiadomości skrzynkami - może należy go jakoś zmodyfikować?'
                '<br>'
                '<br>Rozwiązanie jest następujące: poczta A pobiera od osoby B jej kod szyfrujący (skrzynkę z kłódką bez klucza) i przekazuje ją osobie A. Osoba A szyfruje wiadomość i oddaje ją poczcie M. Poczta M nie ma dostępu do klucza by odszyfrować wiadomość - więc może ją jedynie przekazać dalej osobie B, gdy ta zapyta o nowe wiadomości.</p>'
        ),

        KonspektStep(
            title: 'Bezpieczne komunikatory',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący informuje uczestników, że szyforwanie, w którym serwis dostarczający usługi nie ma dostępu do wiadomości nazywa się szyfrowaniem end-to-end.'
                '<br>'
                '<br>Prowadzący dodaje także, że jednym z najpopularniejszych bezpiecznych komunikatorów jest Signal - dostępny także w formie aplikacji mobilnej.</p>'
        ),

        KonspektStep(
            title: 'Gawęda',
            duration: Duration(minutes: 10),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący prosi uczestników, by usiedli wygodnie i zamknęli oczy (mogą się też położyć, jeśli chcą) po czym opowiada im gawędę <a href="gaweda_o_braku_telefonu@gaweda">O braku telefonu</a>.</>'
        ),

        KonspektStep(
            title: 'Zagrożenia wynikające z telefonu',
            duration: Duration(minutes: 10),
            activeForm: true,
            content: '<p style="text-align:justify;">Prowadzący dzieli uczestników na grupy. Każda grupa dostaje kartkę i długopis i ma za zadanie w 10 minut wypisać najważniejsze zagrożenia jakie niesie za sobą dostęp do telefonu komórkowego.</p>'
        ),

        KonspektStep(
            title: 'Jak korzystać z telefonu? Savoir-vivre',
            duration: Duration(minutes: 20),
            activeForm: false,
            content: '<p style="text-align:justify;">Uczestnicy wracają do kręgu. Prowadzący informuje uczestników, że będą oni teraz tworzyli savoir-vivre urządzeń mobilnych: czyli zasady kulturalnego i mądrego korzystania z telefonów komórkowych.'
                '<br>'
                '<br>Prowadzący prosi grupy o odczytanie kolejno po jednym zagrożeniu jakie grupy zapisały. Po każdym zagrożeniu uczestnicy muszą przekuć zagrożenie na ogólną zasadę lub zasady postępowania z telefonami.'
                '<br>'
                '<br>Przykładowy savoir-vivre urządzeń mobilnych może wyglądać następująco:'
                '</p>'
                '<ol>'
                '<li><p style="text-align:justify;"><i>Wyjście ze znajomymi ma wyższy priorytet niż granie na fonie lub na kompie.</i></p></li>'
                '<li><p style="text-align:justify;"><i>Podczas zbiórek nie wolno korzystać z telfonu, chyba, że drużynowy wyrazi zgodę.</i></p></li>'
                '<li><p style="text-align:justify;"><i>Podczas przebywania w towarzystwie telefon nie powinien być na widoku.</i></p></li>'
                '<li><p style="text-align:justify;"><i>W ciągu dnia można używać telefonu maksymalnie 1h do rzeczy innych niż pomoc w nauce lub dzwonienie.</i></p></li>'
                '<li><p style="text-align:justify;"><i>Oglądanie TikToka, Realsów i Shortsów jest niedozwolone. Szkoda mózgu.</i></p></li>'
                '</ol>'
        ),

        KonspektStep(
            title: 'Podpisanie stworzonego savoir-vivre',
            duration: Duration(minutes: 5),
            activeForm: true,
            content: '<p style="text-align:justify;">Uczestnicy kolejno podpisują savoir-vivre urządzeń mobilnych. Warto również wywiesić podpisany dokument gdzieś w harcówce w widocznym, ale niekoniecznie centralnym miejscu.</p>'
        ),

      ],
      howToFail: [
        'Przeprowadzić część zajęć dotyczącą szyfrowania w formie wykładu',
        'Jako prowadzący zdominować proces ustalania zasad savoir-vivre urządzeń mobilnych'
      ]
  ),


  // Done
  const Konspekt(
    name: 'spiewogranie_z_quizem_interpretacyjnym',
    title: 'Śpiewogranie z quizem interpretacyjnym',
    category: KonspektCategory.harcerskie,
    type: KonspektType.zajecia,
    spheres: {
      KonspektSphere.duch: KonspektSphereDetails(
          level: [KonspektSphereLevel.duchAksjomaty, KonspektSphereLevel.duchWartosci],
          mechanism: [KonspektSphereMechanism.duchBezposrednia, KonspektSphereMechanism.duchNormalizacja]
      )
    },
    metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
    coverAuthor: 'freepik.com (artefacti)',
    author: DANIEL_IWANICKI,
    customDuration: Duration(minutes: 90),
    aims: [
      'Refleksja nad historiami i wynikającymi z nich wartościami i postawami w piosenkach.',
    ],
    materials: [
      KonspektMaterial(
        amountAttendantFactor: 1,
        name: 'Teksty śpiewanych piosenek',
      ),
    ],
    description: '<p style="text-align:justify;">Prowadzący wybiera kilka piosenek, które niosą nieoczywiste na pierwszy “rzut oka (ucha?)” przesłanie w swojej treści lub które wymagają do ich zrozumienia znajomości kontekstu historycznego lub kulturowego.'
        '<br>'
        '<br>Uczestnicy otrzymują wydrukowane wybranych piosenek (by oszczędzić zasoby i wprowadzić element współpracy można wprowadzić rozdać teksty po jednym komplecie na dwie osoby).'
        '<br>'
        '<br>Uczestnicy dzieleni są na grupy. Dla każdej piosenki uczestnicy najpierw się jej uczą poprzez wspólnie zaśpiewanie jej z prowadzącym, po czym prowadzący przeprowadza quiz z tematu dotyczącego treści piosenki.'
        '<br>'
        '<br>Quiz może dotyczyć znaczenia różnych niecodziennych słów, wyrażeń, czy tego, co autor piosenki miał na myśli używając pewnego wyrażenia. Na końcu quizu uczestnicy wspólnie próbują podsumować sens piosenki.'
        '<br>'
        '<br>Wskazane jest, by kilka razy przeprowadzeniem formy uczestnicy mieli okazję zaśpiewać piosenki, które będą interpretowane.'
        '<br>'
        '<br>Szczególną wersją tej formy jest “kolędowanie z quizem interpretacyjnym”, gdzie zbiorem piosenek są kolędy.'
        '<br>'
        '<br><b>Przykładowe piosenki dla zuchów</b>:</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Hej przyjaciele <i>(Zayazd)</i></p></li>'
        '<li><p style="text-align:justify;">Wieczorne śpiewogranie</p></li>'
        '</ul>'
        '<br><p style="text-align:justify;"><b>Przykładowe piosenki dla harcerzy</b>:</p>'
        '<ul>'
        '<li><p style="text-align:justify;">A my nie chcemy uciekać stąd <i>(P. Gintrowski)</i></p></li>'
        '<li><p style="text-align:justify;">Czarny chleb i czarna kawa <i>(Strachy na lachy)</i></p></li>'
        '<li><p style="text-align:justify;">Dni, których nie znamy <i>(Marek Grechuta)</i></p></li>'
        '<li><p style="text-align:justify;">Eldorado <i>(Sanah, D. Zawiałow)</i></p></li>'
        '<li><p style="text-align:justify;">Hej przyjaciele <i>(Zayazd)</i></p></li>'
        '<li><p style="text-align:justify;">Hymn <i>(J. Słowacki, Sanah)</i></p></li>'
        '<li><p style="text-align:justify;">Major ponury</p></li>'
        '<li><p style="text-align:justify;">Moja litania <i>(Leszek Wójtowicz)</i></p></li>'
        '<li><p style="text-align:justify;">Niebieski cyrkiel <i>(Stare Dobre Małżeństwo)</i></p></li>'
        '<li><p style="text-align:justify;">Pójdę boso <i>(Zakopower)</i></p></li>'
        '<li><p style="text-align:justify;">Rozwijając Rilkego <i>(Sahan)</i></p></li>'
        '<li><p style="text-align:justify;">Zielony dom <i>(Stare Dobre Małżeństwo)</i></p></li>'
        '</ul>'
        '<p style="text-align:justify;">Forma, aby miała sens, powinna być prowadzona przez osobę, które umie i lubi grać na gitarze i która przynajmniej minimalnie "czuje" temat interpretacji sztuki. Osoba prowadząca powinna się do niej zawczasu przygotować - rozpoczęcie przygotowań godzinę przed rozpoczęciem nie ma sensu.'
        '<br>'
        '<br>Forma ta ma na celu pracę nad duchowością na poziomie aksjomatu i wartości poprzez normalizację. Forma ta może być stosowana jako forma zastępcza dla osób w pionie Z i H, które na obozie nie uczestniczą we Mszy Świętej.</p>',
  ),


  // Done
  const Konspekt(
      name: 'staly_spowiednik',
      title: 'Stały spowiednik',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zwyczaj,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty, KonspektSphereLevel.duchWartosci],
            mechanism: [KonspektSphereMechanism.duchBezposrednia]
        ),
        KonspektSphere.relacje: null,
      },
      metos: [Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (DenisW)',
      author: DANIEL_IWANICKI,
      aims: [
        'Uporządkowanie życia i pomoc w pracy nad sobą przez uczestników'
      ],
      description: '<p style="text-align:justify;">Uczestnik znajduje duchownego, u którego będzie mógł się regularnie spowiadać. Forma ta jest "spowiedzią dla zaawansowanych". Ważne, by nie był to pierwszy napotkany ksiądz, ale by była to osoba, z którą uczestnik dobrze się rozumie i której ufa - najlepiej jeżeli będzie uczestnik formy będzie miał okazję poznać duchownego także prywatnie, nie tylko jako “dostarczyciela sakramentów”.</p>'
  ),


  // Done
  const Konspekt(
    name: 'sznury_funkcje_stopnie',
    title: 'Sznury, funkcje, stopnie ZHP',
    category: KonspektCategory.harcerskie,
    type: KonspektType.zajecia,
    spheres: {
      KonspektSphere.umysl: null,
    },
    metos: [Meto.harc, Meto.hs],
    coverAuthor: 'freepik.com (WangXiNa)',
    author: DANIEL_IWANICKI,
    aims: [
      'Przekazanie wiedzy o funkcjach w ZHP i sposobie ich oznaczenia.',
      'Przekazanie wiedzy o stopniach harcerskich i instruktorskich w ZHP i sposobie ich oznaczenia.',
    ],
    materials: [
      KonspektMaterial(
          name: 'Warcaby (szachownica plus szesnaście pionków + kilka królowych)',
          comment: 'Uwaga: prowadzący musi umieć grać w warcaby!'
      ),


      KonspektMaterial(amount: 2, name: 'Kartka'),
      KonspektMaterial(amount: 2, name: 'Długopis'),
      KonspektMaterial(
          amountAttendantFactor: 2,
          name: 'Jednokolorowe kartki samoprzylepne',
          additionalPreparation: 'Celem jest przygotowanie kartek z nazwami wszystkich stopni harcerskich, które harcerze będą mogli przymocować do czoła tak, by ich nie widzieć lecz by były widoczne dla innych. Należy przygotować osobno zestawy stopni męskich i zestaw stopni damskich.'
              '\n'
              '\nZestawów stopni powinno być tyle, by harcerzy można było podzielić na sześcioosobowe grupy, gdzie każdy otrzyma jeden stopień na swoje czoło. Jeżeli liczba uczestników jest niepodzielna przez sześć, grupy powinny być większe - można wówczas uzupełnić zestawy stopni o trzy gwiazdki zuchowe i/lub dodać próbę harcerza.'
      ),
      KonspektMaterial(amount: 1, name: 'Worek, pudełko lub czapka (coś, by zebrać karteczki do losowania)'),
      KonspektMaterial(amount: 1, name: 'Sznur poczwórnie pleciony do oznaczania funkcji (lub jego zdjęcie)'),
      KonspektMaterial(amount: 1, name: 'Sznur zwykły do oznaczania funkcji (lub jego zdjęcie)'),


      KonspektMaterial(
          amount: 1,
          name: 'Wydrukowany załącznik “sznury”',
          attachmentName: 'sznury',
          additionalPreparation: 'Wydrukowany załącznik należy pociąć w paski zawierające trójki: <i>“funkcja”</i>-<i>”sznur”</i>-<i>”sposób noszenia”</i>. Z każdego paska część <i>“funkcja”</i> powinna zostać odcięta, następnie zgięta tak, by nie było widać jej treści (harcerze będą je losowali). Następnie należy je zebrać w jedno miejsce i pomieszać.'
              '\n'
              '\nPozostałe części pasków (czyli <i>“sznur”</i>-<i>“sposób noszenia”</i>) należy przygotować do rozłożenia na widoku w losowej kolejności na widoku.'
      ),


    ],
    intro: null,
    description: null,
    steps: [
      KonspektStep(
          title: 'Podział na grupy',
          duration: Duration(minutes: 5),
          activeForm: true,
          content: '<p style="text-align:justify;">Harcerze są dzieleni na dwie grupy. Forma podziału jest dowolna (np. wg. zastępów, grając w <a href="atomy@form">atomy</a>).</p>'
      ),


      KonspektStep(
          title: 'Sznury - wywiady z kadrą',
          duration: Duration(minutes: 15),
          activeForm: true,
          required: false,
          content: '<p style="text-align:justify;">Harcerze są informowani, że za chwilę czeka ich wielka gra z wiedzy o funkcjach i sznurach w ZHP. Ich zadaniem jest dowiedzieć się jak najwięcej o sznurach od obecnej na obozie kadry innych drużyn (o ile nie są obecnie zajęci innymi sprawami!). Mogą w tym celu posiłkować się jedynie kartką i długopisem.'
              '<br>'
              '<br>Ich zadaniem jest także się dowiedzieć czym zajmuje się przyboczny, drużynowy i komendant szczepu.</p>'
      ),


      KonspektStep(
          title: 'Sznury - wstęp teoretyczny',
          duration: Duration(minutes: 15),
          activeForm: false,
          required: false,
          content: '<p style="text-align:justify;">Prowadzący, żeby skupić uwagę harcerzy, mówi, że za chwilę harcerze będą podzieleni na grupy i zagrają w “warunkowe warcaby” na podstawie wiedzy z funkcji i sznurów.'
              '<br>'
              '<br>Prowadzący w miarę krótko, od ogółu do szczegółu opowiada jak działa oznaczanie funkcji w ZHP. Ważne by zaznaczył, że nie trzeba posiąść tej wiedzy natychmiast - ona z czasem się utrwali, a teraz stawiają na tej ścieżce pierwszy krok. Oto ogólne zasady:</p>'
              '<ul>'
              '<li>'
              '<p style="text-align:justify;">Każdy poziom struktury ma w ZHP swój kolor:</p>'
              '<ul>'
              '<li><p style="text-align:justify;">Zastępy: <b>brązowy</b></p></li>'
              '<li><p style="text-align:justify;">Drużyna: <b>zielony</b></p></li>'
              '<li><p style="text-align:justify;">Szczep: <b>granatowy</b></p></li>'
              '<li><p style="text-align:justify;">Związek drużyn: <b>granatowo-srebrny</b></p></li>'
              '<li><p style="text-align:justify;">Hufiec: <b>srebrny</b></p></li>'
              '<li><p style="text-align:justify;">Chorągiew: <b>złoty</b></p></li>'
              '<li><p style="text-align:justify;">Poziom centralny: <b>skórzany</b></p></li>'
              '</ul>'
              '<br>'
              '</li>'
              '<li>'
              '<p style="text-align:justify;"><b>Związek drużyn</b> jest jak szczep, tyle że nie musi zapewniać ciągu wychowawczego (Z, H, HS, W).</p>'
              '</li>'
              '<li>'
              '<p style="text-align:justify;">Sznury z ramienia oznaczają kogoś ważniejszego niż spod ramienia. Prowadzący pokazuje na sznurach jak się nosi spod ramienia, jak się nosi sznur z ramienia i jak wygląda sznur poczwórnie pleciony.</p>'
              '<li>'
              '<li>'
              '<p style="text-align:justify;">Różne ważności funkcji we wszystkich poziomach (poza zastępem i drużyną) mają następujące oznaczenia:</p>'
              '<ul>'
              '<li><p style="text-align:justify;">Szef (naczelnik, komendant): <b>poczwórnie pleciony z ramienia</b></p></li>'
              '<li><p style="text-align:justify;">Zastępca szefa i skarbnik: <b>z ramienia zwykły i dwa suwaki</b></p></li>'
              '<li><p style="text-align:justify;">Człon. komendy: <b>spod ramienia, dwa suwaki (w szczepie jeden suwak)</b></p></li>'
              '<li><p style="text-align:justify;">Funkcyjny: <b>sznur funkcji podstawowej i jeden suwak</b></p></li>'
              '</ul>'
              '<br>'
              '</li>'
              '<li>'
              '<p style="text-align:justify;">Na poziomie centralnym jest podział kompetencji: <b>Rada Naczelna</b> ustala sposób działania, <b>Główna Kwatera</b> działa zgodnie z ustalonym sposobem (to jakby jedna osoba ustalała listę zakupów, a druga szła na zakupy). Szefem RN jest <b>Przewodniczący ZHP</b> i ma skórzany sznur z ramienia, a szefem GK jest <b>Naczelnik ZHP</b> i ma sznur zgodnie ze wcześniej podanymi zasadami.</p>'
              '</li>'
              '</ul>'
              '<p style="text-align:justify;">Warto poprosić harcerzy, by powtórzyli podstawowe, przekazane właśnie zasady.</p>'
      ),


      KonspektStep(
          title: 'Przyporządkowywanie sznurów do funkcji - warunkowe warcaby',
          duration: Duration(minutes: 45),
          activeForm: false,
          content: '<p style="text-align:justify;">Prowadzący korzystając z załącznika <a href="sznury@attachment">sznury</a> zbiera przygotowane kartki z funkcjami w jedno miejsce (np. do worka, czapki, etc.) z którego harcerze będa je naprzemiennie losowali.'
              '<br>'
              '<br>Pozostałe części pasków (czyli <i>“sznur”</i>-<i>”sposób noszenia”</i>) prowadzący układa w losowej kolejności na widoku jeden pod drugim. Zadaniem harcerzy będzie naprzemienne losowanie funkcji i próba odnalezienia z puli kartek ze sznurami odpowiadającego im sznura wraz ze sposobem noszenia. Gdy poprawnie przyporządkują sznur do funkcji, zabierają obie części kartki do siebie. Jeżeli się pomylą, funkcja wraca do puli losowania, a sznur do puli sznurów.'
              '<br>'
              '<br>Zadanie odbywa się w formie rozgrywki partii <a href="warcaby_warunkowe@form">warcabów warunkowych</a> między obiema grupami. W formie tej grupy między sobą rozgrywają partię warcabów, w których ruch mogą wykonać tylko, jeżeli poprawnie przyporządkowuje wylosowaną funkcję do sznura i sposobu jego noszenia. Wygrywa grupa, która pokona przeciwnika, lub w przypadku wyczerpania puli funkcji będzie miała więcej pionków na planszy.'
              '<br>'
              '<br>Formę można utrudnić dodając do puli sznurów i sposobów ich noszenia kombinacje nie mające żadnego odpowiednika w funkcjach, np. <i>“sznur złoty z dwoma pomarańczowymi suwakami”</i>. Nieistniejące kombinacje można znaleźć w załączniku <a href="nieistniejace_sznury@attachment">nieistniejące sznury</a>.</p>'
      ),


      KonspektStep(
          title: 'Uszeregowanie męskich stopni harcerskich - milcząca, pół-widoczna kolejność',
          duration: Duration(minutes: 5),
          activeForm: true,
          content: '<p style="text-align:justify;">Harcerze są dzieleni na grupy po 6 osób (tyle, ile jest stopni harcerskich). Jeżeli harcerzy jest za mało na dwie grupy, wszyscy powinni być w jednej grupie.'
              '<br>'
              '<br>Od tej chwili harcerze nie mogą się do siebie odzywać. Prowadzący każdej osobie w każdym zespole nakleja na czoło kartkę z nazwą innego męskiego stopnia harcerskiego. Jeżeli liczba uczestników nie pozwala ich podzielić na sześcioosobowe grupy, należy względnie po równo zwiększyć liczebność grup i uzupełnić pulę kartek o nazwy gwiazdek zuchowych i/lub kartkę “próba harcerza”.'
              '<br>'
              '<br>Grupy powinny być od siebie odizolowane (nie powinny widzieć wzajemnie kartek na swoich czołach). Na polecenie prowadzącego osoby w każdej grupie powinny się bez słowa uszeregować od najmłodszego stopnia do najstarszego.'
              '<br>'
              '<br>Gdy każda grupa skończy się ustawiać, prowadzący pyta każdego co według niego ma na swoim czole. Następnie przykleja (zachowując kolejność) ich kartki na wspólną przestrzeń na podłodze i ze wszystkim uczestnikami omawia wyniki i ocenia ich prawidłowość.</p>'
      ),


      KonspektStep(
          title: 'Uszeregowanie żeńskich stopni harcerskich - milcząca, pół-widoczna kolejność',
          duration: Duration(minutes: 5),
          activeForm: true,
          content: '<p style="text-align:justify;">Prowadzący powtarza poprzednią formę, tym razem ze stopniami żeńskimi.</p>'
      ),


      KonspektStep(
          title: 'Stopnie męskie i damskie - memory',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">Prowadzący zbiera wszystkie kartki ze stopniami. Zostawia po jednej kartce z każdego stopnia (zarówno męskiego jak i żeńskiego), pozostałe wyrzuca. Tasuje kartki i rozkłada je wierzchem do góry na podłodze. Dzieli harcerzy na dwie grupy (można powtórzyć poprzedni podział) i harcerze grają w memory - zebrać parę mogą tylko, gdy połączą stopień męski i odpowiadający im stopień żeński.'
              '<br>'
              '<br>Jeżeli uczestników jest więcej niż 12, można podzielić ich na grupy i zagrać w memory w mniejszych grupach.</p>'
      ),


      KonspektStep(
          title: 'Stopnie instruktorskie - tak-nie',
          duration: Duration(minutes: 15),
          activeForm: true,
          content: '<p style="text-align:justify;">Harcerze są dzieleni na dwie grupy (można powtórzyć poprzedni podział). Grupy ustawiają się w dwóch kolumnach równolegle obok siebie. Kilka metrów przed nimi prowadzący ustawia dwa przedmioty: przedmiot symbolizujący “tak” oraz drugi symbolizujący “nie”.'
              '<br>'
              '<br>Prowadzący zadaje kolejne pytania z załącznika <a href="stopnie_instruktorskie_pytania@attachment">stopnie instruktorskie pytania</a> obu grupom. Po zadaniu pytania osoby na czele każdej z kolumn biegną jak najszybciej do przedmiotów “tak” i “nie” i podnoszą ten, który według nich jest odpowiedzią na zadane pytanie (jeżeli grupa A podniesie przedmiot “tak”, grupa B może już wybrać tylko “nie”). Następnie prowadzący udziela głośno odpowiedzi na zadane pytanie, ewentualnie omawia jego szczegóły.'
              '<br>'
              '<br>Wygrywa grupa, która udzieli najwięcej poprawnych odpowiedzi.</p>'
      ),


    ],
    attachments: [
      KonspektAttachment(
        name: 'sznury',
        title: 'Sznury',
        assets: {
          KonspektAttachmentFormat.pdf: 'sznury.pdf',
          KonspektAttachmentFormat.docx: 'sznury.docx',
        },
      ),
      KonspektAttachment(
          name: 'nieistniejace_sznury',
          title: 'Nieistniejące sznury',
          assets: {
            KonspektAttachmentFormat.pdf: 'nieistniejace_sznury.pdf',
            KonspektAttachmentFormat.docx: 'nieistniejace_sznury.docx',
          }
      ),
      KonspektAttachment(
          name: 'stopnie_instruktorskie_pytania',
          title: 'Stopnie instruktorskie - pytania',
          assets: {
            KonspektAttachmentFormat.pdf: 'stopnie_instruktorskie_pytania.pdf',
            KonspektAttachmentFormat.docx: 'stopnie_instruktorskie_pytania.docx',
          }
      ),
    ],
  ),


  // Done
  const Konspekt(
      name: 'warta_nocna',
      title: 'Warta nocna',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha, KonspektSphereMechanism.duchKsztaltowanieUwaznosci]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      aims: [
        'Kształtowanie u uczestników hartu ducha poprzez wstawanie w nocy na wartę, walkę z sennością, wartowaniem w chłodnej temperaturze',
        'Kształtowanie uważności uczestników poprzez spędzenie czasu w ciszy, w izolacji od bodźców dnia codziennego'
      ],
      description: '<p style="text-align:justify;">Harcerze w dwuosobowych grupach podczas formy wyjazdowej pełnią wartę na terenie obozowania w celu zapewnienia bezpieczeństwa śpiącym uczestnikom od zewnętrznych czynników.'
          '<br>'
          '<br>Formę można z korzyścią połączyć z <a href="nocne_podkradanie@konspekt">nocnym podkradaniem</a>.</p>'
  ),


  // Done
  const Konspekt(
      name: 'wedrowka',
      title: 'Wędrówka',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.cialo: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha, KonspektSphereMechanism.duchKsztaltowanieUwaznosci]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      aims: [
        aimHartDuchaWedrowanie,
        aimUmiejetnoscWedrowania,
        'Stworzenie naturalnej okazji do dyskusji na ważne tematy'
      ],
      description: '<p style="text-align:justify;">Prowadzący wyznacza określoną trasę (samemu lub we współudziale uczestników), uczestnicy przygotowują niezbędny ekwipunek potrzebny do marszu i ew. obozowania, po czym uczestnicy wraz z prowadzącym udają się w trasę.'
          '<br>'
          '<br>Forma, jeżeli odbywa się w odpowiednio dostosowanych warunkach, wpływa znakomicie na hart ducha zwłaszcza, jeśli pomimo trudności nie ma możliwości skrócenia trasy, bo celem jest dojście do noclegu. Głównym mechanizmem hartu ducha jest konfrontacja uczestnika z własnymi oporami (takimi jak: zmęczenie, spocenie, dyskomfort termiczny, ciążenie plecaka), które musi przezwyciężyć, by nie znaleźć się w sytuacji dużo trudniejszej niż ta w której jest teraz (perspektywa przedłużenia obecnego stanu bez uzyskania czegokolwiek w zamian).'
          '<br>'
          '<br>Odpowiednio długa wędrówka pozwala także wpaść w swego rodzaju trans, mantrę stawiania kroków i wyciszenia umysłu. W sposób oczywisty wpływa także na rozwój sfery ciała.</p>'
  ),


  // Done
  const Konspekt(
      name: 'wedrowka_bez_zasobow',
      title: 'Wędrówka bez zasobów',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.cialo: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha, KonspektSphereMechanism.duchKsztaltowanieUwaznosci, KonspektSphereMechanism.duchOtwartoscNaLudzi]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (DenisW)',
      author: DANIEL_IWANICKI,
      aims: [
        aimHartDuchaWedrowanie,
        aimUmiejetnoscWedrowania,
        aimPostawaOdpowiedzialnosciZaCzynny,
        aimWlasnaSprawczosc,
        aimOtwartoscNaInterakcje,
      ],
      description: '<p style="text-align:justify;">Wariant <a href="wedrowka@konspekt">Wędrówki</a>.'
          '<br>'
          '<br>Uczestnicy wędrują po terenie zamieszkałym (wsiach, miasteczkach) z ograniczonymi zasobami w celu zmuszenia uczestników do wejścia w interakcję z lokalną społecznością. Cel ów można osiągnąć przykładowo przez zaopatrzenie harcerzy w butelki lub bidony na wodę nie większe niż 0.5l (prowadzący powinien mieć w plecaku większy zapas wody dla uczestników na wszelki wypadek) lub poprzez określenie jedynie celu wędrówki bez zaopatrzenia ich w mapę. Mechanizmy te w sposób naturalny prowadzą uczestników do konieczności proszenia mieszkańców o uzupełnienie wody w pobliskich domach i do pytania o drogę napotykanych po drodze ludzi.</p>'
  ),


  // Done
  const Konspekt(
      name: 'wedrowka_medytacyjna',
      title: 'Wędrówka medytacyjna',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.cialo: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty],
            mechanism: [KonspektSphereMechanism.duchBezposrednia, KonspektSphereMechanism.duchKsztaltowanieUwaznosci]
        )
      },
      metos: [Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (stockgiu)',
      author: DANIEL_IWANICKI,
      aims: [
        'Wyciszenie uczestników i refleksja nad wybranym zagadnieniem'
      ],
      description: '<p style="text-align:justify;">Harcerze wybierają lub otrzymują jakiś temat do przemyślenia (np. “z jakiego powodu i po co są harcerzami”, “co by zrobili w jakimś przypadku”, “kim jest dla nich Bóg”), fragment rozważania lub Pisma Świętego i wybierają się na całodniową wędrówkę. Forma realizowana jest pojedynczo, trasa powinna zapewniać ciszę i możliwą minimalizację kontaków z ludźmi. Po powrocie harcerze mogą, ale nie muszą opowiedzieć o swoich przemyśleniach i wnioskach np. drużynowemu, opiekunowi próby, zastępowi lub całej drużynie.</p>'
  ),


  // Done
  const Konspekt(
      name: 'wieczorne_przeprosiny_i_podziekowania',
      title: 'Wieczorne przeprosiny i podziękowania',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zwyczaj,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchWartosci, KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchNormalizacja, KonspektSphereMechanism.duchWartoscWtorna, KonspektSphereMechanism.duchOtwartoscNaLudzi]
        ),
        KonspektSphere.relacje: null,
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: '',
      author: DANIEL_IWANICKI,
      aims: [
        'Kształtowanie u uczestników postawy wdzięczności',
        'Kształtowanie u uczestników postawy przepraszania',
        'Kształtowanie u uczestników postawy przebaczania',
        'Kształtowanie u uczestników wartości życia w zgodzie',
        'Kształtowanie u uczestników wartości odpuszczania win',
        'Kształtowanie u uczestników wartości rozmowy o relacjach z bliskimi ludźmi'
      ],
      description: '<p style="text-align:justify;">Podczas formy wyjazdowej pod koniec każdego dnia (np. po obrzędowym zakończeniu dnia w kręgu) wszyscy zostają jeszcze na chwilę na wspólnej przestrzeni (np. na placu apelowym). Każda osoba może w tym czasie podejść do wybranych osób i podziękować im za coś, co się tego dnia działo lub za coś przeprosić. Ważne jest, by uczestnictwo w tej formie zawsze pozostawiać dobrowolnym.</p>',
      howToFail: [
        'Uczynić formę obowiązkową, np. "każdy musi podejść do min. jednej osoby"',
      ]
  ),


  // Done
  const Konspekt(
      name: 'wlasny_nagrobek',
      title: 'Własny nagrobek',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchAksjomaty, KonspektSphereLevel.duchWartosci],
            mechanism: [KonspektSphereMechanism.duchBezposrednia]
        )
      },
      metos: [Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (vecstock)',
      author: DANIEL_IWANICKI,
      aims: [
        'Refleksja uczestników nad sensem i celem własnego życia',
        'Refleksja uczestników nad hierarchia wartości w perspektywie własnej śmierci',
        'Refleksja uczestników nad spójnością między celem własnego życia i jego obecnym kształtem',
      ],
      materials: [
        KonspektMaterial(
            name: 'Materiały na nagrobki (deski, gwoździe, pineski, kartony, kartki, nożyczki, klej, brokat, długopisy, markery, itp.',
            amount: 0
        )
      ],
      summary: 'Uczestnicy wykonują z dostępnych materiałów dwa modele własnych nagrobków - pierwszy to taki, jakby chcieliby by podsumowywał ich życie, drugi to taki, który uważają, że teraz by im postawiono, gdyby umarli jutro.',
      steps: [

        KonspektStep(
            title: 'Wprowadzenie - nagrobek idealny',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący wprowadza uczestników w cel pierwszej części zadania - mają zaprojektować i zbudować nagrobek, który chcieliby by im postawiono na końcu życia.'
                '<br>'
                '<br>Prowadzący informuje uczestników, że na końcu zajęć każdy będzie mógł opowiedzieć o swoim nagrobku idealnym - jeśli tylko będzie chciał.</p>'
        ),


        KonspektStep(
            title: 'Rozdanie materiałów',
            duration: Duration(minutes: 10),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący rozdaje uczestnikom materiały, z których będą budowali nagrobki. Część materiałów warto zostawić na środku, tak by były dostępne dla tych, którzy będą potrzebowali ich więcej.'
                '<br>'
                '<br>Prowadzący informuje uczestników, że na przemyślenie i stworzenie nagrobka będą mieli 60 minut.</p>'
        ),


        KonspektStep(
            title: 'Projektowanie i budowanie nagrobka idealnego',
            duration: Duration(minutes: 60),
            activeForm: true,
            content: '<p style="text-align:justify;">Uczestnicy projektują i budują swój nagrobek idealny.</p>'
        ),


        KonspektStep(
            title: 'Wprowadzenie - nagrobek rzeczywisty',
            duration: Duration(minutes: 5),
            activeForm: false,
            content: '<p style="text-align:justify;">Prowadzący wprowadza uczestników w cel drugiej części zadania - mają zaprojektować i zbudować nagrobek, który sądzą, że postawiono by im, gdyby umarli jutro.'
                '<br>'
                '<br>Ważne, by zawarli w nim te same <b>kategorie informacji</b> (np. imię, lata życia, opis kto ich żegna i jak żyli), które zawarli w nagrobku idealnym.'
                '<br>'
                '<br>Prowadzący informuje uczestników, że nagrobek rzeczywisty tylko dla nich i że nikt nie będzie go podsumowywał, widział ani oceniał.</p>'
        ),


        KonspektStep(
            title: 'Projektowanie i budowanie nagrobka rzeczywistego',
            duration: Duration(minutes: 60),
            activeForm: true,
            content: '<p style="text-align:justify;">Uczestnicy projektują i budują swój nagrobek rzeczywisty.</p>'
        ),


        KonspektStep(
            title: 'Podsumowanie nagrobków idealnych',
            duration: Duration(minutes: 20),
            activeForm: false,
            content: '<p style="text-align:justify;">Uczestnicy wspólnie z prowadzącym podsumowują swoje nagrobki idealne. Nie ma konieczności prezentowania swojego przygotowanego nagrobka.</p>'
        ),


      ]
  ),


  // Done
  const Konspekt(
      name: 'wspolna_minuta_czosnku',
      title: 'Wspólna minuta czosnku',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.cialo: null,
        KonspektSphere.relacje: null,
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchWartosci, KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha, KonspektSphereMechanism.duchOtwartoscNaLudzi]
        )
      },
      metos: [Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (frimufilms)',
      author: DANIEL_IWANICKI,
      customDuration: Duration(minutes: 1),
      aims: [
        'Kształtowanie u uczestników hartu ducha poprzez nieprzyjemne praktyki',
        'Kształtowanie u uczestników wartości funkcjonowania we wspólnocie poprzez wspólny trud',
        'Stwarzanie prowadzącemu okazji do wyśmiania alkoholu',
        'Kształtowanie u uczestników postaw dbania o zdrowie',
      ],
      description: '<p style="text-align:justify;">Grupa osób bierze po ząbku czosnku i staje w kręgu. Na dany znak wszyscy zaczynają jeść ząbek czosnku (rozgryzając go), jednak przełknąć i popić go można dopiero po minucie. Przegrywają Ci, którzy przełkną czosnek wcześniej. Ponieważ jest to forma wspólnego trudu, kształtuje też wartości związane ze wspólnotą.'
          '<br>'
          '<br>Jeśli prowadzący uzna to za stosowne, a uczestnicy są odpowiednio duzi (ok, 15+), może w ten sposób naturalnie skomentować podobieństwo jedzenia czosnku do picia wódki - oba pieką, oba trzeba popić, oba dezynfekują, ale jeden wzmacnia odporność, a drugi niszczy wątrobę i mózg.'
          '<br>'
          '<br>Formę można przeprowadzać <b>maksymalnie</b> raz dziennie - więcej niż jeden ząbek czosnku na dobrę może podrażnić żołądek.</p>'
  ),


  // Done
  const Konspekt(
      name: 'zagadki_matematyczno_logiczne',
      title: 'Zagadki matematno-logiczne',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zwyczaj,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchWartosci],
            mechanism: [KonspektSphereMechanism.duchWartoscWtorna]
        )
      },
      metos: [Meto.hs, Meto.wedro],
      coverAuthor: 'Freepik (hamimfadillah)',
      author: DANIEL_IWANICKI,
      customDuration: Duration(minutes: 90),
      aims: [
        'Ksztaltowanie u uczestników szacunku dla wiedzy i logicznego myślenia'
      ],
      description: '<p style="text-align:justify;">'
          'Prowadzący formę regularnie (np. codziennie na apelu na obozie) przedstawia uczestnikom jedną zagadkę matematyczną, która jest w zasięgu ich możliwości intelektualnych, np:'
          '</p>'

          '<ul>'

          '<li>'
          '<p style="text-align:justify;">'
          '<i>“O magicznym kamieniu wiadomo tylko tyle, że waży on kilogram oraz pół magicznego kamienia.'
          '<br>Ile kilogramów waży magiczny kamień?”.</i>'
          '</p>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<i>Pewien brat mówi o swoim młodszym bracie: „Dwa lata temu byłem trzy razy starszy od mojego brata. Za trzy lata będę dwa razy starszy od mojego brata”.'
          '<br>Ile mają teraz lat?</i>'
          '</p>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<i>Dlaczego dźwięk nadjeżdżającego pociągu szybciej niesie się po torach niż w powietrzu?</i>'
          '</p>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<i>Jeśli półtora kury zniesie półtora jajka w ciągu półtora dnia, ile jaj zniesie pół tuzina kur w ciągu pół tuzina dni?</i>'
          '</p>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<i>Mamy kłódkę zamykaną na 3-cyfrowy szyfr. Musimy znaleźć jej kod. O kodzie wiadomo tylko, że:</i>'
          '</p>'
          '<ul>'

          '<li>'
          '<p style="text-align:justify;">'
          '<i>276 – jedna cyfra jest poprawna, ale w niewłaściwym miejscu.</i>'
          '</p>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<i>387 – żadna cyfra nie jest właściwa.</i>'
          '</p>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<i>368 – jedna cyfra jest właściwa i znajduje się we właściwym miejscu.</i>'
          '</p>'
          '</li>'

          '<li>'
          '<p style="text-align:justify;">'
          '<i>471 – dwie liczby są poprawne, ale znajdują się w niewłaściwym miejscu.</i>'
          '</p>'
          '</li>'

          '</ul>'

          '</li>'

          '<li>'
          '<p style="text-align:justify;"><i>Sześcienna kostka została rzucona jeden raz.'
          '<br>Jakie jest prawdopodobieństwo, że wyrzucona cyfra będzie parzysta i większa niż 2?</i></p>'
          '</li>'

          '</ul>'

          '<p style="text-align:justify;">'
          'Forma ta jest przykładem zjawiska wpływu sfer funkcjonalnych na sferę ducha przy udziale wartości wtórnych - uczestnicy będą mieli tendencję, by z czasem uznać umiejętność logicznego myślenia za ważną, ponieważ będą ją dobrze umieli. W ślad za tym pójdą zaś szacunek do nauki, krytycznego myślenia, itd..'
          '</p>'
  ),


  // Done
  const Konspekt(
      name: 'zakwaterowanie_pod_namiotem',
      title: 'Zakwaterowanie pod namiotem',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zwyczaj,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha, KonspektSphereMechanism.duchOtwartoscNaLudzi]
        )
      },
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      aims: [
        'Kształtowanie u uczestników hartu ducha poprzez funkcjonowanie w warunkach obniżonego komfortu',
        'Budowanie u uczestników wspólnoty poprzez codzienne funkcjonowanie na ograniczonej przestrzeni'
      ],
      description: '<p style="text-align:justify;">Głównym źródłem skuteczności formy jest funkcjonowanie uczestników w warunkach obniżonego komfortu: brak możliwości ogrzania namiotu, brak dobrego światła w namiocie, brak całkowitej izolacji od warunków atmosferycznych (głównie deszczu i upału), obecność robaczków, komarów, pająków, wszechobecność ściółki i kurzu, konieczność korzystania z zewnętrznej latryny, ograniczona przestrzeń na rzeczy w namiocie i brak możliwości całkowitego odizolowania się od pozostałych mieszkańców namiotu.</p>'
  ),


  // ! Done
  const Konspekt(
      name: 'zimowiskowe_apele_przed_osrodkiem',
      title: 'Zimowiskowe apele przed ośrodkiem',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zwyczaj,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchHartDucha]
        )
      },
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      aims: [
        aimHartDuchaZimno
      ],
      description: '<p style="text-align:justify;">Podczas zimowej formy wyjazdowej (obóz lub zimowisko) drużyna codziennie przeprowadza apele na zewnątrz na śniegu. Ponadto w bardzo czytelny sposób obrazuje harcerzom dlaczego dyscyplina jest ważna - jeżeli nie chcą marznąć, muszą sprawnie działać.'
          '<br>'
          '<br>Warto także rozważyć prowadzenie apelu bez kurtek z widocznym mundurem, jeśli mróz nie jest za duży.</p>'
  ),


  // Done
  const Konspekt(
      name: 'zwiad_lokalnej_spolecznosci',
      title: 'Zwiad lokalnej społeczności',
      category: KonspektCategory.harcerskie,
      type: KonspektType.zajecia,
      spheres: {
        KonspektSphere.duch: KonspektSphereDetails(
            level: [KonspektSphereLevel.duchPostawy],
            mechanism: [KonspektSphereMechanism.duchOtwartoscNaLudzi]
        )
      },
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      coverAuthor: 'Daniel Iwanicki',
      author: DANIEL_IWANICKI,
      customDuration: Duration(hours: 5),
      aims: [
        'Kształtowanie u uczestników otwartości na kontakt z drugim człowiekiem',
        aimSzacunekDlaSkutecznegoDzialania
      ],
      description: '<p style="text-align:justify;">Harcerze w zastępach otrzymują zadanie, by rozpoznać okolicę biwaku lub obozu i zebrać informacje na temat ciekawych, przydatnych lub ważnych miejsc w najbliższym otoczeniu.'
          '<br>'
          '<br>Jednocześnie harcerze mają za zadanie zrealizowanie szeregu zadań związanych z lepszym poznaniem lokalnej społeczności. Przykładowe zadania służące temu celowi to:</p>'
          '<ul>'
          '<li><p style="text-align:justify;">Poproście o trzy osoby, żeby zrobiły sobie z Wami zdjęcie pod dowolnym pomnikiem i żeby wysłały je na maila drużynowego</p></li>'
          '<li><p style="text-align:justify;">Dowiedzcie się, jaka jest najciekawsza historia związana z parafią według jednego z księży</p></li>'
          '<li><p style="text-align:justify;">Ustalcie, ile kosztuje najtańsza woda gazowana w mieście</p></li>'
          '<li><p style="text-align:justify;">Dowiedzcie się, w którym roku założone zostało miasto</p></li>'
          '</ul>'
          '<p style="text-align:justify;">Zwiad może być uzupełniony o konkretne zadania lub pytania, na które harcerze podczas wyprawy muszą znaleźć odpowiedzi lub które muszą wykonać.'
          '<br>'
          '<br>Harcerze mogą otrzymać na początku mapę okolicy na której powinni uzupełnić punkty. Mogą także, w trudniejszym, wariancie otrzymać pustą kartkę, na której mapę powinni narysować od podstaw.</p>'
  ),


];

