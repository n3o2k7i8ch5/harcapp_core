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

KonspektMaterial material_zal_sfery = KonspektMaterial(
    name: 'Wydrukowany załącznik "$attach_title_sfery"',
    attachmentName: attach_name_sfery,
    amount: 1
);

KonspektMaterial material_zal_sfery_przyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik "$attach_title_sfery_przyklady"',
    attachmentName: attach_name_sfery_przyklady,
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
  amount: 2,
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

KonspektMaterial material_zal_karty_zalozen_wyjsciowych_wychowania_duchowego = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_karty_zalozen_wyjsciowych_wychowania_duchowego”',
    attachmentName: attach_name_karty_zalozen_wyjsciowych_wychowania_duchowego,
    amount: 1,
);

KonspektMaterial material_zal_szybkie_strzaly_dyskusyjne = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_szybkie_strzaly_dyskusyjne”',
    attachmentName: attach_name_szybkie_strzaly_dyskusyjne,
    amount: 1,
    additionalPreparation: 'Załącznik należy pociąć na 10 kartek wzdłuż przerywanych linii.'
);

// ---

String aksjomaty_przyklady = '<ul>'
    '<li><p style="text-align:justify;">“Świat stworzył przypadek. Świadomość człowieka jest iluzją fizyki, nie ma żadnego celu.”</p></li>'
    '<li><p style="text-align:justify;">“Świat stworzyła wróżka. Ludzie są powiewami meta-powietrza jej tchnienia. Po śmierci człowiek może również stać się wróżką, jeśli wchłonie odpowiednio dużo energii wszechświata poprzez medytację.”</p></li>'
    '<li><p style="text-align:justify;">“Wszystko jest iluzją. Istnieję tylko ja, reszta to zaprogramowane postaci w mojej głowie. Iluzja ta pryśnie, jeśli wszyscy ludzie uwierzą, że w niej żyją.”</p></li>'
    '<li><p style="text-align:justify;">“Świat stworzył trójjedyny Bóg, powołał człowieka na swój obraz, by doświadczył miłości.”</p></li>'
    '</ul>';



KonspektStep step_sfery_rozwoju = KonspektStep(
    title: 'Sfery rozwoju - wymienienie',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący przygotowuje kartki "sfera ciała", "sfera umysłu", "sfera relacji", "sfera emocji" oraz "sfera ducha" z załącznika $attach_html_sfery. Następnie prosi uczestników o wymienienie sfer rozwoju, zgodnie z którymi ruch harcerski rozwija swoich członków. Za każdym razem, gdy uczestnicy wymienią jakąś sferę, prowadzący kładzie we wspólnej przestrzeni odpowiednią kartkę.'
        '</p>'
);

KonspektStep step_sfery_rozwoju_przyklady = KonspektStep(
    title: 'Sfery rozwoju - wymienienie',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący w losowej kolejności odczytuje uczestnikom 8 kartek <b>z białym tłem</b> z załącznika $attach_html_sfery_przyklady. Każdorazowo prosi uczestników o wskazanie, z którą sferą rozwoju określona jest odczytana kartka.'
        '</p>'

        '<p style="text-align:justify;">Prawidłowe odpowiedzi:</p>'
        '<ul>'
        '<li><p style="text-align:justify;"><i>Potrafi przebiec 5 kilometrów w 20 minut</i> - <b>Ciało</b></p></li>'
        '<li><p style="text-align:justify;"><i>Zachowuje zdrowie nawet w fatalnych warunkach pogodowych</i> - <b>Ciało</b></p></li>'
        '<li><p style="text-align:justify;"><i>W 6 miesięcy umie opanować dowolny język obcy</i> - <b>Umysł</b></p></li>'
        '<li><p style="text-align:justify;"><i>Zna budowę silnika mechanicznego</i> - <b>Umysł</b></p></li>'
        '<li><p style="text-align:justify;"><i>Panuje nad sobą, niezależnie od sytuacji</i> - <b>Emocje</b></p></li>'
        '<li><p style="text-align:justify;"><i>Rozróżnia tylko trzy stany samopoczucia: "super", "ok" i "źle"</i> - <b>Emocje</b></p></li>'
        '<li><p style="text-align:justify;"><i>Ma czwórkę rodzeństwa</i> - <b>Relacje</b></p></li>'
        '<li><p style="text-align:justify;"><i>Jest zaręczony ze swoją dziewczyną, którą zna od liceum</i> - <b>Relacje</b></p></li>'
        '</ul>'
);

KonspektStep step_sfery_rozwoju_sfera_ducha_jest_inna = KonspektStep(
    title: 'Sfery rozwoju - sfera ducha jest inna niż wszystkie',
    duration: Duration(minutes: 1),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący mówi:'
        '<br>'
        '<br>'
        '<i>Ktoś mógłby zapytać: <b>"dlaczego do tej pory gadamy o wszystkim, tylko nie o sferze ducha?"</b>. Otóż często panuje przekonanie, że sfera ducha to w sfera jak każda inna - dotyczy jakiegoś kolejnego fragmentu człowieka, oraz że jej sposób rozwoju jest zbliżony do np. sfery umysłu, czy emocji.'
        '<br>'
        '<br>Taki pogląd to fundamentalny błąd i żeby zrozumieć dlaczego, najpierw pochylmy się nad wymienionymi dotąd sferami.'
        '</i>'
        '</p>'
);

KonspektStep step_sfery_rozwoju_sfery_funkcjonalne = KonspektStep(
    title: 'Sfery rozwoju - sfery funkcjonalne',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący zwraca uwagę, że każdą z dotychczas przywołanych sfer: ciała, umysłu, emocji i relacji łączy to, że są bez wyjątku źródłem <b>zdolności</b>. Rozwijając je, człowiek zyskuje nowe kompetencje, narzędzia, możliwości - zyskuje np. możliwość szybkiego biegu, narzędzia jakim jest wiedza, czy zdolność rozwiązywanie skomplikowanych problemów. Ponieważ owe sfery są źródłem nowych funkcjonalności, z których człowiek może w życiu korzystać, o tych sferach można zbiorczo mówić jako o <b>sferach funkcjonalnych</b>.'
        '<br>'
        '<br>Następnie prowadzący obrazowo zbiera rozłożone wcześniej karty sfery ciała, umysłu, relacji i emocji w stosik i przykrywa go kartą "sfery funkcjonalne", również z załącznika $attach_html_sfery.'
        '<br>'
        '<br>Prowadzący dodaje również, że traktowanie sfer funkcjonalnych łącznie jako źródło zdolności, kompetencji i moźliwości ma dużą zaletę: to, że ktoś sobie podzielił sfery funkcjonalne na 4 jest arbitalną decyzją. Równie dobrze można byłoby zmieścić wszystko w dwóch: sferze ciała i umysłu, który przecież odpowiada zarówno za sferę emocji człowieka jak i za kompetencje społeczne. Można również pójść w drugą stronę i wydzielić więcej sfer: np. dodać sferę zasobów materialnych.'
        '<br>'
        '<br>Aby podeprzeć się przykładem, że nawet w obecnym podziale niektóre zdolności nie pasują do tylko jednej sfery, prowadzący może skorzystać z <b>dwóch szarych kartek</b> z załącznika $attach_html_sfery_przyklady i poprosić uczestników o wskazanie, do której sfery funkcjonalnej przynależą zapisane na nich zdolności.'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;"><i>Potrafi w kilka dni zdyskredytować czyjąś reputację</i> - <b>Relacje</b> i <b>Umysł</b></p></li>'
        '<li><p style="text-align:justify;"><i>Potrafi zagrać na fortepianie każdy utwór Chopina</i> - <b>Ciało</b>, <b>Umysł</b> i <b>Emocje</b></p></li>'
        '</ul>'
);

