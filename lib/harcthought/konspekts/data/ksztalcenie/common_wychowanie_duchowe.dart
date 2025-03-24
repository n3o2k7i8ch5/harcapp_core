import 'package:harcapp_core/harcthought/konspekts/data/common.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common_attachments.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

KonspektMaterial material_mini_kartki_biurowe = KonspektMaterial(
  name: 'Mini kartki biurowe (ok. 10x10 cm)',
  amountAttendantFactor: 3,
);

KonspektMaterial material_zal_karty_poziomow_duchowosci = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_karty_poziomow_duchowosci”',
    attachmentName: attach_name_karty_poziomow_duchowosci,
    amount: 1
);

KonspektMaterial material_zal_karty_zdolnosci_integracji_duchowosci = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_karty_zdolnosci_integracji_duchowosci”',
    attachmentName: attach_name_karty_zdolnosci_integracji_duchowosci,
    amount: 1
);


KonspektMaterial material_zal_aksjomaty_opisu_przyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_aksjomaty_opisu_przyklady”',
    attachmentName: attach_name_aksjomaty_opisu_przyklady,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii i pomieszać ich kolejność.',
    amount: 1
);

KonspektMaterial material_zal_aksjomaty_opisu_i_sensu_przyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_aksjomaty_opisu_i_sensu_przyklady”',
    attachmentName: attach_name_aksjomaty_opisu_i_sensu_przyklady,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii i pomieszać ich kolejność.',
    amount: 1
);

KonspektMaterial material_zal_aksjomaty_sensu_przyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_aksjomaty_sensu_przyklady”',
    attachmentName: attach_name_aksjomaty_sensu_przyklady,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii i pomieszać ich kolejność.',
    amount: 1
);

KonspektMaterial material_zal_aksjomaty_bledne_przyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_aksjomaty_bledne_przyklady”',
    attachmentName: attach_name_aksjomaty_bledne_przyklady,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii i pomieszać ich kolejność.',
    amount: 1
);

KonspektMaterial material_budzik = KonspektMaterial(
  name: "Budzik (np. w telefonie)",
  amount: 1
);

KonspektMaterial material_zal_meta_narracja_opis = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_meta_narracja_opis”',
    attachmentName: attach_name_meta_narracja_opis,
    amount: 1
);

KonspektMaterial material_zal_meta_narracja_przyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_meta_narracja_przyklady”',
    attachmentName: attach_name_meta_narracja_przyklady,
    amount: 1,
    additionalPreparation: "Załącznik należy pociąć na 4 kartki wzdłuż przerywanych linii."
);

KonspektMaterial material_flipchart = KonspektMaterial(
  name: 'Duży arkusz papieru (flipchart)',
  amount: 1,
);

KonspektMaterial material_marker = KonspektMaterial(
  name: 'Marker',
  amount: 5,
);

KonspektMaterial material_tasma_klejaca = KonspektMaterial(
  name: 'Taśma klejąca',
  amount: 1,
);

KonspektMaterial material_zal_neutralnosc_duchowa_przyklady = KonspektMaterial(
  name: 'Wydrukowany załącznik “$attach_title_neutralnosc_duchowa_przyklady”',
  attachmentName: attach_name_neutralnosc_duchowa_przyklady,
  amount: 1,
  additionalPreparation: 'Załącznik należy pociąć na 4 części zgodnie z ramkami.'
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

KonspektMaterial material_zal_szybkie_strzaly_dyskusyjne = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_szybkie_strzaly_dyskusyjne”',
    attachmentName: attach_name_szybkie_strzaly_dyskusyjne,
    amount: 1,
    additionalPreparation: 'Załącznik należy pociąć na 10 kartek wzdłuż przerywach linii.'
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
        'Prowadzący na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci wprowadza podział człowieka na 5 sfer rozwoju - 4 sfery funkcjonalne: <b>ciało</b>, <b>umysł</b>, <b>emocje</b>, <b>relacje</b> i jedną sferę centralną: sferę <b>ducha</b>.'
        '<br>'
        '<br>Prowadzący opisuje zależności między sferami - sfery funkcjonalne dostarczają człowiekowi <b>zdolności</b>, zaś sfera ducha jest <b>sposobem</b> ich zarządzania.'
        '<br>'
        '<br>Jeżeli prowadzący uzna, że poprawi to poziom zrozumienia, może skorzystać z analogii opisanej sfer funkcjonalnych i centralnych do samochodu i kierowcy opisanego w załączniku $attach_html_poradnik_o_strukturze_duchowosci.'
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

// Poziomy (warstwy) duchowości

KonspektStep _step_poziomy_duchowosci = KonspektStep(
    title: 'Poziomy (warstwy) rozwoju duchowego',
    duration: Duration(minutes: 10),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci wprowadza rozróżnienie poziomów duchowości kolejno na poziom <b>zachowań</b>, poziom <b>postaw</b>, poziom <b>wartości</b> i poziom <b>aksjomatu</b> (kolejność definiowania jest ważna). Każdorazowo po zdefiniowaniu określonego poziomu duchowości prowadzący kładzie w widocznym miejscu kartkę z nazwą poziomu duchowości i jego hasłową definicją z załącznika $attach_html_karty_poziomow_duchowosci. Dzięki temu uczestnicy mogą zawsze wrócić podczas warsztatów do definicji poziomu duchowości.'
        '<br>'
        '<br>Dodatkowo prowadzący definiuje duchowość <b>wymierną</b> (poziom zachowań i postaw) i <b>głęboką</b> (poziom wartości i aksjomatów).'
        '<br>'
        '<br>Prowadzący powinien wyraźnie zaznaczyć, że “poziom duchowości” nie odnosi się do słowa “poziom” w sensie poziomu zaawansowania (np. poziom w grze komputerowej), ale poziomu w sensie warstwy, piętra, hierarchii etc..'
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

);

KonspektStep _step_poziomy_duchowosci_przyklady_uczestnikow = KonspektStep(
    title: 'Poziomy (warstwy) rozwoju duchowego - przykłady uczestników',
    duration: Duration(minutes: 5),
    required: false,
    activeForm: false,
    content: '<p style="text-align:justify;">'

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
      material_zal_karty_poziomow_duchowosci,
    ]

);

KonspektStep _step_poziomy_duchowosci_aksjomat = KonspektStep(
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
      '<b>Aksjomat zawsze jest fundamentalną, niesprawdzalną wiarą</b> w określony porządek rzeczy.'
      '<br>'
      '<br><b>Aksjomaty całkowicie porządkują postrzeganie rzeczywistości</b>. Aby to zobrazować, prowadzący może posłużyć się przykładem:'
      '<br>'
      '<br><i>"Jeśli ktoś wierzy, że Ziemia jest płaska, to wszystko inne podporządkuje pod to założenie. Również, jeśli ów człowiek zobaczy dowód na kulistość Ziemi, to wniosek będzie miał tylko jeden: narzędzia użyte przy tych dowodach były wadliwe.'
      '<br>'
      '<br>Czy to powinno zaskakiwać? Przecież my, gdy nam przedstawiono nagranie dowodzące, że księżyc jest jedynie wyświetlanym hologramem, też uznalibyśmy, że to nagranie musi być błędne. Nie zakładalibyśmy, że cała nauka się pomyliła - a przecież nauka mogła się pomylić, my jedynie wierzymy, że ona dobrze opisuje rzeczywistość.".</i>'
      '<br>'
      '<br>Prowadzący dzieli aksjomaty na dwie nierozłączne grupy (tzn. każdy aksjomat może należeć do jednej z grup lub wszystkich na raz): <b>aksjomaty opisu</b> oraz <b>aksjomaty sensu</b> na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci.'
      '</p>'
);

