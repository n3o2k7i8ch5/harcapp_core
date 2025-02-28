import 'package:harcapp_core/harcthought/konspekts/data/common.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common_attachments.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

KonspektMaterial material_mini_kartki_biurowe = KonspektMaterial(
  name: 'Mini kartki biurowe (ok. 10x10 cm)',
  amountAttendantFactor: 3,
);

KonspektMaterial material_zal_poziomy_duchowosci = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_poziomy_duchowosci”',
    attachmentName: attach_name_poziomy_duchowosci,
    amount: 1
);

KonspektMaterial material_flipchart = KonspektMaterial(
  name: 'Duży arkusz papieru (flipchart)',
  amount: 1,
);

KonspektMaterial material_marker = KonspektMaterial(
  name: 'Marker',
  amount: 5,
);

KonspektMaterial material_zal_neutralnosc_duchowa_przyklady = KonspektMaterial(
  name: 'Wydrukowany załącznik “$attach_title_neutralnosc_duchowa_przyklady”',
  attachmentName: attach_name_neutralnosc_duchowa_przyklady,
  amount: 1
);

KonspektMaterial material_zal_cel_wychowania_duchowego_zhp_statut = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_cel_wychowania_duchowego_zhp_statut”',
    attachmentName: attach_name_cel_wychowania_duchowego_zhp_statut,
    amount: 4
);

KonspektMaterial material_zal_cel_wychowania_duchowego_zhp_uchwala = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_cel_wychowania_duchowego_zhp_uchwala”',
    attachmentName: attach_name_cel_wychowania_duchowego_zhp_uchwala,
    amount: 4
);

// ---

String aksjomaty_przyklady = '<ul>'
    '<li><p style="text-align:justify;">“Świat stworzył przypadek. Świadomość człowieka jest iluzją fizyki, nie ma żadnego celu.”</p></li>'
    '<li><p style="text-align:justify;">“Świat stworzyła wróżka. Ludzie są powiewami meta-powietrza jej tchnienia. Po śmierci człowiek może również stać się wróżką, jeśli wchłonie odpowiednio dużo energii wszechświata poprzez medytację.”</p></li>'
    '<li><p style="text-align:justify;">“Wszystko jest iluzją. Istnieję tylko ja, reszta to zaprogramowane postaci w mojej głowie. Iluzja ta pryśnie, jeśli wszyscy ludzie uwierzą, że w niej żyją.”</p></li>'
    '<li><p style="text-align:justify;">“Świat stworzył trójjedyny Bóg, powołał człowieka na swój obraz, by doświadczył miłości.”</p></li>'
    '</ul>';

KonspektStep step_sfery_rozwoju_i_ich_relacje = KonspektStep(
    title: 'Sfery rozwoju i ich relacje',
    duration: Duration(minutes: 15),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący na podstawie poradnika $attach_html_o_strukturze_duchowosci wprowadza podział człowieka na 5 sfer rozwoju - 4 sfery funkcjonalne: <b>ciało</b>, <b>umysł</b>, <b>emocje</b>, <b>relacje</b> i jedną sferę centralną: sferę <b>ducha</b>.'
        '<br>'
        '<br>Prowadzący opisuje zależności między sferami - sfery funkcjonalne dostarczają człowiekowi <b>zdolności</b>, zaś sfera ducha jest <b>sposobem</b> ich zarządzania.'
        '<br>'
        '<br>Jeżeli prowadzący uzna, że poprawi to poziom zrozumienia, może skorzystać z analogii opisanej sfer funkcjonalnych i centralnych do samochodu i kierowcy opisanego w załączniku $attach_html_o_strukturze_duchowosci.'
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
);

KonspektStep step_poziomy_duchowosci = KonspektStep(
    title: 'Poziomy (warstwy) rozwoju duchowego',
    duration: Duration(minutes: 15),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący na podstawie pradnika $attach_html_o_strukturze_duchowosci wprowadza rozróżnienie poziomów duchowości kolejno na poziom <b>aksjomatu</b>, poziom <b>wartości</b>, poziom <b>postaw</b> i poziom <b>zachowań</b> (kolejność definiowania jest ważna). Każdorazowo po zdefiniowaniu określonego poziomu duchowości prowadzący kładzie w widocznym miejscu kartkę z nazwą poziomu duchowości i jego hasłową definicją z załącznika $attach_html_poziomy_duchowosci. Dzięki temu uczestnicy mogą zawsze wrócić podczas warsztatów do definicji poziomu duchowości.'
        '<br>'
        '<br>Dodatkowo prowadzący definiuje duchowość <b>wymierną</b> (poziom zachowań i postaw) i <b>głęboką</b> (poziom wartości i aksjomatów).'
        '<br>'
        '<br>Prowadzący powinien wyraźnie zaznaczyć, że “poziom duchowości” nie odnosi się do słowa “poziom” w sensie poziomu zaawansowania, np. poziom w grze komputerowej, ale poziomu w sensie warstwy, piętra, hierarchii etc..'
        '<br>'
        '<br>Prowadzący może w procesie definiowania posiłkować się przykładem:'
        '</p>'

        '<table border="1" style="border-collapse: collapse; width: 100%;">'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Zachowanie</p></td>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Oddanie własnego obiadu bezdomnemu</p></td>'
        '</tr>'
        '<tr>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Postawa</p></td>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Ofiarność</p></td>'
        '</tr>'
        '<tr>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Wartość</p></td>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Godne życie każdego człowieka</p></td>'
        '</tr>'
        '<tr>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Aksjomat</p></td>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Bóg z miłości stworzył każdego człowieka na swój obraz</p></td>'
        '</tr>'
        '</table>'

        '<p style="text-align:justify;">'
        'Po zdefiniowaniu poziomów prowadzący prosi uczestników o podanie kilku przykładowych elementów do każdego z poziomów duchowości. Prowadzący każdorazowo ocenia, czy przykłady są trafne - jeśli nie, podaje powód, dla którego nie są.'
        '<br>'
        '<br><u>Uwagi o wartościach:</u>'
        '</p>'

        '<ul>'

        '<li>'
        '<p style="text-align:justify;">'
        'Stwierdzenie pokroju: <i>“dla mnie wartością jest czytanie książek swoim dzieciom”</i> w istocie nie jest deklaracją wartości, a oceną słuszności czynu. Wartością jest stan, do którego ów czyn prowadzi. <i>“Warto czytać książki dzieciom, bo zacieśnia to więzi w rodzinie”</i> - zatem wartością w tym przypadku jest stan trwania bliskich relacji rodzinnych.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        'Potoczne określenie <i>“wartością jest dla mnie rodzina”</i> nie jest deklaracją wartości, bowiem nie określa preferowanego stanu z nią związanego: czy chodzi o posiadanie rodziny, o jej majętność, długowieczność, szczęście, dużą liczebność, poczucie przyjemności członków rodziny? W sposób domyślny podanie jedynie przedmiotu wartości oznacza: <i>“w staraniach o preferowany stan rzeczywistości wynikający z moich aksjomatów, najbardziej interesuje mnie poprawa fragmentu rzeczywistości związana z moją rodziną”</i>.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        'Wartości nie muszą być wcale przemyślane, górnolotne i głębokie. Chwilowo człowiek może jako preferowany stan określić stan przyjemności wynikający ze zjedzenia cukierka, zaśnięcie, czy euforię po kupieniu nowych ciuchów.'
        '<br>'
        '<br>To także są wartości wpisane w strukturę wartości człowieka.'
        '</p>'
        '</li>'

        '</ul>',
    materials: [
      material_zal_poziomy_duchowosci,
    ]

);