KonspektStep step_sfery_rozwoju_sfera_ducha = KonspektStep(
    title: 'Sfery rozwoju - sfera ducha',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący mówi:'
        '<br>'
        '<br><i>Sfery funkcjonalne, czyli źródło zdolności człowieka, to - jak się zapewne domyślacie - dopiero połowa historii.</i>'
        '<br>'
        '<br>Prowadzący przedstawia prostą intuicję:'
        '<br>'
        '<br><i>Wyobraźcie sobie trzech ludzi: Alberta, Bartka i Cezarego. Mieszkają w tym samym mieście. Każdy ma 20 lat. Pracują w tej samej firmie zajmującej się montażem eletryki. Wszystkie te zdolności</i> - prowadzący wskazuje na zdolności z załącznika $attach_html_sfery_przyklady - <i>opisują każdego z nich: każdy z nich umie tak samo dobrze biegać, każdy z nich tak samo dobrze rozumie budowę silnika, każdy z nich ma narzeczoną (oczywiście są to różne osoby) itd. Ba: są tak podobni, że każdy z nich ma absolutnie identyczną listę zdolności, talentów, możliwości, kompetencji, w skrócie <b>ich sfery funkcjonalne są identyczne</b>.</i>'
        '<br>'
        '<br><u>Historia 1:</u>'
        '<br><i>Pewnego ranka jeden z nich bierze auto z pracy i jedzie do klienta montować elektrykę. Niestety w połowie drogi auto się psuje i staje na poboczu. Na zewnątrz jest minus piętnaście stopni.'
        '<br>'
        '</i></p>'
        '<ul>'
        '<li><p style="text-align:justify;"><i>Gdyby autem jechał Albert, to bez zastanowienia otworzyłby maskę i zaczął naprawiać auto.</i></p></li>'
        '<li><p style="text-align:justify;"><i>Gdyby autem jechał Bartek, nie ruszyłby się z auta, tylko natychmiast zadzwonił do ubezpieczyciela, żeby mu szybko przywieźli auto zastępcze.</i></p></li>'
        '<li><p style="text-align:justify;"><i>Gdyby autem jechał Cezary, wziąłby narzędzia, zostawił samochód i pobiegł resztę trasy pieszo, żeby wykonać u klienta zlecenie.</i></p></li>'
        '</ul>'
        '<p style="text-align:justify;"><i>'
        'Wszyscy trzej mają absolutnie te same zdolności. Wszyscy trzej umieją otworzyć maskę i znaleźć problem, umieją zadzwnoić do ubezpieczyciela i umieją dobiec na czas do klienta. Umieją to samo, a jednak każdy skorzystałby z zupełnie innych zdolności i w innym celu.</i>'
        '<br>'
        '<br>Prowadzący robi pauzę, po czym podsumowuje:'
        '<br>'
        '<br><i>Sfery funkcjonalne definiują co człowiek może. Sfera ducha definicuje jak i do czego ze swoich możliwości korzysta.</i>'
        '<br>'
        '<br>Prowadzący kładzie we wspólnej przestrzeni, obok kartki "sfery funkcjonalne", kartkę "sfera ducha" z załącznika $attach_html_sfery.'
        '</p>'
);







KonspektStep step_sfery_rozwoju_i_ich_relacje = KonspektStep(
    title: 'Sfery rozwoju i ich relacje',
    duration: Duration(minutes: 15),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci wprowadza podział człowieka na 5 sfer rozwoju - 4 sfery funkcjonalne: <b>ciało</b>, <b>umysł</b>, <b>emocje</b>, <b>relacje</b> i jedną sferę centralną: sferę <b>ducha</b>.'
        '<br>'
        '<br>Prowadzący opisuje zależności między sferami - sfery funkcjonalne dostarczają człowiekowi <b>zdolności</b>, zaś sfera ducha jest <b>sposobem</b> ich zarządzania.'
        '<br>'
        '<br>Prowadzący może też skorzystać z analogii sfer do samochodu i kierowcy z załącznika $attach_html_poradnik_o_strukturze_duchowosci.'
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
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący, opierając się na poradniku $attach_html_poradnik_o_strukturze_duchowosci wprowadza kolejno rozróżnienie poziomów duchowości: <b>zachowań</b>, <b>wartości</b> i <b>aksjomatów</b> (kolejność definiowania jest ważna). Po zdefiniowaniu każdego poziomu kładzie w widocznym miejscu odpowiednią kartkę z załącznika $attach_html_karty_poziomow_duchowosci, aby uczestnicy mogli w każdej chwili do nich wrócić.'
        '<br>'
        '<br>Prowadzący może w tym miejscu posiłkować się przykładem:'
        '</p>'

        '<table border="1" style="border-collapse: collapse; width: 100%;">'
        '<tr>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Zachowanie</p></td>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Oddanie własnego obiadu bezdomnemu</p></td>'
        '</tr>'
        '<tr>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Wartość</p></td>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Godność każdego człowieka</p></td>'
        '</tr>'
        '<tr>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Aksjomat</p></td>'
        '<td style="padding-left: 8px; padding-right: 8px;"><p>Bóg z miłości stworzył każdego człowieka na swój obraz</p></td>'
        '</tr>'
        '</table>'

        '<p style="text-align:justify;">'
        'Dodatkowo prowadzący definiuje skróty: duchowość <b>wymierna</b> (poziom zachowań) i <b>głęboka</b> (poziom wartości i aksjomatów).'
        '<br>'
        '<br>Prowadzący powinien zaznaczyć, że „poziom duchowości" oznacza tu warstwę czy piętro hierarchii, a nie stopień zaawansowania (jak np. poziom w grze komputerowej).'
        '</p>'
);