KonspektStep _step_poziomy_duchowosci_aksjomat_dopasowanie_przykladow = KonspektStep(
    title: 'Poziomy (warstwy) rozwoju duchowego - aksjomat - dopasowanie przykładów',
    aims: [
      'Zrozumienie przez uczestników w praktyce różnicy między aksjomatami opisu, a aksjomatami sensu.',
    ],
    materials: [
      material_zal_aksjomaty_opisu_przyklady,
      material_zal_aksjomaty_opisu_i_sensu_przyklady,
      material_zal_aksjomaty_sensu_przyklady,
      material_zal_aksjomaty_bledne_przyklady,
    ],
    duration: Duration(minutes: 15),
    activeForm: true,
    content: '<p style="text-align:justify;">'
        'Aby uczestnicy mieli okazję sami obyć się z aksjomatami, prowadzący rozdaje im wycięte prostokątne kartki z przykładami aksjomatów z załącznika $attach_html_aksjomaty_opisu_przyklady, $attach_html_aksjomaty_opisu_i_sensu_przyklady, $attach_html_aksjomaty_sensu_przyklady i $attach_html_aksjomaty_bledne_przyklady.'
        '<br>'
        '<br>Zadaniem uczestników jest pogrupować przykłady aksjomatów odpowiednio do jako <b>aksjomaty opisu</b>, <b>aksjomaty opisu i sensu</b> oraz <b>aksjomaty sensu</b>. Muszą mieć też na uwadze, że <b>kilka przykładów nie jest aksjomatem</b> w ogóle.'
        '<br>'
        '<br>W trakcie ćwiczenia uczestnicy mogą prosić prowadzącego o pomoc.'
        '<br>'
        '<br>Kartki z przykładowymi aksjomatami powinny zostać ułożone w trzech kolumnach pod wyłożoną podczas prezentowania poziomów duchowości kartką "Aksjomat". Przykłady, które nie są aksjomatami należy odłożyć gdzieś z boku.'
        '<br>'
        '<br>Na końcu prowadzący po krótce omawia z uczestnikami poprawność ich dopasowania.'
        '</p>'
);

KonspektStepGroup step_group_poziomy_duchowosci = KonspektStepGroup(
    title: 'Poziomy (warstwy) duchowości',
    steps: [
      _step_poziomy_duchowosci,
      _step_poziomy_duchowosci_przyklady_uczestnikow,
      _step_poziomy_duchowosci_aksjomat,
      _step_poziomy_duchowosci_aksjomat_dopasowanie_przykladow
    ]
);

// Integracja duchowości

KonspektStep _step_integracja_duchowosci_osie = KonspektStep(
    title: 'Integracja duchowości - osie współrzędnych',
    duration: Duration(minutes: 1),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący bierze dużą kartkę (np. flipchart) i rysuje na niej dwie prostopadłe osie współrzędnych. Na osi X zaznacza <b>czas</b>, zaś na osi Y <b>poziom duchowości</b>. Tłumaczy przy tym, że przejdzie teraz z uczestnikami krok po kroku przez sposób, w jaki kształtuje się duchowość człowieka.'
        '</p>',
);

