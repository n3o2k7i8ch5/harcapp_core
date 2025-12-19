import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';

Konspekt sznury_funkcje_stopnie = const Konspekt(
  name: 'sznury_funkcje_stopnie',
  title: 'Sznury, funkcje, stopnie ZHP',
  category: KonspektCategory.harcerskie,
  type: KonspektType.zajecia,
  spheres: {
    KonspektSphere.umysl: KonspektSphereDetails(
        levels: {
          KonspektSphereLevel.other: KonspektSphereFields(
              fields: {
                umyslZnajomoscSznurowFunkcjiStopniZHP: null,
              }
          )
        }
    ),
    KonspektSphere.duch: KonspektSphereDetails(
        levels: {
          KonspektSphereLevel.duchWartosci: KonspektSphereFields(
              fields: {
                wartoscPrzynaleznoscDoHarcerstwa: {
                  KonspektSphereFactor.duchPerspektywa_Normalizacja
                }
              }
          )
        }
    )
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
  summary: 'Uczestnicy w dwóch grupach rozgrywają "warunkowe warcaby" - mogą zrobić ruch jesli dobrze przypiszą sznur do funkcji.',
  steps: [
    KonspektStep(
        title: 'Podział na grupy',
        duration: Duration(minutes: 5),
        activeForm: KonspektStepActiveForm.active,
        content: '<p style="text-align:justify;">Harcerze są dzieleni na dwie grupy. Forma podziału jest dowolna (np. wg. zastępów, grając w <a href="atomy@form">atomy</a>).</p>'
    ),


    KonspektStep(
        title: 'Sznury - wywiady z kadrą',
        duration: Duration(minutes: 15),
        activeForm: KonspektStepActiveForm.active,
        required: false,
        content: '<p style="text-align:justify;">Harcerze są informowani, że za chwilę czeka ich wielka gra z wiedzy o funkcjach i sznurach w ZHP. Ich zadaniem jest dowiedzieć się jak najwięcej o sznurach od obecnej na obozie kadry innych drużyn (o ile nie są obecnie zajęci innymi sprawami!). Mogą w tym celu posiłkować się jedynie kartką i długopisem.'
            '<br>'
            '<br>Ich zadaniem jest także się dowiedzieć czym zajmuje się przyboczny, drużynowy i komendant szczepu.</p>'
    ),


    KonspektStep(
        title: 'Sznury - wstęp teoretyczny',
        duration: Duration(minutes: 15),
        activeForm: KonspektStepActiveForm.static,
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
        activeForm: KonspektStepActiveForm.static,
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
        activeForm: KonspektStepActiveForm.active,
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
        activeForm: KonspektStepActiveForm.active,
        content: '<p style="text-align:justify;">Prowadzący powtarza poprzednią formę, tym razem ze stopniami żeńskimi.</p>'
    ),


    KonspektStep(
        title: 'Stopnie męskie i damskie - memory',
        duration: Duration(minutes: 10),
        activeForm: KonspektStepActiveForm.static,
        content: '<p style="text-align:justify;">Prowadzący zbiera wszystkie kartki ze stopniami. Zostawia po jednej kartce z każdego stopnia (zarówno męskiego jak i żeńskiego), pozostałe wyrzuca. Tasuje kartki i rozkłada je wierzchem do góry na podłodze. Dzieli harcerzy na dwie grupy (można powtórzyć poprzedni podział) i harcerze grają w memory - zebrać parę mogą tylko, gdy połączą stopień męski i odpowiadający im stopień żeński.'
            '<br>'
            '<br>Jeżeli uczestników jest więcej niż 12, można podzielić ich na grupy i zagrać w memory w mniejszych grupach.</p>'
    ),


    KonspektStep(
        title: 'Stopnie instruktorskie - tak-nie',
        duration: Duration(minutes: 15),
        activeForm: KonspektStepActiveForm.active,
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
        FileFormat.pdf: null,
        FileFormat.docx: null,
      },
    ),
    KonspektAttachment(
        name: 'nieistniejace_sznury',
        title: 'Nieistniejące sznury',
        assets: {
          FileFormat.pdf: null,
          FileFormat.docx: null,
        }
    ),
    KonspektAttachment(
        name: 'stopnie_instruktorskie_pytania',
        title: 'Stopnie instruktorskie - pytania',
        assets: {
          FileFormat.pdf: null,
          FileFormat.docx: null,
        }
    ),
  ],
);