KonspektStep step_poziomy_duchowosci_aksjomat = KonspektStep(
  title: 'Poziomy (warstwy) rozwoju duchowego - aksjomat',
  duration: Duration(minutes: 5),
  activeForm: false,
  content: '<p style="text-align:justify;">'
      'Poziom zachowań, postaw i wartości są dla większości osób zrozumiałe, jednak poziom aksjomatu może być nieintuicyjny. Z tego względu, po zdefiniowaniu wszystkich czterech poziomów duchowości, prowadzący zatrzymuje się dłużej nad aksjomatami.'
      '<br>'
      '<br>Prowadzący podaje kilka przykładów aksjomatów, np.:'
      '</p>'

      '$aksjomaty_przyklady'

      '<p style="text-align:justify;">'
      '<b>Aksjomat zawsze jest pewną fundamentalną niesprawdzalną wiarą</b> w określony porządek rzeczy.'
      '<br>'
      '<br><b>Aksjomaty całkowicie porządkują postrzeganie rzeczywistości</b>. Aby to zobrazować, prowadzący może posłużyć się przykładem:'
      '<br>'
      '<br><i>"Jeśli ktoś wierzy, że Ziemia jest płaska, to wszystko inne podporządkuje pod to założenie. Również, jeśli ów człowiek zobaczy dowód na kulistość Ziemi, to wniosek będzie miał tylko jeden: narzędzia użyte przy tych dowodach były wadliwe.'
      '<br>'
      '<br>Czy to powinno zaskakiwać? Przecież my, gdy nam przedstawiono nagranie, że księżyc jest jedynie wyświetlanym hologramem, też uznalibyśmy, że to nagranie musi być błędne. Nie zakładalibyśmy, że cała nauka się pomyliła - a przecież nauka mogła się pomylić, my jedynie wierzymy, że ona dobrze opisuje rzeczywistość.".</i>'
      '</p>'
);