KonspektStep _step_poziomy_duchowosci_przyklady_uczestnikow = KonspektStep(
    title: 'Poziomy (warstwy) rozwoju duchowego - przykłady uczestników',
    duration: Duration(minutes: 5),
    required: false,
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący prosi uczestników o podanie kilku przykładów do każdego poziomu duchowości i ew. wchodzi w krótką dyskusję, jeśli coś jest nie tak w przykładach uczestników.'
        '<br>'
        '<br><u>Uwagi o wartościach:</u>'
        '</p>'

        '<ul>'

        '<li>'
        '<p style="text-align:justify;">'
        'Wartości zawsze oceniają <b>stan świata</b>. Bezstanowe określenia w stylu "rodzina" formalnie nie są wartością: mogą nią być "posiadanie rodziny", "majętność rodziny", "szczęście członków rodziny", "liczebność rodziny".'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        'Mimo to, przecież ludzie mówią: <i>"rodzina jest dla mnie wartością"</i>!'
        '<br>'
        '<br>Gdy takie stwierdzenie wypowiada konkretna osoba, to w istocie deklaruje: <i>"dobro rodziny, tak jak je rozumiem, jest dla mnie wartością"</i>. Przykładowo:'
        '<br>'
        '<br>Gdy Marian deklaruje: <i>"rodzina jest dla mnie wartością"</i>, to w istocie stwierdza: <i>"ja, Marian, mam swoje przekonania, definicję dobra i zła. Chciałbym, aby wszystko na świecie było dobre, niestety, nie mogę zająć się na raz swoim zdrowiem, pracą i rodziną. Obszarem, który uważam za priorytetowy w doprowadzeniu do "dobra" jest moja rodzina. Dobra rodzina to dla mnie taka, której członkowie sobie ufają i się wspierają, więc nad tym będę pracował."</i>.'
        '<br>'
        '<br>Oznacza to w istocie, że dla Mariana wartością jest <i>"wzajemne zaufanie i wsparcie członków rodziny"</i>.'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        'Wartości nie muszą być wcale przemyślane, górnolotne i głębokie. Chwilowo człowiek może kierować się wartością <b>doświadczania przyjemności</b> wynikającej ze zjedzenia cukierka, czy <b>poczucie euforii</b> po kupieniu nowych ciuchów. To także są wartości wpisane w strukturę wartości człowieka.'
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
  activeForm: KonspektStepActiveForm.static,
  content: '<p style="text-align:justify;">'
      'Poziom zachowań i wartości są dla większości osób zrozumiałe, jednak poziom aksjomatu może być nieintuicyjny. Po zdefiniowaniu wszystkich trzech poziomów duchowości, prowadzący zatrzymuje się dłużej nad aksjomatami.'
      '<br>'
      '<br>Prowadzący podaje kilka przykładów aksjomatów, np.:'
      '</p>'

      '$aksjomaty_przyklady'

      '<p style="text-align:justify;">'
      '<b>Aksjomat jest zawsze fundamentalną, niesprawdzalną wiarą w określony porządek rzeczy — i całkowicie porządkuje postrzeganie rzeczywistości</b>. Aby to zobrazować, prowadzący może posłużyć się przykładem:'
      '<br>'
      '<br><i>"Jeśli ktoś wierzy, że Ziemia jest płaska, to wszystko inne podporządkuje pod to założenie. Również, jeśli zobaczy dowód na kulistość Ziemi, to wniosek będzie miał tylko jeden: narzędzia użyte przy tych dowodach były wadliwe.'
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
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.active,
    content: '<p style="text-align:justify;">'
        'Aby uczestnicy oswoili się z aksjomatami, prowadzący rozdaje im wycięte i pomieszane kartki z przykładami z załączników $attach_html_aksjomaty_opisu_przyklady, $attach_html_aksjomaty_opisu_i_sensu_przyklady, $attach_html_aksjomaty_sensu_przyklady i $attach_html_aksjomaty_bledne_przyklady.'
        '<br>'
        '<br>Zadaniem uczestników jest pogrupować przykłady aksjomatów odpowiednio jako <b>aksjomaty opisu</b>, <b>aksjomaty opisu i sensu</b> oraz <b>aksjomaty sensu</b> - mając na uwadze, że <b>kilka przykładów nie jest aksjomatem</b> w ogóle. W trakcie ćwiczenia uczestnicy mogą prosić prowadzącego o pomoc.'
        '<br>'
        '<br>Kartki z przykładowymi aksjomatami powinny zostać ułożone w trzech kolumnach pod wyłożoną podczas prezentowania poziomów duchowości kartką "Aksjomat". Przykłady, które nie są aksjomatami należy odłożyć gdzieś z boku.'
        '<br>'
        '<br>Na końcu prowadzący pokrótce omawia z uczestnikami poprawność ich dopasowania.'
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
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący bierze dużą kartkę (np. flipchart) i rysuje na niej dwie prostopadłe osie współrzędnych. Na osi X zaznacza <b>czas</b>, zaś na osi Y <b>poziom duchowości</b>. Tłumaczy przy tym, że przejdzie teraz z uczestnikami krok po kroku przez sposób, w jaki kształtuje się duchowość człowieka.'
        '</p>',
);

KonspektStep _step_etapy_ksztaltowania_integracja_duchowosci = KonspektStep(
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
);

KonspektStep _step_integracja_duchowosci_jak_nie = KonspektStep(
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
);

KonspektStep _step_integracja_duchowosci_wstepna_wartosci = KonspektStep(
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
);

KonspektStep _step_integracja_duchowosci_wstepna_aksjomatow = KonspektStep(
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
      '<br><i>Podczas integracji wstępnej duchowość człowieka jest integrowana "po raz pierwszy". Mało tu jest głębokich, życiowych rozważań, a więcej chłonięcia otoczenia. <b>Wartości wyłaniają się z nauczonych zachowań</b>. <b>Aksjomaty wyłaniają się z wcześniej przyjętych wartości</b>. Kształt duchowości zależy tu przede wszystkim od <b>środowiska</b> i <b>temperamentu</b> człowieka.',
);

KonspektStep _step_integracja_duchowosci_swiadoma = KonspektStep(
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
);

KonspektStep _step_integracja_duchowosci_swiadoma_implikacja = KonspektStep(
    title: 'Integracja duchowości - implikacja dla wychowawców',
    duration: Duration(minutes: 1),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'O ile można skutecznie wpływać na wartości, zachowania i postawy młodego człowieka, o tyle wpływ na aksjomat jest już bardziej subtelny. Do aksjomatów można młodego człowieka najwyżej "podprowadzić": owszem, są one kształtowane na podstawie własnych doświadczeń, znanych poglądów i przyjętych uprzednio wartości, jednak przyjąć aksjomat za własny można jedynie samemu, wedle własnego, osobistego przekonania. W tym procesie nie da się komuś towarzyszyć do końca.'
        '</p>',
);

KonspektStepGroup step_group_integracja_duchowosci = KonspektStepGroup(
    title: 'Integracja duchowości',
    steps: [
      _step_integracja_duchowosci_osie,
      _step_etapy_ksztaltowania_integracja_duchowosci,
      _step_integracja_duchowosci_jak_nie,
      _step_integracja_duchowosci_wstepna_wartosci,
      _step_integracja_duchowosci_wstepna_aksjomatow,
      _step_integracja_duchowosci_swiadoma,
      _step_integracja_duchowosci_swiadoma_implikacja,
    ]
);



// Meta-narracja

KonspektStep _step_meta_narracja_scenka_wprowadzenie = KonspektStep(
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
);

KonspektStep _step_meta_narracja_scenka_przygotowanie = KonspektStep(
    title: 'Meta-narracja - scenka - przygotowanie',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.active,
    content: '<p style="text-align:justify;">'
        'Uczestnicy mają pięć minut, aby ustalić między sobą strategię rozmowy.'
        '</p>'
);

KonspektStep _step_meta_narracja_scenka = KonspektStep(
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
);

KonspektStep _step_meta_narracja_omowienie_scenki = KonspektStep(
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
);

KonspektStep _step_meta_narracja_opowiesci = KonspektStep(
    title: 'Meta-narracja - opowieści',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący podsumowuje dotychczasowe wnioski:'
        '<br>'
        '<br><i>Jeżeli chcemy, żeby Adam uznał wartość przebaczenia, to musimy ukształtować jego źródła wartości, czyli aksjomaty. Zanim wskoczymy do oceanu metod skutecznego kształtowania duchowości, musimy jeszcze zatrzymać się nad kwestią aksjomatów.</i>'
        '<br>'
        '<br>Prowadzący zwraca uwagę, że kształtując czyjś fundament duchowości, nie można pozbierać losowych aksjomatów w jedną kupę i powiedzieć komuś: masz, wykuj to, od dziś tym się kierujesz.'
        '<br>'
        '<br>Aksjomaty muszą po pierwsze <b>być między sobą spójne</b>, zaś po drugie muszą wynikać ze sposobu, w jaki człowiek postrzega rzeczywistość - zaś ta cecha jest w gatunku homo sapiens niezmienna od setek tysięcy lat — a tą cechą są <b>archetypiczne opowieści</b>.'
        '</p>'
);