KonspektStep _step_integracja_duchowosci_jak_nie = KonspektStep(
    title: 'Integracja duchowości - jak duchowość nie jest kształtowana',
    duration: Duration(minutes: 2),
    activeForm: false,
    materials: [
      material_flipchart,
      material_marker,
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci opisuje <b>dla zbudowania kontekstu</b> intuicyjny sposób kształtowania duchowości, który jest zupełnie nieprawdziwy. Zaczyna od zwrócenia uwagi:'
        '<br>'
        '<br><i>Najlepiej byłoby, gdyby każdy człowiek najpierw ustalał swoje aksjomaty - czyli fundament duchowości, następnie wnioskował z nich słuszne wartości, zaś z wartości wnioskował właściwe postawy i zachowania. Potem żyłby długo i szczęśliwie, postępując zawsze w zgodzie z samym sobą, czasem tylko odkryłby jakąś nową wartość, albo nowe właściwe zachowanie.'
        '<br>'
        '<br>Wszystko fajnie - tylko czy próbował ktoś kiedyś porozmawiać z niemowlakiem o filozofii egzystencjalnej, aksjomatach, albo chociaż słuszności jednych wartości nad drugimi? A przecież każdy niemowlak jakoś się już zachowuje, czyli ma już określoną duchowość!</i>'
        '<br>'
        '<br>Prowadzący zauważa, że w sposób oczywisty kształtowanie duchowości <b>nie odbywa się</b> od poziomów głębokich (aksjomaty, wartości) do wymiernych (postawy i zachowania). Kształtowanie duchowości zaczyna się od końca: czyli <b>od poziomu zachowań</b>.'
        '</p>'
);

KonspektStep _step_integracja_duchowosci_wstepna = KonspektStep(
    title: 'Integracja duchowości - integracja wstępna',
    duration: Duration(minutes: 6),
    activeForm: false,
    materials: [
      material_flipchart,
      material_marker,
    ],
    contentBuilder: ({required bool isDark}) => '<p style="text-align:justify;">'
        'Prowadzący na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci opisuje właściwe <b>etapy rozwoju duchowego</b> rysując je przy tym na arkuszu papieru. Przy każdym opisywanym poziomie duchowości prowadzący zaznacza na osi czasu <b>wiek człowieka</b>, w którym jego duchowość zaczyna być możliwa do analizy przez pryzmat danego poziomu duchowości.'
        '</p>'

        '<ul>'
        '<li>'
        '<p style="text-align:justify;">'
        'Od dnia narodzin, aż do ok. 10. roku życia duchowość człowieka nie wykracza poza <b>poziom zachowań</b> i <b>postaw</b>. Analizowanie duchowości na innych poziomach nie ma wówczas sensu - wartości i aksjomaty są dla mózgu człowieka zbyt abstrakcyjne. Człowiek rozumie jedynie to, że niektóre zachowania są dobre, a inne złe - ale nie rozumie dlaczego. To m.in. z tego powodu Prawo Zucha stanowi prostolinijnie o tym "co zuch robi", a nie "jakimi wartościami zuch się kieruje".'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        'W wieku ok. 10 lat pojawia się zdolność myślenia abstrakcyjnego. Człowiek zaczyna rozumieć, że ocena zachowań nie jest arbitralnie ustalona, ale że wynika z <b>wartości</b>. Nie trzeba wtedy już mówić: "zawsze przywitaj się grzecznie i podziękuj", można zamiast tego powiedzieć: "uszanuj innych ludzi".'
        '<br>'
        '<br><u>Jakimi wartościami zacznie się na tym etapie kierować młody człowiek</u>?'
        '<br>Oczywiście pierwsze wartości, nie ani losowe, ani zależne od chwilowej konstelacji gwiazd. Człowiek będzie miał tendencję do kierowania się <b>wartościami, z których wynikają zachowania i postawy, którymi na tym etapie żyje</b>.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        'W wieku ok. 13-15 lat są wartości przestają być luźnym zbiorem i są porządkowane w światopoglądy, które mają swoje przyczyny - przyczynami tymi są <b>aksjomaty</b>, czyli przyjęte, nieweryfikowalne założenia o świecie. Towarzyszy temu zrozumienie, że różni ludzie mogą mieć różny światopogląd, czerpać swoje wartości z różnych źródeł i że nie ma możliwości jednoznacznego określenia który światopogląd, tudzież aksjomaty, są słuszne, a które gorsze.'
        '<br>'
        '<br><u>Jakimi aksjomatami zacznie się na tym etapie kierować młody człowiek</u>?'
        '<br>Podobnie jak wcześniej, nie będą one losowe. Człowiek będzie miał tendencję do przyjęcia <b>aksjomatów, z których wynikają wartości, którymi na tym etapie żyje</b>.'
        '</p>'
        '</li>'

        '</ul>'

        '<p style="text-align:justify;">'
        'Prowadzący opisując przejście między kolejnymi etapami rozwoju duchowego rysuje <b>kolejne poziomy duchowości</b> na flipcharcie, tak jak poniżej:'
        '<br>${piramidaDuchowosciPartHtml(isDark: isDark)}'
        '<br>Następnie prowadzący opisuje zjawisko <b>integracji wstępnej duchowości</b>, czyli sposobu w jaki kształtowana jest duchowość człowieka od urodzenia aż do wieku ok. 13-15, gdy człowiek internalizuje poziom aksjomatów:'
        '<br>'
        '<br><i>Od momentu urodzenia człowiek ma określone zachowania - nie muszą być nawet ze sobą spójne. W trakcie, gdy dorasta, jego otoczenie buduje w nim przekonanie, że niektóre zachowania są dobre, a inne są złe. W wieku 10 lat zacznie rozumieć związek zachowań z wartościami i stopniowo orientuje się, że część z jego dotychczasowych zachowań była niezgodna z jego wartościami, więc zaczyna je zmieniać swoje zachowania. Zmiana zachowań sprawia, że zaczyna inaczej funkcjonować i inaczej doświadczać rzeczywistości, a to weryfikuje przyjętą hierarchię wartości. Nowe wartości wpływają z powrotem na nowe zachowania, zachowania na wartości i tak w kółko.'
        '<br>'
        '<br>Dalej, w wieku ok. 13-15 lat, człowiek zaczyna w pełni zrozumieć czym są aksjomaty - nawet jeśli nie nazywa ich słowem "aksjomaty". Przyjmuje w życiu jakieś fundamentalne zasady i zazwyczaj stopniowo dostrzega, że część jego dotychczasowych poglądów, wartości i zachowań jest z nią niezgodna i rozpoczyna się gigantyczny proces ich uspójniania.</i>'
        '<br>'
        '<br>Prowadzący, opisując to wyjaśnia, że jest to mechanizm w jaki kształtowana jest duchowość: nie jest ona <b>budowana</b>, ani <b>wznoszona</b>, ale raczej <b>uspójniana</b> w procesie włączania kolejnych poziomów abstrakcji jej rozumienia, czyli <b>integrowana</b>. Cały ten proces nosi nazwę <b>integracji wstępnej duchowości</b> (od słowa wstęp, jak początek).'
        '<br>'
        '<br>Kolejne poziomy duchowości zależą w tym procesie od kształtu poprzednich. Prowadzący rysuje na flipcharchie strzałkę "integracji wstępnej".'
        '<br>'
        '<br><i>Do momentu internalizacji pojęcia aksjomatu, duchowość człowieka jest integrowana "po raz pierwszy". <b>Wartości, które przyjmie będą wynikały z nauczonych zachowań</b>. <b>Aksjomaty, które przyjmie, będą wynikały z wartości</b>, które wyznaje. Kształt duchowości zależy tu przede wszystkim od <b>otoczenia</b> i <b>temperamentu</b> człowieka. Jest to etap "<b>integracji wstępnej</b>".',

);

KonspektStep _step_integracja_duchowosci_swiadoma = KonspektStep(
    title: 'Integracja duchowości - integracja świadoma',
    duration: Duration(minutes: 6),
    activeForm: false,
    materials: [
      material_flipchart,
      material_marker,
    ],
    contentBuilder: ({required bool isDark}) => '<p style="text-align:justify;">'
        'Prowadzący na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci opisuje ostatni, najdłuższy etap rozwoju duchowego, czyli <b>integrację świadomą</b> duchowości.'
        '<br>'
        '<br><i>Integracja wstępna duchowości jest ściśle zależna od otoczenia człowieka i względnie łatwo można ją kształtować, ponieważ człowiek nie ma ostatecznego punktu odniesienia swojej duchowości, czyli świadomie przyjętych aksjomatów.'
        '<br>'
        '<br>Integracja świadoma jest pod tym kątem zupełnie inna - bezpośredni wpływ na człowieka staje się dużo bardziej ograniczony, bo człowiek zyskuje punkt odniesienia swojej duchowości (aksjomaty).</i>'
        '<br>'
        '<br>Prowadzący na osi czasu rysuje wielką, grubą kropkę, która kończy etap integracji wstępnej i rozpoczyna etap integracji świadomej. Dodaje, że łatwo ten punkt rozpoznać u człowieka, bo ten zaczyna się wówczas poważnie martwić się pytaniami o <b>sens istnienia</b> i <b>podważać utarte założenia</b>. Towarzyszą temu pytania w stylu:'
        '</p>'

        '<ul>'
        '<li><p style="text-align:justify;">“Jaki jest sens życia, o ile w ogóle jakiś jest?”</p></li>'
        '<li><p style="text-align:justify;">“Czy istnieje obiektywne dobro i zło, czy może wszystko jest jedynie subiektywne?”</p></li>'
        '<li><p style="text-align:justify;">“Dlaczego powinienem wierzyć w Boga? Przecież gdybym urodził się w Iranie, wierzyłbym w Allaha?”</p></li>'
        '</ul>'

        '<p style="text-align:justify;">'
        'Prowadzący opisując to, rysuje rysuje na flipcharcie liczne "oscylujące" strzałki i podpisuje je jako "integracja świadoma", tak jak poniżej:'
        '<br>${piramidaDuchowosciHtml(isDark: isDark)}'
        '<br>Na koniec ważne jest, aby prowadzący zaznaczył, że o ile można skutecznie wpływać na wartości, zachowania i postawy młodego człowieka, o tyle wpływ na aksjomat jest już bardziej subtelny. Do aksjomatów można młodego człowieka najwyżej "podprowadzić": owszem, są one kształtowane na podstawie własnych doświadczeń, znanych poglądów i przyjętych uprzednio wartości, jednak przyjąć aksjomat za własny można jedynie samemu, wedle własnego, osobistego przekonania. W tym procesie nie da się komuś towarzyszyć do końca.'
        '</p>',
);

KonspektStepGroup step_group_integracja_duchowosci = KonspektStepGroup(
    title: 'Integracja duchowości',
    steps: [
      _step_integracja_duchowosci_osie,
      _step_integracja_duchowosci_jak_nie,
      _step_integracja_duchowosci_wstepna,
      _step_integracja_duchowosci_swiadoma,
    ]
);

// Meta-narracja

KonspektStep _step_meta_narracja_scenka = KonspektStep(
    title: 'Meta-narracja - scenka',
    duration: Duration(minutes: 15),
    activeForm: true,
    materials: [
      material_budzik
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący przedstawia uczestnikom krótką historię:'
        '<br>'
        '<br>'
        '<i>Na obozie jeden z wędrowników, Radek, zaszedł drugiemu, Adamowi, za skórę. W odwecie Adam zaczął Radka prześladować. Trwało to już od miesiąca. Drużynowy wziął Adama na rozmowę. Powiedział, że zgodnie z harcerskimi wartościami należy traktować innych jak bliźnich i braci, dlatego uważa, że Adam powinien przebaczyć Radkowi ich sprzeczkę.'
        '<br>'
        '<br>Adam jednak stwierdził:'
        '<br>'
        '<br>"Okej. Mogę dać mu spokój, ale po tym, co Radek zrobił, nie zasługuje na traktowanie jak brata. Ja zresztą nie jestem już dzieckiem, dlaczego mam wierzyć w jakieś Prawo Harcerskie, które garstka ludzi nazywających się Radą Naczelną może w każdym momencie zmienić? Kto powiedział, że akurat ich wartości są dobre? Przecież Rada Naczelna to banda starych dziadów rodem z poprzedniej epoki".'
        '</i>'
        '<br>'
        '<br>Prowadzący zwraca uwagę uczestników (może to zrobić w formie pytania), że postawa Adama jest zupełnie nieharcerska (niezgodna z 4. punktem PH "Harcerz w każdym widzi bliźniego, a za brata uważa każdego innego harcerza").'
        '<br>'
        '<br>Następnie prowadzący ustawia budzik na 10 minut i wciela się w Adama. Zadaniem uczestników jest przekonać go, że Adam powinien być posłusznym PH i przebaczyć Radkowi ich sprzeczkę.'
        '<br>'
        '<br>Prowadzący w roli Adama aż do końca ma nie dać się przekonać. Kluczowe jest to, by stał ciągle na stanowisku, że <b>uczestnicy mogą sobie wierzyć w PH, ale według Adama ono jest bez sensu i jest wyrazem słabości</b>.'
        '<br>'
        '<br>Uwagi:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Jeśli prowadzący nie jest sam, najlepiej, jeśli aktorem grającym Adama będzie ktoś inny niż osoba czytająca opis.</p></li>'
        '<li><p style="text-align:justify;">Jeśli uczestników jest wielu (ponad 12), a prowadzący nie jest sam, można podzielić uczestników na grupy i odegrać scenkę niezależnie w grupach przez różnych prowadzących.</p></li>'
        '<li><p style="text-align:justify;">Jeśli prowadzący bardzo nie chce wcielać się w rolę, formę można przeprowadzić w postaci aktywnej dyskusji, gdzie prowadzący wciela się w "adwokata diabła" i stara się argumentować tak, jak robiłby Adam.</p></li>'
        '</ul>'
);

KonspektStep _step_meta_narracja_omowienie_scenki = KonspektStep(
    title: 'Meta-narracja - omówienie scenki',
    duration: Duration(minutes: 10),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący pyta uczestników <i>"jak Wam poszło?"</i>.'
        '<br>'
        '<br>Oczywiście poszło im <b>fatalnie</b> - nie przekonali Adama. Prowadzący inicjuje krótką dyskusję na temat tego, co poszło nie tak.'
        '<br>'
        '<br>Wniosek z dyskusji powinien prowadzić do jedynej możliwej odpowiedzi: <b>“To się nie mogło udać, bo nie ma powodu, by Adam <u>arbitalnie</u> przyjął wartości PH. Jeśli dorosły czlowiek ma traktować Prawo Harcerskie poważnie, musi przyjąć wiarę w coś, z czego owe wartości będą wypływały - np. w to, że jest winien przebaczenie każdemu bliźniemu, bo Chrystus zbawił go przez przebaczenie mu win wyrażonej w śmierci na krzyżu.”</b>.'
        '<br>'
        '<br>Bez wiary w odpowiedni spójny zbiór aksjomatów, w którym Adam może odnaleźć swoją tożsamość, swój cel, swoje źródło dobra, <b>nie ma żadnej drogi by udało się Adama wychować na dojrzałego, spójnego człowieka w harcerskich (lub jakichkolwiek innych) wartościach!</b>'
        '</p>'
);

KonspektStep _step_meta_narracja = KonspektStep(
    title: 'Poziomy (warstwy) rozwoju duchowego - meta-narracja',
    duration: Duration(minutes: 5),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący przedstawia definicję meta-narracji na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci i kładzie przed uczestnikami (obok kartki "Aksjomat") opis meta-narracji z załącznika $attach_html_meta_narracja_opis.'
        '<br>'
        '<br><i>Meta-narracja to zbiór spójnych aksjomatów dających się wyrazić jako opowieść o świecie, jego aktorach, z której bezpośrednio wynika definicja dobra, celu, sensu, osobistej roli przyjmującej ją człowieka, która stanowi źródło motywacji i tożsamości. Meta-narracje mogą zawierać aksjomaty opisu, jednak zawsze muszą zawierać aksjomaty sensu.</i>.'
        '<br>'
        '<br>Prowadzący natychmiast przedstawia uczestnikom kilka przykładów meta-narracji z załącznika $attach_html_meta_narracja_przyklady i kładzie je obok karty "Meta-narracja".'
        '<br>'
        '<br>Prowadzący kończy stwierdzeniem:'
        '<br>'
        '<br><i>Mówię o tym, ponieważ pracując jedynie z postawami i wartościami można kształtować jedynie ludzi do etapu <b>wstępnej integracji duchowości</b>. Później, świadomy młody człowiek musi kontynuować swój rozwój w oparciu o <b>meta-narrację</b>: poznaną wcześniej historię, w której będzie mógł się odnaleźć, która porządkuje świat, która jest wielką opowieścią o świecie i o sensie. Oznacza to, że w procesie wychowawczym <b>nie można abstrahować od kwestii najbardziej osobistych</b> - trzeba wejść z nimi w interakcję.</i>'
        '</p>'
);

KonspektStepGroup step_group_metanarracja = KonspektStepGroup(
    title: 'Meta-narracja',
    steps: [
      _step_meta_narracja_scenka,
      _step_meta_narracja_omowienie_scenki,
      _step_meta_narracja
    ]
);

// Zdolności integracji duchowości

KonspektStep _step_zdolnosci_integracji_duchowosci = KonspektStep(
  title: 'Zdolności integracji duchowości',
  duration: Duration(minutes: 5),
  activeForm: false,
  materials: [
    material_zal_karty_zdolnosci_integracji_duchowosci
  ],
  content: '<p style="text-align:justify;">'
      'Prowadzący bierze obie kartki z załącznika $attach_html_karty_zdolnosci_integracji_duchowosci i kładzie je zakryte przed uczestnikami przed nimi (rewersem do góry). Następnie zadaje pytanie:'
      '<br>'
      '<br><i>“Ustaliliśmy już w jaki sposób modelowo przebiega proces kształtowania duchowości człowieka. Ale! Wiedzieć, to jedno, a móc, to drugie. Jakie dwie, ogólne, fundamentalnie, kluczowe zdolności musi każdy człowiek posiadać (poza wiedzą o mechanizmie kształtowania duchowości), aby móc skutecznie rozwijać swoją duchowość?”</i>'
      '<br>'
      '<br>Prowadzący wdaje się z uczestnikami w dyskusję na temat postawionego pytania. Rolą prowadzącego jest tu podchwytywać wątki i zadawać takie pytania pomocnicze, które pomogą uczestnikom dojść do odpowiedzi zapisanych na kartkach. Jeśli uczestnicy utkną, prowadzący może zadać dwa pytania pomocnicze:'
      '</p>'
      '<ul>'

      '<li>'
      '<p style="text-align:justify;">'
      'Pytanie pomocnicze do <b>zdolności refleksyjnej</b>:'
      '<br><i>“Dlaczego ludzie, którzy biegną przez życie zajęci mnóstwem codziennych, prozaicznych spraw, często budzą się po latach i odkrywają, że zmarnowali swoje życie?”</i>'
      '</p>'
      '</li>'

      '<li>'
      '<p style="text-align:justify;">'
      'Pytanie pomocnicze do <b>siły charakteru</b>:'
      '<br><i>“Dlaczego ludzie, którzy często doskonale wiedzą, jak należy postępować i tak tkwią w starych, niszczących schematach działania?”</i>'
      '</p>'
      '</li>'

      '<p style="text-align:justify;">'
      'Gdy uczestnicy (z pomocą prowadzącego) dojdą do odpowiedzi, prowadzący odkrywa kartki i kładzie je <b>obok</b> kolumny kart z poziomami duchowości.'
      '</p>'

      '</ul>'
);

KonspektStep _step_zdolnosci_integracji_duchowosci_wyjasnienie_przyklady = KonspektStep(
    title: 'Zdolności integracji duchowości - wyjaśnienie na przykładach',
    duration: Duration(minutes: 2),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący, na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci podaje przykłady różnic między dwiema dodanymi kartami:'
        '<br>'
        '<br><i>Siła charakteru to:</i>'
        '</p>'

        '<ul>'
        '<li><p style="text-align:justify;"><i>zdolność do porzucenia wspólnoty, gdy jej wpływ jest destrukcyjny;</i></p></li>'
        '<li><p style="text-align:justify;"><i>zdolność pojechania w nieznane wskutek wniosku, że to konieczne;</i></p></li>'
        '<li><p style="text-align:justify;"><i>zdolność wyczerpującej pracy wskutek wniosku, że jest ona wymagana by zmienić swoje otoczenie na lepsze.</i></p></li>'
        '</ul>'

        '<p style="text-align:justify;">'
        '<i>Zdolność refleksyjna to:</i>'
        '</p>'

        '<ul>'
        '<li><p style="text-align:justify;"><i>zdolność do zrozumienia, że wpływ wspólnoty jest destrukcyjny;</i></p></li>'
        '<li><p style="text-align:justify;"><i>zdolność uświadomienia sobie, że konieczne jest pojechanie w nieznane;</i></p></li>'
        '<li><p style="text-align:justify;"><i>rozeznanie, że konieczne jest podjęcie wyczerpującej pracy.</i></p></li>'
        '</ul>'
);

KonspektStep _step_zdolnosci_integracji_duchowosci_podsumowanie = KonspektStep(
    title: 'Zdolności integracji duchowości',
    duration: Duration(minutes: 3),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący podsumowuje strukturę i sposób kształtowania duchowości:'
        '<br>'
        '<br><i>Duchowość człowieka to sposób, w jaki żyje i któremu podporządkowuje wszystkie inne sfery siebie i swojego życia. Duchowość to <b>zachowania</b> człowieka, które powinny reprezentować <b>spójne postawy</b>, wynikające ze <b>spójnych wartości</b> płynących z <b>aksjomatów</b>, czyli przyjętej spójnej wiary na temat rzeczywistości. Duchowość kształtuje się poprzez stałe <b>integrowanie</b> ze sobą różnych jej elementów, a żeby mogło się to odbywać skutecznie, za tą integracją musi stać <b>zdolność do określania kierunku integracji duchowości</b> oraz <b>zdolność do jej przeprowadzenia pomimo przeciwności</b>.</i>'
        '<br>'
        '<br>Prowadzący sprawdza, czy jest to jasne i czy są pytania od uczestników, które chcieliby przedyskutować.'
        '</p>'
);

KonspektStepGroup step_group_zdolnosc_integracji_duchowosci = KonspektStepGroup(
    title: 'Zdolności integracji duchowości',
    steps: [
      _step_zdolnosci_integracji_duchowosci,
      _step_zdolnosci_integracji_duchowosci_wyjasnienie_przyklady,
      _step_zdolnosci_integracji_duchowosci_podsumowanie
    ]
);

// Duchowość powszechna etc.

KonspektStep _step_duchowosc_powszechna_madrosc_kultura_i_tradycja = KonspektStep(
    title: 'Duchowość powszechna, mądrość, kultura i tradycja',
    duration: Duration(minutes: 10),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci opisuje zjawisko <b>duchowości powszechnej</b>, związanej z nią <b>sztafetowością</b> i <b>selekcją naturalną</b>. Następnie definiuje w oparciu o duchowość powszechną pojęcie <b>mądrości</b> oraz jej formą przekazu - <b>kulture</b> i <b>tradycje</b>. Prowadzący opisuje także zjawisko dualizmu tradycji - z jednej strony jej wiecznego niedoczasu względem rzeczywistości, z drugiej jej funkcji tworzenia norm i przekazywania sprawdzonych rozwiązań nowym pokoleniom.'
        '<br>'
        '<br>Prowadzący może zobrazować dylemat tego <i>"jak ściśle trzymać się tradycji"</i> w sposób następujący:'
        '<br>'
        '<br><i>Kultura i tradycja są mądrością miliona lat żyć, pamięcią miliona umysłów, wiedzą o skutkach miliona głupich prób – wszystkie dostępne dla człowieka żyjącego raptem kilkadziesiąt lat.</i>'
        '<br>'
        '<br><i>Gdybyśmy zanegowali na raz wszystkie tradycje, w ciągu jednego pokolenia wrócilibyśmy do jaskiń. Ale gdybyśmy nigdy nie podważyli żadnej tradycji, nigdy z tych jaskiń byśmy nie wyszli.</i>'
        '</p>'
);

KonspektStep _step_duchowosc_religia_religijnosc_opinie_uczestnikow = KonspektStep(
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

KonspektStep _step_duchowosc_religia_religijnosc = KonspektStep(
    title: 'Duchowość, religia, religijność',
    duration: Duration(minutes: 10),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący na podstawie załącznika $attach_html_poradnik_o_strukturze_duchowosci definiuje religię:'
        '<br>'
        '<br>Religia jest duchowością powszechną. <b>Religia nie jest “dodatkiem” do duchowości, ale jest określoną duchowością</b> - ma określone aksjomaty i wartości, określone sposoby jej (religii jako duchowość) integracji.'
        '<br>'
        '<br>Prowadzący powinien zwrócić uwagę, że nie ma tu mowy o relacji “zawierania”: <b>w obszernym zbiorze “duchowości” <u>nie zawiera się</u> mniejszy zbiór “religii”</b>! Nie jest tak, że część osób ma duchowość “z religią”, a część “bez religii”. Religia jest rodzajem, sposobem duchowości. Nie można z duchowości “wyjąć” elementu religijnego i dalej mieć do czynienia z duchowością, tak samo jak nie można z psa wyjąć elementu “jamnik” i dalej uważać, że pozostałość to pies. Jamnik nie jest dodatkiem do psa, tylko jest rodzajem całego, spójnego psa.'
        '<br>'
        '<br>Oznacza to, że nie można prowadzić wychowania w drużynie w oparciu o jedną, wybraną duchowość, i “wzbogacać” jej dla niektórych religią, a dla innych nie. Wynika to z faktu, że jeśli ktoś jest wychowywany w duchowości religijnej, ma określone religijne aksjomaty, co stoi w kontraście do aksjomatów osób niereligijnych! Osobnym pytaniem jest to, czy da się skutecznie wychowywać grupę do dwóch lub więcej zupełnie różnych duchowości.'
        '<br>'
        '<br>Podobnie, błędnym jest pogląd jakoby istniała symetria między duchowością osób religijnych i niereligijnych: osoby religijne mają z góry określone aksjomaty, jednak aksjomaty osób niereligijnych dopiero wymagają określenia i doprecyzowania.'
        '<br>'
        '<br><b>Religijność</b> jest zestawem zachowań i postaw wynikających z duchowości religijnej. Religijność nie jest jednak zbiorem wartości, ani całą duchowością - religijność to jedynie wierzchnia warstwa duchowości, która pozwala (lecz sama w sobie niekoniecznie wystarcza) by duchowość religijną skutecznie integrować.'
        '</p>'
);

KonspektStepGroup step_group_duchowosc_powszechna_madrosc_kultura_tradycja = KonspektStepGroup(
    title: 'Duchowość powszechna, mądrość, kultura i tradycja',
    steps: [
      _step_duchowosc_powszechna_madrosc_kultura_i_tradycja,

      _step_duchowosc_religia_religijnosc_opinie_uczestnikow,

      _step_duchowosc_religia_religijnosc,
    ]
);

// Neutralność

KonspektStep _step_neutralnosc_duchowa_galeria_sztuki = KonspektStep(
    title: 'Neutralność duchowa - galeria sztuki',
    duration: Duration(minutes: 15),
    activeForm: true,
    aims: [
      'Zaprezentowanie uczestnikom wartości i postaw (przebaczenie, prawdomówność, pomoc bliźnim, indywidualizm, ew. wierność w związku, modlitwa), które choć pozornie uniwersalne, wcale nie są domyślne, oczywiste, czy neutralne',
      'Przekonanie uczestników, że neutralność światopoglądowa w wychowaniu nie jest możliwa'
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący (najlepiej przed przystąpieniem do formy) rozwiesza na różnych ścianach kartki z załącznika $attach_html_neutralnosc_duchowa_przyklady. Wszystkie kartki zawierają scenariusze sytuacji wychowawczych z udziałem instruktora harcerskiego.'
        '<br>'
        '<br>Uczestnicy mają 15 minut, aby przejść się między wszystkimi scenariuszami, przeczytać je, po czym odpowiedzieć do każdego na dwa pytania:'
        '<br>'
        '<br><u><b>1. Czy działanie instruktora miało wpływ na duchowość harcerzy?</b> Jeśli tak, to <b>jakie wartości</b> lub postawy działanie instruktora wzmocniło?</u>'
        '<br>'
        '<br><u><b>2. Jak należałoby postąpić, by zachować w opisanych scenariuszu neutralność w aspekcie duchowym?</u>'
        '<br>'
        '<br>Uczestnicy mogą chodzić pojedynczo i zastanawiać się w ciszy lub, jeśli chcą, w parach i dyskutować między sobą.'
        '<br>'
        '<br>Prowadzący prosi, by uczestnicy <b>nie skupiali się na technikaliach</b> (nie zastanawiali się, czy instruktor zareagował efektywnie), lecz jedynie na skutku działań - wpływie na duchowość (np. postawy lub wartości) wychowanków.'
        '<br>'
        '<br>Uczestnicy mogą notować swoje odpowiedzi, by łatwiej móc do nich wrócić.'
);

KonspektStep _step_neutralnosc_duchowa_omowienie_wnioskow = KonspektStep(
    title: 'Neutralność duchowa - omówienie wniosków',
    duration: Duration(minutes: 15),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Gdy wszyscy uczestnicy skonczą swoje rozważania nad scenariuszami, wracają do wspólnego miejsca i prowadzący prosi uczestników, by doszli do porozumienia w sprawie odpowiedzi na pierwsze pytanie, czyli:'
        '<br>'
        '<br><u><b>1. Czy działanie instruktora miało wpływ na duchowość harcerzy?</b> Jeśli tak, to <b>jakie wartości</b> lub postawy działanie instruktora wzmocniło?</u>'
        '<br>'
        '<br>Prowadzący czeka, aż uczestnicy podyskutują - swoją rolę ogranicza jedynie do notowania ich wspólnych wniosków do każdego ze scenariuszy. Uczestnicy powinni zwrócić uwagę, że każdy ze scenariuszy kształtuje duchowość harcerzy w określonym kierunku:'
        '</p>'

        '<ul>'
        '<li><p style="text-align:justify;">Scenariusz 1 - postawa wybaczenia</p></li>'
        '<li><p style="text-align:justify;">Scenariusz 2 - życie w prawdzie</p></li>'
        '<li><p style="text-align:justify;">Scenariusz 3 - bezinteresowna pomoc bliźnim</p></li>'
        '<li><p style="text-align:justify;">Scenariusz 4 - wyższość dobra jednostki nad wizerunkiem wspólnoty</p></li>'
        '<li><p style="text-align:justify;">Scenariusz 5 (opcjonalny) - wierność w związkach romantycznych</p></li>'
        '<li><p style="text-align:justify;">Scenariusz 6 (opcjonalny) - modlitwa</p></li>'

        '</ul>'

        '<p style="text-align:justify;">'
        '<br>'
        '<br>Gdy dyskusje dobiegną końca, prowadzący może dorzucić kilka swoich niezobowiązujacych uwag na temat wniosków uczestników. Ważniejsze jest jednak, aby szybko przejść do drugiego pytania:'
        '<br>'
        '<br><b><i>“Czy w którymkolwiek scenariuszu instruktor mógł postąpić neutralnie z perspektywy kształtowania duchowości?”</i></b>.'
        '<br>'
        '<br>W toku próby odpowiedzi na to pytanie może wywiązać się między uczestnikami dyskusja. Nie powinna ona trwać zbyt długo. Scenariusze, które zostały omówione przez uczestników powinny prowadzić do wniosku: w sposób oczywisty harcerskie <b>wychowanie nie jest neutralne duchowo</b>.',
    materials: [
      material_zal_neutralnosc_duchowa_przyklady,
    ]

);

KonspektStep _step_neutralnosc_duchowa_w_przypadku_problemow = KonspektStep(
    title: 'Neutralność duchowa - w przypadku problemów',
    duration: Duration(minutes: 5),
    activeForm: false,
    required: false,
    content: '<p style="text-align:justify;">'
        '<br>Jeśli uczestnicy sądzą, że neutralność jest możliwa, prowadzący może zadać pytanie:'
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

KonspektStep _step_neutralnosc_analogia_do_ogrodnikow = KonspektStep(
    title: 'Neutralność duchowa - analogia harcerstwa z ogrodnikami',
    duration: Duration(minutes: 5),
    activeForm: false,
    required: false,
    content: '<p style="text-align:justify;">'
        'Jeśli uczestnicy mają problem ze zrozumieniem, dlaczego zarówno działanie wychowawcze jak i jego brak zawsze kształtuje duchowość wychowanków, prowadzący może przedstawić uczestnikom użyteczną analogię:'
        '<br>'
        '<br><i>ZHP jest jak wielka, rozproszona organizacja ogrodnicza. Zajmuje się ona kształtowaniem krzewów (czyli kształtowaniem duchowości i zdolności harcerzy). Pojawiają się u nas różne drzewka, w różnych formach i kształtach, a zadaniem ogrodników (instruktorów) jest te drzewa przycinać, podlewać, nawozić lub pozwalać im rosnąć tak, by nadać im określony kształt.</i>'
        '<br>'
        '<br>W analogii należy podkreślić, że niezależnie od działania ogrodnika, <b>krzew zawsze ma jakiś kształt</b>. Krzew nabywa określonego kształtu, także wtedy, gdy ogrodnik nic nie robi.'
        '<br>'
        '<br>Harcerstwo jest przedsięwzięciem kształtowania ludzi. W sposób oczywisty kształtuje ich według określonych zasad (np. zasad PH). Wokół faktu, że harcerstwo kształtuje przekonania i wartości młodego człowieka w określonym kierunku narosła dziwna i niepotrzebna kontrowersja - ale <b>bez celowej i planowej zmiany duchowości harcerzy harcerstwo nie ma najmniejszego sensu.</b>.'
        '</p>'
);

KonspektStepGroup step_group_neutralnosc_duchowa = KonspektStepGroup(
    title: 'Neutralność duchowa',
    steps: [
      _step_neutralnosc_duchowa_galeria_sztuki,
      _step_neutralnosc_duchowa_omowienie_wnioskow,
      _step_neutralnosc_duchowa_w_przypadku_problemow,
      _step_neutralnosc_analogia_do_ogrodnikow
    ]
);

// Duchowość w ZHP

KonspektStep _step_duchowosc_w_zhp_dokumenty = KonspektStep(
    title: 'Duchowość w ZHP - dokumenty',
    duration: Duration(minutes: 5),
    activeForm: false,
    aims: [
      'Wskazanie uczestnikom formalnych źródeł stanowiących, że harcerstwo jest dla wszystkich, ale nie wychowuje do wszystkiego - ma ściśle określone wartości, do których kształtuje'
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący przedstawia uczestnikom stosowny fragment statutu ZHP (załącznik $attach_html_cel_wychowania_duchowego_zhp_statut) oraz preambułę uchwały w sprawie wspierania rozwoju duchowego w ZHP (załącznik $attach_html_cel_wychowania_duchowego_zhp_uchwala). Zwraca uwagę na to, że w ZHP mamy ściśle określony zbiór wartości i postaw, do których wychowujemy oraz ramy źródeł wartości. Jeśli uczestnicy będą chcieli - mogą potem do nich zajrzeć.'
        '</p>',
  materials: [
    material_zal_cel_wychowania_duchowego_zhp_statut,
    material_zal_cel_wychowania_duchowego_zhp_uchwala
  ]
);

KonspektStep _step_duchowosc_w_zhp_aksjoamty = KonspektStep(
    title: 'Duchowość w ZHP - aksjomaty',
    duration: Duration(minutes: 20),
    activeForm: false,
    aims: [
      'Uświadomienie uczestnikom, że do wspierania rozwoju duchowego na poziomie Z i H wystarczy poziom postaw i wartości, ale rozwój duchowy z HS i W wymaga pracy na poziomie aksjomatu',
      'Uświadomienie uczestnikom, że harcerskie wartości, oparte na “oczywistych” wartościach naszej cywilizacji, w sposób ścisły wypływają z wiary chrześcijańskiej'
    ],
    content: '<p style="text-align:justify;">'
        '<br>Prowadzący znowu prezentuje uczestnikom scenariusze z użytego już załącznika $attach_html_neutralnosc_duchowa_przyklady. Prowadzący stawia przed nimi zadanie w formie pytania:'
        '<br>'
        '<br><i>“We wszystkich scenariuszach mowa jest o wartościach obecnych w PH. Ale przecież żaden wędrownik (mam nadzieję!) nie będzie przestrzegał PH wierząc, że spadło z nieba na kamiennych tablicach!'
        '<br>'
        '<br>Jakie aksjomaty, lub szerzej: meta-narracje ukształtowały ludzi, dla którego te wartości w sposób oczywisty dobre i do których mogą się dziś odnieść wędrownicy, by wierzyć w słuszność tych wartości?”</i>'
        '<br>'
        '<br>Prowadzący wchodzi z uczestnikami w dyskusję na temat kolejnych wartości opisanych w załączniku $attach_html_neutralnosc_duchowa_przyklady i omawia źródła wartości w poszczególnych scenariuszach, odnosząc się w razie potrzeby do wniosków uczestników.'
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
        '<br>W kulturze konfucjańskiej najpierw liczy się kolektyw, dobro zbiorowości, trwałość systemu państwowego - a dopiero potem dobro jednostki. W Chinach niedopuszczalne jest publiczne okazywanie sporów, ponieważ osłabia to wspólnotę. W kulturze japońskiej należy poświęcić własne plany prywatne, jeśli kolidują one z wydarzeniem firmy, w której się pracuje.'
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

KonspektStep _step_duchowosc_w_zhp_podsumowanie = KonspektStep(
    title: 'Duchowość w ZHP - podsumowanie',
    duration: Duration(minutes: 5),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        '<b>Podsumowanie (dla przewodników)</b>'
        '</p>'

        '<ul>'
        '<li><p style="text-align:justify;">Nie istnieje neutralne wychowanie.</p></li>'
        '<li><p style="text-align:justify;">Jeśli harcerstwo chce być skuteczne wychowawczo, nie może abdykować z rozwoju duchowego na poziomie aksjomatu.</p></li>'
        '<li><p style="text-align:justify;">Harcerskie wychowanie jest fundamentalnie chrześcijańskie, nawet jeśli jego członkowie są innego wyznania.</p></li>'
        '<li><p style="text-align:justify;">Nie należy zbyt łatwo pomijać elementów tradycyjnej duchowości, których jako kadra nie rozumiemy (jako kadra). Zazwyczaj stoją za nimi dziesiątki wieków mądrości.</p></li>'
        '<li><p style="text-align:justify;">Harcerstwo powinno mieć wysokie standardy. Nie po to, by prowadzić selekcję osób mogących harcerzami zostać, ale po to, by wychować ludzi w szacunku do wartości, postaw, a często również wiary, która dała nam świat merytokracji, równości, wolności, godności ludzkiej, przebaczenia, uznania własnej niedoskonałości, powszechnej sprawiedliwości, nauki, itd..</p></li>'
        '</ul>'

        '<p style="text-align:justify;">'
        '<br>'
        '<b>Podsumowanie dodatkowe (dla podharcmistrzów)</b>'
        '</p>'

        '<ul>'
        '<li>'
        '<p style="text-align:justify;">'
        'Mamy w ZHP niechlubną tradycję zmieniania harcerskich zasad i ideałów, gdy okazuje się że postawy harcerzy się z nimi nie spotykają. A przecież to harcerstwo powinno zmieniać ludzi, a nie się do nich dostosowywać.'
        '</p>'
        '</li>'
        '</ul>'
);

KonspektStepGroup step_group_duchowosc_w_zhp = KonspektStepGroup(
    title: 'Duchowość w ZHP',
    steps: [
      _step_duchowosc_w_zhp_aksjoamty,

      _step_duchowosc_w_zhp_dokumenty,

      _step_duchowosc_w_zhp_podsumowanie,
    ]
);

// Strategia wychowania duchowego

KonspektStep _step_strategia_wychowania_duchowego = KonspektStep(
    title: 'Strategia wychowania duchowego',
    duration: Duration(minutes: 15),
    activeForm: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący informuje uczestników, że za kilka chwil ich zadaniem będzie zaprojektować proces wychowania duchowego dla konkretnej jednostki.'
        '<br>'
        '<br>Zanim uczestnicy przejdą do planowania, trzeba ustalić kilka kwestii strategicznych dotyczących filozofii, której jako instruktorzy harcerscy chcą podporządkować styl swojej pracy.'
        '<br>'
        '<br>Prowadzący wydziela następujące przestrzenie do omówienia:'
        '</p>'
        '<ul>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Polityka trzymania wychowanków pod ideowym kloszem</b>'
        '<br>Czy i na jakim etapie duchowość wychowanków ma być kontestowana? Do jakiego stopnia? W jakim celu?'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '<br><i>Początkowo harcerze powinni mieć jednoznaczny, niepodważany, niezmącony przekaz dotyczący tego, co jest dobre, a co złe. Stan ten powinien trwać mniej więcej do początku etapu świadomej integracji duchowości. W dalszej kolejności harcerze powinni być stopniowo wystawiani na inne perspektywy, inne postawy, inne wspólnoty, jednak nie po to, żeby przyjęli ich duchowość, tylko żeby wobec niej utwierdzili swoją własną oraz by nauczyli się funkcjonować w świecie, w którym nie ma jednorodności duchowej.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Polityka fizycznego i emocjonalnego bezpieczeństwa wychowanków</b>'
        '<br>Czy, kiedy i w jakim celu można wystawiać wychowanków na ryzyko? Czy, kiedy i w jakim celu należy wystawiać wychowanków na doświadczenie bezradności, agresji wobec nich, frustracji, etc.?'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '<br><i>Po pierwsze, niektóre niezwykle skuteczne formy wychowawcze mają w sobie element ryzyka: chodzenie w góry, jeżdżenie autostopem, podróże po innych krajach, etc.. Po drugie, świat jest w sposób immanentny niebezpieczny. Niemal na pewno nasi wychowankowie zetkną się w życiu z agresją, bezradnością, frustracją. Lepiej jest ich do tego skutecznie przygotować w kontrolowanych warunkach. To właśnie jest chartem ducha.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Polityka inkluzywności form w sytuacji różnicy aksjomatycznej wychowanków</b>'
        '<br>Czy wszystkie formy muszą być tak skonstruowane, aby każdy wychowanek, niezależnie od aksjomatów swojej duchowości, mógł wziąć w nich udział?'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '<br><i>Absolutnie nie - prowadzi to do zjawiska <b>weganizacji wychowania duchowego</b>, czyli do zjawiska ograniczenia wychowania do najmniejszego wspólnego mianownika duchowości osób o różnych aksjomatach. Ludzie wychowywani w różnych wiarach wymagają różnych form pracy nad swoją duchowością. To, że formy te będa wykluczające dla części osób jest normalne, konieczne i nie należy się tego bać.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Polityka prywatności życia duchowego wychowanków</b>'
        '<br>Czy symbolika, obrzędy, tradycje, język religijny wychowanków może być obecny w przestrzeni publicznej drużyny, w której nie wszyscy są wspólnego wyznania?'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '<br><i>Duchowość to sprawa indywidualna i fundamentalnie osobista, <b>ale</b> jest jednocześnie sprawą publiczna - z duchowości wynika długa lista spraw (zachowania, postawy i wartości), które dotyczą i wpływają na całe otoczenie, w którym człowiek żyje. O wierze można i trzeba o niej rozmawiać, robić dla niej miejsce, można ją publicznie praktykować, także w formie tradycji, czy w warstwie symbolicznej.</i>'
        '</p>'
        '</li>'

        '</ul>',
    materials: [
      material_zal_cel_wychowania_duchowego_zhp_statut,
      material_zal_cel_wychowania_duchowego_zhp_uchwala
    ]
);

KonspektStepGroup step_strategia_wychowania_duchowego = KonspektStepGroup(
    title: 'Strategia wychowania duchowego',
    steps: [
      _step_strategia_wychowania_duchowego
    ]
);

// Szybkie strzały dyskusyjne

KonspektStep step_szybkie_strzaly_dyskusyjne = KonspektStep(
    title: 'Szybkie strzały dyskusyjne',
    duration: Duration(minutes: 30),
    activeForm: true,
    required: false,
    materials: [
      material_zal_szybkie_strzaly_dyskusyjne
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący rozkłada na podłodze kartki z załącznika $attach_html_szybkie_strzaly_dyskusyjne rewersem do góry (zakryte). Zadaniem uczestników jest kolejno podchodzić do kartek, wybierać losową i odczytać jej treść.'
        '<br>'
        '<br>Po odczytaniu każdej kartki uczestnicy mają krótką chwilę na dyskusję. Prowadzący może w trakcie dyskusji zadawać pytania, jednak do jej końca nie prezentuje swojego stanowiska. Dojście do wspólnej konkluzji przez uczestników nie jest ważne. Na końcu każdej dyskusji prowadzący może powiedzieć krótko co uważa na wywołany temat.'
        '<br>'
        '<br>Sugestie do kartek:'
        '</p>'
        '<ul>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>Nie powinno się wychowywać człowieka w konkretnym celu.</u>'
        '<br>'
        '<br><i>Nie da się wychować człowieka w sposób "neutralny" - każde działanie wychowawcze kształtuje duchowość człowieka w jakimś kierunku. Zamiast robić fikołki siląc się na nieosiągalną neutralność, lepiej świadomie określić zawczasu cele wychowawcze.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>Religia jest dodatkiem do duchowości i nie każdy musi ją mieć.</u>'
        '<br>'
        '<br><i>Religia nie jest "dodatkiem" do duchowości - religia jest konkretną duchowością. Niektóre duchowości nie są religią, jednak nie zmienia to faktu, że tak jak każda religia mają określone arbitralne, dogmatyczne prawdy na temat świata.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>Jeśli ktoś chce kościelnego harcerstwa, powinien pójść do ZHRu.</u>'
        '<br>'
        '<br><i>Cywilizacja łacińska, powszechne na zachodzie normy moralne i Prawo Harcerskie wszystkie są bezpośrednio spadkobiercami chrześcijaństwa. ZHP zapewnia pełnowartościowe wychowanie duchowe osobom wierzącym, a uwzględnianie w procesie wychowawczym roli wspólnoty Kościoła jest tego kluczowym elementem.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>Religia to prywatna sprawa każdego człowieka i nie powinien się z nią afiszować.</u>'
        '<br>'
        '<br><i>Życie religijne człowieka jest sprawą indywidualną i fundamentalnie osobistą, ale jest jednocześnie sprawą publiczną - z religii wynika długa lista spraw (zachowania, postawy i wartości), które dotyczą i wpływają na całe otoczenie, w którym człowiek żyje. O wierze można i trzeba o niej rozmawiać, robić dla niej miejsce, można ją publicznie praktykować.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>Patriotyzm to duchowość.</u>'
        '<br>'
        '<br><i>Patriotyzm to postawa, a postawy są elementem duchowości.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>Wszystkie niebezpieczne działania są niewychowawcze i nieodpowiedzialne.</u>'
        '<br>'
        '<br><i>Życie jest niebezpieczne i nie da się odizolować od tego człowieka. Zamiast chować go pod kloszem i wychowywać do życia w nieistniejącym świecie, lepiej dawkować młodemu człowiekowi doświadczenie braku bezpieczeństwa - takie działania mogą być ryzykowne, ale są wychowawcze i są wyrazem odpowiedzialności za przyszłość młodego człowieka.</i>'
        '</p></li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>Każdy harcerz powinien mieć dowolność w tym, jak chce się rozwijać duchowo.</u>'
        '<br>'
        '<br><i>Harcerstwo jest ruchem, który wychowuje do określonych zachowań, postaw i wartości, co jest możliwe tylko drogą wpływania na określone aksjomaty człowieka. Harcerstwo wychowuje z zachowaniem indywidualności, ale robi to we wspólnym dla wszystkich kierunku, który jest określony w statucie i tradycji harcerskiej. Elementy dobrowolności są narzędziem do skutecznego budowania harcerskiego ducha.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>W ZHP nie wolno narzucać poglądów.</u>'
        '<br>'
        '<br><i>Harcerstwo jest ruchem, który wychowuje do określonych zachowań, postaw i wartości, co jest możliwe tylko drogą wpływania na określone aksjomaty człowieka. Poglądy, do których wychowuje harcerstwo są określone w statucie i tradycji harcerskiej. Powinno się to odbywać w sposób nienachalny, aby wychowanie było skuteczniejsze, nie dlatego, że harcerstwo jest wolne od konkretnych poglądów.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>Możliwość zamknięcia próby instruktorskiej powinna zależeć od poglądów kandydata.</u>'
        '<br>'
        '<br><i>Tak. Instruktorzy wychowuję również poprzez przykład własny i pełnią rolę autorytetów, dlatego ma to znaczenie, jakie poglądy reprezentuje instruktor. Nie każdy człowiek powinien nim być.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>W ramach działań drużyny nie powinno być aktywności religijnych, gdyż te wykluczają niewierzących.</u>'
        '<br>'
        '<br><i>Osoby wyznające wiarę w osobowego Boga, aby móc rozwijać swoją duchowość muszą brać udział w formach, w które są niecelowe dla osób niereligijnych. Ograniczanie osobom wychowywanym w wierze form religijnych, tabuizowanie tematu wiary i religii jest dla nich krzywdzące. Skuteczne wychowanie osób o różnych aksjomatach w jednej drużynie <b>zawsze prowadzi przez formy, które są nieinkluzywne</b> - zjawisko to jest normalne i pożądane. Uciekanie od tego faktu skutkuje zjawiskiem <b>weganizacji procesu wychowawczego</b>.</i>'
        '</p>'
        '</li>'

        '</ul>'

        '<p style="text-align:justify;">'
        'Na końcu, jeśli starczy czasu, prowadzący może sam przedstawić jeszcze trzy "strzały":'
        '</p>'

        '<ul>'
        '<li><p style="text-align:justify;">Boga nie powinno być w Przyrzeczeniu, bo niektórzy harcerze składaliby Przyrzeczenie wbrew swoim przekonaniom.</p></li>'
        '<li><p style="text-align:justify;">Polski nie powinno być w Przyrzeczeniu, bo niektórzy harcerze składaliby Przyrzeczenie wbrew swoim przekonaniom.</p></li>'
        '<li><p style="text-align:justify;">Pomoc bliźnim nie powinna być w Przyrzeczeniu, bo niektórzy harcerze składaliby Przyrzeczenie wbrew swoim przekonaniom.</p></li>'
        '</ul>'

        '<p style="text-align:justify;">'
        'Celem tych trzech "strzałów" jest zwrócenie uwagi, że harcerstwo nie ma technicznej możliwości wychowywać do zbyt szerokiej puli poglądów, ponieważ przestanie wówczas wychowywać do czegokolwiek.'
        '</p>'
);