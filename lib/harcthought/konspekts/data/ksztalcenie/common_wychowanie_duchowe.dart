import 'package:harcapp_core/harcthought/konspekts/data/common.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common_attachments.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

const String _tableStyle = 'border-collapse: collapse;';
const String _tableStyleWide = 'border-collapse: collapse; width: 100%;';
const String _tdPadding = 'padding-left: 8px; padding-right: 8px;';

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

KonspektMaterial material_zal_aksjomaty_wartosci_przyporzadkowanie = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_aksjomaty_wartosci_przyporzadkowanie”',
    attachmentName: attach_name_aksjomaty_wartosci_przyporzadkowanie,
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

KonspektMaterial material_zal_scenka_wychowawcza = KonspektMaterial(
    name: 'Wydrukowany załącznik "$attach_title_scenka_wychowawcza"',
    attachmentName: attach_name_scenka_wychowawcza,
    amount: 4
);

KonspektMaterial material_budzik = KonspektMaterial(
  name: "Budzik (np. w telefonie)",
  amount: 1
);

KonspektMaterial material_zal_narracja_opis = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_narracja_opis”',
    attachmentName: attach_name_narracja_opis,
    amount: 1
);

KonspektMaterial material_zal_narracja_przyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_narracja_przyklady”',
    attachmentName: attach_name_narracja_przyklady,
    amount: 1,
    additionalPreparation: "Załącznik należy pociąć na 4 kartki wzdłuż przerywanych linii."
);

KonspektMaterial material_zal_meta_narracja_opis = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_meta_narracja_opis”',
    attachmentName: attach_name_meta_narracja_opis,
    amount: 1
);

KonspektMaterial material_zal_wartosci_lacinskie = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_wartosci_lacinskie”',
    attachmentName: attach_name_wartosci_lacinskie,
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

