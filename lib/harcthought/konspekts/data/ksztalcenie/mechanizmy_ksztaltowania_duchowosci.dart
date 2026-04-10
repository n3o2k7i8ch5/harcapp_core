import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common_attachments.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/warsztaty_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people/data.dart';

const konspekt_kszt_name_mechanizmy_ksztaltowania_duchowosci = 'mechanizmy_ksztaltowania_duchowosci';

// Materials

KonspektMaterial material_zal_poradnik_mechanizmy_ksztaltowania_duchowosci = KonspektMaterial(
    name: 'Wydrukowany $attach_title_poradnik_mechanizmy_ksztaltowania_duchowosci',
    attachmentName: attach_name_poradnik_mechanizmy_ksztaltowania_duchowosci,
    amount: 2
);

KonspektMaterial material_zal_scenariusze_czynnikow_duchowosci = KonspektMaterial(
  name: 'Dostępny załącznik “$attach_title_scenariusze_mechanizmow_ksztaltowania_duchowosci”',
  attachmentName: attach_name_scenariusze_mechanizmow_ksztaltowania_duchowosci,
  amount: 1
);

KonspektMaterial material_zetony = KonspektMaterial(
    name: 'Żetony (np. zapałki, akrylowe kryształki, pieniądze z monopoly)',
    amount: 200
);

KonspektMaterial material_nagroda = KonspektMaterial(
  name: 'Nagroda dla zwycięskiego zespołu (np. paczka żelków)',
  amount: 1
);

KonspektMaterial material_zal_plansza_mechanizmow_ksztaltowania_duchowosci = KonspektMaterial(
  name: 'Wydrukowany załącznik "$attach_title_plansza_mechanizmow_ksztaltowania_duchowosci"',
  attachmentName: attach_name_plansza_mechanizmow_ksztaltowania_duchowosci,
  amount: 1
);

KonspektMaterial material_zal_karty_szczebli_internalizacji_duchowosci = KonspektMaterial(
  name: 'Wydrukowany załącznik "$attach_title_karty_szczebli_internalizacji_duchowosci"',
  attachmentName: attach_name_karty_szczebli_internalizacji_duchowosci,
  amount: 1
);

List<KonspektMaterial> materials_kszt_mechanizmy_ksztaltowania_duchowosci = [
  material_zal_poradnik_mechanizmy_ksztaltowania_duchowosci,
  material_zal_scenariusze_czynnikow_duchowosci,
  material_zal_plansza_mechanizmow_ksztaltowania_duchowosci,
  material_zal_karty_szczebli_internalizacji_duchowosci,
  material_zetony,
  material_nagroda,
];