KonspektStep step_integracja_duchowosci = KonspektStep(
    title: 'Integracja duchowości',
    duration: Duration(minutes: 15),
    activeForm: false,
    contentBuilder: ({required bool isDark}) => '<p style="text-align:justify;">'
        'Prowadzący na podstawie poradnika $attach_html_o_strukturze_duchowosci opisuje <b>etapy rozwoju duchowego</b>:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Do 9. roku życia dzieci są zdolne rozumieć jedynie właściwe <b>zachowania</b>, na podstawie których kregują swoje <b>postawy</b>.</p></li>'
        '<li><p style="text-align:justify;">W wieku ok. 10 lat pojawia się zdolność myślenia abstrakcyjnego. Człowiek zaczyna wówczas rozumieć, że zachowania wynikają z pewnej abstrakcyjnej zasady którą są <b>wartości</b>. Nie trzeba wtedy już mówić: "przywitaj się grzecznie i podziękuj", można zamiast tego powiedzieć: "odnoś się z szacunkiem".</p></li>'
        '<li><p style="text-align:justify;">W wieku ok. 15 lat są wartości porządkowane w światopogląd i internalizowane jest pojęcie <b>aksjomatu</b>. Pojawia się zrozumienie, że różni ludzie mogą mieć różny światopogląd i czerpać swoje wartości z różnych źródeł.</p></li>'
        '</ul>'

        '<p style="text-align:justify;">'
        'Prowadzący opisując przejście między kolejnymi etapami rozwoju duchowego rysuje kolejno piętra piramidy na flipcharcie, tak jak poniżej:'
        '<br>${piramidaDuchowosciHtml(isDark: isDark)}'
        '<br>'
        '<br>Następnie prowadzący opisuje zjawisko <b>integracji duchowości</b>, czyli sposobu w jaki kształtowana jest duchowość człowieka:'
        '<br>'
        '<br><i>Jeżeli młody człowiek w wieku 10 lat zacznie rozumieć, że jego zachowania powinny wynikać z określonych wartości, zazwyczaj orientuje się, że niektóre z jego dotychczasowych zachowań były niezgodne z jego wartościami i zaczyna je zmieniać. Zmiana zachowań sprawia, że zaczyna inaczej funkcjonować - zaczyna inaczej doświadczać rzeczywistości, a to weryfikuje przyjętą hierarchię wartości. Nowe wartości wpływają z powrotem na nowe zachowania, zachowania na wartości i tak w kółko.'
        '<br>'
        '<br>Rozwoju duchowego nie należy postrzegać jako budowanie kolejnych pięter. Rozwój duchowy polega na <b>integracji</b> i uspójnianiu między sobą kolejnych pięter duchowości.'
        '<br>'
        '<br>Podobnie rzecz się ma w przypadku przejścia z poziomu wartości na poziomem aksjomatu - gdy człowiek w pełni zrozumie, że musi opierzeć swoje życie o konkretną, arbitralną wiarę, zaczyna rozumieć, że część jego dotychczasowych poglądów, wartości i zachowań jest z nią niezgodna. Z czasem jego wiara będzie pogłębiana, będzie ewoluowała pod wpływem doświadczeń, co z powrotem będzie rzutować na resztę struktury duchowości.</i>'
        '<br>'
        '<br>Prowadzący, opisując zjawisko integracji duchowości rysuje na flipcharchie z piramidą duchowości strzałkę "integracji wstępnej". Następnie wprowadza rozróżnienie między <b>integracją wstępną</b> a <b>integracją świadomą</b> duchowości:'
        '<br>'
        '<br><i>Do momentu, aż człowiek nie zinternalizowuje pojęcia aksjomatu, jego duchowość jest integrowana "po raz pierwszy". <b>Wartości, które przyjmie będą wynikały z nauczonych zachowań</b>. <b>Aksjomaty, które przyjmie, będą wynikały z wartości</b>, które wyznaje. Kształt duchowości zależy tu przede wszystkim od <b>otoczenia</b> i <b>temperamentu</b> człowieka. Jest to etap "<b>integracji wstępnej</b>".'
        '<br>'
        '<br>Gdy człowiek zaczyna poważnie martwić się pytaniami o sens istnienia i zaczyna rozumieć, że odpowiedzi na te pytania są kluczowe dla jego życia, rozpoczyna etap "<b>integracji świadomej</b>". Zyskuje w pełni świadomość własnej duchowości i staje się zdolny do wpływania na jej kształt. Wciąż jest uwarunkowany czynnikami zewnętrznymi, jednak on sam staje się czynnikiem.</i>'
        '<br>'
        '<br>Prowadzący może zaznaczyć, że rozpoczęcie integracji świadomej łatwo poznać po pytaniach w stylu:'
        '</p>'

        '<ul>'
        '<li><p style="text-align:justify;">“Jaki jest sens życia, o ile w ogóle jakiś jest?”</p></li>'
        '<li><p style="text-align:justify;">“Czy istnieje obiektywne dobro i zło, czy może wszystko jest jedynie subiektywne?”</p></li>'
        '<li><p style="text-align:justify;">“Dlaczego powinienem wierzyć w Boga? Przecież gdybym urodził się w Iranie, wierzyłbym w Allaha?”</p></li>'
        '</ul>'

        '<p style="text-align:justify;">'
        'Na koniec ważne jest, aby prowadzący zaznaczył, że o ile można skutecznie wpływać na wartości, zachowania i postawy młodego człowieka, o tyle wpływ na aksjomat jest już bardziej subtelny. Do aksjomatów można młodego człowieka najwyżej "podprowadzić": owszem, są one kształtowane na podstawie własnych doświadczeń, znanych poglądów i przyjętych uprzednio wartości, jednak przyjąć aksjomat za własny można jedynie samemu, wedle własnego, osobistego przekonania. W tym procesie nie da się komuś towarzyszyć do końca.'
        '</p>',
    materials: [
      material_flipchart,
      material_marker,
    ]
);

KonspektStep step_duchowosc_powszechna_madrosc_kultura_i_tradycja = KonspektStep(
    title: 'Duchowość powszechna, mądrość, kultura i tradycja',
    duration: Duration(minutes: 15),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący na podstawie poradnika $attach_html_o_strukturze_duchowosci opisuje zjawisko <b>duchowości powszechnej</b>, związanej z nią <b>sztafetowością</b> i <b>selekcją naturalną</b>. Następnie definiuje w oparciu o duchowość powszechną pojęcie <b>mądrości</b> oraz jej implementacją i formą przekazu - <b>kulturą</b> i jej elementami - <b>tradycjami</b>. Prowadzący opisuje także zjawisko dualizmu tradycji - z jednej strony jej wiecznego niedoczasu względem rzeczywistości, z drugiej jej funkcji tworzenia norm i przekazywania sprawdzonych rozwiązań nowym pokoleniom.'
        '<br>'
        '<br>Prowadzący może zobrazować dylemat tego <i>"jak ściśle trzymać się tradycji"</i> w sposób następujący:'
        '<br>'
        '<br><i>Gdybyśmy zanegowali na raz wszystkie tradycje, w ciągu jednego pokolenia wrócilibyśmy do jaskiń. Ale gdybyśmy nigdy nie podważyli żadnej tradycji, nigdy z tych jaskiń byśmy nie wyszli.</i>'
        '</p>'
);