KonspektMaterial material_zal_duchowosc_harcerska_tezy = KonspektMaterial(
    name: 'Wydrukowany załącznik "$attach_title_duchowosc_harcerska_tezy"',
    attachmentName: attach_name_duchowosc_harcerska_tezy,
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
    materials: [
      material_zal_sfery,
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący przygotowuje kartki z 5 sferami <b>ciała</b>, <b>umysłu</b>, <b>relacji</b>, <b>emocji</b> oraz <b>ducha</b> z załącznika $attach_html_sfery.'
        '<br>'
        '<br>Następnie prowadzący prosi uczestników o wymienienie sfer człowieka rozwijanych w harcerstwie. Każdorazowo, gdy padnie odpowiedź, kładzie odpowiednią kartkę we wspólnej przestrzeni.'
        '</p>'
);

KonspektStep step_sfery_rozwoju_przyklady = KonspektStep(
    title: 'Sfery rozwoju - przykłady',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    materials: [
      material_zal_sfery_przyklady,
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący w losowej kolejności odczytuje uczestnikom 8 kartek <b>z białym tłem</b> z załącznika $attach_html_sfery_przyklady. Każdorazowo prosi uczestników o wskazanie, z którą sferą rozwoju związana jest odczytana kartka.'
        '<br>'
        '<br>Prawidłowe odpowiedzi:'
        '</p>'

        '<table border="1" style="$_tableStyle">'
        '<tr><td style="$_tdPadding"><p style="text-align:justify;"><i>Potrafi przebiec 5 kilometrów w 20 minut</i></p></td><td style="$_tdPadding"><p><b>Ciało</b></p></td></tr>'
        '<tr><td style="$_tdPadding"><p style="text-align:justify;"><i>Zachowuje zdrowie nawet w fatalnych warunkach pogodowych</i></p></td><td style="$_tdPadding"><p><b>Ciało</b></p></td></tr>'
        '<tr><td style="$_tdPadding"><p style="text-align:justify;"><i>W 6 miesięcy umie opanować dowolny język obcy</i></p></td><td style="$_tdPadding"><p><b>Umysł</b></p></td></tr>'
        '<tr><td style="$_tdPadding"><p style="text-align:justify;"><i>Zna budowę silnika mechanicznego</i></p></td><td style="$_tdPadding"><p><b>Umysł</b></p></td></tr>'
        '<tr><td style="$_tdPadding"><p style="text-align:justify;"><i>Panuje nad sobą, niezależnie od sytuacji</i></p></td><td style="$_tdPadding"><p><b>Emocje</b></p></td></tr>'
        '<tr><td style="$_tdPadding"><p style="text-align:justify;"><i>Rozróżnia tylko trzy stany samopoczucia: "super", "ok" i "źle"</i></p></td><td style="$_tdPadding"><p><b>Emocje</b></p></td></tr>'
        '<tr><td style="$_tdPadding"><p style="text-align:justify;"><i>Ma czwórkę rodzeństwa</i></p></td><td style="$_tdPadding"><p><b>Relacje</b></p></td></tr>'
        '<tr><td style="$_tdPadding"><p style="text-align:justify;"><i>Jest zaręczony ze swoją dziewczyną, którą zna od liceum</i></p></td><td style="$_tdPadding"><p><b>Relacje</b></p></td></tr>'
        '</table>'
);

KonspektStep step_sfery_rozwoju_sfera_ducha_jest_inna = KonspektStep(
    title: 'Sfery rozwoju - sfera ducha jest inna niż wszystkie',
    duration: Duration(minutes: 1),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący mówi:'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Często panuje przekonanie, że sfera ducha to sfera jak każda inna:'
        '</p>'
        '<ul>'
        '<li>że dotyczy jakiegoś kolejnego fragmentu człowieka,</li>'
        '<li>że jej sposób rozwoju jest zbliżony do np. sfery umysłu, czy emocji.</li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Taki pogląd to fundamentalny błąd. Żeby zrozumieć dlaczego, najpierw pochylmy się nad wymienionymi dotąd 4 sferami.'
        '</p>'
        '</blockquote>'
);

KonspektStep step_sfery_rozwoju_sfery_zdolnosci = KonspektStep(
    title: 'Sfery rozwoju - sfery zdolności',
    duration: Duration(minutes: 1),
    activeForm: KonspektStepActiveForm.static,
    materials: [
      material_zal_sfery,
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący definiuje sfery zdolności:'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Przywołane dotąd 4 sfery (ciała, umysłu, emocji i relacji) łączy jedno: wszystkie są źródłem <b>zdolności</b> (np. szybkiego biegu, czy rozwiązywania skomplikowanych problemów). Te zdolności są jak <b>narzędzia</b>, które leżą na półce, gotowe do użycia. O tych sferach można zbiorczo mówić jako o <b>sferach zdolności</b> - są bowiem źródłem zdolności.'
        '</p>'
        '</blockquote>'
        '<p style="text-align:justify;">'
        'Następnie prowadzący zbiera rozłożone wcześniej karty 4 sfer zdolności (ciała, umysłu, relacji i emocji) i symbolicznie składa je w stosik, który przykrywa kartą "sfery zdolności" z załącznika $attach_html_sfery.'
        '</p>'
);

KonspektStep step_sfery_rozwoju_sfery_zdolnosci_arbitralnosc_podzialu = KonspektStep(
    title: 'Sfery rozwoju - sfery zdolności - arbitralność podziału',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    materials: [
      material_zal_sfery_przyklady,
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący zwraca uwagę, że traktowanie sfer zdolności łącznie, bez wchodzenia w to, czy chodzi o ciało, umysł, emocje, czy relacje rozwiązuje dwa problemy:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;"><b>Arbitralność podziału</b> — to, że ktoś podzielił sfery zdolności na 4 jest arbitralną decyzją. Równie dobrze można by zmieścić wszystko w dwóch: sferze ciała i umysłu, który przecież odpowiada zarówno za sferę emocji człowieka jak i za kompetencje społeczne. Można również pójść w drugą stronę i wydzielić więcej sfer: np. dodać sferę zasobów materialnych.</p></li>'
        '<li><p style="text-align:justify;"><b>Nieostrość podziału</b> — w obecnym podziale (i w każdym podziale) istnieją zdolności, które nie pasują do tylko jednej sfery.</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Prowadzący może skorzystać z <b>dwóch szarych kartek</b> z załącznika $attach_html_sfery_przyklady i poprosić uczestników o wskazanie, do której sfery zdolności przynależą zapisane na nich zdolności:'
        '</p>'
        '<table border="1" style="$_tableStyle">'
        '<tr><td style="$_tdPadding"><p style="text-align:justify;"><i>Potrafi w kilka dni zdyskredytować czyjąś reputację</i></p></td><td style="$_tdPadding"><p><b>Relacje</b> i <b>Umysł</b></p></td></tr>'
        '<tr><td style="$_tdPadding"><p style="text-align:justify;"><i>Potrafi zagrać na fortepianie każdy utwór Chopina</i></p></td><td style="$_tdPadding"><p><b>Ciało</b>, <b>Umysł</b> i <b>Emocje</b></p></td></tr>'
        '</table>'
);

KonspektStep step_sfery_rozwoju_sfera_ducha = KonspektStep(
    title: 'Sfery rozwoju - sfera ducha',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    materials: [
      material_zal_sfery,
      material_zal_sfery_przyklady,
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący mówi:'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Sfery zdolności to dopiero połowa historii.'
        '</p>'
        '</blockquote>'
        '<p style="text-align:justify;">'
        'Prowadzący kładzie dookoła kartki "sfery zdolności" kartki z przykładowymi zdolnościami z załącznika $attach_html_sfery_przyklady i opowiada następującą historię:'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Wyobraźcie sobie trzech ludzi: Alberta, Bartka i Cezarego. Mieszkają w tym samym mieście. Każdy ma 20 lat. Pracują w tej samej firmie zajmującej się montażem elektryki. Każda zdolność, którą tu widzicie, opisuje każdego z nich w identycznym stopniu: każdy umie tak samo dobrze biegać, tak samo dobrze rozumie budowę silnika, każdy ma narzeczoną. Ba: <b>ich sfery zdolności są identyczne</b>.'
        '<br>'
        '<br>Pewnego ranka jeden z nich jedzie autem do klienta. W połowie drogi auto się psuje. Na zewnątrz jest minus piętnaście stopni.'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Gdyby autem jechał Albert, to bez zastanowienia otworzyłby maskę i zaczął naprawiać auto.</p></li>'
        '<li><p style="text-align:justify;">Gdyby autem jechał Bartek, nie ruszyłby się z auta, tylko natychmiast zadzwonił do ubezpieczyciela i poczekał na auto zastępcze.</p></li>'
        '<li><p style="text-align:justify;">Gdyby autem jechał Cezary, wziąłby narzędzia, zostawił samochód i pobiegł wykonać zlecenie u klienta.</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Wszyscy trzej umieją dokładnie to samo, wiedzą dokładnie to samo i mają dokładnie te same narzędzia. A jednak: każdy te same zdolności wykorzystałby zupełnie inaczej i w innym celu.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący kładzie obok kartki "sfery zdolności", kartkę "sfera ducha" z załącznika $attach_html_sfery. Wskazuje najpierw na kartkę "sfery zdolności" wraz z przykładami zdolności i podsumowuje:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">Czujecie różnicę? Sfery zdolności i wszystkie wypływające z nich kompetencje to worek narzędzi, które człowiek posiada.</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Następnie prowadzący wskazuje na kartkę "sfera ducha":'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">Sfera ducha nie dostarcza żadnych narzędzi. Sfera ducha określa, jak i do czego dostępne narzędzia mają być w życiu wykorzystywane.</p>'
        '</blockquote>'
);

KonspektStep step_sfery_rozwoju_sfera_ducha_dopowiedzenie = KonspektStep(
    title: 'Sfery rozwoju - sfera ducha - dopowiedzenie i przykład',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    required: false,
    content: '<p style="text-align:justify;">'
        'Prowadzący proponuje pewną intuicję dotyczącą sfery ducha:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'O sferze ducha można myśleć w następujący sposób:'
        '<br>'
        '<br>Jest sobie człowiek, weźmy już wspomnianego Alberta. Albert ma jakieś zdolności. Życie Alberta jest taśmą kolejnych zdarzeń, np.:'
        '</p>'
        '<ul>'
        '<li>Ktoś mu powie "dzień dobry",</li>'
        '<li>spotka w autobusie swoją byłą dziewczynę,</li>'
        '<li>szef da mu podwyżkę,</li>'
        '<li>poczuje głód,</li>'
        '<li>pojawi mu się w głowie myśl, że ktoś został niesprawiedliwie potraktowany,</li>'
        '<li>zauważy, że za chwilę wybije godzina dwudziesta,</li>'
        '<li>...</li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Sfera ducha jest sposobem, czy schematem w jaki Albert zareaguje na każdą z sytuacji, która go w życiu spotka.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący podaje jeden przykład:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Wyobraźcie sobie, że Albert dowiaduje się, że jego młodszej siostrze po lekcjach dokuczają koledzy z klasy. Albert umie różne rzeczy: ma określone zdolności, ale może je wykorzystać w różny sposób. Oczywiście sposobów reakcji na taką sytuację jest nieskończenie wiele, ale na chwilę uprośćmy je do trzech:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Albert nie robi nic — sprawa była już zgłoszona do dyrekcji. W szkole co chwilę ktoś komuś dokucza, problem prawdopodobnie szybko zniknie.</p></li>'
        '<li><p style="text-align:justify;">Albert kilka razy po lekcjach czeka przed szkołą na kolegów dokuczających jego siostrze. W ciągu jednego tygodnia całkowicie ich ośmiesza i dyskredytuje w oczach reszty klasy — problem znika.</p></li>'
        '<li><p style="text-align:justify;">Albert zakłada bluzę z kapturem, jednorazowo wybiera się do szkoły w odpowiedniej porze i gdy dostrzega dokuczających jego siostrze chłopaków, sprzedaje największemu gonga w twarz i odchodzi — to niewątpliwie ustawi ich do pionu.</p></li>'
        '</ul>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Wszystkie te trzy opcje są na stole: to, jak Albert je oceni i którą z opcji wykona zależy od kształtu jego sfery ducha.'
        '</p>'

);

KonspektStep step_sfery_rozwoju_pytania = KonspektStep(
    title: 'Sfery rozwoju - pytania',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący daje uczestnikom czas na ewentualne pytania.'
        '</p>'

);


KonspektStepGroup step_group_definicja_sfery_ducha = KonspektStepGroup(
    title: 'Definicja sfery ducha',
    steps: [
      step_sfery_rozwoju,
      step_sfery_rozwoju_przyklady,
      step_sfery_rozwoju_sfera_ducha_jest_inna,
      step_sfery_rozwoju_sfery_zdolnosci,
      step_sfery_rozwoju_sfery_zdolnosci_arbitralnosc_podzialu,
      step_sfery_rozwoju_sfera_ducha,
      step_sfery_rozwoju_sfera_ducha_dopowiedzenie,
      step_sfery_rozwoju_pytania,
    ]);


// Poziomy (warstwy) duchowości

KonspektStep _step_poziomy_duchowosci_wstep = KonspektStep(
    title: 'Poziomy duchowości - wstęp',
    duration: Duration.zero,
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący zaczyna od stwierdzenia:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Ustaliliśmy już, że duchowość to sposób, w jaki człowiek reaguje na rzeczywistość. Fajnie byłoby jednak móc nieco precyzyjniej opisać różne duchowości, żeby umożliwić ich nazywanie, porównywanie, analizę itd.'
        '<br><br>'
        'Na szczęście taka możliwość istnieje i to na kilka sposobów: w pracy wychowawczej szczególnie przydatne są trzy sposoby spojrzenia na duchowość, każdy na innym poziomie abstrakcji.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący prezentuje kolejno poziomy duchowości: <b>zachowań</b>, <b>wartości</b> i <b>aksjomatów</b> i dla każdego z tych poziomów opisuje je w taki sam sposób:'
        '</p>'
        '<ol>'
        '<li><p style="text-align:justify;">Definiuje, czym jest określony poziom duchowości.</p></li>'
        '<li><p style="text-align:justify;">Podaje przykład tego poziomu dla przypadku Alberta.</p></li>'
        '<li><p style="text-align:justify;">Daje uczestnikom chwilę na pytania.</p></li>'
        '<li><p style="text-align:justify;">Przedstawia uczestnikom zagadkę, pozorną sprzeczność, czy proste zadanie, by utrwalić ich zrozumienie.</p></li>'
        '</ol>'
);

KonspektStep _step_poziomy_duchowosci_zachowania_definicja = KonspektStep(
    title: 'Poziomy duchowości - zachowania - definicja',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący opisuje <b>poziom zachowań</b>, kładąc w odpowiednim momencie we wspólnej przestrzeni kartkę "poziom zachowań" z załącznika $attach_html_karty_poziomow_duchowosci.'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Najłatwiej zacząć od poziomu zachowań. Duchowość każdego człowieka można dokładnie opisać wymieniając zachowania, którymi zreaguje na każdą możliwą sytuację.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_poziomy_duchowosci_zachowania_przyklad = KonspektStep(
    title: 'Poziomy duchowości - zachowania - przykład',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący opisuje <b>poziom zachowań</b> na przykładzie Alberta:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Przykładowo o <b>poziomie zachowań w duchowości</b> Alberta można powiedzieć, że:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Auto się zepsuło w drodze do pracy — otwiera maskę i naprawia.</p></li>'
        '<li><p style="text-align:justify;">Usłyszy „dzień dobry" — zawsze odpowie „dzień dobry".</p></li>'
        '<li><p style="text-align:justify;">Wraca głodny po pracy, w szafce czipsy albo składniki na obiad — ugotuje obiad.</p></li>'
        '<li><p style="text-align:justify;">Zobaczy śmieć na chodniku podczas spaceru — podniesie go i wyrzuci do kosza.</p></li>'
        '<li><p style="text-align:justify;">Zobaczy śmieć na chodniku, gdy spieszy się do teatru i idzie z narzeczoną — minie go i pobiegnie dalej.</p></li>'
        '<li><p style="text-align:justify;">Szef go skrytykuje — zacznie się z nim wykłócać.</p></li>'
        '<li><p style="text-align:justify;">...i tak dalej, i tak dalej.</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Oczywiście taka lista jest zawsze nieskończona: są w niej wszystkie możliwe sytuacje, każda z nich występuje we wszystkich możliwych okolicznościach, warunkach otoczenia, stanach samego Alberta itd. - poziom zachowań duchowości polega na spojrzeniu na <b>zachowania</b> człowieka, które ten podejmuje.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_poziomy_duchowosci_zachowania_pytania = KonspektStep(
    title: 'Poziomy rozwoju duchowego - zachowania - pytania',
    duration: Duration(minutes: 1),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący daje uczestnikom czas na ewentualne pytania.'
        '</p>'
);

KonspektStep _step_poziomy_duchowosci_wartosci_definicja = KonspektStep(
    title: 'Poziomy duchowości - wartości - definicja',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący płynnie przechodzi do opisu <b>poziomu wartości</b>, kładąc w odpowiednim momencie we wspólnej przestrzeni kartkę "poziom wartości" z załącznika $attach_html_karty_poziomow_duchowosci.'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Na szczęście, gdy się przyjrzeć uważniej zachowaniom ludzi, prawie zawsze coś je ze sobą łączy. Zazwyczaj ludzie w swoich poczynaniach dążą do tego, co uważają za <b>dobre</b>. Owe dobra, którym człowiek podporządkowuje swoje zachowania to <b>wartości</b>.'
        '<br>'
        '<br>Wartości to np.: zdrowie, władza, bogactwo, śmierć wrogów, posiadanie, rodzina, pokora, patriotyzm, ale też przyjemność, brak głodu, spokój, etc.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_poziomy_duchowosci_wartosci_przyklad = KonspektStep(
    title: 'Poziomy duchowości - wartości - przykład',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący opisuje <b>poziom wartości</b> na przykładzie Alberta:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Przykładowo o <b>poziomie wartości w duchowości</b> Alberta można powiedzieć, że:'
        '</p>'

        '<ul>'
        '<li><p style="text-align:justify;">Wartością dla Alberta są <b>pieniądze</b> - wynikają z tego zachowania w stylu: chodzenie do pracy, utrzymywanie konta bankowego itd.</p></li>'
        '<li><p style="text-align:justify;">Wartością większą od pieniędzy jest dla Alberta <b>rodzina</b> - wynikają z tego zachowania w stylu: dbanie o relację z narzeczoną, spędzanie czasu z rodzeństwem, dostosowywanie swojego życia pod posiadanie dużej liczby dzieci, etc.</p></li>'
        '<li><p style="text-align:justify;">Wartością dla Alberta jest <b>lojalność wobec firmy</b> - wynikają z tego zachowania w stylu: dbanie o reputację firmy, próba naprawy w środku zimy zepsutego auta, by móc dojechać do klienta (a przecież Albert mógłby zostać w jego ciepłym wnętrzu, zadzwonić po lawetę i napisać szefowi, że nie da rady dojechać - przecież to nie jego wina).</p></li>'
        '<li><p style="text-align:justify;">Wartością dla Alberta nie jest poezja - nie czyta jej, nie rozmyśla o niej, nie poświęca jej czasu, nie interesuje go ten temat.</p></li>'
        '</ul>'

        '</blockquote>'
);

KonspektStep _step_poziomy_duchowosci_wartosci_pytania = KonspektStep(
    title: 'Poziomy rozwoju duchowego - wartości - pytania',
    duration: Duration(minutes: 1),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący daje uczestnikom czas na ewentualne pytania.'
        '</p>'
);

KonspektStep _step_poziomy_duchowosci_wartosci_zagadka_1 = KonspektStep(
    title: 'Poziomy duchowości - wartości - zagadka 1 - pierwotne i moralne',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący upewnia się, że uczestnicy nadążają za jego tokiem rozumowania, następnie zadaje pytanie-zagadkę:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Czy jeśli ktoś, mogąc ukraść coś w sklepie świadomie tego nie robi - czy wartością jest dla niego uczciwość? A może niekoniecznie?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący daje uczestnikom chwilę, by spróbowali rozwiązać tę zagwozdkę. Dobrze, jeśli wywiąże się z tego jakaś <b>dyskusja</b>, która doprowadzi do następującego wniosku:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Niekoniecznie - może mieć w nosie uczciwość, prawdę czy zaufanie, ale zwyczajnie bać się konsekwencji karnych.'
        '</p>'
        '<p style="text-align:justify;">'
        'Z tej prostej obserwacji płyną dwa bardzo ważne wnioski:'
        '</p>'
        '<ol>'
        '<li><p style="text-align:justify;">Te same zachowania mogą wynikać z zupełnie różnych wartości, np. z uczciwości albo ze strachu.</p></li>'
        '<li><p style="text-align:justify;">Istnieją dwa bardzo różne "gatunki" wartości:</p>'
        '<ul>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Wartości moralne</b>'
        '<br>Pierwsze, o czym zazwyczaj każdy myśli, słysząc o wartościach, to <b>wartości moralne</b>, np.: "honor", "uczciwość", "prawda", "rodzina", "wiara".'
        '</p>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Wartości pierwotne</b>'
        '<br>...ale przecież każdy człowiek (również każde zwierzę) jest motywowany pewnymi pierwotnymi, biologicznymi instynktami, np.: ciekawością, strachem, głodem, przyjemnością, zakochaniem, etc. Są to <b>wartości pierwotne</b> - i też są to wartości; bezpiecznie jest nawet założyć, że są to przeważające wartości w życiu przeciętnego człowieka.'
        '</p>'
        '</li>'

        '</ul>'
        '</li>'
        '</ol>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Po tych słowach prowadzący upewnia się, że podział na "wartości pierwotne" oraz "wartości moralne" zapisane na kartce "poziom wartości" jest dla uczestników jasny.'
        '</p>'

);

KonspektStep _step_poziomy_duchowosci_wartosci_zagadka_2 = KonspektStep(
    title: 'Poziomy duchowości - wartości - zagadka 2 - dualizm',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący zadaje uczestnikom drugie pytanie-zagadkę:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'No dobrze, ale skoro wartości są tym, co człowiek uważa za dobre i do czego człowiek dąży, to dlaczego uczniowie bardzo chcą dobrze napisać maturę, ale gdy przychodzi co do czego, to zamiast się uczyć robią zupełne głupoty pokroju scrollowania instagrama? Wartości jedno, a zachowania drugie? O co chodzi?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący ponownie daje uczestnikom chwilę, by spróbowali rozwiązać tę zagwozdkę. Ponownie: dobrze, jeśli wywiąże się z tego jakaś <b>dyskusja</b>, która doprowadzi do następującego wniosku:'
        '</p>'

        '<blockquote>'
        '<ul>'
        '<li><p style="text-align:justify;">Wartości są tym, do czego człowiek dąży i co uważa za dobre — a nie tym, co mówi, że uważa za dobre.</p></li>'
        '<li><p style="text-align:justify;">Wartości nie są wcale stałe w czasie. Człowiek może zupełnie coś innego uważać za dobre w chwili, gdy wisi nad nim bezpośrednia wizja oblania egzaminu, a zupełnie coś innego, gdy wraca wieczorem do domu i ma czas do zagospodarowania.</p></li>'
        '<li><p style="text-align:justify;">Wartości nie muszą być wcale przemyślane, górnolotne i głębokie. Ludzie kierują się chęcią bycia wyspanym, czy doznania przyjemności i najedzenia, a to, czy o tym wiedzą, lub czy chcą się do tego przyznać, to już inna sprawa.</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Czy to oznacza, że nie ma znaczenia, co człowiek mówi, że jest dla niego ważne, bo liczą się tylko fakty? Nie do końca. Człowiek może pracować nad swoimi wartościami i wówczas jego świadoma wola jest kluczowa w kierunku rozwoju jego hierarchii wartości.'
        '</p>'
        '</blockquote>'

);

KonspektStep _step_poziomy_duchowosci_wartosci_zagadka_3 = KonspektStep(
    title: 'Poziomy duchowości - wartości - zagadka 3 - predyspozycje',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący zadaje uczestnikom trzecie pytanie-zagadkę:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'A jak to jest, zdarzają się ludzie (przykładowo bliźniacy), wychowani w tej samej rodzinie, w takich samych warunkach, ale jedno z nich jest kłótliwe i stawia na swoje, a drugie ugodowe i chodzące na kompromisy, mimo że rodzice dokładają wszelkich starań, by byli w tej kwestii tacy sami?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący ponownie daje uczestnikom chwilę, by spróbowali rozwiązać tę zagwozdkę. Ponownie: dobrze, jeśli wywiąże się z tego jakaś <b>dyskusja</b>, która doprowadzi do następującego wniosku:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Ludzie mają <b>predyspozycje</b> do określonych wartości - zwłaszcza związanych z wartościami pierwotnymi.'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Ludzie asertywni będą mieli skłonność do cenienia <b>konfrontacji</b> i <b>poszanowania własnych granic</b> wyżej od ludzi ugodowych.</p></li>'
        '<li><p style="text-align:justify;">Ludzie ekstrawertyczni będą mieli skłonność do cenienia <b>przebywania z ludźmi</b> wyżej od ludzi introwertycznych.</p></li>'
        '<li><p style="text-align:justify;">Ludzie sumienni będą mieli skłonność do cenienia <b>kończenia tego, co już zaczęli</b> wyżej od ludzi impulsywnych.</p></li>'
        '<li><p style="text-align:justify;">Ludzie neurotyczni będą mieli skłonność do cenienia <b>spokoju</b> i <b>braku stresu</b> wyżej od ludzi o niższej wrażliwości na negatywne emocje.</p></li>'
        '<li><p style="text-align:justify;">itd.</p></li>'
        '</ul>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Powyższe przykłady są związane z cechami temperamentu w modelu Big Five — są to cechy biologiczne, na które nie wpływa wychowanie. Warto o tym wspomnieć, jeśli ktoś z uczestników sam o to zapyta — w przeciwnym wypadku nie warto wprowadzać wątku nazewnictwa.'
        '</p>'

);

KonspektStep _step_poziomy_duchowosci_aksjomaty_dekompozycja = KonspektStep(
    title: 'Poziomy rozwoju duchowego - aksjomaty - dekompozycja',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący płynnie przechodzi do opisu <b>poziomu aksjomatów</b>. Zanim jednak cokolwiek zdefiniuje, pomaga najpierw uczestnikom zbudować intuicję.'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Jak niektórzy mogli już wychwycić podczas opisywania poziomu wartości, wartości nie funkcjonują w luźnej kupie, ale w formie hierarchicznej struktury. Różne rzeczy są dla ludzi ważne, ale niektóre są ważniejsze od innych: ma to znaczenie, gdy człowiek decyduje, czy poświęcić czas rodzinie, czy pracy, mimo że oba są dla niego ważne.'
        '<br>'
        '<br>Hierarchiczność wartości oznacza, że zawsze muszą istnieć jakieś <b>wartości najważniejsze</b>.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Przykładowo można byłoby podrążyć trochę w wartościach Alberta powtarzając pytanie: <b>"dlaczego jest to dla Ciebie ważne?"</b>.'
        '<br>'
        '<br><u>Przykładowy tok rozumowania Alberta:</u>'
        '<br>'
        '<i>'
        '<br>- Praca jest dla mnie ważna.'
        '<br>- Dlaczego?'
        '<br>- Bo chcę mieć pieniądze - są dla mnie ważne.'
        '<br>- Dlaczego?'
        '<br>- Bo potrzebuję ich do życia, jedzenie, ubrania, ale przede wszystkim chcę móc odłożyć na przyszłość.'
        '<br>- Dlaczego?'
        '<br>- Bo cenię sobie bezpieczeństwo, chciałbym też móc kupić kiedyś dom.'
        '<br>- Dlaczego?'
        '<br>- Bo chcę mieć dużą rodzinę i chcę, żeby dobrze im się żyło.'
        '<br>- Dlaczego?'
        '<br>- Bo uważam, że jestem do tego powołany, żeby mieć rodzinę. Rodzina to bliskość, wspólnota, miłość - a to najlepsze, co w życiu może być.'
        '<br>- Dlaczego?'
        '<br>- Nie wiem. Tak uważam. Uważam, że miłość jest najważniejsza w życiu. Przemawia do mnie i wierzę w historię Chrystusa.'
        '<br>- Dlaczego?'
        '<br>- Nie wiem. Wierzę w to i tyle. Nie wiem. Po prostu.'
        '</i>'
        '<br>'
        '<br>Zawsze w takich sekwencjach w końcu dochodzi się do ściany, gdzie nie ma już dalej odpowiedzi na pytanie "dlaczego". Albert nie ma dalszych odpowiedzi, nie dlatego, że jest głupi, ale dlatego, że dotarł do fundamentu — do pewnego przekonania, które z niczego dalej nie wynika. Zazwyczaj takie rozważania nie trwają kilku minut, a raczej kilka dni, miesięcy, czy nawet lat. Za każdym razem jednak, gdy dochodzi się do tej granicy, dotyka się ostatniego poziomu duchowości, czyli poziomu aksjomatu.'
        '</p>'
);

KonspektStep _step_poziomy_duchowosci_aksjomaty_definicja = KonspektStep(
    title: 'Poziomy rozwoju duchowego - aksjomaty - definicja',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący definiuje <b>poziom aksjomatów</b>, kładąc w odpowiednim momencie we wspólnej przestrzeni kartkę "poziom aksjomatów" z załącznika $attach_html_karty_poziomow_duchowosci.'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Aksjomat jest zawsze fundamentalną, nieweryfikowalną wiarą w określony porządek rzeczy — coś, co całkowicie porządkuje postrzeganie rzeczywistości.'
        '<br>'
        '<br>Ludzie wyznają najróżniejsze aksjomaty. Przykładowo mogą to być:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">"Świat stworzył trójjedyny Bóg, powołał człowieka na swój obraz, by doświadczył miłości."</p></li>'
        '<li><p style="text-align:justify;">"Świat stworzył przypadek. Świadomość człowieka jest iluzją fizyki, nie ma żadnego celu."</p></li>'
        '<li><p style="text-align:justify;">"Światem rządzą wibracje dobrych i złych energii, człowiek może się z nimi łączyć przez medytację."</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Istnieją jednak też inne aksjomaty, które ludzie wyznają, a których często nie są nawet świadomi:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">To, czego doświadczają moje zmysły, jest odzwierciedleniem realnego świata.</p></li>'
        '<li><p style="text-align:justify;">Prawa fizyki są zawsze takie same, nie tylko wtedy, gdy się je bada.</p></li>'
        '</ul>'

        '<p style="text-align:justify;">'
        'Aksjomaty zawsze są odpowiedzią na pytanie o najgłębszą wiarę.'
        '</p>'

        '</blockquote>'
);

KonspektStep _step_poziomy_duchowosci_aksjomaty_przyklad = KonspektStep(
    title: 'Poziomy rozwoju duchowego - aksjomaty - przykład',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący opisuje <b>poziom aksjomatów</b> na przykładzie Alberta:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Albert wziął się za naprawę, a przecież mógłby uklęknąć i medytować, by odeprzeć wibracje chaosu od silnika. Dlaczego tego nie zrobił? Może medytacja by zadziałała. Może mechanika, której uczył się w szkole nie ma zastosowania do akurat tego silnika: może prawa fizyki uległy tu akurat zmianie. Albert wziął się za naprawę, bo wierzy, że świat rządzi się stałymi prawami, które można poznać i zastosować.'
        '<br>'
        '<br>Inny przykład: Albert naprawia auto w mrozie, mimo że nikt go nie widzi, nikt mu dodatkowo nie zapłaci: mógłby olać temat i poczekać na lawetę. Czemu tego nie zrobi? Skąd u niego wartości takie jak zaradność, inicjatywa, czy działania mimo trudu? Przecież Albert mógłby wierzyć, że zepsute auto to znak z niebios.'
        '<br>'
        '<br>Tymczasem Albert bez żadnego specjalnego powodu wierzy, że świat staje się lepszy, gdy człowiek dobrowolnie bierze na siebie krzyż, trudy, zmagania rzeczywistości i je dźwiga — nawet gdy nikt tego nie wymaga. Dlaczego w to wierzy? Wierzy, bo tak. Taki wyznaje aksjomat i cześć.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący kończy definicję aksjomatów:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Ludzie wierzą w różne rzeczy. Spojrzenie na duchowość człowieka przez pryzmat poziomu aksjomatów polega na ustaleniu: co stoi za czyjąś strukturą wartości? Jaka wiara porządkuje i nadaje interpretację postrzeganej rzeczywistości? Jakie jest najwyższe dobro, czy cel, któremu podporządkowują swoje dążenia?'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_poziomy_duchowosci_aksjomaty_pytania = KonspektStep(
    title: 'Poziomy rozwoju duchowego - aksjomaty - pytania',
    duration: Duration(minutes: 1),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący daje uczestnikom czas na ewentualne pytania.'
        '</p>'
);

KonspektStep _step_poziomy_duchowosci_aksjomaty_wartosci_przyporzadkowanie = KonspektStep(
    title: 'Poziomy rozwoju duchowego - aksjomaty - zadanie 1',
    aims: [
      'Zbudowanie u uczestników intuicji tego, czym jest aksjomat.',
      'Pokazanie uczestnikom przykładu tego, że z różnych aksjomatów wynikają różne wartości.',
      'Pokazanie uczestnikom przykładu tego, że niektóre wartości mogą wynikać z różnych aksjomatów.',
    ],
    materials: [
      material_zal_aksjomaty_wartosci_przyporzadkowanie,
    ],
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.active,
    content: '<p style="text-align:justify;">'
        'Aby uczestnicy oswoili się z aksjomatami, prowadzący rozdaje im wycięte i pomieszane kartki z załącznika $attach_html_aksjomaty_wartosci_przyporzadkowanie.'
        '<br>'
        '<br>Zadaniem uczestników jest przyporządkować każdą z 14 wartości do któregoś z 3 aksjomatów. Dwie wartości pasują do więcej niż jednego aksjomatu. W trakcie ćwiczenia uczestnicy mogą prosić prowadzącego o pomoc.'
        '<br>'
        '<br>Na końcu prowadzący pokrótce omawia z uczestnikami poprawność ich dopasowania.'
        '<br>'
        '<br>Poprawne przyporządkowanie:'
        '<ol>'
        '<li>Chrystus, Syn Boży, wziął na siebie nasze winy, oddał życie i zmartwychwstał, byśmy mogli dostąpić zbawienia.'
        '<ul>'
        '<li>przebaczenie win</li>'
        '<li>dobrowolne dźwiganie trudu życia</li>'
        '<li>pokora, uznanie i walka z własnymi słabościami</li>'
        '<li>gotowość poświęcenia na rzecz bliźniego, choćby i nieprzyjaciela</li>'
        '</ul>'
        '</li>'
        '<li>Świat powstał przypadkiem, istnienie kończy się wraz ze śmiercią, a celem jest czerpanie przyjemności z życia, póki ono trwa.'
        '<ul>'
        '<li>unikanie długotrwałych zobowiązań</li>'
        '<li>bogactwo materialne</li>'
        '<li>dobrowolna eutanazja</li>'
        '<li>realizacja swoich pragnień</li>'
        '</ul>'
        '</li>'
        '<li>Świat jest areną walki i opresji, gdzie uprzywilejowane grupy niesprawiedliwie wyzyskują dyskryminowane mniejszości.'
        '<ul>'
        '<li>postrzeganie jednostki przez pryzmat jej przynależności grupowej</li>'
        '<li>inkluzywność, nawet kosztem dobra większości</li>'
        '<li>odnajdywanie i kompensowanie krzywd historycznych</li>'
        '<li>zwalczanie źródeł sukcesu grup uprzywilejowanych</li>'
        '</ul>'
        '</li>'
        '</ol>'
        '<br>Wspólne:'
        '<ul>'
        '<li>ochrona najuboższych (1 i 3)</li>'
        '<li>dostrzeganie piękna świata (1 i 2)</li>'
        '</ul>'
        '</p>'
);

KonspektStep _step_poziomy_duchowosci_aksjomaty_plaska_ziemia = KonspektStep(
    title: 'Poziomy rozwoju duchowego - aksjomaty - zagadka 2',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący, żeby sprawdzić, czy uczestnicy rozumieją sposób funkcjonowania aksjomatów, stawia przed nimi pytanie:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Czy wiara w to, że Ziemia jest płaska, może być aksjomatem?'
        '<br>'
        '<br>Wyjaśnijmy najpierw o co <b>nie chodzi</b>: może się zdarzyć, że ktoś robi badania i obserwacje i wychodzi mu, że Ziemia jest płaska - na przykład wskutek błędu w obliczeniach. W takim przypadku stwierdzenie, że Ziemia jest płaska nie jest aksjomatem, tylko <b>wnioskiem</b> z badań. Taki przypadek nas <b>nie interesuje</b>.'
        '<br>'
        '<br>Pytanie brzmi, czy może być tak, że ktoś całe spojrzenie na świat zaczyna od dogmatu, że Ziemia jest płaska?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący wchodzi z uczestnikami w dyskusję, która powinna doprowadzić do jednoznacznego wniosku:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Oczywiście, że tak - stwierdzenie, że Ziemia jest płaska, może być czyimś aksjomatem.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący wyjaśnia to, zwracając uwagę na dwie kwestie:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Jeśli ktoś wyjdzie z założenia, że Ziemia jest płaska, to po prostu dostosuje do tego wszystkie inne wnioski o świecie - to, czy będą one raczej pomagały, czy przeszkadzały w życiu, to już zupełnie inna sprawa.'
        '</p>'

        '<ol>'

        '<li><p style="text-align:justify;">'
        '<b>Aksjomat porządkuje wszystko.</b>'
        '<br>Jeśli ktoś wierzy, że Ziemia jest płaska, to wszystko inne podporządkuje pod to założenie. Przykładowo, gdy ktoś zobaczy zdjęcie kulistej Ziemi z kosmosu, wniosek będzie miał tylko jeden: zdjęcie jest sfałszowane, albo uzna to za dowód na to, że przebywanie w próżni powoduje iluzję kulistości rzeczy płaskich.'
        '</p></li>'

        '<li><p style="text-align:justify;">'
        '<b>My robimy dokładnie to samo.</b>'
        '<br>Gdyby ktoś nam powiedział, że ma dowód na to, że nauka to stek bzdur, uznalibyśmy, że jego dowód musi być błędny. Nie założylibyśmy nagle, że cała matematyka, fizyka, chemia czy biologia się mylą. W tym zakresie niczym się nie różnimy od wyznawców płaskiej Ziemi: my wyznajemy wiarę w metodę naukową, oni w płaską Ziemię. My również wszystko arbitralnie dostosowujemy do wiary w naukę, żeby zawsze móc uznać, że działa.'
        '</p></li>'

        '</ol>'
        '</blockquote>'
);



KonspektStepGroup step_group_poziomy_duchowosci = KonspektStepGroup(
    title: 'Poziomy (warstwy) duchowości',
    steps: [
      _step_poziomy_duchowosci_wstep,

      _step_poziomy_duchowosci_zachowania_definicja,
      _step_poziomy_duchowosci_zachowania_przyklad,
      _step_poziomy_duchowosci_zachowania_pytania,

      _step_poziomy_duchowosci_wartosci_definicja,
      _step_poziomy_duchowosci_wartosci_przyklad,
      _step_poziomy_duchowosci_wartosci_pytania,
      _step_poziomy_duchowosci_wartosci_zagadka_1,
      _step_poziomy_duchowosci_wartosci_zagadka_2,
      _step_poziomy_duchowosci_wartosci_zagadka_3,

      _step_poziomy_duchowosci_aksjomaty_dekompozycja,
      _step_poziomy_duchowosci_aksjomaty_definicja,
      _step_poziomy_duchowosci_aksjomaty_przyklad,
      _step_poziomy_duchowosci_aksjomaty_pytania,
      _step_poziomy_duchowosci_aksjomaty_wartosci_przyporzadkowanie,
      _step_poziomy_duchowosci_aksjomaty_plaska_ziemia
    ]
);

// Etapy rozwoju duchowości

KonspektStep _step_etapy_rozwoju_duchowosci_roznica_jakosciowa = KonspektStep(
  title: 'Etapy rozwoju duchowości - różnica jakościowa',
  duration: Duration(minutes: 2),
  activeForm: KonspektStepActiveForm.static,
  content: '<p style="text-align:justify;">'
      'Prowadzący zaczyna od zwrócenia uwagi na <b>różnicę</b> między sposobem rozwoju <b>sfer zdolności</b>, a <b>sfery ducha</b>:'
      '</p>'

      '<blockquote>'
      '<p style="text-align:justify;">'
      'Rozwój <b>sfer zdolności</b> polega na tym, że do już istniejącego "worka ze zdolnościami" dorzucane są kolejne zdolności: człowiek uczy się grać na nowym instrumencie, uczy się nowego języka, uczy się sposobu radzenia sobie ze złością, etc.'
      '<br>'
      '<br>Rozwój <b>sfery ducha</b> jest zupełnie inny. Człowiek nie ma "worka z różnymi duchowościami" - ma zawsze jedną, konkretną duchowość. Rozwój sfery ducha polega na porzucaniu jednej formy duchowości i przyjmowaniu nowej.'
      '<br>'
      '<br>Przykładowo: dla kogoś dotąd najważniejsze było zdrowie i wszystkie swoje czyny podporządkowywał zdrowemu stylowi życia, aż pewnego razu miejsce zdrowia zastępuje przyjaźń - i wówczas to relacja z drugim człowiekiem determinuje sposób użycia posiadanych zdolności i zasobów.'
      '<br>'
      '<br>To trochę jak wygranie na ten sam komputer zupełnie nowego systemu operacyjnego.'
      '<br>'
      '<br>O rozwoju duchowym nie należy myśleć jak o budowaniu — lecz jak o kształtowaniu, rzeźbieniu: ten sam kawałek gliny może przyjąć nieskończenie wiele kształtów, ale zawsze jest tylko jeden naraz.'
      '<br>'
      '<br>Czujecie tę różnicę?'
      '</p>'
      '</blockquote>',
);

KonspektStep _step_etapy_rozwoju_duchowosci_roznica_jakosciowa_pytania = KonspektStep(
  title: 'Etapy rozwoju duchowości - różnica jakościowa - pytania',
  duration: Duration(minutes: 2),
  activeForm: KonspektStepActiveForm.static,
  content: '<p style="text-align:justify;">'
      'Prowadzący daje uczestnikom czas na zadanie pytań.'
      '</p>',
);

KonspektStep _step_etapy_rozwoju_duchowosci_osie = KonspektStep(
  title: 'Etapy rozwoju duchowości - osie współrzędnych',
  duration: Duration(minutes: 1),
  activeForm: KonspektStepActiveForm.static,
  content: '<p style="text-align:justify;">'
      'Prowadzący bierze dużą kartkę (np. flipchart) i rysuje na niej dwie prostopadłe osie współrzędnych. Na osi X zaznacza <b>czas</b>, zaś na osi Y <b>poziom duchowości</b> i wyjaśnia, co się będzie działo:'
      '</p>'
      '<blockquote>'
      '<p style="text-align:justify;">'
      'Przejdziemy teraz krok po kroku przez etapy ogólnego procesu kształtowania duchowości - od zucha po dorosłego człowieka, którego harcerstwo ma ambicję wychować.'
      '</p>'
      '</blockquote>',
);

KonspektStep _step_etapy_rozwoju_duchowosci_schemat = KonspektStep(
  title: 'Etapy rozwoju duchowości - schemat',
  duration: Duration.zero,
  activeForm: KonspektStepActiveForm.static,
  content: '<p style="text-align:justify;">'
      'Prowadzący przechodzi do tłumaczenia krok po kroku sposobu kształtowania duchowości. W tym celu wydzielić należy 3 etapy wiekowe wymienione poniżej. Dla każdego etapu przechodzi przez każdy z poziomów rozwoju duchowego w wymienionej niżej kolejności.'
      '<br>'
      '<br>Model i kolejność tłumaczenia etapów powinien być następujący:'
      '</p>'
      '<ul>'
      '<li>Etap <b>7-9</b> lat:'
      '<ol>'
      '<li><b>Zachowania</b> w duchowości [TAK]</li>'
      '<li><b>Wartości</b> w duchowości [NIE]</li>'
      '<li><b>Aksjomaty</b> w duchowości [NIE]</li>'
      '</ol>'
      '</li>'
      '<li>Etap <b>10-12</b> lat:'
      '<ol start="0">'
      '<li>Co się zmienia? [WARTOŚCI]</li>'
      '<li><b>Wartości</b> w duchowości [TAK]</li>'
      '<li><b>Zachowania</b> w duchowości [TAK]</li>'
      '<li><b>Aksjomaty</b> w duchowości [NIE]</li>'
      '</ol>'
      '</li>'
      '<li>Etap <b>13-15</b> lat:'
      '<ol start="0">'
      '<li>Co się zmienia? [Aksjomaty]</li>'
      '<li><b>Aksjomaty</b> w duchowości [TAK]</li>'
      '<li><b>Wartości</b> w duchowości [TAK]</li>'
      '<li><b>Zachowania</b> w duchowości [TAK]</li>'
      '</ol>'
      '</li>'
      '</ul>'

      '<p style="text-align:justify;">'
      'Każdorazowo, po opisaniu konkretnego fragmentu, prowadzący rysuje na dużej kartce kolejne elementy wykresu.'
      '<br>'
      '<br>Ważne, by całą tę część przeprowadzić możliwie dynamicznie, ale spokojnie, w formie wynikającej z siebie opowieści, podając odpowiednie przykłady, by uczestnicy zbudowali sobie intuicję o każdym z etapów rozwoju.'
      '</p>',
);

KonspektStep _step_etapy_rozwoju_duchowosci_7_9_lat_zachowania = KonspektStep(
  title: 'Etapy rozwoju duchowości - 7-9 lat - zachowania',
  duration: Duration(minutes: 2),
  activeForm: KonspektStepActiveForm.static,
  content: '<p style="text-align:justify;">'
      'Prowadzący przedstawia poziom <b>zachowań</b> na etapie <b>7-9 lat</b>:'
      '</p>'
      '<blockquote>'
      '<p style="text-align:justify;">'
      'Czy przed 9-tym rokiem życia, w duchowości człowieka funkcjonują <b>zachowania</b> i czy można je szeroko kształtować?'
      '</p>'
      '</blockquote>'

      '<p style="text-align:justify;">'
      'Prowadzący, jeśli chce, może poczekać kilka sekund, aż ktoś wyrazi swoje zdanie, po czym sam udziela odpowiedzi:'
      '</p>'

      '<blockquote>'
      '<p style="text-align:justify;">'
      'Oczywiście, że tak. Dzieci podejmują określone zachowania: jedzą, chodzą, mówią, skaczą, śpią, etc.'
      '<br>'
      '<br>Zachowania można kształtować, np. napominaniem dzieci (np., gdy rodzic mówi dziecku: "powiedz pani «dzień dobry»"). Kształtować zachowania u dzieci można też wykorzystując ich tendencję do naśladowania innych - można przykładowo jeść nożem i widelcem i dzięki temu dzieci same zaczną to robić.'
      '<br>'
      '<br>W skrócie: tak, w wieku 7-9 lat w duchowości dzieci funkcjonują zachowania.'
      '</p>'
      '</blockquote>'
);

KonspektStep _step_etapy_rozwoju_duchowosci_7_9_lat_wartosci = KonspektStep(
    title: 'Etapy rozwoju duchowości - 7-9 lat - wartości',
    duration: Duration(minutes: 4),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący przedstawia poziom <b>wartości</b> na etapie <b>7-9 lat</b>:'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Czy przed 9-tym rokiem życia, w duchowości człowieka funkcjonują <b>wartości</b> i czy można je szeroko kształtować?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący udziela odpowiedzi:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Nie - z pewnym wyjątkiem.'
        '<br>'
        '<br>Dzieci mają <b>wartości pierwotne</b>: zainteresowania, temperament, empatię, popędy, do których zaspokojenia konsekwentnie dążą. U dzieci w tym wieku próżno szukać jednak zrozumienia, że źródłem ich działań są jakiekolwiek wartości, czy imperatywy.'
        '<br>'
        '<br>Podobnie, próżno szukać też u dzieci <b>wartości moralnych</b>. Zachowania przejawiane w tym wieku, jeśli nawet sprawiają wrażenie spójnie motywowanych moralnością, to tylko dlatego, że są ukształtowane przez środowisko funkcjonujące według określonego systemu wartości. U dzieci te zachowania nie są ze sobą związane - granie "fair play" w warcaby w żaden sposób nie przełoży się dla nich na zasady "fair play" w piłkę.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący podaje pierwszą intuicję:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Brak świadomych wartości u dzieci przed 10. rokiem życia wynika z ich problemów z abstrakcyjnym myśleniem. Dobrze to widać przy sprzątaniu:'
        '<br>'
        '<br>Dla dzieci w tym wieku nie istnieje koncept "porządku". Sprzątanie nie polega na doprowadzeniu przestrzeni do jakiegoś stanu, ale na wykonaniu sekwencji przeniesienia rzeczy na określone miejsca: klocków pod szafkę, pluszaków na półkę, a kredek do kredensu. Niestety, jeśli ta umiejętność zostanie stworzona w kontekście sprzątania w przedszkolu, to w żaden sposób nie wpłynie to na umiejętność sprzątania w domu.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący podaje drugą intuicję:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Wymowne w tym zakresie jest także Prawo Zucha - nie bez przyczyny składa się ono ze stwierdzeń: co zuch <b>robi</b> i jaki zuch <b>jest</b>, a nie czym się zuch <b>kieruje</b>, albo do czego <b>dąży</b>.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_etapy_rozwoju_duchowosci_7_9_lat_aksjomaty = KonspektStep(
    title: 'Etapy rozwoju duchowości - 7-9 lat - aksjomaty',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący przedstawia poziom <b>aksjomatów</b> na etapie <b>7-9 lat</b>:'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Czy przed 9-tym rokiem życia, w duchowości człowieka funkcjonują <b>aksjomaty</b> i czy można je szeroko kształtować?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący udziela odpowiedzi:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Nie - również z pewnym wyjątkiem.'
        '<br>'
        '<br>Dzieci mają pewną wąską grupę podstawowych założeń o świecie: '
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Wierzą, że świat jest taki, jak go widzą, lub</p></li>'
        '<li><p style="text-align:justify;">Rodzice zawsze mają rację.</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'U dzieci w tym wieku próżno szukać jednak zrozumienia, że działają w oparciu o tę wiarę - nie rozumieją nawet tego, co to oznacza "wierzyć".'
        '<br>'
        '<br>Dzieci nie wyznają świadomie żadnej wiary, ani aksjomatów, nie umieją niczego z nich wywnioskować, nie umieją ich nazwać. Mogą zapamiętać stwierdzenia o tym, co jest w życiu najważniejsze, ale nie są w stanie spójnie określić, co jest w konsekwencji dobre, a co złe.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący zadaje uczestnikom pytanie-zagadkę:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Czy skoro dla dzieci aksjomaty takie, jak:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Życie, śmierć i zmartwychwstanie Chrystusa, albo:</p></li>'
        '<li><p style="text-align:justify;">Dobro zawsze wraca</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        '...nie mają znaczenia duchowego, to czy w ogóle warto im mówić, co jest w życiu najważniejsze?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący podaje odpowiedź:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Tak. Wprawdzie nie ma szans, aby człowiek w tym wieku sam, świadomie oparł o te prawdy swoje wartości i zachowania, ale ich znajomość buduje skojarzenia, schematy, wyobrażenia, sformułowania, przyzwyczajenia i rytuały. Gdy ci sami ludzie za kilka lat spojrzą w końcu na świat przez pryzmat aksjomatów, to te, które będą brzmiały znajomo i będą się im dobrze kojarzyły zyskają pierwszeństwo.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_etapy_rozwoju_duchowosci_7_9_lat_wykres = KonspektStep(
  title: 'Etapy rozwoju duchowości - 7-9 lat - wykres',
  duration: Duration(minutes: 1),
  activeForm: KonspektStepActiveForm.static,
  contentBuilder: ({required bool isDark}) =>
  '<p style="text-align:justify;">'
      'Prowadzący rysuje na wykresie elementy odpowiadające etapowi <b>7-9 lat</b>.'
      '</p>'
      '${piramidaDuchowosci7_9Html(isDark: isDark)}',
);

// czy dzieci mają duchowość?

KonspektStep _step_etapy_rozwoju_duchowosci_10_12_lat_co_sie_zmienia = KonspektStep(
    title: 'Etapy rozwoju duchowości - 10-12 lat - co się zmienia?',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący przedstawia zmianę, jaka zachodzi w okolicy 9-10 roku życia:'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Mniej więcej między trzecią, a czwartą klasą szkoły podstawowej zachodzi w umyśle człowieka ważna zmiana, która znacząco wpływa na duchowość: człowiek zyskuje zdolność do abstrakcyjnego myślenia:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">liczby przestają oznaczać jedynie "jabłka leżące na stole", do których można dodać jeszcze kilka jabłek - człowiek zaczyna je rozumieć jako abstrakcyjne byty, które mogą być ujemne, ułamkowe itp.</p></li>'
        '<li><p style="text-align:justify;">koncept porządku przestaje już być związany z konkretną salą w przedszkolu, czy pokojem w domu - człowiek zaczyna go rozumieć jako autonomiczny, niezwiązany z jakimś miejscem byt.</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Zmiana ta powoduje, że człowiek szybko dostrzega między różnymi zachowaniami wspólne cechy, których nie można bezpośrednio dotknąć, czy przedstawić - np. szacunek, siłę, posłuszeństwo, honor, braterstwo itp.'
        '<br>'
        '<br>W świadomości człowieka pojawia się koncept "wartości" - nawet, jeśli nie są one tym określeniem nazywane.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_etapy_rozwoju_duchowosci_10_12_lat_wartosci = KonspektStep(
    title: 'Etapy rozwoju duchowości - 10-12 lat - wartości',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący przedstawia poziom <b>wartości</b> na etapie <b>10-12 lat</b>:'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Skoro ustaliliśmy już, że od ok. 10. roku życia w duchowości człowieka krystalizują się wartości, to zastanówmy się, jakie wartości człowiek przyjmie jako pierwsze:'
        '<br>'
        '<br>Po pierwsze: na pewno nie będą to wartości losowe. Po drugie: pierwsze wartości, które człowiek przyjmie będą niemal na pewno korespondowały z zachowaniami, do których człowiek jest najsilniej przywiązany oraz z którymi ma najlepsze doświadczenia.'
        '<br>'
        '<br>Przykładowo: jeśli człowiek chodził do szkoły, uczył się, dobrze mu szło i był otoczony ludźmi robiącymi to samo - wykształcenie będzie dla niego prawdopodobnie ważną rzeczą.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_etapy_rozwoju_duchowosci_10_12_lat_zachowania = KonspektStep(
    title: 'Etapy rozwoju duchowości - 10-12 lat - zachowania',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący wraca do poziomu <b>zachowań</b> na etapie <b>10-12 lat</b>:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Zatrzymajmy się w takim razie jeszcze na chwilę przy zachowaniach w tym wieku. Po pierwsze - można dalej mówić o <b>zachowaniach</b> w duchowości człowieka na etapie 10-12 lat, oraz czy można je szeroko kształtować?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Odpowiedź na to pytanie jest banalna, jednak prowadzący zwraca uwagę:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Oczywiście: człowiek tak jak miał, tak dalej ma różne, określone zachowania.'
        '<br>'
        '<br>W ich kształcie zmieniają się jednak trzy rzeczy:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Po pierwsze: od momentu pojawienia się w świadomości człowieka wartości, dotychczasowe zachowania zaczynają być stopniowo weryfikowane - dotychczasowe sposoby funkcjonowania są zderzane z tym, co człowiek świadomie uważa za dobre.</p></li>'
        '<li><p style="text-align:justify;">Po drugie: zachowania nadal bywają kształtowane pojedynczo, ale często są one kształtowane grupowo wskutek uznania lub wzmocnienia określonej wartości - przykładowo, gdy człowiek poczuje moralny dyskomfort, że wyżej sobie ceni gry komputerowe niż przyjaźnie, zmieni cały szereg zachowań w swoim życiu.</p></li>'
        '<li><p style="text-align:justify;">Po trzecie: odkąd człowiek odnosi zachowania do swoich wartości, trudniej jest w procesie wychowawczym ukształtować w nim dowolne zachowanie z taką łatwością jak wcześniej - jeżeli bowiem będzie ono sprzeczne z jego wartościami, raczej go nie przyjmie.</p></li>'
        '</ul>'
        '</blockquote>'
);

KonspektStep _step_etapy_rozwoju_duchowosci_10_12_lat_aksjomaty = KonspektStep(
    title: 'Etapy rozwoju duchowości - 10-12 lat - aksjomaty',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący przedstawia poziom <b>aksjomatów</b> na etapie <b>10-12 lat</b>:'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Czy w wieku 10-12 lat w duchowości człowieka funkcjonują <b>aksjomaty</b> i czy można je szeroko kształtować?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący udziela odpowiedzi:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Nie. W tym zakresie niewiele się zmienia: człowiek wprawdzie ma różne wartości, ale nie ma on jeszcze potrzeby, ani zdolności, by zrozumieć, że różne systemy wartości są między sobą nieporównywalne, oraz potrzebę, by za jego wartościami stała jakaś głębsza wiara porządkująca jego życie. Aksjomatyczne stwierdzenia mogą być rozumiane nieco głębiej niż wcześniej, ale wciąż nie są one ostateczną, arbitralnie przyjmowaną prawdą, której podporządkowywana jest cała pozostała perspektywa.'
        '</p>'
        '</blockquote>'

);

KonspektStep _step_etapy_rozwoju_duchowosci_10_12_lat_wykres = KonspektStep(
  title: 'Etapy rozwoju duchowości - 10-12 lat - wykres',
  duration: Duration(minutes: 1),
  activeForm: KonspektStepActiveForm.static,
  contentBuilder: ({required bool isDark}) =>
  '<p style="text-align:justify;">'
      'Prowadzący rysuje na wykresie elementy odpowiadające etapowi <b>10-12 lat</b>.'
      '</p>'
      '${piramidaDuchowosci10_12Html(isDark: isDark)}',
);

KonspektStep _step_etapy_rozwoju_duchowosci_13_15_lat_co_sie_zmienia = KonspektStep(
    title: 'Etapy rozwoju duchowości - 13-15 lat - co się zmienia?',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący przedstawia zmianę, jaka zachodzi w okolicy 13-15 roku życia:'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Przychodzi w końcu w życiu człowieka piękny czas początku szkoły średniej. Z jednej strony wiąże się to z tak zwanym nastoletnim buntem, a z drugiej, zupełnym zbiegiem okoliczności jest to też czas, w którym człowiek zaczyna mieć potencjał do przebudowania swojej duchowości w perspektywie konkretnych aksjomatów.'
        '<br>'
        '<br>Istnieje kilka charakterystycznych wydarzeń, które towarzyszą temu procesowi:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Człowiek zaczyna podważać dotychczasową duchowość, w której został ukształtowany i zaczyna budować swoją autonomię od rodziców.</p></li>'
        '<li><p style="text-align:justify;">Człowiek zaczyna widzieć, że wiele z tego, co uważał dotychczas za obiektywne wcale nie musi takie być:</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Kto ustalił, które wartości są dobre, a które nie?</p></li>'
        '<li><p style="text-align:justify;">Czemu mam wierzyć w Boga, skoro gdybym urodził się w Iranie, to wierzyłbym w Allaha?</p></li>'
        '</ul>'
        '</li>'
        '</ul>'
        '<p style="text-align:justify;">'
        'Tym pytaniom towarzyszy najczęściej także niewypowiedziana, ale paląca potrzeba oparcia swojego życia o coś większego: o jakąś misję, tożsamość, wiarę, perspektywę, etc.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_etapy_rozwoju_duchowosci_13_15_lat_aksjomaty = KonspektStep(
    title: 'Etapy rozwoju duchowości - 13-15 lat - aksjomaty',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący przedstawia poziom <b>aksjomatów</b> na etapie <b>13-15 lat</b>:'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'A zatem człowiek budzi się pewnego ranka i niedługo potem jego życie staje w perspektywie poszukiwania czegoś głębszego. Znowu: zastanówmy się jakie aksjomaty człowiek przyjmie jako pierwsze?'
        '<br>'
        '<br>Znowu, na pewno nie będą to losowe aksjomaty. Podobnie jak wcześniej, człowiek będzie miał tendencję do przyjęcia aksjomatów, które już zna: takich, które będą korespondowały z wartościami i zachowaniami, do których człowiek jest najsilniej przywiązany oraz z którymi ma najlepsze doświadczenia.'
        '<br>'
        '<br>Przykładowo: jeśli dla człowieka ważne były przyjaźnie, przebaczenie i modlitwa to przyjęcie zbawczej roli życia, męki i zmartwychwstania Chrystusa będzie bardzo prawdopodobne.'
        '</p>'
        '</blockquote>'

);

KonspektStep _step_etapy_rozwoju_duchowosci_13_15_lat_wartosci = KonspektStep(
    title: 'Etapy rozwoju duchowości - 13-15 lat - wartości',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący wraca do poziomu <b>wartości</b> na etapie <b>13-15 lat</b>:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Nie będzie chyba zaskoczeniem, gdy powiem, że ludzie w wieku 13-15 lat wciąż mają wartości. Ciekawszym zagadnieniem jest to, co się z nimi dzieje po internalizacji aksjomatów?'
        '<br>'
        '<br>Pierwszy proces, który się rozpoczyna, to proces uspójniania wartości z przyjętymi aksjomatami. Jeśli jakieś wartości były między sobą niespójne, powstanie napięcie, które będzie pchało człowieka do zrobienia czegoś z tą niespójnością.'
        '<br>'
        '<br>Drugi proces, który następuje to wyłonienie zupełnie nowych wartości, których wcześniej człowiek nie miał, ale które wynikają z przyjęcia określonych aksjomatów.'
        '<br>'
        '<br>W największym skrócie proces, któremu podlegają wartości jest długim procesem uspójnienia ich z przyjętymi aksjomatami - może się również okazać, że człowiek będzie tak przywiązany do niektórych wartości, że to aksjomat będzie musiał ustąpić. Efekt jest jednak wciąż ten sam - stopniowe budowanie spójności w obrębie hierarchii wartości i jej źródła.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_etapy_rozwoju_duchowosci_13_15_lat_zachowania = KonspektStep(
    title: 'Etapy rozwoju duchowości - 13-15 lat - zachowania',
    duration: Duration(minutes: 2),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący wraca do poziomu <b>zachowań</b> na etapie <b>13-15 lat</b>:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Poziom zachowań jest tą samą opowieścią, co poziom wartości: gdy aksjomaty zaczynają odciskać piętno na wartościach, w ślad za tym wartości przekształcają zachowania człowieka.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_etapy_rozwoju_duchowosci_13_15_lat_wykres = KonspektStep(
  title: 'Etapy rozwoju duchowości - 13-15 lat - wykres',
  duration: Duration(minutes: 1),
  activeForm: KonspektStepActiveForm.static,
  contentBuilder: ({required bool isDark}) =>
  '<p style="text-align:justify;">'
      'Prowadzący rysuje na wykresie elementy odpowiadające etapowi <b>13-15 lat</b>.'
      '</p>'
      '${piramidaDuchowosci13_15Html(isDark: isDark)}',
);

KonspektStep _step_etapy_rozwoju_duchowosci_16_plus_lat = KonspektStep(
    title: 'Etapy rozwoju duchowości - 16+ lat',
    duration: Duration(minutes: 3),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący podnosi temat rozwoju duchowości człowieka po internalizacji aksjomatów:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'No dobrze - człowiek ma już kilkanaście lat, ma określone wartości, ma jakieś aksjomaty lub przynajmniej potrzebę znalezienia aksjomatu - i co teraz? Czy to już koniec kształtowania duchowości?'
        '<br>'
        '<br>Oczywiście - nie. Kształtowanie duchowości się absolutnie nie kończy, choć faktem jest, że nabiera innego charakteru. Warto tu wspomnieć o trzech rzeczach:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Po pierwsze, od momentu, w którym duchowość człowieka jest oparta w konkretnym, nieporównywalnym źródle, wpływ zewnętrznych czynników wychowawczych staje się dużo bardziej subtelny. Każda "proponowana zmiana" w duchowości jest odnoszona do ostatecznego kryterium jakim są przyjęte przez człowieka aksjomaty - rozwój duchowy człowieka staje się dużo bardziej autonomiczny.</p></li>'
        '<li><p style="text-align:justify;">Po drugie: proces budowania spójności między kolejnymi poziomami duchowości nie trwa pięciu minut. Czasami jest to kwestia miesięcy, a nawet lat - ludzie mają określone przyzwyczajenia, nawyki, zajęcia itp - nie siedzą cały dzień i nie dumają nad swoją duchowością.</p></li>'
        '<li><p style="text-align:justify;">Po trzecie: za każdym razem, gdy coś w aksjomacie lub wartościach ulegnie zmianie, zmieniają się także zachowania. Ale zmiana zachowań to zmiana sposobu funkcjonowania w świecie — a to oznacza nowe doświadczenia, nową perspektywę i nowe impulsy do dalszego kształtowania duchowości. Powstaje pętla, która w praktyce sprawia, że rozwój duchowy trwa aż do końca życia.</p></li>'
        '</ul>'
        '</blockquote>'
);

KonspektStep _step_etapy_rozwoju_duchowosci_16_plus_lat_wykres = KonspektStep(
  title: 'Etapy rozwoju duchowości - 16+ lat - wykres',
  duration: Duration(minutes: 1),
  activeForm: KonspektStepActiveForm.static,
  contentBuilder: ({required bool isDark}) =>
  '<p style="text-align:justify;">'
      'Prowadzący rysuje na wykresie elementy odpowiadające etapowi <b>16+ lat</b>.'
      '</p>'
      '${piramidaDuchowosci16Html(isDark: isDark)}',
);

KonspektStep _step_etapy_rozwoju_duchowosci_pytania = KonspektStep(
    title: 'Etapy rozwoju duchowości - pytania',
    duration: Duration(minutes: 1),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący daje uczestnikom czas na zadanie pytań.'
        '</p>',
);

KonspektStepGroup step_group_etapy_rozwoju_duchowosci = KonspektStepGroup(
    title: 'Etapy rozwoju duchowości',
    steps: [
      _step_etapy_rozwoju_duchowosci_roznica_jakosciowa,
      _step_etapy_rozwoju_duchowosci_roznica_jakosciowa_pytania,
      _step_etapy_rozwoju_duchowosci_osie,
      _step_etapy_rozwoju_duchowosci_schemat,

      _step_etapy_rozwoju_duchowosci_7_9_lat_zachowania,
      _step_etapy_rozwoju_duchowosci_7_9_lat_wartosci,
      _step_etapy_rozwoju_duchowosci_7_9_lat_aksjomaty,
      _step_etapy_rozwoju_duchowosci_7_9_lat_wykres,

      _step_etapy_rozwoju_duchowosci_10_12_lat_co_sie_zmienia,
      _step_etapy_rozwoju_duchowosci_10_12_lat_wartosci,
      _step_etapy_rozwoju_duchowosci_10_12_lat_zachowania,
      _step_etapy_rozwoju_duchowosci_10_12_lat_aksjomaty,
      _step_etapy_rozwoju_duchowosci_10_12_lat_wykres,

      _step_etapy_rozwoju_duchowosci_13_15_lat_co_sie_zmienia,
      _step_etapy_rozwoju_duchowosci_13_15_lat_aksjomaty,
      _step_etapy_rozwoju_duchowosci_13_15_lat_wartosci,
      _step_etapy_rozwoju_duchowosci_13_15_lat_zachowania,
      _step_etapy_rozwoju_duchowosci_13_15_lat_wykres,

      _step_etapy_rozwoju_duchowosci_16_plus_lat,
      _step_etapy_rozwoju_duchowosci_16_plus_lat_wykres,
      _step_etapy_rozwoju_duchowosci_pytania,
    ]
);


// Scenka wychowawcza

KonspektStep _step_scenka_wychowawcza_wprowadzenie = KonspektStep(
    title: 'Scenka wychowawcza - wprowadzenie',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    materials: [
      material_zal_scenka_wychowawcza,
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący rozdaje uczestnikom załącznik $attach_html_scenka_wychowawcza, po czym czyta na głos opisaną tam historię. Następnie informuje uczestników, że za chwilę wcielą się w kadrę wędrowniczą. Ich zadaniem będzie odbyć rozmowę z Adamem i spróbować <b>przekonać go w ciągu 15 minut, że harcerską postawą jest wybaczyć Radkowi, kierując się 4. punktem PH.</b>'
        '<br>'
        '<br>Uwagi:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Jeśli prowadzący nie jest sam, najlepiej, jeśli aktorem grającym Adama będzie ktoś inny niż osoba czytająca opis.</p></li>'
        '<li><p style="text-align:justify;">Wskazane jest, aby na czas "grania roli Adama" prowadzący jakoś się ucharakteryzował, np. ubrał czapkę.</p></li>'
        '<li><p style="text-align:justify;">Jeśli uczestników jest wielu (ponad 10), a prowadzący nie jest sam, można podzielić uczestników na grupy i odegrać scenkę niezależnie w grupach przez różnych prowadzących.</p></li>'
        '<li><p style="text-align:justify;">Jeśli prowadzący bardzo nie chce wcielać się w rolę, formę można przeprowadzić w postaci aktywnej dyskusji, gdzie prowadzący wciela się w "adwokata diabła" i stara się argumentować tak, jak robiłby Adam.</p></li>'
        '</ul>'
);

KonspektStep _step_scenka_wychowawcza_przygotowanie = KonspektStep(
    title: 'Scenka wychowawcza - przygotowanie',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.active,
    content: '<p style="text-align:justify;">'
        'Uczestnicy mają pięć minut, aby ustalić między sobą strategię rozmowy.'
        '</p>'
);

KonspektStep _step_scenka_wychowawcza_etap_wlasciwy = KonspektStep(
    title: 'Scenka wychowawcza - etap właściwy',
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

KonspektStep _step_scenka_wychowawcza_omowienie = KonspektStep(
    title: 'Scenka wychowawcza - omówienie',
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący pyta uczestników: <i>"jak Wam poszło?"</i>.'
        '<br>'
        '<br>Oczywiście poszło im <b>fatalnie</b> — nie przekonali Adama. Prowadzący zadaje kolejne pytania:'
        '</p>'
        '<blockquote>'
        '<ol>'
        '<li><p style="text-align:justify;"><i>"Jakich argumentów używaliście?"</i></p></li>'
        '<li><p style="text-align:justify;"><i>"Dlaczego nie działały?"</i></p></li>'
        '<li><p style="text-align:justify;"><i>"Czego Wam brakowało, żeby go przekonać?"</i></p></li>'
        '</ol>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący podsumowuje:'
        '<br>'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Zabrakło Wam dwóch rzeczy:'
        '</p>'
        '<ol>'
        '<li><p style="text-align:justify;">Adam nie otrzymał <b>powodu</b>, żeby wyznawać harcerskie wartości — brakowało mu aksjomatu, z którego te wartości by wypływały. Tylko skąd miałby ten aksjomat wziąć?</p></li>'
        '<li><p style="text-align:justify;">Duchowości człowieka nie kształtuje się rozmowami wychowawczymi. One działają tylko w bardzo wąskim zakresie przypadków.</p></li>'
        '</ol>'
        '</blockquote>'
);

KonspektStepGroup step_group_scenka_wychowawcza = KonspektStepGroup(
    title: 'Scenka wychowawcza',
    steps: [
      _step_scenka_wychowawcza_wprowadzenie,
      _step_scenka_wychowawcza_przygotowanie,
      _step_scenka_wychowawcza_etap_wlasciwy,
      _step_scenka_wychowawcza_omowienie,
    ]
);


// Meta-narracja

KonspektStep _step_meta_narracja_opowiesci = KonspektStep(
    title: 'Meta-narracja - opowieści',
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący mówi:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Wróćmy jeszcze do przypadku Adama ze scenki. Przyczyną, dla której nie udało Wam się go przekonać był nie tylko nieodpowiedni dobór narzędzi - ale przede wszystkim nie dostał <b>powodu, by przyjąć wartości, które przyjmujemy w harcerstwie</b>.'
        '<br>'
        '<br>Czy zastanawialiście się kiedyś, dlaczego ludzie wierzą w to, w co wierzą? Albo raczej: dlaczego ludzie chętniej wierzą w jedne rzeczy, ale zupełnie nie przekonują ich inne poglądy?'
        '<br>'
        '<br>Ludzie nie postrzegają świata fundamentalnie jako zbioru obiektów, ani zbioru faktów. Ludzie postrzegają rzeczywistość przede wszytskim jako <b>opowieści</b>: historie mające przyczynę, sens, cel, która opowiadające o naturze świata, o swojej roli w nim itd..'
        '<br>'
        '<br>Przykładów na to można mnożyć bez końca: Grecy widzieli świat takim, jakim opisali go w mitologicznych historiach. Starotestamentalny lud żydowski, z którego nota bene my wszyscy wyrastamy, widział świat jako miejsce, w którym Bóg prowadzi ich przez dzieje, stopniowo odkrywając przed nimi swoją naturę. Tymczasem dziś, kilka tysięcy lat później, głód i potrzeba opowieści jest wciąż tak wielka, że ludzie płacą pieniądze za to, by móc usiąść na kilka godzin w fotelu i obejrzeć zupełnie wymyśloną historię walki dobra ze złem, taką jak Gwiezdne Wojny, Władca Pierścieni, czy Avengersi.'
        '<br>'
        '<br>Zatrzymajmy się chwilę nad tymi opowieściami:'
        '<br>'
        '<br>W pierwszym odruchu łatwo pomyśleć, że to atawizm - cecha, która kiedyś była przydatna, żeby sobie wyjaśnić jakieś zjawiska pogodowe i choroby, ale w gruncie rzeczy jest cechą prymitywnych ludów. No ale my, dzisiaj, nowocześni i współcześni, mamy wierzyć w jakieś mity? My, którzy mamy naukę i oświecenie?'
        '<br>'
        '<br>Po pierwsze: wierzymy w mity, i to jak! Uznajemy istnienie państw, wierzymy w swoją życiową misję względem rodziny, widzimy walkę wielkich, złych korporacji z dobrymi, zwykłymi ludźmi, wierzymy w oświeceniową opowieść o niezbywalnej godności wynikającej z samego faktu bycia człowiekiem, opowieści o bohaterach poległych za ojczyznę, wierzymy, że spokój i spełnienie osiąga się poprzez przepracowanie swoich problemów z dzieciństwa w drodze psychoterapii, czy w kapłańską rolę naukowców obcujących z najczystszą formą prawdy.'
        '<br>'
        '<br>Po drugie: opowieści i mity nie są bajeczkami, czy kłamstwami. Ich sens polega na przedstawieniu pewnej trudno uchwytnej prawdy o świecie, którą osiąga się poprzez stworzenie fikcyjnych postaci, fikcyjnych wydarzeń, które następnie są używane, by pokazać realne mechanizmy obecne w świecie.'
        '<br>'
        '<br>Przykładowo:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Można z jednej strony polecić komuś napisaną precyzyjnym, ale specyficznym językiem serię publikacji naukowych „Psychologiczne i socjologiczne aspekty wariantowych relacji dzieci i ich rodziców", albo można tę samą treść opowiedzieć w historii Pinokia: drewnianej, naiwnej kukle, która uciekłszy z domu, zostaje przygnieciona życiem, lecz w końcu bierze odpowiedzialność za siebie, ratuje nieudacznego ojca z wnętrza wieloryba i dzięki temu staje się w pełni człowiekiem.</p></li>'
        '<li><p style="text-align:justify;">Jak myślicie, która forma prędzej wpłynie na sposób bycia człowieka: powiedzenie komuś "do największego dobra zdolni są czasem ludzie, po których nikt by się tego początkowo nie spodziewał", czy historia Froda z Władcy Pierścieni?</p></li>'
        '</ul>'
        '<p style="text-align:justify;">'
        '<br>Ludzie wierzą w różne rzeczy. Czasami nawet wierzą w byle jakie treści, ale niemal nigdy nie wierzą w byle jakie formy. Przekonania, które wyznają, muszą do nich w pewien sposób przemawiać. Formą tą jest najczęściej <b>narracja</b> o rzeczywistości: opowieść, która porządkuje świat, opowiada o dobru i złu, nadaje tożsamość, sens i cel.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący kładzie obok karty "aksjomatu" kartę z załącznika $attach_html_narracja_opis, po czym prezentuje uczestnikom przykłady narracji z załącznika $attach_html_narracja_przyklady.'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Adamowi nie można po prostu powiedzieć: "przebaczenie jest dobre, uwierz w to". To, że przebaczenie jest dobre musi wynikać z jakiejś narracji, w którą uwierzy: ze pewnej opowieści, przez pryzmat której Adam będzie postrzegał rzeczywistość.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_meta_narracja_warunki_brzegowe = KonspektStep(
    title: 'Meta-narracja - warunki brzegowe',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    content: '<blockquote>'
        '<p style="text-align:justify;">'
        'Niestety nie wystarczy, żeby Adam przyjął dowolną narrację. Gdyby, przykładowo, przyjął darwinowski pogląd że <b>"świat to arena walki i prawo do życia mają tylko osobniki najlepiej dostosowane"</b>, raczej nie uznałby wartości braterstwa, uniwersalnej godności człowieka, czy przebaczenia.'
        '<br>'
        '<br>Konieczne jest, by z narracji przyjętej przez Adama wynikały <b>harcerskie wartości</b>.'
        '<br>'
        '<br>Zgodzicie się zapewne, że są nimi przede wszystkim wspomniane: "braterstwo", "godność każdego człowieka", "przebaczenie", czy "mówienie prawdy"?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Uczestnicy raczej powinni się zgodzić - w razie potrzeby dyskusji, prowadzący może podeprzeć się Prawem Harcerskim i Statutem ZHP.'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Zastanawialiście się kiedyś, skąd te wartości wzięły się w harcerskim wychowaniu? Czy jakiś stary, mądry harcerz, na przykład Robert Baden-Powell, usiadł kiedyś, głęboko się namyślił i ogłosił je wbrew całemu światu? A może jest inaczej: może harcerstwie wartości nie są wcale fundamentalnie inne od wartości kultury, w której żyjemy?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Po krótkiej dyskusji uczestnicy powinni zwrócić uwagę, że te wartości są powszechne w całej naszej kulturze, nie tylko w harcerstwie.'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'A czy zastanawialiście się kiedyś dlaczego nasza cywilizacja zbudowana jest akurat na takich, a nie innych wartościach?'
        '<br>'
        '<br>Jeśli mamy określić które poglądy i narracje mogą dać Adamowi wartości przebaczenia, braterstwa i uniwersalnej ludzkiej godności, to warto najpierw odpowiedzieć na pytanie jakie narracje dały początek tym wartościom w naszej kulturze. Do tego jednak konieczne jest nakreślenie pewnego kontekstu.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_meta_narracja_uniwersalnosc = KonspektStep(
    title: 'Meta-narracja - uniwersalność łacińskich wartości',
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.static,
    content:
        '<p style="text-align:justify;">'
        'Prowadzący zaczyna od zwrócenia uwagi, że wartości łacińskie nie są ani trochę <b>domyślne</b> ani <b>uniwersalne</b>:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Na początku rozprawmy się z założeniem, że nasze wartości są domyślne i naturalne: czyli że każdy, gdyby zostawić go samemu sobie, sam by je w końcu odkrył.'
        '<br>'
        '<br>Czy wiecie ile czasu my, jako gatunek (homo sapiens) żyjemy na świecie? Około 300 000 lat - gdybyście przenieśli noworodka sprzed 300 000 lat w czasie do obecnej chwili, to wyrósłby na zupełnie normalnego człowieka.'
        '<br>'
        '<br>Niestety przez 99% czasu swojego istnienia na Ziemi ludzie nawet nie stali obok braterstwa, przebaczenia, czy uniwersalnej ludzkiej godności. Te wartości wcale nie są dla nas naturalne - domyślne są dla nas <b>plemienność</b>, <b>niewolnictwo</b> i <b>przemoc</b>.'
        '<br>'
        '<br>Doskonale to widać nawet dziś na naszych najbliższych gatunkowych krewniakach, czyli szympansach. Niestety nie są to, mówiąc ogólnie, gołąbki pokoju: szympanse mają to do siebie, że regularnie zbierają się w grupy i polują na członków obcych stad, a gdy jakiegoś złapią, to dosłownie, żywcem rozrywają go na kawałki. To jest mniej więcej obraz tego, kim z natury jesteśmy także my dzisiaj, czyli gatunek homo sapiens.'
        '<br>'
        '<br>Nie jest to raczej przyjemna wiadomość dla naszych dzisiejszych, cywilizowanych uszu, ale jedynym powodem, dla którego jesteśmy inni jest to, że narzuciliśmy sobie bardzo wyrafinowane struktury, które z trudem wypierają z nas nasze naturalne instynkty i kształtują w nas zupełnie inną duchowość: zasady, wartości i przekonania, które zamiast pozwalać nam wybijać swoich wrogów, każą nam im przebaczać.'
        '<br>'
        '<br>To, jak kruche i w pewnym sensie nienaturalne są dla nas te narzucone duchowości widać niestety bardzo często. Masowe, przemysłowe mordy XX wieku na sąsiednich narodach nie były wcale wypadkiem i wynaturzeniem, ale obliczem naszego gatunku gdy cywilizująca nas duchowość na chwilę się zachwieje. Niemcy z III rzeszy nie byli jakimiś neandertalczykami, nie mieli innego genomu: byli identycznymi ludźmi jak my dziś i my na ich miejscu niestety zrobilibyśmy to samo.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Następnie prowadzący zwraca uwagę, że wartości łacińskie nie są <b>powszechne</b> na przestrzeni wszystkich <b>cywilizacji</b>:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Spróbujmy się teraz zastanowić, czy wszystkie cywilizacje, chcąc stłumić pierwotną, dziką ludzką duchowość dochodzi w końcu do łacińskich wartości.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący, poruszając temat kolejnych wartości, może posiłkować się kartkami z załącznika $attach_html_wartosci_lacinskie.'
        '</p>'

        '<ol>'

        // Wartość 1 - Niezbywalna godność każdego człowieka
        '<li>'
        '<p style="text-align:justify;">'
        '<b>Niezbywalna godność każdego człowieka.</b>'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Czy niezbywalna godność każdego człowieka jest uniwersalną wartością w każdej rozwiniętej cywilizacji?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący daje uczestnikom chwilę, by wyrazili swoje zdanie, po czym zwraca uwagę:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'W systemach konfucjańskich, np. w Chinach, Japonii, czy Korei, liczy się najpierw wspólnota i kolektyw, dopiero potem jednostka - powszechne jest oczekiwanie, że prawa i wolności człowieka można mu zabrać, gdy wymaga tego dobro wspólne.'
        '<br>'
        '<br>Niektórzy wyznawcy hinduizmu powstrzymają innych od udzielenia pomocy cierpiącemu – jeśli ktoś cierpi, to pokutuje za grzechy popełnione w poprzednim życiu.'
        '</p>'
        '</blockquote>'
        '</li>'

        // Wartość 2 - Przebaczenie.
        '<li>'
        '<p style="text-align:justify;">'
        '<b>Przebaczenie.</b>'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Czy przebaczenie jest uniwersalną wartością w każdej rozwiniętej cywilizacji?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący daje uczestnikom chwilę, by wyrazili swoje zdanie, po czym zwraca uwagę:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'W wielu kulturach przebaczenie jest uważane za zachętę do bycia wykorzystywanym.'
        '<br>'
        '<br>Nietzsche widział w przebaczaniu wyraz słabości i element moralności niewolników.'
        '<br>'
        '<br>W tradycyjnej kulturze japońskiej po popełnieniu poważnej winy nie było drogi jej odpuszczenia – jedynym honorowym wyjściem było rytualne samobójstwo: seppuku.'
        '</p>'
        '</blockquote>'
        '</li>'

        // Wartość 3 - Życie w prawdzie.
        '<li>'
        '<p style="text-align:justify;">'
        '<b>Życie w prawdzie.</b>'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Czy życie w prawdzie (mówienie prawdy i szacunek do niej) jest uniwersalną wartością w każdej rozwiniętej cywilizacji?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący daje uczestnikom chwilę, by wyrazili swoje zdanie, po czym zwraca uwagę:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'W kulturach wschodnich, gdzie najważniejsza jest harmonia społeczna, należy kłamać, jeśli prowadzi to do uniknięcia konfliktu. W części kultur afrykańskich kłamstwo nie jest złem, jeśli służy uniknięciu wstydu.'
        '</p>'
        '</blockquote>'
        '</li>'

        '</ol>'

);

KonspektStep _step_meta_narracja_zrodla_lacinskich_wartosci = KonspektStep(
    title: 'Meta-narracja - źródła łacińskich wartości',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący kontrastuje poprzednie trzy alternatywne systemy przekonań z systemem łacińskim:'
        '</p>'

        '<blockquote>'
        '<ol>'
        '<li><p style="text-align:justify;">Skąd zatem w naszej duchowości pogląd, że wykształcony profesor z zasługami dla narodu ma mieć takie same prawa jak półinteligentny osiedlowy cwaniaczek? Skąd pomysł, że prawo do życia i godnego traktowania przysługuje każdemu, niezależnie od wieku, pochodzenia czy wyznania?</p></li>'
        '<li><p style="text-align:justify;">Dlaczego w naszych systemach prawnych po odbyciu kary wina zostaje zmazana i człowiek jest wolny? Dlaczego za kradzież nie skazuje się ludzi dożywotnio, żeby skutecznie ich od niej zniechęcić?</p></li>'
        '<li><p style="text-align:justify;">Dlaczego akurat my tak się uparliśmy, by nagannie traktować świadome kłamstwa?</p></li>'
        '</ol>'
        '<p style="text-align:justify;">'
        'Przecież ani nie są to dla nas naturalne instynkty, ani nawet nie są to uniwersalne remedia na nasze naturalne instynkty - większość cywilizacji i systemów społecznych kieruje się czymś zupełnie innym!'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący pozwala uczestnikom wejść w dyskusję i przedstawić własne propozycje, po czym podsumowuje:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Nasza cywilizacja jest zbudowana wokół takich wartości tylko z jednego powodu: bo ukształtowała ją wiara w zbawcze dla człowieka: życie, śmierć i zmartwychwstanie Chrystusa.'
        '</p>'
        '<ol>'
        '<li><p style="text-align:justify;">Nie byłoby niezbywalnej godności każdego człowieka, ani równości wobec prawa, ani humanitaryzmu, ani oświecenia, ani Powszechnej Deklaracji Praw Człowieka bez wiary, że skoro sam Bóg dobrowolnie wydał się na śmierć dla zbawienia najpodlejszego nawet człowieka, to że w każdym człowieku jest coś iście boskiego, nieważne jak bardzo jest podły, bezużyteczny, inny, czy denerwujący. Koncept godności niektórych ludzi funkcjonował w wielu kręgach już wcześniej - ale godność każdego człowieka - bez względu na jego urodzenie, majętność, plemienną przynależność, czy poglądy - jest czymś zupełnie innym.</p></li>'
        '<li><p style="text-align:justify;">Nie byłoby przebaczenia, ani odpuszczenia win, gdyby nie wiara, że sam Bóg, stwórca świata wziął na siebie błędy każdego człowieka i ich konsekwencje i zgodził się dobrowolnie ponieść śmierć, by zostać potępionym zamiast ludzi.</p></li>'
        '<li><p style="text-align:justify;">Nie byłoby wreszcie uznania wartości prawdy, gdyby nie wiara, że świat i jego prawa zostały stworzone przez absolutne dobro, oraz że stając w prawdzie pomimo błędów, czy chwilowego braku interesu jest jedyną drogą, by naprawić swoje życie, bo czuwa nad nim wszechmogący i miłujący Bóg.</p></li>'
        '</ol>'
        '</blockquote>'
);

KonspektStep _step_meta_narracja_selekcja_naturalna = KonspektStep(
    title: 'Meta-narracja - selekcja naturalna',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    content: '<blockquote>'
        '<p style="text-align:justify;">'
        'Ale co jeśli ktoś jest niewierzący? Co, jeśli ktoś nie patrzy na świat przez paradygmat chrześcijański?'
        '<br>'
        '<br>Tutaj jest do rozwikłania kilka rzeczy.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący zwraca uwagę, że źródło wartości cywilizacji łacińskiej nie jest kwestią wiary:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Po pierwsze, to że nasza cywilizacja i jej wartości są bezpośrednim efektem myśli, filozofii i wiary chrześcijańskiej nie jest zależne od tego, czy ktoś, kto dziś o tym myśli jest wierzący, czy nie.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Następnie prowadzący opisuje zjawisko <b>selekcji naturalnej</b> duchowości powszechnych:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Po drugie: nie wszystkie narracje, które stoją u podstaw różnych duchowości są tego samego kalibru i warto zrozumieć dlaczego.'
        '<br>'
        '<br>Ludzie mają to do siebie, że żyją w grupach, oraz że mają tendencję do ujednolicania w ramach swoich wspólnot swoich duchowości. Z tej perspektywy można zatem spojrzeć na duchowość nie tylko jak na sposób bycia pojedynczego człowieka, ale można w przypadku wspólnoty ludzi mówić o ich duchowości powszechnej - czyli zachowaniach, wartościach i aksjomatach wspólnych dla całej wspólnoty.'
        '<br>'
        '<br>Główną różnicą duchowości powszechnej jest to, że jej istnienie nie kończy się wraz ze śmiercią jednego człowieka. Duchowość powszechna ma charakter sztafetowy: każde przyjmujące ją pokolenie nią żyje, pogłębia ją, testuje jej warianty i coś poprawi, coś doda, coś usunie - i w końcu przekaże tę duchowość kolejnym pokoleniom. Ta sztafetowość ma olbrzymie znaczenie: zwykła duchowość jednego człowieka jest kształtowana tylko na podstawie doświadczeń i zasobów pojedynczego ludzkiego życia. Duchowość powszechna korzysta zaś z sekwencji milionów ludzkich żyć, prób, błędów, myśli i doświadczeń, co pozwala jej być daleko, daleko lepiej dostosowaną do życia w świecie niż pojedyncza duchowość pojedynczego człowieka.'
        '<br>'
        '<br>Drugą cechą duchowości powszechnych jest to, że podlegają one <b>selekcji naturalnej</b>. Niektóre sposoby postępowania działają w określonym środowisku lepiej od innych: niektóre poglądy, wartości i zachowania pozwalają żyć dłużej, szczęśliwiej, zasobniej niż inne. Przykładowo duchowość oparta jedynie na słuchaniu własnych potrzeb w ciągu kilku pokoleń doprowadziłaby do totalnego rozpadu struktur społecznych i sprawiałaby, że jej wyznawcy staliby się skazani tylko na siebie i prawdopodobnie wyginęli.'
        '<br>'
        '<br>Na świecie było i jest mnóstwo sposobów życia - ale zostawione samym sobie, wszystkie zostaną brutalnie zweryfikowane przez rzeczywistość i po kilkuset, czy nawet kilku tysiącach lat pozostaną tylko duchowości mieszczące się w wąskich granicach takich sposobów bycia, które pozwalają po pierwsze przetrwać, a po drugie czasami nawet się rozwijać.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący zwraca jeszcze uwagę na aspekt <b>narracji</b> duchowości powszechnych i wprowadza pojęcie <b>meta-narracji</b>:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Za każdą duchowością, która jest dla ludzi "przyjmowalna" stoi określona <b>narracja</b> - to już wiadomo. Ale w przypadku duchowości powszechnych te narracje także są innego kalibru.'
        '<br>'
        '<br>Jeżeli jakaś duchowość jest nieprzystająca do rzeczywistości i kończy się katastrofą ludzi ją przyjmujących, to zazwyczaj oznacza to, że owa narracja jest w jakiś sposób fałszywa - że opisuje świat i relacje w nim inaczej, niż funkcjonują one naprawdę.'
        '<br>'
        '<br>Jeżeli jednak jakaś duchowość okazuje się stabilna, oznacza to po pierwsze, że stojąca za nią narracja jest w jakiś głęboki sposób zgodna z tym, jak w istocie funkcjonuje świat. Po drugie zaś, jeśli trafia do ludzi, to znaczy, że nie przemawia do nich w sposób płytki i czysto emocjonalny, lecz dotyka ich najgłębszych kwestii egzystencjalnych.'
        '<br>'
        '<br>W tym drugim przypadku trudno mówić już jedynie o jakiejś wycinkowej narracji. Za stabilnymi, wielowiekowymi duchowościami stoją niezwykle spójne i głębokie opowieści o świecie, które rysują jego obraz w sposób zupełny, z których wynikają prawdy dotykające każdego ważnego aspektu życia.'
        '<br>'
        '<br>W takim wypadku zaś można już śmiało mówić o czymś więcej - o <b>meta-narracji</b>.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący obok karty "narracja" kładzie kartę "meta-narracja" z załącznika $attach_html_meta_narracja_opis, po czym prezentuje uczestnikom przykłady narracji z załącznika $attach_html_meta_narracja_przyklady. '
        '<br>'
        '<br>Na końcu prowadzący zwraca uwagę, że optymalnych duchowości nie da się "wymyślić":'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Kluczowe jest to, że rzeczywistość jest na tyle skomplikowana i nieprzewidywalna, że stworzenie duchowości "od zera" jest w zasadzie niewykonalne - jedyną metodą na zweryfikowanie jakości określonej duchowości jest jej empiryczne sprawdzenie w ogniu rzeczywistości.'
        '<br>'
        '<br>Podobnie, nie da się usiąść i skleić sobie na boku, nawet myśląc o tym przez kilkadziesiąt lat, jakiejś nowej meta-narracji. Takie próby oczywiście były wielokrotnie podejmowane i zawsze kończyły się tak samo: na początku działały, potem zaczynały pękać, a potem doprowadzały do rozlewu olbrzymiej ilości krwi.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_meta_narracja_wniosek = KonspektStep(
    title: 'Meta-narracja - wniosek',
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.static,
    content: '<blockquote>'
        '<p style="text-align:justify;">'
        'Przejdźmy zatem do wniosków i wróćmy już z powrotem do Adama. Jakie mamy opcje, żeby skutecznie wychować go do harcerskich wartości?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący proponuje jako opcję pierwszą <b>strategię "abdykacji"</b>:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Przede wszystkim można wyjść z założenia, że to nie jest nasz problem: że Adam jest po prostu stracony, a innym jakoś tam powiemy, że "trzeba być w życiu po prostu dobrym człowiekiem", albo "że trzeba się dzielić i przebaczać, bo kiedyś był kolonializm i musimy spłacić swój dług".'
        '<br>'
        '<br>Tylko że to w ogóle nie mieści się w harcerskim wychowaniu. Harcerstwo nie wychowuje konformistów, ani ignorantów, tylko wychowuje ludzi świadomych i ideowych.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący przed zaproponowaniem drugiej i trzeciej opcji przedstawia warunki, które należy spełnić:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Jeżeli zatem chcemy stanąć na wysokości zadania, to podsumujmy fakty:'
        '</p>'
        '<ol>'
        '<li><p style="text-align:justify;">Adam nie uzna żadnych wartości, o ile nie będą one wynikały z jakoś przyjętego przezeń aksjomatu.</p></li>'
        '<li><p style="text-align:justify;">Kształtowanie aksjomatów Adama (od dostosowania, przez przyzwyczajenie, tożsamość, a w końcu wiarę) musi dążyć do formy jakiejś narracji - jest to język, którym człowiek czyta aksjomaty.</p></li>'
        '<li><p style="text-align:justify;">Chcemy, żeby duchowość Adama była spójna i stabilna, dlatego nie wystarczą byle jakie narracje. Większość narracji kończy się dla przyjmujących ich ludzi fatalnie: w najlepszym wypadku samotnością, apatią i rozwalonym życiem, w najgorszym śmiercią. Chociaż nie jest to takie oczywiste, które z tych dwóch jest gorsze.'
        '<br>Potrzebujemy zatem narracji, które mają za sobą co najmniej kilkadziesiąt pokoleń historii i weryfikacji, czyli w zasadzie potrzebujemy jakiejś meta-narracji. Bez meta-narracji trudno oczekiwać spójnych i stabilnych wartości innych niż wartości pierwotne.</p></li>'
        '<li><p style="text-align:justify;">Potrzebujemy meta-narracji spełniającej bardzo konkretne kryteria: chcemy, żeby wynikały z niej uniwersalna i niezbywalna ludzka godność, przebaczenie, braterstwo, pokora, dążenie do ideału itd.</p></li>'
        '</ol>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący proponuje jako opcję drugą <b>strategię "chrześcijańską"</b>:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Istnieje w sposób oczywisty znana i bardzo stara meta-narracja, która spełnia wszystkie kryteria: jest to meta-narracja o zbawczym życiu, śmierci i zmartwychwstaniu Chrystusa.'
        '<br>'
        '<br>Oczywiście to, jak w praktyce wygląda praca wychowcza z taką meta-narracją to osobne zagadnienie.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący omawia jako opcję trzecią <b>strategię "alternatywy"</b>:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Ale wiele z Was może się zapewne zastanawiać: "A co, jeśli Adam jest niewierzący"?'
        '<br>'
        '<br>I tutaj obawiam się, że otwiera się pustka, na którą nikt dotąd nie podał odpowiedzi.'
        '<br>'
        '<br>Cała nasza cywilizacja została zbudowana na aksjomatach chrześcijańskich. Została ukształtowana przez życia miliardów ludzi, na przestrzeni tysięcy lat, przez myślicieli i filozofów większych od wszystkich tu obecnych. Czy można to wszystko porzucić i liczyć na to, że można usunąć fundamenty, na których stoimy, a potem jakoś "wymyśli się" coś równie dobrego w ich miejsce?'
        '<br>'
        '<br>Być może istnieje jakaś alternatywa, ale na dziś, myśl, że można utrzymać świat merytokracji, równości, wolności, godności ludzkiej, przebaczenia, uznania własnej niedoskonałości, powszechnej sprawiedliwości, nauki, ale pozbyć się tego, z czego one wynikają jest, mówiąc najdelikatniej, wielką nieodpowiedzialnością.'
        '<br>'
        '<br>Można próbować wybiegów w stylu: "wystarczy być dobrym człowiekiem", "idź za głosem serca" albo zostawić sferę aksjomatów niewierzących harcerzy samym sobie i tak oto pozbyć się problemu. Na razie taki model w ZHP funkcjonuje, ale jest to wyraz bezradności, a nie poważna odpowiedź na to pytanie. Chyba nikt nie ma odpowiedzi na to pytanie.'
        '</p>'
        '</blockquote>'


        '<p style="text-align:justify;">'
        'Na końcu prowadzący wyraża głośno wynikającą z tego zagadnienia myśl:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        '<br>Czy to zatem oznacza, że osoby niewierzące w Chrystusa nie mają jak kształtować swojej duchowości zgodnie z harcerskimi wartościami?'
        '<br>'
        '<br>Tutaj sprawa jest dwoista: dopóki wystarcająco wiele osób żyje zgodnie z chrześcijańskimi zasadami, to można być niewierzącym i przez dostosowanie, przyzwyczajenie, a czasami (choć rzadko) tożsamość, owe zasady zachować.'
        '<br>'
        '<br>Jeżeli jednak w życiu niewierzącego człowieka nastąpi jakieś nagłe wydarzenie, katastrofa, albo jeśli wystarczająco wiele osób porzuci te wartości - to w kilka dekad nic z ludzkiej wolności, godności, braterstwa, czy równości nie zostanie. Zresztą, sami pomyślcie: dlaczego nie wyłączyć ludzi robiących złe rzeczy z prawa do godnego traktowania? Czemu ktokolwiek miałby się poświęcać dla swojego wroga?'
        '<br>'
        '<br>Nie chodzi o to, że każdy, kto porzuci klasyczną, łacińską, meta-narrację jutro umrze. Absolutnie. Chodzi o to, jeśli zacznie szukać w swoim życiu głębokiem spójności ze swoimi przekonaniami, to absolutnie nie można liczyć na to, że w długim okresie zachowa harcerskie wartości jako swoje.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący powinien pozwolić, by fundamentalny <b>brak odpowiedzi</b> na pytanie „co dla ateistów" wybrzmiał wśród uczestników. <b>Odpowiedź nie padnie na warsztatach</b> – nie dlatego, że ktoś chce ją ukryć, ale dlatego, że próba potraktowania tego pytania poważnie prowadzi do karkołomnych konsekwencji – niezależnie od poglądów obecnych tu osób.'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Ta kwestia niech zostanie zatem otwarta - zastanówcie się nad nią i możemy do niej wrócić po lub w trakcie obiadu, jeśli najdą Was jakieś myśli.'
        '</p>'
        '</blockquote>'

);

KonspektStep _step_meta_narracja_pytania = KonspektStep(
    title: 'Meta-narracja - pytania',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Uczestnicy mogą dopytać o niejasne kwestie związane z meta-narracją.'
        '</p>'
);

KonspektStepGroup step_group_metanarracja = KonspektStepGroup(
    title: 'Meta-narracja',
    steps: [
      _step_meta_narracja_opowiesci,
      _step_meta_narracja_warunki_brzegowe,
      _step_meta_narracja_uniwersalnosc,
      _step_meta_narracja_zrodla_lacinskich_wartosci,
      _step_meta_narracja_selekcja_naturalna,
      _step_meta_narracja_wniosek,
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

      '</ul>'

      '<p style="text-align:justify;">'
      'Gdy uczestnicy (z pomocą prowadzącego) dojdą do odpowiedzi, prowadzący odkrywa kartki i kładzie je <b>obok</b> kolumny kart z poziomami duchowości.'
      '</p>'
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


// Duchowość harcerska - praktyczne aspekty

KonspektStep _step_duchowosc_harcerska_galeria_sztuki = KonspektStep(
  title: 'Duchowość harcerska - galeria sztuki',
  duration: Duration(minutes: 20),
  activeForm: KonspektStepActiveForm.active,
  materials: [
    material_zal_cel_wychowania_duchowego_zhp_statut,
    material_zal_cel_wychowania_duchowego_zhp_uchwala,
    material_zal_duchowosc_harcerska_tezy,
    material_tasma_klejaca,
  ],
  content: '<p style="text-align:justify;">'
      'Prowadzący (przed przystąpieniem do formy) rozwiesza na różnych ścianach kartki z załączników:'
      '</p>'
      '<ul>'
      '<li><p style="text-align:justify;">$attach_html_cel_wychowania_duchowego_zhp_statut</p></li>'
      '<li><p style="text-align:justify;">$attach_html_cel_wychowania_duchowego_zhp_uchwala</p></li>'
      '<li><p style="text-align:justify;">$attach_html_duchowosc_harcerska_tezy</p></li>'
      '</ul>'
      '<p style="text-align:justify;">'
      'Jeśli jest taka możliwość i pogoda temu sprzyja, warto rozwiesić kartki na zewnątrz, żeby przewietrzyć uczestników!'
      '<br>'
      '<br>Uczestnicy mają czas, by przespacerować się między kartkami i się nad nimi zastanowić.'
      '<br>'
      '<br>Uczestnicy mogą chodzić pojedynczo, by zastanawiać się w ciszy lub, jeśli chcą, w grupach i dyskutować między sobą.'
      '</p>'
);

KonspektStep _step_duchowosc_harcerska_dyskusja = KonspektStep(
    title: 'Duchowość harcerska - dyskusja',
    duration: Duration(minutes: 50),
    activeForm: KonspektStepActiveForm.active,
    materials: [
      material_zal_cel_wychowania_duchowego_zhp_statut,
      material_zal_cel_wychowania_duchowego_zhp_uchwala,
      material_zal_duchowosc_harcerska_tezy
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący przeprowadza w formie "Dwuściennej dyskusji" krótką debatę dotyczącą kolejno każdego z tematów zawartych w załączniku $attach_html_duchowosc_harcerska_tezy.'
        '<br>'
        '<br>Przy każdym z dyskutowanych punktów warto położyć w widocznym miejscu kartę z tezą, nad którą trwa dyskusja, by uczestnicy mogli do niej wrócić.'
        '<br>'
        '<br>Wnioski, które wypłyną z dyskusji, powinny być następujące:'
        '</p>'

        '<ul>'


        // Czy wychowanie duchowe powinno być neutralne?
        '<li>'
        '<p style="text-align:justify;">'
        'Teza: <b>Czy wychowanie duchowe powinno być neutralne?</b>'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Co miałoby oznaczać "neutralne"? Każdy akt wychowawczy (każda forma kształtowania duchowości) kształtuje duchowość w jakimś określonym kierunku - umacnia lub osłabia określone zachowania, wartości, lub aksjomaty.'
        '<br>'
        '<br>Neutralność jest tutaj niemożliwa do osiągnięcia - jakie działanie wychowawcze byłoby neutralne?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Jeśli uczestnicy uznają, że istnieją neutralne formy wychowania, np. te dążące do uniwersalnych harcerskich wartości, prowadzący może zapytać:'
        '</p>'

        '<blockquote><p style="text-align:justify;">'
        'Czy ta reakcja byłaby w istocie neutralna, czy po prostu mieści się w duchowości, którą prywatnie wyznajecie?'
        '</p></blockquote>'
        '</li>'

        // Dobrowolność – czy harcerze mogą wyznawać co tylko chcą?
        '<li>'
        '<p style="text-align:justify;">'
        'Teza: <b>Dobrowolność – czy harcerze mogą wyznawać co tylko chcą?</b>'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Dobrowolność nie jest <b>celem wychowania</b> w ZHP, tylko <b>cechą metody</b>, czyli cechą narzędzi, które mają doprowadzić do celu.'
        '<br>'
        '<br>Dobrowolność jest stosowana w ZHP, ponieważ skuteczniej jest wychować młodego człowieka do określonych wartości, gdy ma poczucie, że to on je wybiera, niż kiedy ma poczucie, że jest mu to zadane. Nie oznacza to jednak, że w ZHP istnieje dobrowolność celu wychowania.'
        '</p>'
        '</blockquote>'
        '</li>'

        // Wspólna, harcerska duchowość, ale religia dla chętnych?
        '<li>'
        '<p style="text-align:justify;">'
        'Teza: <b>Wspólna, harcerska duchowość, ale religia dla chętnych?</b>'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        '<b>Religia nie jest "rozszerzeniem", ani "dodatkiem" do duchowości – religia jest autonomiczną, pełną duchowością</b>, z własnymi aksjomatami, spójną hierarchią wartości i sposobami ich integracji.'
        '<br>'
        '<br>U osób wierzących wartości (w tym wartości harcerskie) muszą wynikać z przyjętej wiary, inaczej zostaną wyparte. Jeśli harcerz ma w każdym widzieć bliźniego, to nie dlatego, że „tak mówi Prawo Harcerskie" i już – dla człowieka wierzącego powinno to wynikać z wiary w <b>zbawczą relację między Chrystusem a człowiekiem</b>, w tym nim samym. Budowanie wartości w oderwaniu od aksjomatów kończy się tym, że w procesie redukcji dysonansu owe wartości zostaną porzucone jako naiwne i dziecinne.'
        '<br>'
        '<br>Nie jest tak, że wszyscy ludzie mają bazową duchowość, a część ma ją „z dodatkiem religii". Nie da się z czyjejś duchowości wyjąć elementu religijnego i dalej mieć do czynienia z duchowością – tak jak nie da się z jamnika wyjąć elementu „pies". Jamnik nie składa się z psa i czegoś jeszcze: jamnik jest psem.'
        '</p>'
        '</blockquote>'

        '</li>'

        // Duchowość harcerzy – ich sprawa prywatna?
        '<li>'
        '<p style="text-align:justify;">'
        'Teza: <b>Duchowość harcerzy – ich sprawa prywatna?</b>'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Duchowość to sprawa indywidualna i fundamentalnie osobista, <b>ale</b> jest jednocześnie sprawą publiczna - z duchowości wynika długa lista spraw (zachowania, postawy i wartości), które dotyczą i wpływają na całe otoczenie, w którym człowiek żyje. O wierze można i trzeba rozmawiać, robić dla niej miejsce, można ją publicznie praktykować, także w formie tradycji, czy w warstwie symbolicznej.'
        '</p>'
        '</blockquote>'
        '</li>'

        // Czy wszystkie formy harcerskie muszą być „inkluzywne”?
        '<li>'
        '<p style="text-align:justify;">'
        'Teza: <b>Czy wszystkie formy harcerskie muszą być „inkluzywne”?</b>'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '</p>'
        '<blockquote>'
        '<p style=”text-align:justify;”>'
        'Absolutnie nie - prowadzi to do zjawiska <b>weganizacji wychowania duchowego</b>, czyli do zjawiska ograniczenia wychowania do najmniejszego wspólnego mianownika duchowości osób o różnych aksjomatach. Ludzie wychowywani w różnych wiarach wymagają różnych form pracy nad swoją duchowością. To, że formy te będą wykluczające dla części osób jest normalne, konieczne i nie należy się tego bać.'
        '</p>'
        '</blockquote>'
        '</li>'

        // Czy harcerzy należy izolować od niemoralnych postaw?
        '<li>'
        '<p style="text-align:justify;">'
        'Teza: <b>Czy harcerzy należy izolować od niemoralnych postaw?</b>'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Początkowo harcerze powinni mieć jednoznaczny, niepodważany, niezmącony przekaz dotyczący tego, co jest dobre, a co złe. Stan ten powinien trwać mniej więcej do początku etapu świadomej integracji duchowości. W dalszej kolejności harcerze powinni być stopniowo wystawiani na inne perspektywy, inne postawy, inne wspólnoty, jednak nie po to, żeby przyjęli ich duchowość, tylko żeby wobec niej utwierdzili swoją własną oraz by nauczyli się funkcjonować w świecie, w którym nie ma jednorodności duchowej.'
        '</p>'
        '</blockquote>'
        '</li>'

        // Czy harcerzy wolno narażać na ryzyko lub dyskomfort?
        '<li>'
        '<p style="text-align:justify;">'
        'Teza: <b>Czy harcerzy wolno narażać na ryzyko lub dyskomfort?</b>'
        '<br>'
        '<br><u>Sugestia prowadzącego:</u>'
        '</p>'
        '<blockquote>'
        '<p style="text-align:justify;">'
        'Po pierwsze, niektóre niezwykle skuteczne formy wychowawcze mają w sobie element ryzyka: chodzenie w góry, jeżdżenie autostopem, podróże po innych krajach, etc. Po drugie, świat jest w sposób immanentny niebezpieczny. Niemal na pewno nasi wychowankowie zetkną się w życiu z agresją, bezradnością, frustracją. Lepiej jest ich do tego skutecznie przygotować w kontrolowanych warunkach. To właśnie jest hartem ducha.'
        '</p>'
        '</blockquote>'
        '</li>'

        '</ul>',
);

KonspektStepGroup step_group_duchowosc_harcerska = KonspektStepGroup(
    title: 'Duchowość harcerska - praktyczne aspekty',
    steps: [
      _step_duchowosc_harcerska_galeria_sztuki,
      _step_duchowosc_harcerska_dyskusja
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
        '<u>Wszystkie niebezpieczne działania są niewychowawcze i nieodpowiednialne.</u>'
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