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


KonspektMaterial material_zal_aksjomaty_opisu_przyklady = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_aksjomaty_opisu_przyklady”',
    attachmentName: attach_name_aksjomaty_opisu_przyklady,
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

KonspektMaterial material_zal_meta_narracja_scenka = KonspektMaterial(
    name: 'Wydrukowany załącznik "$attach_title_meta_narracja_scenka"',
    attachmentName: attach_name_meta_narracja_scenka,
    amount: 4
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
        'Prowadzący w losowej kolejności odczytuje uczestnikom 8 kartek <b>z białym tłem</b> z załącznika $attach_html_sfery_przyklady. Każdorazowo prosi uczestników o wskazanie, z którą sferą rozwoju określona jest odczytana kartka.'
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
        '<li><p style="text-align:justify;">Albert zakłada bluzę z kapturem, jednorazowo wybiera się do szkoły w odpowiedniej porze i gdy dostrzega dokuczających jego siostrze chłopaków, sprzedaje największemu gonga w twarz i odchodzi — do niewątpliwie ustawi ich do pionu.</p></li>'
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
        'Na szczęście taka możliwość istnieje i to na kilka sposobów: w pracy wychowawczej szczególnie przydatne są trzy sposoby spojrzenia na duchowość, każda na innym poziomie abstrakcji.'
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
        '<li><p style="text-align:justify;">Wartością większą od pieniędzy jest dla Alberta <b>rodzina</b> - wynikają z tego zachowania w stylu: dbanie o relację narzeczoną, spędzanie czasu z rodzeństwem, dostosowywanie swojego życia pod posiadanie dużej liczby dzieci, etc.</p></li>'
        '<li><p style="text-align:justify;">Wartością dla Alberta jest <b>lojalność wobec firmy</b> - wynikają z tego zachowania w stylu: dbanie o reputację firmy, próba naprawy w środku zimy zepsutego auto, by móc dojechać do klienta (a przecież Albert mógłby zostać w jego ciepłym wnętrzu, zadzwonić po lawetę i napisać szefowi, że nie da rady dojechać - przecież to nie jego wina).</p></li>'
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
        'Jak niektórzy mogli już wychwycić podczas opisywania poziomu wartości, wartości nie funkcjonują w luźnej kupie, ale w formie hierarchicznej struktury. Różne rzeczy są dla ludzi ważne, ale niektóre są ważniejsze od innych: ma to znaczenie, gdy człowiek decyduje, czy poświęcić czas rodzinie, czy pracy, mimo, że oba są dla niego ważne.'
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
        '<br>Tymczasem Albert bez żadnego specjalnego powodu wierzy, że świat staje się lepszy, gdy człowiek dobrowolnie bierze na siebie krzyż, trudy, zmagania rzeczywistości i je dźwiga — nawet, gdy nikt tego nie wymaga. Dlaczego w to wierzy? Wierzy, bo tak. Taki wyznaje aksjomat i cześć.'
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

KonspektStep _step_poziomy_duchowosci_aksjomaty_dopasowanie_przykladow = KonspektStep(
    title: 'Poziomy rozwoju duchowego - aksjomaty - zadanie 1',
    aims: [
      'Zbudowanie u uczestników intuicji dotyczącej tego, co jest, a co nie jest aksjomatem.',
    ],
    materials: [
      material_zal_aksjomaty_opisu_przyklady,
      material_zal_aksjomaty_sensu_przyklady,
      material_zal_aksjomaty_bledne_przyklady,
    ],
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.active,
    content: '<p style="text-align:justify;">'
        'Aby uczestnicy oswoili się z aksjomatami, prowadzący rozdaje im wycięte i pomieszane kartki z przykładami z załączników $attach_html_aksjomaty_opisu_przyklady, $attach_html_aksjomaty_sensu_przyklady i $attach_html_aksjomaty_bledne_przyklady.'
        '<br>'
        '<br>Zadaniem uczestników jest pogrupować przykłady aksjomatów odpowiednio jako <b>aksjomaty opisu</b> oraz <b>aksjomaty sensu</b> - mając na uwadze, że <b>kilka przykładów nie jest aksjomatem</b> w ogóle. W trakcie ćwiczenia uczestnicy mogą prosić prowadzącego o pomoc.'
        '<br>'
        '<br>Kartki z przykładowymi aksjomatami powinny zostać ułożone w trzech kolumnach pod wyłożoną podczas prezentowania poziomów duchowości kartką "Aksjomat". Przykłady, które nie są aksjomatami należy odłożyć gdzieś z boku.'
        '<br>'
        '<br>Na końcu prowadzący pokrótce omawia z uczestnikami poprawność ich dopasowania.'
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
      _step_poziomy_duchowosci_aksjomaty_dopasowanie_przykladow,
      _step_poziomy_duchowosci_aksjomaty_plaska_ziemia
    ]
);