KonspektStep step_duchowosc_religia_religijnosc_opinie_uczestnikow = KonspektStep(
    title: 'Duchowość, religia, religijność - opinie uczestników',
    duration: Duration(minutes: 10),
    activeForm: true,
    required: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący zadaje publicznie pytanie:'
        '<br>'
        '<br><b><i>“Jaka jest relacja między duchowością, religią, a religijnością?”</i></b>.'
        '<br>'
        '<br>Uczestnicy indywidualnie przez kilka minut na <b>mini-kartkach</b> zapisują hasłowo swoje odpowiedzi, które potem będą mogli rozwinąć.'
        '<br>'
        '<br>Prowadzący prosi uczestników kolejno o zaprezentowanie po jednej kartce i położeniu jej na środku - prezentacja w kręgu zachodzi dopóki ktoś jeszcze ma jakąś kartkę. Jeśli jakaś myśl została już przedstawiona, nie ma potrzeby jej ponownego rozwijania - można po prostu dołożyć kartkę do już położnej.'
        '</p>',
    materials: [
      material_mini_kartki_biurowe
    ]
);

KonspektStep step_duchowosc_religia_religijnosc = KonspektStep(
    title: 'Duchowość, religia, religijność',
    duration: Duration(minutes: 20),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący na podstawie załącznika $attach_html_o_strukturze_duchowosci definiuje religię:'
        '<br>'
        '<br>Religia jest duchowością powszechną. <b>Religia nie jest “dodatkiem” do duchowości, ale jest określoną duchowością</b> - ma określone aksjomaty i wartości, określone sposoby jej (religii jako duchowość) integracji.'
        '<br>'
        '<br>Prowadzący powinien zwrócić uwagę, że nie ma tu mowy o relacji “zawierania”: <b>w obszernym zbiorze “duchowości” <u>nie zawiera się</u> mniejszy zbiór “religii”</b>! Nie jest tak, że część osób ma duchowość “z religią”, a część “bez religii”. Religia jest rodzajem, sposobem duchowości. Nie można z duchowości “wyjąć” elementu religijnego i dalej mieć do czynienia z duchowością, tak samo jak nie można z psa wyjąć elementu “jamnik” i dalej uważać, że pozostałość to pies. Jamnik nie jest dodatkiem do psa, tylko jest rodzajem całego, spójnego psa.'
        '<br>'
        '<br>Oznacza to, że nie można prowadzenić wychowania w drużynie w oparciu o jedną, wybraną duchowość, i “wzbogacać” jej dla niektórych religią, a dla innych nie. Wynika to z faktu, że jeśli ktoś jest wychowywany w duchowości religijnej, ma określone religijne aksjomaty, co stoi w kontraście do aksjomatów osób niereligijnych! Osobnym pytaniem jest to, czy da się skutecznie wychowywać grupę do dwóch lub więcej zupełnie różnych duchowości'
        '<br>'
        '<br>Podobnie, błędnym jest pogląd jakoby istniała symetria między duchowością osób religijnych i niereligijnych: osoby religijne mają z góry określone aksjomaty, jednak aksjomaty osób niereligijnych dopiero wymagają określenia i doprecyzowania.'
        '<br>'
        '<br><b>Religijność</b> jest zestawem zachowań i postaw wynikających z duchowości religijnej. Religijność nie jest jednak zbiorem wartości, ani całą duchowością - religijność to jedynie wierzchnia warstwa duchowości, która pozwala (lecz sama w sobie niekoniecznie wystarcza) by duchowość religijną skutecznie integrować.'
        '</p>'
);

// Neutralność

