class Choragiew {
  final String name;
  const Choragiew(this.name);
}

class Hufiec {
  final String name;
  final Choragiew choragiew;
  const Hufiec(this.name, this.choragiew);
}

const choragiewStoleczna = Choragiew('Chorągiew Stołeczna');
const choragiewKrakowska = Choragiew('Chorągiew Krakowska');

const List<Choragiew> choragwie = [
  choragiewStoleczna,
  choragiewKrakowska,
];

const List<Hufiec> srodowiska = [
  // ===== Chorągiew Stołeczna =====
  Hufiec('Hufiec Błonie im. Edwarda Przybysza', choragiewStoleczna),
  Hufiec('Hufiec Celestynów im. Bohaterów Akcji pod Celestynowem', choragiewStoleczna),
  Hufiec('Hufiec „Orłów” Garwolin', choragiewStoleczna),
  Hufiec('Hufiec Grodzisk Mazowiecki im. Leonida Teligi', choragiewStoleczna),
  Hufiec('Hufiec Legionowo im. Szarych Szeregów „Rój-Tom”', choragiewStoleczna),
  Hufiec('Hufiec Milanówek im. J. Kusocińskiego', choragiewStoleczna),
  Hufiec('Hufiec Nowy Dwór Mazowiecki im. Korpusu Kadetów nr. 2', choragiewStoleczna),
  Hufiec('Hufiec Otwock im. Roju Sosny Szarych Szeregów', choragiewStoleczna),
  Hufiec('Hufiec Piaseczno im. Bohaterów Pokoju', choragiewStoleczna),
  Hufiec('Hufiec Piastów im. prof. hm. A. Kamińskiego „Kamyka”', choragiewStoleczna),
  Hufiec('Hufiec Pruszków im. Andrzeja Romockiego „Morro”', choragiewStoleczna),
  Hufiec('Hufiec Sulejówek im. Batalionu „Zośka”', choragiewStoleczna),
  Hufiec('Hufiec Uroczysko Konstancin', choragiewStoleczna),
  Hufiec('Hufiec Warszawa-Centrum im. Księcia Janusza I Mazowieckiego', choragiewStoleczna),
  Hufiec('Hufiec Warszawa-Mokotów im. Szarych Szeregów', choragiewStoleczna),
  Hufiec('Hufiec Warszawa-Ochota im. płk. Cypriana Godebskiego', choragiewStoleczna),
  Hufiec('Hufiec Warszawa-Praga-Północ im. Wigierczyków', choragiewStoleczna),
  Hufiec('Hufiec Warszawa-Praga-Południe im. I WDP „T. Kościuszki”', choragiewStoleczna),
  Hufiec('Hufiec Warszawa-Ursus-Włochy im. hm. Mieczysława Bema', choragiewStoleczna),
  Hufiec('Hufiec Warszawa-Wawer', choragiewStoleczna),
  Hufiec('Hufiec Warszawa-Wola', choragiewStoleczna),
  Hufiec('Hufiec Warszawa-Żoliborz', choragiewStoleczna),
  Hufiec('Hufiec Wołomin im. Mieczysława Cicheckiego', choragiewStoleczna),
  Hufiec('Hufiec Ząbki im. Bohaterów Lotnictwa Polskiego', choragiewStoleczna),
  Hufiec('Hufiec Zielonka im. Janusza Korczaka', choragiewStoleczna),

  // ===== Chorągiew Krakowska =====
  Hufiec('Hufiec ZHP Andrychów im. Szarych Szeregów', choragiewKrakowska),
  Hufiec('Hufiec ZHP Bochnia im. gen. Jana Henryka Dąbrowskiego', choragiewKrakowska),
  Hufiec('Hufiec ZHP Brzesko im. Mikołaja Kopernika', choragiewKrakowska),
  Hufiec('Hufiec Gorczański ZHP im. Władysława Orkana', choragiewKrakowska),
  Hufiec('Hufiec ZHP Gorlice im. hm. Marii Rydarowskiej', choragiewKrakowska),
  Hufiec('Hufiec ZHP Jordanów im. Aleksandra Kamińskiego', choragiewKrakowska),
  Hufiec('Hufiec ZHP Kęty im. Mieczysława Biesiadeckiego', choragiewKrakowska),
  Hufiec('Hufiec ZHP Kraków-Krowodrza', choragiewKrakowska),
  Hufiec('Hufiec ZHP Kraków-Nowa Huta im. Mariusza Zaruskiego', choragiewKrakowska),
  Hufiec('Hufiec ZHP Kraków-Podgórze im. Podgórskich Szarych Szeregów', choragiewKrakowska),
  Hufiec('Hufiec ZHP Kraków-Śródmieście im. Mikołaja Kopernika', choragiewKrakowska),
  Hufiec('Hufiec ZHP Krzeszowice im. Szarych Szeregów', choragiewKrakowska),
  Hufiec('Hufiec ZHP Myślenice im. Stefana Mirowskiego', choragiewKrakowska),
  Hufiec('Hufiec ZHP Nowy Sącz', choragiewKrakowska),
  Hufiec('Hufiec ZHP Olkusz im. Bohaterów Powstania Styczniowego', choragiewKrakowska),
  Hufiec('Hufiec ZHP Oświęcim im. hm. Edmunda Wilkosza', choragiewKrakowska),
  Hufiec('Hufiec ZHP Podhalański im. Kurierów Tatrzańskich', choragiewKrakowska),
  Hufiec('Hufiec Podkrakowski ZHP im. Krakowskich Szarych Szeregów', choragiewKrakowska),
  Hufiec('Hufiec ZHP Tarnów im. gen. Józefa Bema', choragiewKrakowska),
  Hufiec('Hufiec ZHP Trzebinia im. ks. hm. Mariana Luzara', choragiewKrakowska),
  Hufiec('Hufiec ZHP Wieliczka im. Edwarda Dembowskiego', choragiewKrakowska),
  Hufiec('Hufiec Ziemi Wadowickiej ZHP', choragiewKrakowska),
];