KonspektStep _step_meta_narracja_czy_opowiesci_to_atawizm = KonspektStep(
    title: 'Meta-narracja - czy opowieści to atawizm?',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący zwraca uwagę, że zazwyczaj, gdy współczesny człowiek słyszy o widzeniu świata w perspektywie opowieści, myśli o prehistorycznych ludach, które nie umiały wyjaśnić przyczyny chorób, deszczu, ani burz, więc wymyślali sobie jakieś bajeczki na ten temat, które dziś są zupełnie śmieszne.'
        '<br>'
        '<br>Opowieści kształtujące ludzkie postrzeganie są jednak czymś dużo głębszym: w greckiej mitologii nie chodzi o to, że jest jakiś chłop z błyskawicami na chmurce, ale o prawidła rządzące rzeczywistym światem, do którego opowiedzenia najwygodniej użyć fikcyjnych aktorów.'
        '<br>'
        '<br>To jasne, że nie było nigdy takiego człowieka, jak Odyseusz i że nie było nigdy żadnych cyklopów. Odyseja nie jest jednak o tym: chodzi o wyrażenie tego, że życie nie jest procesem, który można sobie zaplanować, albo z którym można się siłować i że próba powrotu do miejsca zwanego domem bywa procesem, który może trwać dwie dekady, zanim się w końcu uda.'
        '<br>'
        '<br>Nic się w tym zakresie nie zmieniło do dziś. Dlaczego ludzie płacą za to, żeby siedzieć z jakimiś losowymi ludźmi i gapić się przez dwie godziny na ekran kina, na którym lecą Avengersi, Władca Pierścieni, czy Gwiezdne Wojny? Dziś widzimy świat przez opowieść o instytucjach i państwach, wierzymy w swoją życiową misję względem rodziny, widzimy walkę wielkich, złych korporacji z dobrymi, zwykłymi ludźmi, wierzymy w oświeceniową opowieść o niezbywalnej godności człowieka, w opowieści o bohaterach poległych za ojczyznę, w kapłańską rolę naukowców obcujących z najczystszą formą prawdy. To nie jest atawizm — to sposób, w jaki każdy człowiek postrzega rzeczywistość.'
        '</p>'
);

