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
  name: 'Nagroda dla zwyciezkiego zespołu (np. paczka żelków)',
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
      title: 'Wyjaśnienie merytoryczne - szczeble internalizacji',
      duration: Duration(minutes: 5),
      activeForm: KonspektStepActiveForm.static,
      materials: [
        material_zal_poradnik_mechanizmy_ksztaltowania_duchowosci,
      ],
      content: '<p style="text-align:justify;">'
          'Prowadzący, na podstawie załącznika $attach_html_poradnik_mechanizmy_ksztaltowania_duchowosci wyjaśnia uczestnikom czym są mechanizmy kształtowania duchowości.'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Duchowość człowieka można kształtować - co więcej, jest ona stale kształtowana, przez różne mechanizmy - niektóre z nich wynikają z intencjonalnych działań, np. harcerskich wychowawców, zaś inne są dziełem zamierzonych przez nikogo zjawisk.'
          '<br>'
          '<br>Istnieje cały zestaw narzędzi i mechanizmów, którymi można pływać na duchowość wychowanków, jednak przede wszystkim trzeba zrozumieć, że nie jest do końca tak, że jakieś zachowanie, wartość, czy aksjomat w duchowości są lub ich nie ma. W rzeczywistości każde zachowanie, wartość, czy aksjomat mogą być zakorzenione w duchowości człowieka w na różnym stopniu głębokości.'
          '<br>'
          '<br>Zanim przejdziemy do konkretnych mechanizmów kształtowania duchowości, warto mieć na uwadze, że różne mechanizmy kształtują duchowość na różnym poziomie jej zakorzenienia. Jest ich cztery i szybko je nakreślę.'
          '</p>'
          '</blockquote>'

          '<p style="text-align:justify;">'
          'Prowadzący kładzie w widocznym miejscu pierwszą kartę z załącznika $attach_html_karty_szczebli_internalizacji_duchowosci i ją objaśnia:'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Najpłytszym i najłatwiejszym do ukształtowania szczeblem internalizacji jest szczel <b>dostosowania</b>.'
          '<br>'
          '<br>Człowiek ma tendencję do robienia tego, co wymaga najmniej wysiłku. Jeśli ktoś (koledzy, kadra, rodzice) lub coś (ekonomia, kultura, środowisko) do czegoś zachęca, namawia, wywiera presję, lub czyni przystępniejszym, człowiek prawdopodobnie to zrobi.'
          '</p>'
          '</blockquote>'

          '<p style="text-align:justify;">'
          'Prowadzący kładzie w widocznym miejscu drugą kartę z załącznika $attach_html_karty_szczebli_internalizacji_duchowosci i ją objaśnia:'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Drugim szczeblem internalizacji jest szczel <b>przyzwyczajenia</b>.'
          '<br>'
          '<br>Człowiek ma tendencję do robienia tego, do czego jest przyzwyczajony. Przyzwyczajenie jest trwalsze od dostosowania – działa bez nadzoru i bez zewnętrznych czynników. Jest jednak kruche przy zmianie środowiska, rutyny i rytmu dnia.'
          '</p>'
          '</blockquote>'

          '<p style="text-align:justify;">'
          'Prowadzący kładzie w widocznym miejscu trzecią kartę z załącznika $attach_html_karty_szczebli_internalizacji_duchowosci i ją objaśnia:'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Trzecim szczeblem internalizacji jest szczel <b>tożsamości</b>.'
          '<br>'
          '<br>Tożsamość to odpowiedź na pytanie "kim jestem" – zbiór cech, ról i przynależności, które człowiek uznaje za swoje. Tożsamość jest trwalsza niż dostosowanie lub przyzwyczajenie.'
          '<br>'
          '<br>Tożsamość, której wychowanek nigdy nie zakwestionował, jest krucha – rozpadnie się przy pierwszej konfrontacji z innym środowiskiem. Tożsamość, która przeszła przez wątpliwości i przetrwała, jest trwała właśnie dlatego, że została przetestowana.'
          '</p>'
          '</blockquote>'

          '<p style="text-align:justify;">'
          'Prowadzący kładzie w widocznym miejscu czwartą kartę z załącznika $attach_html_karty_szczebli_internalizacji_duchowosci i ją objaśnia:'
          '</p>'

          '<blockquote>'
          '<p style="text-align:justify;">'
          'Ostatnim, czwartym szczeblem internalizacji jest szczel <b>wiary</b>.'
          '<br>'
          '<br>Najtrwalszy poziom – przetrwa nawet kryzys tożsamości. Wymaga dojrzałości poznawczej (min. 11–12 lat). Nie da się jej narzucić.'
          '<br>'
          '<br>Próba kształtowania wiary bez poruszania innych szczebli jest zwykle jałowa. Ludzie rzadko dochodzą do wiary drogą rozumowania – jest raczej odwrotnie: osądy moralne powstają automatycznie, a wyznawane poglądy i rozumowanie na ich podstawie pojawia się później jako ich uzasadnienie.'
          '</p>'
          '</blockquote>'
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
          'Prowadzący wyjaśnia uczestnikom zasady gry, ktorą za chwilę rozegrają:'
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
          '<br>Gdy grupy się zastanowią, mogą na każdej z kart położyć od 0 do 3 żetonów, obstawiając prawidłowe odpowiedzi. Gdy żetony zostaną rozdysponowane na kartach, grupy pokazują sobie nazwajem obstawione karty i prowadzący odczytuje odpowiedzi. Dobrze obstawione żetony są podwajane, źle obstawione są zabierane.'
          '<br>'
          '<br>Grupa, która zdobędzie najwięcej punktów, wygrywa.'
          '</p>'
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
      title: 'Zapoznanie się z poradnikami',
      duration: Duration(minutes: 10),
      activeForm: KonspektStepActiveForm.static,
      materials: [
        material_zal_poradnik_mechanizmy_ksztaltowania_duchowosci,
      ],
      content: '<style="text-align:justify;">'
          'Prowadzący wręcza każdej z grup po jednym egzemplarzu poradnika $attach_html_poradnik_mechanizmy_ksztaltowania_duchowosci. Ważne, aby dało się go rozłożyć na osobne kartki - na tych kartkach każda grupa będzie kładła swoje żetony.'
          '<br>'
          '<br>Uczestnicy mają czas, aby zapoznać się z treściami kartek. Mogą przeczytać je sobie na głos, po cichu na raz, każdy po jednej kartce, po czym się nimi okrężnie wymieniać.'
          '<br>'
          '<br>Gdy to zrobią, uczestnicy kładą kartki w rzędzie przed sobą na widoku, by móc do nich wracać w trakcie gry oraz obstawiać kartki z poprawnymi czynnikami za pomocą żetonów.'
          '</p>'
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
          '<br>Warto, aby prowadzący nie czytał historii po kolei, jako że są ułożone w tej samej kolejności, co czynniki opisane w poradnikach.'
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
          'Prowadzący zlicza punkty każdej z grup i wyłania zwycięzką grupę, następnie wręcza nagrodę.'
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