// Ksztaltowanie duchowości

KonspektStep _step_ksztaltowanie_duchowosci_roznica_jakosciowa = KonspektStep(
  title: 'Kształtowanie duchowości - różnica jakościowa',
  duration: Duration(minutes: 2),
  activeForm: KonspektStepActiveForm.static,
  content: '<p style="text-align:justify;">'
      'Prowadzący zaczyna od zwrócenia uwagi na różnicę między sposobem rozwoju sfer zdolności, a sfery ducha:'
      '</p>'

      '<blockquote>'
      '<p style="text-align:justify;">'
      'Rozwój <b>sfer zdolności</b> polega na tym, że do już istniejącego "worka ze zdolnościami" dorzucane są kolejne zdolności: człowiek uczy się grać na nowym instrumencie, uczy się nowego języka, uczy się sposobu radzenia sobie ze złością, etc..'
      '<br>'
      '<br>Rozwój <b>sfery ducha</b> jest zupełnie inny. Człowiek nie ma "worka z różnymi duchowościami" - ale ma zawsze jedną, konkretną duchowość. Rozwój duchowości polega na jej przekształcaniu. Przykładowo, dla kogoś najważniejsze było zdrowie i wszystkie swoje czyny podporządkowywał zdrowemu stylowi życia, aż pewnego razu, wskutek rozwoju duchowego miejsce zdrowia zastępują przyjaźnie - i wówczas to one determinują sposób użycia posiadanych zdolności i zasobów.'
      '<br>'
      '<br>O rozwoju duchowym nie należy myśleć jak o procesie "budowania", czy "wnoszenia kolejnych pięter", ale raczej jak o procesie kształtowania - nadawaniu określonemu kawałkowi gliny jednego z nieskończonej liczby możliwych kształtów.'
      '<br>'
      '<br>Czujecie tę różnicę?'
      '</p>'
      '</blockquote>',
);

KonspektStep _step_ksztaltowanie_duchowosci_roznica_jakosciowa_pytania = KonspektStep(
  title: 'Kształtowanie duchowości - różnica jakościowa - pytania',
  duration: Duration(minutes: 2),
  activeForm: KonspektStepActiveForm.static,
  content: '<p style="text-align:justify;">'
      'Prowadzący daje uczestnikom czas na zadanie pytań.'
      '</p>',
);