KonspektStep step_neutralnosc_duchowa = KonspektStep(
    title: 'Neutralność duchowa',
    duration: Duration(minutes: 30),
    activeForm: false,
    aims: [
      'Zaprezentowanie uczestnikom wartości i postaw (przebaczenie, prawdomówność, pomoc bliźnim, indywidualizm, ew. wierność w związku, modlitwa), które choć pozornie uniwersalne, wcale nie są domyślne, oczywiste, czy neutralne',
      'Przekonanie uczestników, że neutralność światopoglądowa w wychowaniu nie jest możliwa'
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący przedstawia uczestnikom scenariusze z załącznika $attach_html_neutralnosc_duchowa_przyklady. Wszystkie scenariusze opisują sytuacje wychowawcze z udziałem instruktora harcerskiego. Zadaniem uczestników jest określenie:'
        '<br>'
        '<br><u><b>Czy działanie instruktora miało wpływ na duchowość harcerzy?</b> Jeśli tak, to <b>jakie wartości</b> lub postawy działanie instruktora wzmocniło?</u>'
        '<br>'
        '<br>Prowadzący prosi, by uczestnicy nie skupiali się na technikaliach (nie zastanawiali się, czy instruktor zareagował efektywnie), lecz na skutku działań - wpływie na duchowość (np. postawy lub wartości) wychowanków.'
        '<br>'
        '<br>Jeśli uczestników jest więcej niż 20, można podzielić ich na dwie grupy, które równolegle między sobą dyskutują o scenariuszach.'
        '<br>'
        '<br>Gdy wszystkie grupy przedyskutują swoje scenariusze, prowadzący zadaje pytanie:'
        '<br>'
        '<br><b><i>“Czy instruktor mógł zadziałać w sposób, który nie wpłynąłby na duchowość harcerzy?”</i></b>.'
        '<br>'
        '<br><b><i>“Czy w ogóle istnieje neutralność w wychowaniu?”</i></b>.'
        '<br>'
        '<br>W toku próby odpowiedzi na to pytanie może wywiązać się między uczestnikami dyskusja. Nie powinna ona trwać zbyt długo. Scenariusze, które zostały omówione przez uczestników powinny prowadzić do wniosku: w sposób oczywisty harcerskie <b>wychowanie nie jest neutralne duchowo</b>.',
    materials: [
      material_zal_neutralnosc_duchowa_przyklady
    ]

);

KonspektStep step_neutralnosc_duchowa_w_przypadku_problemow = KonspektStep(
    title: 'Neutralność duchowa - w przypadku problemów',
    duration: Duration(minutes: 5),
    activeForm: false,
    required: false,
    content: '<p style="text-align:justify;">'
        '<br>Jeśli uczestnicy nie są przekonani do tego, że neutralność nie jest możliwa, prowadzący może zadać pytanie:'
        '<br>'
        '<br><i>“Czy jeśli harcerz zawsze bije kolegów, którzy się z nim nie zgadzają, a instruktor nie reaguje, to czy postępuje neutralnie?”</i>'
        '<br>'
        '<br>Następnie może zapytać uczestników, jaka reakcja instruktora w tym wypadku była neutralna, po czym zadać pytanie:'
        '<br>'
        '<br><i>“Czy ta reakcja byłaby w istocie neutralna, czy po prostu mieści się w duchowości, którą prywatnie wyznajecie?”</i>'
        '<br>'
        '<br>Jeśli z kolei uczestnicy sądzą, że neutralne jest to, co jest zapisane w Prawie Harcerskim, prowadzący może zadać pytanie:'
        '<br>'
        '<br><i>“Ależ Prawo Harcerskie zmienia się pod wpływem poglądów Rady Naczelnej, poza tym skąd pomysł, że zasady jakiejś niewielkiej organizacyjki wychowawczej, z której wartościami nie wszyscy się w Polsce zgadzają, są prawdziwie neutralne?”</i>'
        '</p>'
);

KonspektStep step_harcerstwo_analogia_do_ogrodnikow = KonspektStep(
    title: 'Neutralność duchowa - analogia harcerstwa z ogrodnikami',
    duration: Duration(minutes: 5),
    activeForm: false,
    required: false,
    content: '<p style="text-align:justify;">'
        'Jeśli uczestnicy mają problem ze zrozumieniem, dlaczego zarówno działanie wychowawcze jak i jego brak zawsze kształtuje duchowość wychowanków, prowadzący może przedstawić uczestnikom użyteczną analogię:'
        '<br>'
        '<br><i>Nasz Związek jest jak wielka, rozproszona organizacja ogrodnicza. Zajmuje się ona kształtowaniem krzewów (czyli kształtowaniem duchowości i zdolności harcerzy). Pojawiają się u nas różne drzewka, w różnych formach i kształtach, a zadaniem ogrodników (instrktorów) jest te drzewa przycinać, podlewać, nawozić lub pozwalać im rosnąć tak, by nadać im określony kształt.</i>'
        '<br>'
        '<br>W analogii należy podkreślić, że niezależnie od działania ogrodnika, <b>krzew zawsze ma jakiś kształt</b>. Krzew nabywa określonego kształtu, także wtedy, gdy ogrodnik nic nie robi.'
        '<br>'
        '<br>Harcerstwo jest przedsięwzięciem kształtowania ludzi. W sposób oczywisty kształtuje ich według określonych zasad (np. zasad PH). Wokół faktu, że harcerstwo kształtuje przekonania i wartości młodego człowieka w określonym kierunku narosła dziwna i niepotrzebna kontrowersja - ale <b>bez celowej i planowej zmiany duchowości harcerzy harcerstwo nie ma najmniejszego sensu.</b>.'
        '</p>'
);

KonspektStep step_zrodla_wartosci_w_zhp_dyskusja_o_scenariuszach = KonspektStep(
    title: 'Neutralność duchowa - źródła wartości - dyskusje o scenariuszach',
    duration: Duration(minutes: 15),
    activeForm: false,
    aims: [
      'Zbudowanie u uczestników zdolności wiązania wartości harcerskich z ich aksjomatami',
      'Przebicie bańki fałszywej tezy relatywizmu wyznawanych w harcerstwie wartości'
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący zaczyna od stwierdzenia:'
        '<br>'
        '<br><i>“Skoro harcerstwo nie jest neutralne, to spróbujmy wgryźć się w esencję ducha harcerskiego wychowania. Może uda się to bez utonięcia w filozofii i teologii”</i>.'
        '<br>'
        '<br>Prowadzący znowu prezentuje uczestnikom scenariusze z użytego już załącznika $attach_html_neutralnosc_duchowa_przyklady. Prowadzący stawia przed nimi zadanie w formie pytania:'
        '<br>'
        '<br><i>“Wszystkie przedstawione w scenariuszach wartości mają swoje odzwierciedlenie w PH. Ale przecież PH nie spadło z nieba na kamiennych tablicach! Z jakiego aksjomatu wynikają prezentowane w scenariuszu postawy, przekonania i wartości?”</i>'
        '<br>'
        '<br>Prowadzący prosi uczestników, by dokopali się do najgłębszego źródła wartości (aksjomatu), funkcjonującego w naszym kręgu cywilizacyjnym. Uczestnicy nie powinni bać się zanurkowania w przestrzeń <b>religii</b> i <b>filozofii</b>, a czasami <b>selekcji naturalnej</b>. Grupa nie musi być zgodna we wnioskach - może zaproponować zapisać kilka różnych aksjomatów, z których wynikają omawiane wcześniej wartości.'
        '<br>'
        '<br>Warto, by prowadzący przedstawił kilka przykładowych aksjomatów, jeśli uczestnicy jeszcze nie do końca je "czują":'
        '</p>'

        '$aksjomaty_przyklady'

        '<p style="text-align:justify;">'
        'Wskazane jest, by uczestnicy mieli możliwość swobodnej dyskusji. Dlatego, jeśli to możliwe, warto podzielić uczestników na grupy po nie więcej niż 5 osób i dać im po jednym ze scenariuszy. Dodatkowo każda grupa powinna dostać kartkę, na której powinna spisać swoje wnioski.'
        '<br>'
        '<br>Na końcu każda grupa w ciągu minuty prezentuje wyniki swojej pracy. Gdy skończy, prowadzący prosi, by położyli omawiany scenariusz oraz kartkę z aksjomatem przed sobą.'
        '</p>',
    materials: [
      material_zal_neutralnosc_duchowa_przyklady
    ]
);

KonspektStep step_zrodla_wartosci_w_zhp_okreslonosc_wartosci = KonspektStep(
    title: 'Neutralność duchowa - źródła wartości w ZHP - określoność wartości',
    duration: Duration(minutes: 5),
    activeForm: false,
    aims: [
      'Uświadomienie uczestnikom, że harcerstwo jest dla wszystkich, ale nie wychowuje do wszystkiego - ma ściśle określone wartości, którymi się kieruje'
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący zaczyna od zadania pytania:'
        '<br>'
        '<br><i>“Możliwe, że część z was na tym etapie zastanawia się, jakie są oraz skąd wypływają harcerskie wartości?”</i>.'
        '<br>'
        '<br>Prowadzący przedstawia uczestnikom stosowny fragment statutu ZHP (załącznik $attach_html_cel_wychowania_duchowego_zhp_statut) oraz preambułę uchwały w sprawie wspierania rozwoju duchowego w ZHP (załącznik $attach_html_cel_wychowania_duchowego_zhp_uchwala). Zwraca uwagę na to, że w ZHP mamy ściśle określony zbiór wartości i postaw, do których wychowujemy.'
        '</p>',
  materials: [
    material_zal_cel_wychowania_duchowego_zhp_statut,
    material_zal_cel_wychowania_duchowego_zhp_uchwala
  ]
);

KonspektStep step_zrodla_wartosci_w_zhp_aksjoamty = KonspektStep(
    title: 'Neutralność duchowa - źródła wartości w ZHP - aksjomaty',
    duration: Duration(minutes: 20),
    activeForm: false,
    aims: [
      'Uświadomienie uczestnikom, że do wspierania rozwoju duchowego na poziomie Z i H wystarczy poziom postaw i wartości, ale rozwój duchowy z HS i W wymaga pracy na poziomie aksjomatu',
      'Uświadomienie uczestnikom, że harcerskie wartości, oparte na “oczywistych” wartościach naszej cywilizacji, w sposób ścisły wypływają z wiary chrześcijańskiej'
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący stawia pytanie:'
        '<br>'
        '<br><i>“Przychodzi do Was HS i pyta: dlaczego mam nie prześladować kogoś, kto wyrządził mi krzywdę? Uważam, że należy go przykładnie i doszczętnie zgnębić. Inni niech robią co chcą na moim miejscu, ale dlaczego mam wierzyć w jakieś arbitralnie wymyślone dyrdymały o godności każdego człowieka?”</i>.'
        '<br>'
        '<br>Prowadzący zauważa, że nawet jeśli niewerbalnie, to rozwój duchowy prowadzi przez pytanie “dlaczego mam wierzyć w takie a nie inne wartości?”. Jako instruktorzy organizacji wychowawczej mamy wówczas dwa wyjścia:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Zignorować aksjomatyczne poszukiwania harcerzy (pozwolić innym czynnikom wpłynąć na decyzję harcerza),</p></li>'
        '<li><p style="text-align:justify;">Świadomie pomóc w znalezieniu odpowiedzi</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Żadne z tych rozwiązań nie jest neutralne światopoglądowo!'
        '<br>'
        '<br>Prowadzący stawia w tym miejscu trzy tezy:'
        '</p>'
        '<ol>'
        '<li><p style="text-align:justify;">Jeśli harcerstwo chce być skuteczne wychowawczo, nie powinno abdykować ze rozwoju duchowego na poziomie aksjomatu.</p></li>'
        '<li><p style="text-align:justify;">Harcerstwo w samym swoim założeniu jest stronnicze. Tak samo każda forma pracy z aksjomatem ducha jest stronnicza i jest związana z wiarą, filozofią i arbitralnością.</p></li>'
        '<li><p style="text-align:justify;">System wartości harcerskich wynika w głównej mierze z wiary chrześcijańskiej i nie warto tego zmieniać.</p></li>'
        '</ol>'
        '<p style="text-align:justify;">'
        'Prowadzący omawia źródła wartości w poszczególnych scenariuszach, odnosząc się w razie potrzeby do wniosków uczestników.'
        '</p>'

        '<ol>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 1.</b> Przebaczenie i odpuszczenie win.'
        '<br>'
        '<br>Przebaczenie win nie jest moralnym standardem. W wielu kulturach jest to uważane za zachętę do bycia wykorzystywanym. Nietzsche uważał przebaczanie za wyraz słabości i element moralności niewolników. W tradycyjnej kulturze Japońskiej, po popełnieniu poważnej winy nie było drogi odpuszczenia winy: jedynym honorowym wyjściem było popełnienie rytualnego samobójstwa: seppuku (lub harakiri).'
        '<br>'
        '<br>Dlaczego więc w kulturze łacińskiej jest inaczej? Bo naszą kulturę ukształtowała wiara, że sam stwórca świata uznał za słuszne ponieść śmierć za człowieka, by ten doznał odpuszczenia win, a na pytanie św. Piotra o to ile razy ma wybaczyć komuś winę, usłyszał: zawsze.'
        '<br>'
        '<br>Z tego też powodu w zachodnim systemie prawnym po poniesieniu kary za popełnioną winę, zostaje ona zmazana i człowiek otrzymuje niejako "czystą kartę" - a przecież nie ma technicznego problemu, by za kradzież człowiek był skazywany i uznany winnym do końca życia.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 2.</b> Mówienie prawdy.'
        '<br>'
        '<br>W kulturach wschodnich, szczególnie w kulturze konfucjańskiej, gdzie najważniejsza jest harmonia społeczna i kolektywizm, należy kłamać, jeśli prowadzi do uniknięcia konfliktu. W części kultur afrykańskich kłamstwo nie jest złem, jeśli służy uniknięciu wstydu.'
        '<br>'
        '<br>Dlaczego więc akurat my tak się uparliśmy, by nagannie traktować świadome mówienie nieprawdy?'
        '<br>'
        '<br>Po pierwsze naszą kulturę ukształtowała wiara, że całe cierpienie i grzechy świata swój początek wzięły w kłamstwie węża, w które Adam i Ewa uwierzyli. Po drugie, jeśli Bóg stworzył świat, który wierzymy, że jest dobry, to wyjście z trudnych sytuacji nie może być długodystansowo możliwe przez nagięcie lub zatajenie rzeczywistości. Nasz świat jest oparty o ewangeliczną tezę <i>“poznacie prawdę, a prawda was wyzwoli”</i>.'
        '<br>'
        '<br><i>“Do obalenia totalitaryzmu wystarczy jeden człowiek, który powie prawdę”</i> napisał Sołżenicyn w „Archipelagu GUŁag”.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 3.</b> Bezinteresowna pomoc bliźnim'
        '<br>'
        '<br>Niezbywalna godność i równość każdego człowieka? W systemach konfucjańskich liczy się najpierw wspólnota i kolektyw, dopiero potem człowiek. Niektórzy wyznawcy hinduizmu widząc cierpienie drugiego człowieka powstrzymają innych od udzielenia mu pomocy - jeśli ktoś cierpi, to niewątpliwie pokutuje za grzechy popełnione w poprzednim życiu.'
        '<br>'
        '<br>A skąd pogląd, że wykształcony profesor z zasługami dla narodu ma takie same prawa jak półinteligentny osiedlowy cwaniaczek? Skąd pomysł, że prawo do życia i godnego traktowania ma każdy, niezależnie od wieku, pochodzenia, czy wyznania?</i>.'
        '<br>'
        '<br>Naszą kulturę ukształtowała wiara, że chyba w nawet najpodlejszemu człowiekowi nie można odebrać godności, skoro sam Bóg zechciał umrzeć na krzyżu dla jego zbawienia. W świetle tego faktu nie ma usprawiedliwienia dla systemu kastowego, niewolnictwa ani wyzysku.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 4.</b> Stawianie wyżej dobra jednostki nad kolektywem'
        '<br>'
        '<br>Immanentne poszanowanie jednostki i dobra indywidualnego człowieka? Niezbywalne wolności osobiste? Prawa człowieka nawet, gdy zbiorowości się to nie opłaca?'
        '<br>'
        '<br>W kulturze konfucjańskiej najpierw liczy się kolektyw, dobro zbiorowości, trwałość systemu państwowego - a dopiero potem dobro jednostki. W Chinach niedopuszczalne jest publiczne okazywanie sporów, ponieważ osłabia to wspólnotę. W kulturze japońskiej należy poświecić własne plany prywatne, jeśli kolidują one z wydarzeniem firmy, w której się pracuje.'
        '<br>'
        '<br>Skąd więc u nas "oczywiste" przekonanie, że należy zapewnić odszkodowanie rodzinie, której dom stoi na drodze nowej autostrady? Skąd przekonanie, że nie można zmusić kogoś do pracy, jeśli nie chce? Nasza kultura została ukształtowana przez wiarę, że Bóg stworzył każdego człowieka na swój obraz, że zginął za każdego, najmniejszego z ludzi, by ten mógł doświadczyć zbawienia. "Wszystko, coście uczynili jednemu z braci moich najmniejszych mnieście [Bogu] uczynili".'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 5.</b> Wierność w związku'
        '<br>'
        '<br>Dlaczego kultura łacińska nalega na trwałe związki damsko-męskie?'
        '<br>'
        '<br>Być może przewagi monogamii wyparły skutecznością większość innych modeli relacji. Monogamia jest przewidywalna, stabilna, ułatwia zarządzanie zasobami i dziedziczenie, a to zwiększa bezpieczeństwo dzieci. W skali makro zmniejsza napięcia społeczne wynikające z braku dostępnych partnerów życiowych i minimalizuje ryzyko chorób przenoszonych drogą płciową.'
        '<br>'
        '<br>Z indywidualistycznej perspektywy pozwala zrównać w relacji obie płcie nie odbierając możliwości pełnienia komplementarnych ról, zaś brak możliwości łatwego zakończenia związku zmusza jego uczestników do skutecznego mierzenia się z problemami ich osobowości.'
        '</p>'
        '</li>'

        '</ol>'

        '<p style="text-align:justify;">'
        '<b>Ale przecież te aksjomaty są religijne - co z tzw. “niewierzącymi” harcerzami?</b>'
        '<br>'
        '<br>Po pierwsze - to, że chrześcijańska myśl dała naszej cywilizacji (i przy okazji harcerstwu) zbiór wartości nie zależy od tego, czy rozmyśla o nich osoba wierząca, czy niewierząca.'
        '<br>'
        '<br>Po drugie - na czym miałoby polegać wychowanie “z dala” od chrześcijańskich aksjomatów? Na porzuceniu idei mówienia prawdy, miłości bliźniego, szacunku wobec każdego człowieka, idei przebaczenia, miłosierdzia, sprawiedliwości, równości i relacji z absolutem?'
        '<br>'
        '<br>Po trzecie -  jaki inny aksjomat, który jest wewnętrznie spójny, z którego wynikają wartości zgodne z tymi przyjętymi przez ruch harcerski i który nie zapadnie się pod własnymi założeniami w ciągu dwóch pokoleń chcemy tym harcerzom zaproponować?'
        '<br>'
        '<br>Nie trzeba być wierzącym, żeby przyznać, że harcerskie wartości są fundamentalnie chrześcijańskie, ani żeby dostrzec ogrom pozytywów, jaki to za sobą niesie.'
        '<br>'
        '<br>Wychowanie duchowe na poziomie aksjomatu musi doprowadzić do świadomej, spójnej wiary w “coś”. Ignorowanie potrzeby posiadania spójnego aksjomatu nie jest wyrazem inkluzywności i tolerancji, ale ignorancji i infantylizmu.'
        '<br>'
        '<br>Może drogą do przodu nie jest zmiana cywilizacyjnych wartości, których się nie rozumiemy, ale próba ich zinternalizowania w nowych warunkach, w których przyszło nam żyć.'
        '</p>'
);

KonspektStep step_neutralnosc_podsumowanie = KonspektStep(
    title: 'Neutralność duchowa - podsumowanie',
    duration: Duration(minutes: 5),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        '<b>Podsumowanie (dla przewodników)</b>'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Nie istnieje neutralne wychowanie.</p></li>'
        '<li><p style="text-align:justify;">Harcerskie wychowanie jest fundamentalnie chrześcijańskie, nawet jeśli jego członkowie są innego wyznania.</p></li>'
        '<li><p style="text-align:justify;">Jeśli są w harcerskiej duchowości i ideałach wartości, których jako kadra nie rozumiemy, to warto je zgłębić zamiast je pomijać lub się ich pozbyć. Zazwyczaj za tymi wartościami stoją dziesiątki wieków cywilizacyjnej mądrości.</p></li>'
        '<li><p style="text-align:justify;">Harcerstwo powinno mieć wysokie standardy nie po to, by prowadzić selekcję osób mogących harcerzami zostać, ale po to, by wychować ludzi w szacunku do wartości, postaw, a często również wiary, która dała nam świat merytokracji, równości, wolności, godności ludzkiej, przebaczenia, uznania własnej niedoskonałości, powszechnej sprawiedliwości, nauki, itd..</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        '<br>'
        '<b>Podsumowanie dodatkowe (dla podharcmistrzów)</b>'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Mamy w ZHP niechlubną tradycję zmieniania harcerskich zasad i ideałów, gdy okazuje się że postawy harcerzy się z nimi nie spotykają. A przecież to harcerstwo powinno zmieniać ludzi, a nie się do nich dostosowywać.</p></li>'
        '</ul>'
);

// Szybkie strzały dyskusyjne

KonspektStep step_szybkie_strzaly_dyskusyjne = KonspektStep(
    title: 'Szybkie strzały dyskusyjne',
    duration: Duration(minutes: 30),
    activeForm: true,
    required: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący rzuca krótkie frazy z listy poniżej i nad każdą przez kilka minut trwa dyskusja. Prowadzący może w trakcie dyskusji zadawać pytania, jednak do jej końca nie prezentuje swojego stanowiska. Dojście do wspólnej konkluzji przez uczestników nie jest ważne. Na końcu każdej dyskusji prowadzący może powiedzieć krótko co uważa na wywołany temat.'
        '</p>'
        '<ol>'
        '<li><p style="text-align:justify;">Nie powinno się wychowywać człowieka w konkretnym celu.</p></li>'
        '<li><p style="text-align:justify;">Religijność jest dodatkiem do duchowości i nie każdy musi ją mieć.</p></li>'
        '<li><p style="text-align:justify;">Jeśli ktoś chce kościelnego harcerstwa, powinien pójść do ZHRu.</p></li>'
        '<li><p style="text-align:justify;">Religia to prywatna sprawa każdego człowieka i nie powinien się z nią afiszować.</p></li>'
        '<li><p style="text-align:justify;">Patriotyzm to duchowość.</p></li>'
        '<li><p style="text-align:justify;">Wszystkie niebezpieczne działania są niewychowawcze i nieodpowiedzialne.</p></li>'
        '<li><p style="text-align:justify;">Każdy harcerz powinien mieć dowolność w tym, jak chce się rozwijać duchowo.</p></li>'
        '<li><p style="text-align:justify;">W ZHP nie wolno narzucać poglądów.</p></li>'
        '<li><p style="text-align:justify;">Możliwość zamknięcia próby instruktorskiej powinna zależeć od poglądów kandydata.</p></li>'
        '<li><p style="text-align:justify;">W ramach działań drużyny nie powinno być aktywności religijnych, gdyż te wykluczają niewierzących.</p></li>'
        '<li><p style="text-align:justify;">Boga nie powinno być w Przyrzeczeniu, bo niektórzy harcerze składaliby Przyrzeczenie wbrew swoim przekonaniom.</p></li>'
        '<li><p style="text-align:justify;">Polski nie powinno być w Przyrzeczeniu, bo niektórzy harcerze składaliby Przyrzeczenie wbrew swoim przekonaniom.</p></li>'
        '<li><p style="text-align:justify;">Pomoc bliźnim nie powinna być w Przyrzeczeniu, bo niektórzy harcerze składaliby Przyrzeczenie wbrew swoim przekonaniom.</p></li>'
        '</ol>'
);