KonspektStep _step_meta_narracja_definicja = KonspektStep(
    title: 'Meta-narracja - definicja i przykłady',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    materials: [
      material_zal_meta_narracja_opis,
      material_zal_meta_narracja_przyklady,
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący mówi:'
        '<br>'
        '<br><i>Wśród wszystkich opowieści istnieje bardzo wąska, ale szczególna kategoria — opowieści tak fundamentalne, że porządkują całą rzeczywistość. Opowieść, która mówi człowiekowi kim jest, jak działa jego świat, co jest dobre i jaki jest sens. Opowieści te noszą nazwę <b>meta-narracji</b>.</i>'
        '<br>'
        '<br>Prowadzący kładzie przed uczestnikami (obok kartki "Aksjomat") opis meta-narracji z załącznika $attach_html_meta_narracja_opis i odczytuje go:'
        '<br>'
        '<br><i>Meta-narracja to opowieść o świecie, obok której nie można przejść obojętnie. To opowieść tak głęboka, tak wielka, tak dojmująca i fundamentalna, że niejako chwyta człowieka za samo serce i staje się dla niego głównym punktem odniesienia jego obecności w świecie.'
        '<br>'
        '<br>Meta-narracja jest opowieścią o świecie, jego aktorach, o osobistej roli przyjmującego ją człowieka.</i>'
        '<br>'
        '<br>Prowadzący natychmiast przedstawia uczestnikom kilka przykładów meta-narracji z załącznika $attach_html_meta_narracja_przyklady i kładzie je obok karty "Meta-narracja".'
        '</p>'
);

KonspektStep _step_meta_narracja_powrot_do_scenki = KonspektStep(
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
);

KonspektStep _step_meta_narracja_pytania = KonspektStep(
    title: 'Meta-narracja - pytania',
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Uczestnicy mogą dopytać o niejasne kwestie związane z meta-narracją.'
        '</p>'
);

KonspektStepGroup step_group_metanarracja = KonspektStepGroup(
    title: 'Meta-narracja',
    steps: [
      _step_meta_narracja_scenka_wprowadzenie,
      _step_meta_narracja_scenka_przygotowanie,
      _step_meta_narracja_scenka,
      _step_meta_narracja_omowienie_scenki,
      _step_meta_narracja_opowiesci,
      _step_meta_narracja_czy_opowiesci_to_atawizm,
      _step_meta_narracja_definicja,
      _step_meta_narracja_powrot_do_scenki,
      _step_meta_narracja_pytania,
    ]
);


// Zdolności integracji duchowości

KonspektStep _step_zdolnosci_integracji_duchowosci = KonspektStep(
  title: 'Zdolności integracji duchowości',
  duration: Duration(minutes: 5),
  activeForm: KonspektStepActiveForm.static,
  materials: [
    material_zal_karty_zdolnosci_integracji_duchowosci
  ],
  content: '<p style="text-align:justify;">'
      'Prowadzący bierze obie kartki z załącznika $attach_html_karty_zdolnosci_integracji_duchowosci i kładzie je zakryte przed uczestnikami (rewersem do góry). Następnie zadaje pytanie:'
      '<br>'
      '<br><i>“Ustaliliśmy już w jaki sposób modelowo przebiega proces kształtowania duchowości człowieka. Ale! Wiedzieć, to jedno, a móc, to drugie. Jakie dwie, fundamentalne zdolności musi każdy człowiek posiadać (poza wiedzą o mechanizmie kształtowania duchowości), aby móc skutecznie rozwijać swoją duchowość?”</i>'
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
    activeForm: KonspektStepActiveForm.static,
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
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący podsumowuje strukturę i sposób kształtowania duchowości:'
        '<br>'
        '<br><i>Duchowość człowieka to sposób, w jaki żyje. Aby duchowość mogła być prawidłowo kształtowana, konieczna jest <b>zdolność do określania kierunku jej zmian</b> oraz <b>zdolność do ich przeprowadzenia pomimo przeciwności</b>.</i>'
        '<br>'
        '<br>Prowadzący daje uczestnikom czas na pytania, które chcieliby przedyskutować.'
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

// Neutralność

KonspektStep _step_neutralnosc_duchowa_galeria_sztuki = KonspektStep(
    title: 'Neutralność duchowa - galeria sztuki',
    duration: Duration(minutes: 15),
    activeForm: KonspektStepActiveForm.active,
    aims: [
      'Zaprezentowanie uczestnikom wartości i postaw (przebaczenie, prawdomówność, pomoc bliźnim, indywidualizm, ew. wierność w związku, modlitwa), które choć pozornie uniwersalne, wcale nie są domyślne, oczywiste, czy neutralne',
      'Przekonanie uczestników, że neutralność światopoglądowa w wychowaniu nie jest możliwa'
    ],
    materials: [
      material_zal_neutralnosc_duchowa_przyklady,
      material_tasma_klejaca,
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący (najlepiej przed przystąpieniem do formy) rozwiesza na różnych ścianach kartki z załącznika $attach_html_neutralnosc_duchowa_przyklady (jeśli jest taka możliwość i pogoda temu sprzyja, warto rozwiesić kartki na zewnątrz, żeby przewietrzyć uczestników!). Wszystkie kartki zawierają scenariusze sytuacji wychowawczych z udziałem instruktora harcerskiego.'
        '<br>'
        '<br>Uczestnicy mają 15 minut, aby przejść się między wszystkimi scenariuszami, przeczytać je, po czym odpowiedzieć do każdego na dwa pytania:'
        '</p>'

        '<ol>'
        '<li>'
        '<p style="text-align:justify;">'
        '<b>Czy działanie instruktora miało wpływ na duchowość harcerzy?</b> Jeśli tak, to <b>jakie wartości</b> lub postawy działanie instruktora wzmocniło?'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        'Jak należałoby postąpić, by zachować w opisanym scenariuszu neutralność w aspekcie duchowym?'
        '</p>'
        '</li>'
        '</ol>'

        '<p style="text-align:justify;">'
        'Uczestnicy mogą chodzić pojedynczo i zastanawiać się w ciszy lub, jeśli chcą, w parach i dyskutować między sobą.'
        '<br>'
        '<br>Prowadzący prosi, by uczestnicy <b>nie skupiali się na technikaliach</b> (nie zastanawiali się, czy instruktor zareagował efektywnie), lecz jedynie na skutku działań - wpływie na duchowość (np. postawy lub wartości) wychowanków.'
        '<br>'
        '<br>Uczestnicy mogą notować swoje odpowiedzi, by móc łatwiej do nich wrócić.'
        '</p>'
);

KonspektStep _step_neutralnosc_duchowa_omowienie_wnioskow = KonspektStep(
    title: 'Neutralność duchowa - omówienie wniosków',
    duration: Duration(minutes: 15),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Gdy wszyscy uczestnicy skończą rozważania nad scenariuszami, wracają do wspólnego miejsca. Prowadzący prosi, by doszli do wspólnej odpowiedzi na pierwsze pytanie:'
        '<br>'
        '<br><b>Czy działanie instruktora miało wpływ na duchowość harcerzy?</b> Jeśli tak, to <b>jakie wartości</b> lub postawy działanie instruktora wzmocniło?'
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
        'Gdy dyskusje dobiegną końca, prowadzący może dorzucić kilka swoich niezobowiązujących uwag na temat wniosków uczestników. Ważniejsze jest jednak, aby szybko przejść do drugiego pytania:'
        '<br>'
        '<br><b><i>“Czy w którymkolwiek scenariuszu instruktor mógł postąpić neutralnie z perspektywy kształtowania duchowości?”</i></b>.'
        '<br>'
        '<br>Uczestnicy ponownie wracają do dyskusji. Scenariusze, które zostały omówione przez uczestników powinny prowadzić do wniosku: w sposób oczywisty harcerskie <b>wychowanie nie jest neutralne duchowo</b>.',
    materials: [
      material_zal_neutralnosc_duchowa_przyklady,
    ]

);

KonspektStep _step_neutralnosc_duchowa_w_przypadku_problemow = KonspektStep(
    title: 'Neutralność duchowa - w przypadku problemów',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    required: false,
    content: '<p style="text-align:justify;">'
        'Rolą prowadzącego jest kształtowanie dyskusji uczestników poprzez zadawania pytań. Jeśli uczestnicy sądzą, że neutralność jest możliwa, prowadzący może zapytać:'
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
    activeForm: KonspektStepActiveForm.static,
    required: false,
    content: '<p style="text-align:justify;">'
        'Jeśli uczestnicy mają problem ze zrozumieniem, dlaczego zarówno działanie wychowawcze jak i jego brak zawsze kształtuje duchowość wychowanków, prowadzący może przedstawić uczestnikom użyteczną analogię:'
        '<br>'
        '<br><i>ZHP jest jak wielka, rozproszona organizacja ogrodnicza. Zajmuje się kształtowaniem krzewów (czyli kształtowaniem duchowości i zdolności harcerzy). Pojawiają się u nas różne krzewy, w różnych formach i kształtach, a zadaniem ogrodników (instruktorów) jest te krzewy przycinać, podlewać, nawozić lub pozwalać im rosnąć tak, by nadać im kształt w określonym stylu.'
        '<br>'
        '<br>Krzew <b>zawsze nabywa jakiegoś kształtu</b>, także wtedy, gdy ogrodnik nic nie robi. Nie da się być rośliną nie mając jakiegoś kształtu. Tak samo, jak nie da się mówić nie użyjąc jakiegoś języka.'
        '<br>'
        '<br>Harcerstwo jest przedsięwzięciem kształtowania ludzi: ich przekonań, wartości i postaw w określonym kierunku. <b>Bez celowego kształtowania duchowości harcerzy harcerstwo nie realizuje swojego celu</b>, jakim jest wychowanie.</i>'
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


// Duchowość powszechna etc.

KonspektStep _step_duchowosc_powszechna_madrosc_kultura_i_tradycja = KonspektStep(
    title: 'Duchowość powszechna',
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci opisuje zjawisko <b>duchowości powszechnej</b>, związanej z nią <b>sztafetowością</b> i <b>selekcją naturalną</b>. Opisuje także zjawisko dualizmu aktualności duchowości powszechnych - z jednej strony jej wiecznego niedoczasu względem rzeczywistości, z drugiej jej funkcji tworzenia norm i przekazywania sprawdzonych rozwiązań nowym pokoleniom.'
        '<br>'
        '<br>Prowadzący może zobrazować dylemat tego <i>"jak ściśle trzymać się tradycji"</i> w sposób następujący:'
        '<br>'
        '<br><i>Kultura i tradycja są mądrością miliona lat żyć, pamięcią miliona umysłów, wiedzą o skutkach miliona głupich prób – wszystkie dostępne dla człowieka żyjącego raptem kilkadziesiąt lat.</i>'
        '<br>'
        '<br><i>Gdybyśmy zanegowali na raz wszystkie tradycje, w ciągu jednego pokolenia wrócilibyśmy do jaskiń. Ale gdybyśmy nigdy nie podważyli żadnej tradycji, nigdy z tych jaskiń byśmy nie wyszli.</i>'
        '</p>'
);

KonspektStep _step_ocena_metanarracji_i_duchowosci_odpowiedz = KonspektStep(
    title: 'Meta-narracja - pytanie końcowe - odpowiedź',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Na koniec prowadzący zadaje uczestnikom pytanie: <i>Czy istnieją meta-narracje, tudzież duchowości <b>lepsze</b> oraz <b>gorsze</b>?</i>'
        '<br>'
        '<br>Prowadzący pozwala uczestnikom podyskutować chwilę nad tym zagadnieniem, po czym zwraca uwagę: <i>Niektóre duchowości wyraźnie skuteczniej prowadzą do szczęścia i rozwoju człowieka oraz jego otoczenia od pozostałych. Niektóre duchowości czynią to w sposób stabilny od tysięcy lat, inne działają dobrze przez pół pokolenia, po czym prowadzą do katastrofy - czego najlepszym dowodem są systemy totalitarne XX wieku.</i>'
        '</p>'
);

KonspektStepGroup step_group_duchowosc_powszechna = KonspektStepGroup(
    title: 'Duchowość powszechna',
    steps: [
      _step_duchowosc_powszechna_madrosc_kultura_i_tradycja,

      _step_ocena_metanarracji_i_duchowosci_odpowiedz,
    ]
);


// Duchowość w ZHP

KonspektStep _step_duchowosc_w_zhp_dokumenty = KonspektStep(
    title: 'Duchowość w ZHP - dokumenty',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    aims: [
      'Wskazanie uczestnikom formalnych źródeł stanowiących, że harcerstwo jest dla wszystkich, ale nie wychowuje do wszystkiego - ma ściśle określone wartości, do których kształtuje'
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący przedstawia uczestnikom stosowny fragment statutu ZHP (załącznik $attach_html_cel_wychowania_duchowego_zhp_statut) oraz preambułę uchwały w sprawie wspierania rozwoju duchowego w ZHP (załącznik $attach_html_cel_wychowania_duchowego_zhp_uchwala). Zwraca uwagę, że w ZHP mamy określony zbiór wartości i postaw, do których wychowujemy, ale <b>nie mamy jako określonych aksjomatów</b> na podstawie których te wartości są wywodzone.'
        '<br>'
        '<br>Prowadzący kończy stwierdzeniem:'
        '<br>'
        '<br><i>To oczywiste, że nie da się wychować młodego człowieka bez pracy z aksjomatami. Skoro zaś ZHP nie określa skąd harcerskie wartości mają być wywodzone, to spróbujmy rozszyfrować dlaczego te wartości są tak oczywiste w naszej cywilizacji.</i>'
        '</p>',
  materials: [
    material_zal_cel_wychowania_duchowego_zhp_statut,
    material_zal_cel_wychowania_duchowego_zhp_uchwala
  ]
);

KonspektStep _step_duchowosc_w_zhp_dobrowolnosc = KonspektStep(
    title: 'Duchowość w ZHP - dobrowolność',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    required: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący zwraca uwagę uczestników na następujący dylemat:'
        '<br>'
        '<br><i>Mamy w statucie ZHP zapisaną określoną duchowość. Ale jak się to ma do faktu, że cechą metody harcerskiej jest dobrowolność?</i>'
        '<br>'
        '<br>Uczestnicy powinni znać rozwiązanie tego dylematu, jeśli byli na kursie przewodnikowskim. Jeśli jest inaczej, po krótkiej dyskusji prowadzący rozwiązuje zagadkę:'
        '<br>'
        '<br><i>Dobrowolność nie jest <b>celem wychowania</b> w ZHP, tylko <b>cechą metody</b>, czyli cechą narzędzi, które mają doprowadzić do celu.'
        '<br>'
        '<br>Dobrowolność jest stosowana w ZHP, ponieważ skuteczniej jest wychować młodego człowieka do określonych wartości, gdy ma poczucie, że to on je wybiera, niż kiedy ma poczucie, że jest mu to zadane. Nie oznacza to jednak, że w ZHP istnieje dobrowolność celu wychowania.</i>'
        '<br>'
        '<br>Dobrowolność jako narzędzie ma także drugą rolę:'
        '<br>'
        '<br><i>Jeśli jakieś działanie wychowawcze nie cieszy się entuzjazmem wychowanków, to jest to sygnał, że jego forma nie jest atrakcyjna, a przez to jest mniej skuteczna. Skonstatowanie tego w sytuacji braku dobrowolności byłoby dużo trudniejsze.</i>'
        '</p>',
    materials: [
      material_zal_cel_wychowania_duchowego_zhp_statut,
      material_zal_cel_wychowania_duchowego_zhp_uchwala
    ]
);

KonspektStep _step_duchowosc_w_zhp_aksjomaty_poszukiwanie_zrodla = KonspektStep(
    title: 'Duchowość w ZHP - aksjomaty - poszukiwanie źródła',
    duration: Duration(minutes: 15),
    activeForm: KonspektStepActiveForm.static,
    materials: [
      material_zal_neutralnosc_duchowa_przyklady
    ],
    aims: [
      'Uświadomienie uczestnikom, że harcerskie wartości, oparte na wartościach cywilizacji łacińskiej nie są oczywiste, uniwersalne, ani naturalne.'
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący zwraca uwagę, że wartości cywilizacji łacińskiej nie są ani uniwersalne, ani naturalne. Posiłkując się przykładami z użytego wcześniej załącznika ${attach_html_neutralnosc_duchowa_przyklady}, poddaje pod dyskusję pytanie: <b>dlaczego w naszej kulturze akurat te, a nie inne wartości są tak powszechne</b>?'
        '</p>'

        '<ol>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 1.</b> Przebaczenie i odpuszczenie win.'
        '<br>'
        '<br>W wielu kulturach przebaczenie jest uważane za zachętę do bycia wykorzystywanym. Nietzsche widział w nim wyraz słabości i element moralności niewolników. W tradycyjnej kulturze japońskiej po popełnieniu poważnej winy nie było drogi jej odpuszczenia – jedynym honorowym wyjściem było rytualne samobójstwo: seppuku. Dlaczego więc w kulturze łacińskiej jest inaczej? Dlaczego w naszych systemach prawnych po odbyciu kary wina zostaje zmazana i człowiek jest wolny? Dlaczego za kradzież nie skazuje się ludzi dożywotnio, żeby skutecznie ich od niej zniechęcić?'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 2.</b> Życie w prawdzie.'
        '<br>'
        '<br>W kulturach wschodnich, gdzie najważniejsza jest harmonia społeczna, należy kłamać, jeśli prowadzi to do uniknięcia konfliktu. W części kultur afrykańskich kłamstwo nie jest złem, jeśli służy uniknięciu wstydu. Dlaczego więc akurat my tak się uparliśmy, by nagannie traktować świadome mówienie nieprawdy?'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 3.</b> Niezbywalna godność każdego człowieka'
        '<br>'
        '<br>W systemach konfucjańskich liczy się najpierw wspólnota i kolektyw, dopiero potem jednostka. Niektórzy wyznawcy hinduizmu powstrzymają innych od udzielenia pomocy cierpiącemu – jeśli ktoś cierpi, to pokutuje za grzechy popełnione w poprzednim życiu. A skąd pogląd, że wykształcony profesor z zasługami dla narodu ma takie same prawa jak półinteligentny osiedlowy cwaniaczek? Skąd pomysł, że prawo do życia i godnego traktowania przysługuje każdemu, niezależnie od wieku, pochodzenia czy wyznania?'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 4.</b> Stawianie wyżej dobra jednostki nad kolektywem'
        '<br>'
        '<br>W kulturze konfucjańskiej najpierw liczy się zbiorowość, trwałość systemu państwowego – a dopiero potem dobro jednostki. W Chinach niedopuszczalne jest publiczne okazywanie sporów, ponieważ osłabia to wspólnotę. W kulturze japońskiej należy poświęcić plany prywatne, jeśli kolidują z wydarzeniem firmy. Skąd więc u nas „oczywiste" przekonanie, że rodzinie, której dom stoi na drodze nowej autostrady, należy się odszkodowanie? Skąd przekonanie, że nie można zmusić człowieka do pracy, jeśli nie chce? Dlaczego chronimy tak zaciekle wolności słowa, nawet, gdy osłabia ona spójność społeczną?'
        '</p>'
        '</li>'

        '</ol>'
);

KonspektStep _step_duchowosc_w_zhp_aksjomaty_odpowiedzi = KonspektStep(
    title: 'Duchowość w ZHP - aksjomaty - odpowiedzi',
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.static,
    materials: [
      material_zal_neutralnosc_duchowa_przyklady
    ],
    aims: [
      'Uświadomienie uczestnikom, że harcerskie wartości, oparte na “oczywistych” wartościach naszej cywilizacji, w sposób ścisły wypływają z wiary chrześcijańskiej'
    ],
    content: '<p style="text-align:justify;">'
        'Gdy uczestnicy dostrzegą, jak nieoczywiste – a z perspektywy reszty świata wręcz dziwne – są wartości łacińskie, prowadzący naprowadza ich na powód, dla którego akurat te wartości stały się u nas standardem:'
        '<br>'
        '<br><i>Nie byłoby niezbywalnej godności każdego człowieka, ani równości wobec prawa, ani humanitaryzmu, ani oświecenia, ani Powszechnej Deklaracji Praw Człowieka bez wiary, że skoro sam Bóg dobrowolnie wydał się na śmierć dla zbawienia najpodlejszego nawet człowieka, to że w każdym człowieku jest coś iście boskiego, nieważne jak bardzo jest podły, bezużyteczny, inny, czy denerwujący.'
        '<br>'
        '<br>Nie byłoby uniwersytetów bez zgromadzeń i klasztorów zakonnych, ani nie byłoby nauki bez przekonania, że Bóg stworzył dobry, uporządkowany świat, że Bóg przekracza naturę i że można badać ją bez bluźnierstwa, oraz bez ewangelicznej wiary w wartość prawdy pomimo pokusy fałszowania rzeczywistości dla własnych korzyści.'
        '</i>'
        '<br>'
        '<br>Prowadzący zostawia uczestnikom przestrzeń, by weszli z nim na ten temat w dyskusję.'
        '</p>'

);

KonspektStep _step_duchowosc_w_zhp_religia = KonspektStep(
    title: 'Duchowość w ZHP - religia',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący stawia pytanie: <i>jak wygląda relacja między wychowaniem duchowym osób wierzących i osób bez wyznania w jednej drużynie? Czy można prowadzić wspólne wychowanie duchowe, a religię traktować jako „dodatek" dla części harcerzy?</i>'
        '<br>'
        '<br>Na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci prowadzący naprowadza uczestników na kluczową tezę: <b>religia nie jest dodatkiem do duchowości – jest autonomiczną, pełną duchowością</b>, z własnymi aksjomatami, spójną hierarchią wartości i sposobami ich integracji.'
        '<br>'
        '<br>Nie ma tu relacji zawierania – nie jest tak, że wszyscy ludzie mają bazową duchowość, a część ma ją „z dodatkiem religii". Nie da się z czyjejś duchowości wyjąć elementu religijnego i dalej mieć do czynienia z duchowością – tak jak nie da się z jamnika wyjąć elementu „pies". Jamnik nie składa się z psa i czegoś jeszcze: jamnik jest psem.'
        '<br>'
        '<br>Wnioski wychowawcze:'
        '</p>'

        '<ol>'
        '<li>'
        '<p style="text-align:justify;">'
        'U osób wierzących wartości – w tym harcerskie – muszą wynikać z przyjętej wiary. Jeśli harcerz ma w każdym widzieć bliźniego, to nie dlatego, że „tak mówi Prawo Harcerskie" – powód jest dla niego ostatecznie religijny. Budowanie wartości w oderwaniu od aksjomatów sprawia, że za kilka lat będą one widziane jako archaiczne, naiwne bajeczki dla dzieci.'
        '</p>'
        '</li>'
        '<li>'
        '<p style="text-align:justify;">'
        'Nie ma symetrii między wychowaniem osób religijnych i niereligijnych. Osoby religijne mają z góry określone aksjomaty, natomiast aksjomaty osób niereligijnych dopiero wymagają określenia.'
        '</p>'
        '</li>'
        '</ol>'
);

KonspektStep _step_duchowosc_w_zhp_ateisci = KonspektStep(
    title: 'Duchowość w ZHP - co dla ateistów?',
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący zwraca uczestnikom uwagę na pewien problem (chyba, że któryś z uczestników sam zwróci na niego uwagę):'
        '<br>'
        '<br><i>Co, jeśli kogoś nie interesuje chrześcijaństwo?</i>'
        '<br>'
        '<br>Prowadzący otwiera tym samym krótką dyskusję. Warto rozpatrzyć tutaj dwa osobne przypadki:'
        '</p>'

        '<ol>'

        '<li>'
        '<p style="text-align:justify;">'
        '<i>'
        '<u>Co, jeśli ktoś nie jest zainteresowany egzystencjalnymi pytaniami? Co jeśli ktoś uważa, że należy być dobrym "bo tak"?</u>'
        '<br>'
        '<br>Harcerstwo stawia za cel wychowanie osób świadomych swoich wartości, potrafiących je uzasadnić i ich bronić. Faktycznie jednak należy liczyć się z tym, że niektórzy zwyczajnie nie będą sobie zadawali trudu refleksji nad swoim życiem i duchem. Część osób może konformistycznie, na bieżąco dopasowywać się do poglądów otoczenia, mieć przez to kolegów i czuć się z tym dobrze, jednak <b>jest to wyraz niedojrzałości</b>.'
        '<br>'
        '<br>Ludzie mogą być też motywowani różnymi meta-narracjami. Niektóre mogą być absurdalne, czy trywialne, np.: "Musimy dzielić się bogactwem, bo był kiedyś kolonializm". Nie zmienia to faktu, że dla kogoś może być to odpowiedzią na wszystkie życiowe rozterki. Nie należy jednak sądzić, że w ogólności ludzie pójdą za każdą meta-narracją. Nie wszystkie meta-narracje kończą się dla człowieka dobrze. Nie bez przyczyny za niektórymi meta-narracjami poszły miliardy ludzi, a inne wygasły po dwóch pokoleniach.'
        '</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<i>'
        '<u>Jakie aksjomaty powinny być podstawą duchowości ateistów w ZHP?</u>'
        '<br>'
        '<br>Nie wiem. I prawdopodobnie nikt nie wie. Cała nasza zachodnia cywilizacja została zbudowana na aksjomatach chrześcijańskich. Została ukształtowana przez życia miliardów ludzi, na przestrzeni tysięcy lat, przez myślicieli i filozofów większych od wszystkich tu obecnych. Czy można to wszystko porzucić i liczyć na to, że "wymyśli się" coś równie dobrego w kilka lat?'
        '<br>'
        '<br>Myśl, że można utrzymać świat merytokracji, równości, wolności, godności ludzkiej, przebaczenia, uznania własnej niedoskonałości, powszechnej sprawiedliwości, nauki, ale pozbyć się fundamentów, na których powstały wydaje się być <b>co najmniej wielką nieodpowiedzialnością</b>.'
        '<br>'
        '<br>Można próbować wybiegów w stylu: "wystarczy być dobrym człowiekiem", "idź za głosem serca" albo zostawić sferę aksjomatów niewierzących harcerzy samym sobie i tak oto pozbyć się problemu. Na razie taki model w ZHP funkcjonuje, ale jest to wyraz bezradności, a nie poważna odpowiedź na to pytanie. Chyba nikt nie ma odpowiedzi na to pytanie.'
        '</i>'
        '</p>'
        '</li>'

        '</ol>'

        '<p style="text-align:justify;">'
        'Prowadzący powinien pozwolić, by fundamentalny <b>brak odpowiedzi</b> na pytanie „co dla ateistów" wybrzmiał wśród uczestników. <b>Odpowiedź nie padnie na warsztatach</b> – nie dlatego, że ktoś chce ją ukryć, ale dlatego, że próba potraktowania tego pytania poważnie prowadzi do karkołomnych konsekwencji – niezależnie od poglądów obecnych tu osób.'
        '</p>'
);

KonspektStep _step_duchowosc_w_zhp_podsumowanie = KonspektStep(
    title: 'Duchowość w ZHP - podsumowanie',
    duration: Duration(minutes: 5),
    required: false,
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        '<b>Podsumowanie (dla przewodników)</b>'
        '</p>'

        '<ul>'
        '<li><p style="text-align:justify;">Nie istnieje neutralne wychowanie.</p></li>'
        '<li><p style="text-align:justify;">Jeśli harcerstwo chce być skuteczne wychowawczo, nie może abdykować z rozwoju duchowego na poziomie aksjomatu.</p></li>'
        '<li><p style="text-align:justify;">Harcerskie wychowanie jest fundamentalnie chrześcijańskie, nawet jeśli jego członkowie są innego wyznania.</p></li>'
        '<li><p style="text-align:justify;">Nie należy zbyt łatwo pomijać elementów tradycyjnej duchowości, których jako kadra nie rozumiemy. Zazwyczaj stoją za nimi dziesiątki wieków mądrości.</p></li>'
        '<li><p style="text-align:justify;">Harcerstwo powinno mieć wysokie standardy. Nie po to, by prowadzić selekcję osób mogących harcerzami zostać, ale po to, by wychować ludzi w szacunku do wartości, postaw, a często również wiary, która dała nam świat merytokracji, równości, wolności, godności ludzkiej, przebaczenia, uznania własnej niedoskonałości, powszechnej sprawiedliwości, nauki, itd..</p></li>'
        '</ul>'

        '<p style="text-align:justify;">'
        '<b>Podsumowanie dodatkowe (dla podharcmistrzów)</b>'
        '</p>'

        '<ul>'
        '<li>'
        '<p style="text-align:justify;">'
        'Mamy w ZHP niechlubną tradycję zmieniania harcerskich zasad i ideałów, gdy okazuje się, że postawy harcerzy się z nimi nie spotykają. A przecież to harcerstwo powinno zmieniać ludzi, a nie się do nich dostosowywać.'
        '</p>'
        '</li>'
        '</ul>'
);

KonspektStepGroup step_group_duchowosc_w_zhp = KonspektStepGroup(
    title: 'Duchowość w ZHP',
    steps: [
      _step_duchowosc_w_zhp_dokumenty,

      _step_duchowosc_w_zhp_dobrowolnosc,
      
      _step_duchowosc_w_zhp_aksjomaty_poszukiwanie_zrodla,

      _step_duchowosc_w_zhp_aksjomaty_odpowiedzi,

      _step_duchowosc_w_zhp_religia,

      _step_duchowosc_w_zhp_ateisci,

      _step_duchowosc_w_zhp_podsumowanie,
    ]
);

// Założenia wyjściowe wychowania duchowego

KonspektStep _step_zalozenia_wyjsciowe_wychowania_duchowego = KonspektStep(
    title: 'Założenia wyjściowe wychowania duchowego',
    duration: Duration(minutes: 20),
    activeForm: KonspektStepActiveForm.active,
    materials: [
      material_flipchart.copyWith(amount: 1),
      material_marker.copyWith(amount: 2),
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący informuje uczestników, że za chwilę będą projektować proces wychowania duchowego dla konkretnej jednostki, ale najpierw trzeba ustalić wyjściowe założenia dotyczące filozofii pracy.'
        '<br>'
        '<br>Prowadzący przeprowadza w formie "Dwuściennej dyskusji" krótką debatę dotyczącą kolejno każdego z tematów zawartych w załączniku ${attach_html_karty_zalozen_wyjsciowych_wychowania_duchowego}.'
        '<br>'
        '<br>Wnioski, które wypłyną z dyskusji powinny być następujące:'
        '</p>'

        '<ul>'

        '<li>'
        '<p style="text-align:justify;">'
        'Teza: <b>Duchowość harcerzy to ich prywatna sprawa</b>'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '<br><i>Duchowość to sprawa indywidualna i fundamentalnie osobista, <b>ale</b> jest jednocześnie sprawą publiczna - z duchowości wynika długa lista spraw (zachowania, postawy i wartości), które dotyczą i wpływają na całe otoczenie, w którym człowiek żyje. O wierze można i trzeba rozmawiać, robić dla niej miejsce, można ją publicznie praktykować, także w formie tradycji, czy w warstwie symbolicznej.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        'Teza: <b>Harcerzy należy izolować od niemoralnych postaw</b>'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '<br><i>Początkowo harcerze powinni mieć jednoznaczny, niepodważany, niezmącony przekaz dotyczący tego, co jest dobre, a co złe. Stan ten powinien trwać mniej więcej do początku etapu świadomej integracji duchowości. W dalszej kolejności harcerze powinni być stopniowo wystawiani na inne perspektywy, inne postawy, inne wspólnoty, jednak nie po to, żeby przyjęli ich duchowość, tylko żeby wobec niej utwierdzili swoją własną oraz by nauczyli się funkcjonować w świecie, w którym nie ma jednorodności duchowej.</i>'
        '</p>'
        '</li>'


        '<li>'
        '<p style="text-align:justify;">'
        'Teza: <b>Formy pracy harcerskiej powinny być inkluzywne</b>'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '<br><i>Absolutnie nie - prowadzi to do zjawiska <b>weganizacji wychowania duchowego</b>, czyli do zjawiska ograniczenia wychowania do najmniejszego wspólnego mianownika duchowości osób o różnych aksjomatach. Ludzie wychowywani w różnych wiarach wymagają różnych form pracy nad swoją duchowością. To, że formy te będą wykluczające dla części osób jest normalne, konieczne i nie należy się tego bać.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        'Teza: <b>Nie wolno narażać harcerzy na niebezpieczeństwo ani dyskomfort</b>'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '<br><i>Po pierwsze, niektóre niezwykle skuteczne formy wychowawcze mają w sobie element ryzyka: chodzenie w góry, jeżdżenie autostopem, podróże po innych krajach, etc.. Po drugie, świat jest w sposób immanentny niebezpieczny. Niemal na pewno nasi wychowankowie zetkną się w życiu z agresją, bezradnością, frustracją. Lepiej jest ich do tego skutecznie przygotować w kontrolowanych warunkach. To właśnie jest hartem ducha.</i>'
        '</p>'
        '</li>'

        '</ul>',
);

KonspektStepGroup step_zalozenia_wyjsciowe_wychowania_duchowego = KonspektStepGroup(
    title: 'Założenia wyjściowe wychowania duchowego',
    steps: [
      _step_zalozenia_wyjsciowe_wychowania_duchowego
    ]
);

// Szybkie strzały dyskusyjne

KonspektStep step_szybkie_strzaly_dyskusyjne = KonspektStep(
    title: 'Szybkie strzały dyskusyjne',
    duration: Duration(minutes: 30),
    activeForm: KonspektStepActiveForm.active,
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
        '<br><i>Życie religijne człowieka jest sprawą indywidualną i fundamentalnie osobistą, ale jest jednocześnie sprawą publiczną - z religii wynika długa lista spraw (zachowania, postawy i wartości), które dotyczą i wpływają na całe otoczenie, w którym człowiek żyje. O wierze można i trzeba rozmawiać, robić dla niej miejsce, można ją publicznie praktykować.</i>'
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
        '<br><i>Tak. Instruktorzy wychowują również poprzez przykład własny i pełnią rolę autorytetów, dlatego ma to znaczenie, jakie poglądy reprezentuje instruktor. Nie każdy człowiek powinien nim być.</i>'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<u>W ramach działań drużyny nie powinno być aktywności religijnych, gdyż te wykluczają niewierzących.</u>'
        '<br>'
        '<br><i>Osoby wyznające wiarę w osobowego Boga, aby móc rozwijać swoją duchowość muszą brać udział w formach, które są niecelowe dla osób niereligijnych. Ograniczanie osobom wychowywanym w wierze form religijnych, tabuizowanie tematu wiary i religii jest dla nich krzywdzące. Skuteczne wychowanie osób o różnych aksjomatach w jednej drużynie <b>zawsze prowadzi przez formy, które są nieinkluzywne</b> - zjawisko to jest normalne i pożądane. Uciekanie od tego faktu skutkuje zjawiskiem <b>weganizacji procesu wychowawczego</b>.</i>'
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