KonspektStep _step_ksztaltowanie_duchowosci_osie = KonspektStep(
  title: 'Kształtowanie duchowości - osie współrzędnych',
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

KonspektStep _step_ksztaltowanie_duchowosci_schemat = KonspektStep(
  title: 'Kształtowanie duchowości - schemat',
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

KonspektStep _step_ksztaltowanie_duchowosci_7_9_lat_zachowania = KonspektStep(
  title: 'Kształtowanie duchowości - 7-9 lat - zachowania',
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

KonspektStep _step_ksztaltowanie_duchowosci_7_9_lat_wartosci = KonspektStep(
    title: 'Kształtowanie duchowości - 7-9 lat - wartości',
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
        'Brak świadomego postrzegania wartości przez dzieci przed 10. rokiem życia jest ściśle związany z ich niezdolnością do abstrakcyjnego myślenia. Ma to swoje odzwierciedlenie w ich problemach ze sprzątaniem:'
        '<br>'
        '<br>Dla dzieci w tym wieku nie istnieje koncept "porządku". Sprzątanie nie polega na doprowadzeniu pokoju do pewnego stanu, ale na wykonaniu sekwencji przeniesienia rzeczy na określone miejsce: klocków pod szafkę, pluszaków na półkę, a kredek do kredensu. Niestety, jeśli ta umiejętność zostanie stworzona w kontekście sprzątania w przedszkolu, to w żaden sposób nie wpłynie to na umiejętność sprzątania w domu.'
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

KonspektStep _step_ksztaltowanie_duchowosci_7_9_lat_aksjomaty = KonspektStep(
    title: 'Kształtowanie duchowości - 7-9 lat - aksjomaty',
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

KonspektStep _step_ksztaltowanie_duchowosci_7_9_lat_wykres = KonspektStep(
  title: 'Kształtowanie duchowości - 7-9 lat - wykres',
  duration: Duration(minutes: 1),
  activeForm: KonspektStepActiveForm.static,
  contentBuilder: ({required bool isDark}) =>
  '<p style="text-align:justify;">'
      'Prowadzący rysuje na wykresie elementy odpowiadające etapowi <b>7-9 lat</b>.'
      '</p>'
      '${piramidaDuchowosci7_9Html(isDark: isDark)}',
);

// czy dzieci mają duchowość?

KonspektStep _step_ksztaltowanie_duchowosci_10_12_lat_co_sie_zmienia = KonspektStep(
    title: 'Kształtowanie duchowości - 10-12 lat - co się zmienia?',
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

KonspektStep _step_ksztaltowanie_duchowosci_10_12_lat_wartosci = KonspektStep(
    title: 'Kształtowanie duchowości - 10-12 lat - wartości',
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

KonspektStep _step_ksztaltowanie_duchowosci_10_12_lat_zachowania = KonspektStep(
    title: 'Kształtowanie duchowości - 10-12 lat - zachowania',
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

KonspektStep _step_ksztaltowanie_duchowosci_10_12_lat_aksjomaty = KonspektStep(
    title: 'Kształtowanie duchowości - 10-12 lat - aksjomaty',
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

KonspektStep _step_ksztaltowanie_duchowosci_10_12_lat_wykres = KonspektStep(
  title: 'Kształtowanie duchowości - 10-12 lat - wykres',
  duration: Duration(minutes: 1),
  activeForm: KonspektStepActiveForm.static,
  contentBuilder: ({required bool isDark}) =>
  '<p style="text-align:justify;">'
      'Prowadzący rysuje na wykresie elementy odpowiadające etapowi <b>10-12 lat</b>.'
      '</p>'
      '${piramidaDuchowosci10_12Html(isDark: isDark)}',
);

KonspektStep _step_ksztaltowanie_duchowosci_13_15_lat_co_sie_zmienia = KonspektStep(
    title: 'Kształtowanie duchowości - 13-15 lat - co się zmienia?',
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

KonspektStep _step_ksztaltowanie_duchowosci_13_15_lat_aksjomaty = KonspektStep(
    title: 'Kształtowanie duchowości - 13-15 lat - aksjomaty',
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

KonspektStep _step_ksztaltowanie_duchowosci_13_15_lat_wartosci = KonspektStep(
    title: 'Kształtowanie duchowości - 13-15 lat - wartości',
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

KonspektStep _step_ksztaltowanie_duchowosci_13_15_lat_zachowania = KonspektStep(
    title: 'Kształtowanie duchowości - 13-15 lat - zachowania',
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

KonspektStep _step_ksztaltowanie_duchowosci_13_15_lat_wykres = KonspektStep(
  title: 'Kształtowanie duchowości - 13-15 lat - wykres',
  duration: Duration(minutes: 1),
  activeForm: KonspektStepActiveForm.static,
  contentBuilder: ({required bool isDark}) =>
  '<p style="text-align:justify;">'
      'Prowadzący rysuje na wykresie elementy odpowiadające etapowi <b>13-15 lat</b>.'
      '</p>'
      '${piramidaDuchowosci13_15Html(isDark: isDark)}',
);

KonspektStep _step_ksztaltowanie_duchowosci_16_plus_lat = KonspektStep(
    title: 'Kształtowanie duchowości - 16+ lat',
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

KonspektStep _step_ksztaltowanie_duchowosci_16_plus_lat_wykres = KonspektStep(
  title: 'Kształtowanie duchowości - 16+ lat - wykres',
  duration: Duration(minutes: 1),
  activeForm: KonspektStepActiveForm.static,
  contentBuilder: ({required bool isDark}) =>
  '<p style="text-align:justify;">'
      'Prowadzący rysuje na wykresie elementy odpowiadające etapowi <b>16+ lat</b>.'
      '</p>'
      '${piramidaDuchowosci16Html(isDark: isDark)}',
);

KonspektStep _step_ksztaltowanie_duchowosci_pytania = KonspektStep(
    title: 'Kształtowanie duchowości - pytania',
    duration: Duration(minutes: 1),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący daje uczestnikom czas na zadanie pytań.'
        '</p>',
);

KonspektStepGroup step_group_ksztaltowanie_duchowosci = KonspektStepGroup(
    title: 'Kształtowanie duchowości',
    steps: [
      _step_ksztaltowanie_duchowosci_roznica_jakosciowa,
      _step_ksztaltowanie_duchowosci_roznica_jakosciowa_pytania,
      _step_ksztaltowanie_duchowosci_osie,
      _step_ksztaltowanie_duchowosci_schemat,

      _step_ksztaltowanie_duchowosci_7_9_lat_zachowania,
      _step_ksztaltowanie_duchowosci_7_9_lat_wartosci,
      _step_ksztaltowanie_duchowosci_7_9_lat_aksjomaty,
      _step_ksztaltowanie_duchowosci_7_9_lat_wykres,

      _step_ksztaltowanie_duchowosci_10_12_lat_co_sie_zmienia,
      _step_ksztaltowanie_duchowosci_10_12_lat_wartosci,
      _step_ksztaltowanie_duchowosci_10_12_lat_zachowania,
      _step_ksztaltowanie_duchowosci_10_12_lat_aksjomaty,
      _step_ksztaltowanie_duchowosci_10_12_lat_wykres,

      _step_ksztaltowanie_duchowosci_13_15_lat_co_sie_zmienia,
      _step_ksztaltowanie_duchowosci_13_15_lat_aksjomaty,
      _step_ksztaltowanie_duchowosci_13_15_lat_wartosci,
      _step_ksztaltowanie_duchowosci_13_15_lat_zachowania,
      _step_ksztaltowanie_duchowosci_13_15_lat_wykres,

      _step_ksztaltowanie_duchowosci_16_plus_lat,
      _step_ksztaltowanie_duchowosci_16_plus_lat_wykres,
      _step_ksztaltowanie_duchowosci_pytania,
    ]
);


// Meta-narracja

KonspektStep _step_meta_narracja_scenka_wprowadzenie = KonspektStep(
    title: 'Meta-narracja - scenka - wprowadzenie',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    materials: [
      material_zal_meta_narracja_scenka,
    ],
    content: '<p style="text-align:justify;">'
        'Prowadzący rozdaje uczestnikom załącznik $attach_html_meta_narracja_scenka, po czym czyta na głos opisaną tam historię. Następnie informuje uczestników, że za chwilę wcielą się w kadrę wędrowniczą. Ich zadaniem będzie odbyć rozmowę z Adamem i spróbować <b>przekonać go w ciągu 15 minut, że harcerską postawą jest wybaczyć Radkowi, kierując się 4. punktem PH.</b>'
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
        '<br>Uczestnicy ponownie wracają do dyskusji. Scenariusze, które zostały omówione przez uczestników powinny prowadzić do wniosku: w sposób oczywisty harcerskie <b>wychowanie nie jest neutralne duchowo</b>.'
        '</p>',
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
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'To oczywiste, że nie da się wychować młodego człowieka bez pracy z aksjomatami. Skoro zaś ZHP nie określa skąd harcerskie wartości mają być wywodzone, to spróbujmy rozszyfrować dlaczego te wartości są tak oczywiste w naszej cywilizacji.'
        '</p>'
        '</blockquote>',
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
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Mamy w statucie ZHP zapisaną określoną duchowość. Ale jak się to ma do faktu, że cechą metody harcerskiej jest dobrowolność?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Uczestnicy powinni znać rozwiązanie tego dylematu, jeśli byli na kursie przewodnikowskim. Jeśli jest inaczej, po krótkiej dyskusji prowadzący rozwiązuje zagadkę:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Dobrowolność nie jest <b>celem wychowania</b> w ZHP, tylko <b>cechą metody</b>, czyli cechą narzędzi, które mają doprowadzić do celu.'
        '<br>'
        '<br>Dobrowolność jest stosowana w ZHP, ponieważ skuteczniej jest wychować młodego człowieka do określonych wartości, gdy ma poczucie, że to on je wybiera, niż kiedy ma poczucie, że jest mu to zadane. Nie oznacza to jednak, że w ZHP istnieje dobrowolność celu wychowania.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Dobrowolność jako narzędzie ma także drugą rolę:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Jeśli jakieś działanie wychowawcze nie cieszy się entuzjazmem wychowanków, to jest to sygnał, że jego forma nie jest atrakcyjna, a przez to jest mniej skuteczna. Skonstatowanie tego w sytuacji braku dobrowolności byłoby dużo trudniejsze.'
        '</p>'
        '</blockquote>',
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
        'Prowadzący zwraca uwagę, że wartości cywilizacji łacińskiej nie są ani uniwersalne, ani naturalne. Posiłkując się przykładami z użytego wcześniej załącznika ${attach_html_neutralnosc_duchowa_przyklady}, poddaje pod dyskusję pytanie:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Dlaczego w naszej kulturze akurat te, a nie inne wartości są tak powszechne?'
        '</p>'
        '</blockquote>'

        '<ol>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 1.</b> Przebaczenie i odpuszczenie win.'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'W wielu kulturach przebaczenie jest uważane za zachętę do bycia wykorzystywanym. Nietzsche widział w nim wyraz słabości i element moralności niewolników. W tradycyjnej kulturze japońskiej po popełnieniu poważnej winy nie było drogi jej odpuszczenia – jedynym honorowym wyjściem było rytualne samobójstwo: seppuku. Dlaczego więc w kulturze łacińskiej jest inaczej? Dlaczego w naszych systemach prawnych po odbyciu kary wina zostaje zmazana i człowiek jest wolny? Dlaczego za kradzież nie skazuje się ludzi dożywotnio, żeby skutecznie ich od niej zniechęcić?'
        '</p>'
        '</blockquote>'
        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 2.</b> Życie w prawdzie.'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'W kulturach wschodnich, gdzie najważniejsza jest harmonia społeczna, należy kłamać, jeśli prowadzi to do uniknięcia konfliktu. W części kultur afrykańskich kłamstwo nie jest złem, jeśli służy uniknięciu wstydu. Dlaczego więc akurat my tak się uparliśmy, by nagannie traktować świadome mówienie nieprawdy?'
        '</p>'
        '</blockquote>'

        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 3.</b> Niezbywalna godność każdego człowieka'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'W systemach konfucjańskich liczy się najpierw wspólnota i kolektyw, dopiero potem jednostka. Niektórzy wyznawcy hinduizmu powstrzymają innych od udzielenia pomocy cierpiącemu – jeśli ktoś cierpi, to pokutuje za grzechy popełnione w poprzednim życiu. A skąd pogląd, że wykształcony profesor z zasługami dla narodu ma takie same prawa jak półinteligentny osiedlowy cwaniaczek? Skąd pomysł, że prawo do życia i godnego traktowania przysługuje każdemu, niezależnie od wieku, pochodzenia czy wyznania?'
        '</p>'
        '</blockquote>'

        '</li>'

        '<li>'
        '<p style="text-align:justify;">'
        '<b>Scenariusz 4.</b> Stawianie wyżej dobra jednostki nad kolektywem'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        '<br>W kulturze konfucjańskiej najpierw liczy się zbiorowość, trwałość systemu państwowego – a dopiero potem dobro jednostki. W Chinach niedopuszczalne jest publiczne okazywanie sporów, ponieważ osłabia to wspólnotę. W kulturze japońskiej należy poświęcić plany prywatne, jeśli kolidują z wydarzeniem firmy. Skąd więc u nas „oczywiste" przekonanie, że rodzinie, której dom stoi na drodze nowej autostrady, należy się odszkodowanie? Skąd przekonanie, że nie można zmusić człowieka do pracy, jeśli nie chce? Dlaczego chronimy tak zaciekle wolności słowa, nawet, gdy osłabia ona spójność społeczną?'
        '</p>'
        '</blockquote>'
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
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Nie byłoby niezbywalnej godności każdego człowieka, ani równości wobec prawa, ani humanitaryzmu, ani oświecenia, ani Powszechnej Deklaracji Praw Człowieka bez wiary, że skoro sam Bóg dobrowolnie wydał się na śmierć dla zbawienia najpodlejszego nawet człowieka, to że w każdym człowieku jest coś iście boskiego, nieważne jak bardzo jest podły, bezużyteczny, inny, czy denerwujący.'
        '<br>'
        '<br>Nie byłoby uniwersytetów bez zgromadzeń i klasztorów zakonnych, ani nie byłoby nauki bez przekonania, że Bóg stworzył dobry, uporządkowany świat, że Bóg przekracza naturę i że można badać ją bez bluźnierstwa, oraz bez ewangelicznej wiary w wartość prawdy pomimo pokusy fałszowania rzeczywistości dla własnych korzyści.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący zostawia uczestnikom przestrzeń, by weszli z nim na ten temat w dyskusję.'
        '</p>'

);

KonspektStep _step_duchowosc_w_zhp_ateisci = KonspektStep(
    title: 'Duchowość w ZHP - co dla ateistów?',
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący zwraca uczestnikom uwagę na pewien problem (chyba, że któryś z uczestników sam zwróci na niego uwagę):'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Co, jeśli kogoś nie interesuje chrześcijaństwo?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący otwiera tym samym krótką dyskusję. Warto rozpatrzyć tutaj dwa osobne przypadki:'
        '</p>'

        '<blockquote>'
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
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Prowadzący powinien pozwolić, by fundamentalny <b>brak odpowiedzi</b> na pytanie „co dla ateistów" wybrzmiał wśród uczestników. <b>Odpowiedź nie padnie na warsztatach</b> – nie dlatego, że ktoś chce ją ukryć, ale dlatego, że próba potraktowania tego pytania poważnie prowadzi do karkołomnych konsekwencji – niezależnie od poglądów obecnych tu osób.'
        '</p>'
);

KonspektStep _step_duchowosc_w_zhp_duchowosc_powszechna = KonspektStep(
    title: 'Duchowość w ZHP - duchowość powszechna',
    duration: Duration(minutes: 10),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci opisuje zjawisko <b>duchowości powszechnej</b>, związanej z nią <b>sztafetowością</b> i <b>selekcją naturalną</b>. Opisuje także zjawisko dualizmu aktualności duchowości powszechnych - z jednej strony jej wiecznego niedoczasu względem rzeczywistości, z drugiej jej funkcji tworzenia norm i przekazywania sprawdzonych rozwiązań nowym pokoleniom.'
        '<br>'
        '<br>Prowadzący może zobrazować dylemat tego <i>"jak ściśle trzymać się tradycji"</i> w sposób następujący:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Kultura i tradycja są mądrością miliona lat żyć, pamięcią miliona umysłów, wiedzą o skutkach miliona głupich prób – wszystkie dostępne dla człowieka żyjącego raptem kilkadziesiąt lat.'
        '<br>'
        '<br>Gdybyśmy zanegowali na raz wszystkie tradycje, w ciągu jednego pokolenia wrócilibyśmy do jaskiń. Ale gdybyśmy nigdy nie podważyli żadnej tradycji, nigdy z tych jaskiń byśmy nie wyszli.'
        '<br>'
        '<br>Niektóre duchowości wyraźnie skuteczniej prowadzą do szczęścia i rozwoju człowieka oraz jego otoczenia od pozostałych. Niektóre duchowości czynią to w sposób stabilny od tysięcy lat, inne działają dobrze przez pół pokolenia, po czym prowadzą do katastrofy - czego najlepszym dowodem są systemy totalitarne XX wieku.'
        '</p>'
        '</blockquote>'
);

KonspektStep _step_duchowosc_w_zhp_religia = KonspektStep(
    title: 'Duchowość w ZHP - religia',
    duration: Duration(minutes: 5),
    activeForm: KonspektStepActiveForm.static,
    content: '<p style="text-align:justify;">'
        'Prowadzący stawia pytanie:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        'Jak wygląda relacja między wychowaniem duchowym osób wierzących i osób bez wyznania w jednej drużynie? Czy można prowadzić wspólne wychowanie duchowe, a religię traktować jako „dodatek" dla części harcerzy?'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Na podstawie poradnika $attach_html_poradnik_o_strukturze_duchowosci prowadzący naprowadza uczestników na kluczową tezę:'
        '</p>'

        '<blockquote>'
        '<p style="text-align:justify;">'
        '<b>Religia nie jest dodatkiem do duchowości – jest autonomiczną, pełną duchowością</b>, z własnymi aksjomatami, spójną hierarchią wartości i sposobami ich integracji.'
        '<br>'
        '<br>Nie ma tu relacji zawierania – nie jest tak, że wszyscy ludzie mają bazową duchowość, a część ma ją „z dodatkiem religii". Nie da się z czyjejś duchowości wyjąć elementu religijnego i dalej mieć do czynienia z duchowością – tak jak nie da się z jamnika wyjąć elementu „pies". Jamnik nie składa się z psa i czegoś jeszcze: jamnik jest psem.'
        '</p>'
        '</blockquote>'

        '<p style="text-align:justify;">'
        'Wnioski wychowawcze:'
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
        '<li><p style="text-align:justify;">Harcerstwo powinno mieć wysokie standardy. Nie po to, by prowadzić selekcję osób mogących harcerzami zostać, ale po to, by wychować ludzi w szacunku do wartości, postaw, a często również wiary, która dała nam świat merytokracji, równości, wolności, godności ludzkiej, przebaczenia, uznania własnej niedoskonałości, powszechnej sprawiedliwości, nauki, itd.</p></li>'
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

      _step_duchowosc_w_zhp_ateisci,

      _step_duchowosc_w_zhp_duchowosc_powszechna,

      _step_duchowosc_w_zhp_religia,

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