// Steps
List<KonspektStep> steps_kszt_mechanizmy_ksztaltowania_duchowosci = [

  KonspektStep(
      title: 'Wyjaśnienie merytoryczne - wstęp',
      duration: Duration(minutes: 1),
      activeForm: KonspektStepActiveForm.active,
      content: '<p style="text-align:justify;">'
          'Prowadzący, jeśli chce, może zacząć od małej prowokacji:'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Skoro jesteśmy tutaj w tak zaszczytnym, instruktorskim gronie, to powiedzcie mi: jaki jest kompletny przepis na wychowanie dowolnego wychowanka do harcerskiego ducha? Znacie jakiś zestaw tricków, metod, narzędzi?'
          '</p>'
          '</blockquote>'

          '<p style="text-align:justify;">'
          'Jeżeli ktoś coś zaproponuje - super! Można chwilę podyskutować, lub zwrócić uwagę na to, że "jest to dobry start", by potem przejść do omówienia mechanizmów kształtowania duchowości.'
          '<br>'
          '<br>Jeśli pytanie prowadzącego spotka się z milczeniem, prowadzący może zagadnąć:'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Jak to? Nie wiecie? Przecież jesteście harcerskimi wychowawcami, ekspertami od wychowania!'
          '<br>'
          '<br>Spokojnie, oczywiście żartuję - macie pełne prawo tego nie wiedzieć, bo nikt tego do końca nie wie. Ale jest kilka ważnych aspektów, które pozwalają dużo skuteczniej kształtować duchowość.'
          '</p>'
          '</blockquote>'

  ),

  KonspektStep(
      title: 'Wyjaśnienie merytoryczne - skrót',
      duration: Duration(minutes: 4),
      activeForm: KonspektStepActiveForm.active,
      content: '<p style="text-align:justify;">'
          'Prowadzący, na podstawie załącznika $attach_html_poradnik_mechanizmy_ksztaltowania_duchowosci wprowadza uczestników w mechanizmy kształtowania duchowości.'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Duchowość człowieka, jak pewnie się domyślacie, nie jest wyryta raz na zawsze w skale. Istnieją różne zjawiska, które wpływają na jej kształt.'
          '</p>'
          '</blockquote>'

          // Adresat
          '<p style="text-align:justify;">'
          '<b>Adresat</b>'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Po pierwsze: adresat.'
          '<br>'
          '<br>Ma znaczenie kim jest wychowanek, o którym mowa. Inne metody są konieczne by wychować do patriotyzmu, wiary, braterstwa, czy czegokolwiek innego wielomiejskiego konformistę, a inne w przypadku małomiasteczkowego cwaniaka. Ludzie są różni na wielu wymiarach, jednak na kształtowanie duchowości mają wpływ przede wszystkim dwie kwestie:'
          '</p>'
          '<ul>'
          '<li><p>biologia i etap rozwoju człowieka (jego temperament, neurochemia, zdrowie, wiek, zainteresowania, itd.),</p></li>'
          '<li><p>dotychczasowa duchowość człowieka.</p></li>'
          '</ul>'
          '</blockquote>'

          // Drabina internalizacji
          '<p style="text-align:justify;">'
          '<b>Drabina internalizacji</b>'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Po drugie: drabina internalizacji.'
          '<br>'
          '<br>Każde zachowanie, wartość, czy aksjomat człowieka może być zinternalizowana przez człowieka na różnym szczeblu głębokości. To, że dwójka ludzi dobrowolnie myje co wieczór zęby nie oznacza jeszcze, że w obu przypadkach wynika to z tak samo silnie zakorzenionej przyczyny.'
          '<br>'
          '<br>Warto wyróżnić tutaj cztery poziomy internalizacji elementów duchowości, które za chwilę trochę głębiej omówimy:'
          '</p>'

          '<ul>'
          '<li><p>dostosowanie</p></li>'
          '<li><p>przyzwyczajenie</p></li>'
          '<li><p>tożsamość</p></li>'
          '<li><p>wiara (w jakiś porządek rzeczy)</p></li>'
          '</ul>'

          '<p style="text-align:justify;">'
          'Im szczebel jest płytszy, tym łatwiej go ukształtować, jednak tym bardziej jest on ulotny. Im szczebel jest głębszy, tym trudniej na niego wpłynąć, ale tym jest on trwalszy.'
          '<br>'
          '<br>Duchowość na różnych szczeblach jej internalizacji kształtuje się różnymi narzędziami – inaczej kształtuje się czyjeś przyzwyczajenia, a inaczej czyjąś tożsamość, czy wiarę w porządek rzeczy.'
          '</p>'
          '</blockquote>'

          // Kontekst stosowania narzędzi
          '<p style="text-align:justify;">'
          '<b>Kontekst stosowania narzędzi</b>'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Po trzecie: kontekst stosowania narzędzi.'
          '<br>'
          '<br>Ma znaczenie, w jakich warunkach i przez kogo używane są narzędzia kształtowania duchowości. Tych samych metod można użyć w kontekście, który wzmocni ich działanie, ale można też łatwo doprowadzić do absolutnego zniweczenia ich wpływu.'
          '<br>'
          '<br>Okazuje się, przykładowo, że jeżeli jakieś narzędzie wychowawcze jest wykorzystywane przez kogoś, kogo wychowanek uznaje za swój autorytet, to jest dużo skuteczniejsze, niż gdyby to samo zrobił przypadkowy człowiek z ulicy.'
          '</p>'
          '</blockquote>'

  ),

  KonspektStep(
      title: 'Wyjaśnienie merytoryczne - szczeble internalizacji',
      duration: Duration(minutes: 5),
      activeForm: KonspektStepActiveForm.static,
      materials: [
        material_zal_poradnik_mechanizmy_ksztaltowania_duchowosci,
      ],
      content: '<p style="text-align:justify;">'
          'Prowadzący, na podstawie załącznika $attach_html_poradnik_mechanizmy_ksztaltowania_duchowosci wprowadza uczestników w mechanizmy kształtowania duchowości.'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Kwestię adresata naszego wychowania oraz kontekstu stosowania narzędzi na chwilę zaparkujemy - skupmy się póki co na samych narzędziach oraz na drabinie internalizacji.'
          '<br>'
          '<br>Pierwszą istotną kwestią jest to, że składowe duchowości człowieka (zachowania, wartości, czy aksjomaty) nie są w niej binarnie obecne: nie jest tak, że jakaś wartość albo w czyjejś duchowości jest, albo jej nie ma i że nie ma nic poza tym. W rzeczywistości każde zachowanie, wartość, czy aksjomat mogą być zakorzenione w duchowości człowieka na <b>różnym stopniu głębokości</b>.'
          '<br>'
          '<br>Istnieją cztery szczeble "zakorzenienia", czy "zakotwiczenia" różnych zachowań, wartości, czy aksjomatów w duchowości człowieka: im są one płycej osadzone, tym łatwiej je ukształtować, ale tym są mniej stabilne. Im są głębiej osadzone, tym trudniej je ukształtować, ale są za to stabilniejsze.'
          '</p>'
          '</blockquote>'

          '<p style="text-align:justify;">'
          'Prowadzący kładzie w widocznym miejscu kartę <b>dostosowanie</b> z załącznika $attach_html_karty_szczebli_internalizacji_duchowosci i ją objaśnia:'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Najpłytszym i najłatwiejszym do ukształtowania szczeblem internalizacji jest szczebel <b>dostosowania</b>.'
          '<br>'
          '<br>Chodzi po prostu o to, że człowiek ma tendencję do robienia tego, co wymaga najmniej wysiłku. Jeśli ktoś (koledzy, kadra, rodzice) lub coś (ekonomia, kultura, środowisko) do czegoś zachęca, namawia, wywiera presję, lub czyni przystępniejszym, człowiek prawdopodobnie to zrobi.'
          '<br>'
          '<br>Przykładowo: jeżeli na obozie kadra wprowadzi kary za niepościelone łóżko, to harcerze będą je ścielili - czyli dostosują się do najmniej wymagającej ścieżki. Poziom dostosowania jednak działa tylko tak długo, jak długo warunki, do których człowiek się dostosowuje są obecne. Gdyby kara znikła, zniknęłoby także ścielenie łóżka u harcerzy.'
          '</p>'
          '</blockquote>'

          '<p style="text-align:justify;">'
          'Prowadzący kładzie w widocznym miejscu kartę <b>przyzwyczajenie</b> z załącznika $attach_html_karty_szczebli_internalizacji_duchowosci i ją objaśnia:'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Drugim szczeblem internalizacji jest szczebel <b>przyzwyczajenia</b>.'
          '<br>'
          '<br>Człowiek ma tendencję do robienia tego, do czego jest przyzwyczajony. Przyzwyczajenie jest trwalsze od dostosowania – działa bez nadzoru i bez zewnętrznych czynników. Jest jednak kruche przy zmianie środowiska, rutyny i rytmu dnia.'
          '<br>'
          '<br>Przykładowo: jeżeli kadra na obozie przyzwyczai harcerzy do codziennego ścielenia łóżek, to nie będzie trzeba ich dodatkowo motywować - po prostu będą to robili i już. Problem jednak się pojawi, gdy na chwilę coś sprawi, że przestaną praktykować owo ścielenie - wówczas przyzwyczajenie przepadnie.'
          '</p>'
          '</blockquote>'

          '<p style="text-align:justify;">'
          'Prowadzący kładzie w widocznym miejscu kartę <b>tożsamość</b> z załącznika $attach_html_karty_szczebli_internalizacji_duchowosci i ją objaśnia:'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Trzecim szczeblem internalizacji jest szczebel <b>tożsamości</b>.'
          '<br>'
          '<br>Tożsamość to odpowiedź na pytanie "kim jestem" – zbiór cech, ról i przynależności, które człowiek uznaje za swoje. Tożsamość jest trwalsza niż dostosowanie lub przyzwyczajenie - przetrwa zmianę środowiska, czy zmianę nawyków.'
          '<br>'
          '<br>Tożsamość bywa jednak słaba, jeżeli wychowanek nigdy jej nie zakwestionował - ma ona wówczas większą tendencję do rozpadu w przypadku zderzenia z nowymi realiami. Z kolei tożsamość, która przeszła przez wątpliwości i przetrwała, jest dużo bardziej odporna.'
          '<br>'
          '<br>Przykładowo: jeżeli kadra na obozie zbuduje w harcerzach poczucie, że są wspólnotą, że wyróżnia ich dbałość i porządna praca, że łączą ich wspólne zasady i jeżeli harcerze będą się z tym poczuciem identyfikowali - będą ścielili łóżko nawet, jeśli znajdą się w zupełnie nowej rzeczywistości.'
          '</p>'
          '</blockquote>'

          '<p style="text-align:justify;">'
          'Prowadzący kładzie w widocznym miejscu kartę <b>wiara</b> z załącznika $attach_html_karty_szczebli_internalizacji_duchowosci i ją objaśnia:'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Ostatnim, najgłębszym szczeblem internalizacji jest szczebel <b>wiary</b>.'
          '<br>'
          '<br>Jest to najtrwalszy, ale i najtrudniejszy do ukształtowania szczebel – przetrwa nawet kryzys tożsamości. Przede wszystkim wymaga ona dojrzałości poznawczej (min. 11–12 lat). Wiary nie da się narzucić.'
          '<br>'
          '<br>Próba kształtowania wiary bez poruszania innych szczebli jest zwykle jałowa. Ludzie rzadko dochodzą do wiary drogą rozumowania – jest raczej odwrotnie: osądy moralne powstają automatycznie, a wyznawane poglądy i rozumowanie na ich podstawie pojawia się później jako ich uzasadnienie.'
          '<br>'
          '<br>Przykładowo: jeżeli harcerze będą wierzyli, że świat tak działa, że życie w uporządkowanym otoczeniu wprowadza porządek w myślach, relacjach i dążeniach człowieka, to będą starali się utrzymywać porządek nawet jeśli wszystko wokół, łącznie z ich poczuciem przynależności, będzie ich pchało w inną stronę.'
          '</p>'
          '</blockquote>'
  ),

  KonspektStep(
      title: 'Wyjaśnienie merytoryczne - "przygotowywanie gruntu" i "redukcja dysonansu"',
      duration: Duration(minutes: 5),
      activeForm: KonspektStepActiveForm.static,
      materials: [
        material_zal_poradnik_mechanizmy_ksztaltowania_duchowosci,
      ],
      content: '<p style="text-align:justify;">'
          'Prowadzący, na podstawie załącznika $attach_html_poradnik_mechanizmy_ksztaltowania_duchowosci wprowadza pojęcia "przygotowywania gruntu":'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Szczeble drabiny internalizacji duchowości opisują nie tylko głębokość zakorzenienia duchowości w człowieku: wyznaczają także naturalny „kierunek” jej kształtowania. Chcąc ukształtować głębszy fragment duchowości człowieka (np. wartość bycia porządnym opartą o tożsamość, czy wiarę), zazwyczaj konieczne jest wcześniejsze “przygotowanie gruntu” w postaci zadbania o płytsze wymiary duchowości (np. zachowania "ścielenia łóżka" wynikające z dostosowania, czy przyzwyczajenia).'
          '</p>'
          '</blockquote>'

          '<p style="text-align:justify;">'
          'Następnie prowadzący, na podstawie załącznika $attach_html_poradnik_mechanizmy_ksztaltowania_duchowosci wprowadza pojęcia "redukcji dysonansu":'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          '"Przygotowywanie gruntu" działa na podstawie powszechnego u ludzi zjawiska "redukcji dysonansu".'
          '<br>'
          '<br>Wyobraźcie sobie, że jest jakiś człowiek, np. jakiś wędrownik. Wierzy on, że zdrowie jest najważniejsze, ale tak się składa, że bardzo lubi grać na kompie i spędza czas głównie przed ekranem.'
          '<br>'
          '<br>Między tymi dwoma elementami duchowości jest ewidentna sprzeczność i prędzej, czy później pojawi się w takim człowieku potrzeba jej usunięcia. Jak myślicie, co taki człowiek zrobi:'
          '</p>'
          '<ul>'
          '<li><p>przestanie grać na kompie,</p></li>'
          '<li><p>zmieni swoją wiarę w to, że zdrowie jest najważniejsze?</p></li>'
          '</ul>'
          '<p style="text-align:justify;">'
          'Otóż najczęściej, jak pokazują badania, usunięcie sprzeczności zachodzi po ścieżce najmniejszego oporu i powinniście się w takim przypadku spodziewać dostosowania głębszych poziomów duchowości (np. przekonań) do płytszych (np. do zachowań).'
          '<br>'
          '<br>Czyli w jego przypadku raczej należy się spodziewać, że pewnego dnia oznajmi on, że wierzy, że w życiu najważniejsze jest życie w zgodzie ze swoimi potrzebami i słuchanie swojego wewnętrznego dziecka.'
          '</p>'
          '</blockquote>'
  ),

  KonspektStep(
      title: 'Podział na grupy',
      duration: Duration(minutes: 5),
      activeForm: KonspektStepActiveForm.active,
      content: '<p style="text-align:justify;">'
          'Prowadzący dzieli uczestników na dwie grupy.'
          '</p>'
  ),

  KonspektStep(
      title: 'Zasady postaw na milion',
      duration: Duration(minutes: 5),
      activeForm: KonspektStepActiveForm.static,
      materials: [
        material_zetony,
        material_zal_poradnik_mechanizmy_ksztaltowania_duchowosci,
        material_zal_plansza_mechanizmow_ksztaltowania_duchowosci
      ],
      content: '<p style="text-align:justify;">'
          'Prowadzący wyjaśnia uczestnikom zasady gry, którą za chwilę rozegrają:'
          '<br>'
          '<br>Uczestnicy zostaną podzieleni na grupy. Każda grupa otrzyma na początku:'
          '</p>'

          '<ul>'
          '<li><p>5 żetonów</p></li>'
          '<li><p style="text-align:justify;">wydrukowany załącznik $attach_html_poradnik_mechanizmy_ksztaltowania_duchowosci z opisami poszczególnych mechanizmów kształtowania duchowości,</p></li>'
          '<li><p style="text-align:justify;">wydrukowany załącznik $attach_html_plansza_mechanizmow_ksztaltowania_duchowosci z możliwymi do obstawienia odpowiedziami dotyczącymi czynników duchowości.</p></li>'
          '</ul>'

          '<p style="text-align:justify;">'
          'Co turę prowadzący będzie czytał krótką historię. Gdy skończy, każda grupa będzie miała możliwość zastanowić się, które czynniki rozwoju duchowego są w niej opisane - może być ich więcej niż jeden.'
          '<br>'
          '<br>Gdy grupy się zastanowią, mogą na każdej z kart położyć od 0 do 3 żetonów, obstawiając prawidłowe odpowiedzi. Gdy żetony zostaną rozdysponowane na planszy, prowadzący prosi każdą z grup o podanie argumentów dla swoich odpowiedzi, po czym odczytuje prawidłowe rozwiązanie. Dobrze obstawione żetony są podwajane, źle obstawione są zabierane.'
          '<br>'
          '<br>Na końcu gry grupa, która zdobędzie najwięcej punktów, wygrywa.'
          '</p>'
  ),

  KonspektStep(
      title: 'Zapoznanie się z poradnikami',
      duration: Duration(minutes: 10),
      activeForm: KonspektStepActiveForm.static,
      materials: [
        material_zal_poradnik_mechanizmy_ksztaltowania_duchowosci,
        material_zal_plansza_mechanizmow_ksztaltowania_duchowosci
      ],
      content: '<p style="text-align:justify;">'
          'Prowadzący wręcza każdej z grup po jednym egzemplarzu poradnika $attach_html_poradnik_mechanizmy_ksztaltowania_duchowosci. Ważne, aby dało się go rozłożyć na osobne kartki, by uczestnicy mieli łatwy dostęp do treści.'
          '<br>'
          '<br>Prowadzący rozdaje również uczestnikom po jednym egzemplażu załącznika $attach_html_plansza_mechanizmow_ksztaltowania_duchowosci - na nich uczestnicy będą obstawiali swoje odpowiedzi przy użyciu żetonów.'
          '<br>'
          '<br>Uczestnicy mają czas, aby zapoznać się z treściami kartek poradnika. Mogą przeczytać je sobie na głos, po cichu na raz, każdy po jednej kartce, po czym się nimi okrężnie wymieniać.'
          '<br>'
          '<br>Gdy to zrobią, uczestnicy kładą kartki w rzędzie przed sobą na widoku.'
          '<br>'
          '<br>Następnie prowadzący prosi uczestników, żeby położyli plansze z załącznika $attach_html_plansza_mechanizmow_ksztaltowania_duchowosci gdzieś bliżej prowadzącego i by zasłonili je tak, by druga grupa nie mogła ich podejrzeć.'
          '<br>'
          '<br>Zabieg ten ma na celu dwie rzeczy:'
          '</p>'
          '<ul>'
          '<li><p style="text-align:justify;">ważniejsze: sprawić, by uczestnicy musieli wstać, by obstawić swoje żetony (element dynamizujący)</p></li>'
          '<li><p style="text-align:justify;">mniej ważne: sprawić, by uczestnicy nie mogli szybko zmienić swoich obstawień w trakcie dyskusji.</p></li>'
          '</ul>'
  ),

  KonspektStep(
      title: 'Postaw na milion',
      duration: Duration(minutes: 40),
      activeForm: KonspektStepActiveForm.active,
      materials: [
        material_zetony,
        material_zal_poradnik_mechanizmy_ksztaltowania_duchowosci,
        material_zal_plansza_mechanizmow_ksztaltowania_duchowosci
      ],
      content: '<p style="text-align:justify;">'
          'Co turę prowadzący odczytuje kolejną historię z załącznika $attach_html_scenariusze_mechanizmow_ksztaltowania_duchowosci. Gdy skończy czytać, zadaje pytanie punktowane o to, "który czynnik duchowości jest opisany w opowiedzianej historii?".'
          '<br>'
          '<br>Grupy obstawiają swoje odpowiedzi. Gdy wszyscy skończą obstawiać, odsłaniają je i prowadzący odczytuje poprawne odpowiedzi.'
          '<br>'
          '<br>Następuje chwila na wspólne <b>omówienie niejasności</b> wynikających z przeczytanej historii i udzielonych odpowiedzi. Jeśli jakaś drużyna obstawi niepunktowaną odpowiedź, ale będzie w stanie przekonać prowadzącego, że mają oni rację, prowadzący może nie zabierać im żetonów za to obstawienie.'
          '<br>'
          '<br>Po wyjaśnieniu niejasności, prowadzący przyznaje żetony za poprawne odpowiedzi i zabiera żetony za błędne wskazania.'
          '<br>'
          '<br>Następnie, jeśli jest na to czas, prowadzący może jeszcze zapytać o to, <b>jakiego poziomu (warstwy) duchowości</b> dotyczyła przeczytana historia, jednak za to pytanie nie przewidziane są punkty.'
          '<br>'
          '<br>Gra trwa do momentu, gdy prowadzący przeczyta wszystkie historie, lub aż skończy się czas.'
          '<br>'
          '<br>Prowadzący nie powinien czytać historii po kolei, jako że są ułożone w tej samej kolejności, co czynniki opisane w poradnikach.'
          '</p>'
  ),

  KonspektStep(
      title: 'Wręczenie nagrody',
      duration: Duration(minutes: 5),
      activeForm: KonspektStepActiveForm.static,
      materials: [
        material_nagroda,
      ],
      content: '<p style="text-align:justify;">'
          'Prowadzący zlicza punkty każdej z grup i wyłania zwycięską grupę, następnie wręcza nagrodę.'
          '</p>'
  ),

];

// Konspekt
Konspekt konspekt_kszt_mechanizmy_ksztaltowania_duchowosci = Konspekt(
  name: konspekt_kszt_name_mechanizmy_ksztaltowania_duchowosci,
  title: 'Mechanizmy kształtowania duchowości',
  category: KonspektCategory.ksztalcenie,
  type: KonspektType.zajecia,
  spheres: {},
  metos: [Meto.kadra],
  coverAuthor: 'Freepik (freepik)',
  author: DANIEL_IWANICKI,
  aims: [
    'Przedstawienie uczestnikom czynników duchowości.',
    'Przedstawienie uczestnikom mechanizmów kształtowania duchowości.',
  ],
  attachments: attach_kszt_mechanizmy_ksztaltowania_duchowosci,
  materials: materials_kszt_mechanizmy_ksztaltowania_duchowosci,
  summary: 'Uczestnicy rozgrywają między sobą bieganą familiadę, by na podstawie krótkich historii określić, które czynniki rozwoju duchowości są w nich opisane.',
  steps: steps_kszt_mechanizmy_ksztaltowania_duchowosci,
  partOf: konspekt_kszt_warsztaty_wychowania_duchowego
);