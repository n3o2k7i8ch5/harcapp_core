/// Na ile uwaga piosenkomatu blokuje piosenkę. To tylko **kolor pastylki**
/// w edytorze — narzędzie po przeglądzie uwag nie czyta.
enum SongIssueSeverity{
  /// Czerwona: bez tego nie powinno wejść do apki.
  blocking,
  /// Pomarańczowa: dane kompletne, ktoś musi zdecydować.
  decision,
}

/// Co piosenkomat ma do zarzucenia piosence, która idzie do przeglądu.
///
/// Uwaga to zawsze **osąd** o piosence — fakty o zgłoszeniu (stara apka,
/// poprawka, dopisek) siedzą w [PiosenkomatData], nie tu. Piosenka identyczna
/// z apką nigdy nie trafia do pliku, więc „identyczna” nie jest uwagą.
///
/// Dwie osie w nazwach duplikatów: **co** (`same-title` / `similar-text`)
/// i **gdzie** (`in-app` — wśród piosenek już w apce, `in-batch` — w tej
/// samej paczce zgłoszeń).
///
/// [id] jedzie w pliku `.hrcpsng`, więc raz nadanej nazwy nie zmieniamy.
/// [text] widzi człowiek w podpowiedzi pastylki.
enum SongIssue{

  missingTitle('missing-title', 'brak tytułu', SongIssueSeverity.blocking),
  missingChords('missing-chords', 'brak chwytów', SongIssueSeverity.blocking),
  missingYoutube('missing-youtube', 'brak YouTube', SongIssueSeverity.blocking),

  noConsent('no-consent', 'brak zgody / wersji regulaminu', SongIssueSeverity.blocking),

  /// Zła suma kontrolna, nie JSON, obcięty plik albo zero zgłoszeń w środku.
  corruptedSubmissionFile('corrupted-submission-file', 'załącznik zgłoszenia uszkodzony', SongIssueSeverity.blocking),
  /// Wersja formatu nowsza niż znana — zawartości nie zgadujemy.
  unknownSubmissionFormat('unknown-submission-format', 'nowsza wersja formatu zgłoszenia', SongIssueSeverity.blocking),
  /// Kilka kart osób dodających: nie wiadomo, do której dokleić adres nadawcy.
  severalContributors('several-contributors', 'kilka osób dodających w zgłoszeniu', SongIssueSeverity.blocking),
  /// Adres nadawcy doklejony do jedynej karty na zgadywanie — stary format
  /// nie mówi, czy nadawca to osoba dodająca.
  guessedContributorEmail('guessed-contributor-email', 'adres nadawcy doklejony do jedynej karty — sprawdź, czy to ta osoba', SongIssueSeverity.decision),

  /// Nadawcą jest skrzynka HarcApp, a treść nie niesie adresu — nie ma komu
  /// przypisać wkładu ani kogo dopytać o zgodę.
  noContributorEmail('no-contributor-email', 'nie da się ustalić, kto zgłosił', SongIssueSeverity.blocking),

  /// Ta sama piosenka co w apce (tytuł, tekst), ale inne chwyty — ktoś
  /// poprawił chwyty i wysłał jako nową.
  chordsDifferFromApp('chords-differ-from-app', 'ta sama piosenka co w apce, inne chwyty', SongIssueSeverity.decision),
  /// Ta sama piosenka co w apce, różni się drobiazgiem: kolejność zwrotek,
  /// interpunkcja, YouTube, wykonawca… — niezadeklarowana poprawka.
  metadataDifferFromApp('metadata-differ-from-app', 'ta sama piosenka co w apce, drobne różnice', SongIssueSeverity.decision),

  /// Cała piosenka z apki plus zwrotki, których tam nie ma — zwykle poprawka
  /// wysłana jako nowa piosenka.
  moreVersesThanApp('more-verses-than-app', 'ta sama piosenka co w apce, dopisane zwrotki — może to poprawka?', SongIssueSeverity.decision),
  /// Fragment piosenki z apki: część zwrotek, nic nowego.
  fewerVersesThanApp('fewer-verses-than-app', 'fragment piosenki z apki — brak części zwrotek', SongIssueSeverity.decision),
  /// Połowa wersów wspólna: wariant tej samej piosenki albo bliska przeróbka.
  variantOfApp('variant-of-app', 'wariant albo bliska przeróbka piosenki z apki', SongIssueSeverity.decision),

  sameTitleInApp('same-title-in-app', 'ten sam tytuł, inna treść niż w apce', SongIssueSeverity.decision),
  similarTextInApp('similar-text-in-app', 'treść podobna do piosenki w apce', SongIssueSeverity.decision),

  sameTitleInBatch('same-title-in-batch', 'ten sam tytuł w paczce, inna treść', SongIssueSeverity.decision),
  similarTextInBatch('similar-text-in-batch', 'treść podobna do innego zgłoszenia w paczce', SongIssueSeverity.decision),
  /// Dwie poprawki tej samej piosenki w jednej paczce — przy wgrywaniu
  /// podmienisz tylko jedną.
  sameTargetInBatch('same-target-in-batch', 'druga poprawka tej samej piosenki w paczce', SongIssueSeverity.decision),

  /// Poprawka, ale w apce nie ma czego poprawiać — nic nie pasuje tytułem
  /// ani tekstem.
  noTargetInApp('no-target-in-app', 'poprawka piosenki, której nie ma w apce', SongIssueSeverity.decision),
  /// Zgłoszenie nie powiedziało, co poprawia — cel dobrany po tytule i tekście.
  /// Poprawka podmienia piosenkę po id, więc domysł trzeba obejrzeć.
  guessedCorrectionTarget('guessed-correction-target', 'cel poprawki zgadnięty, nie podany przez apkę', SongIssueSeverity.decision),

  hasUserMessage('has-user-message', 'użytkownik dopisał wiadomość', SongIssueSeverity.decision);

  const SongIssue(this.id, this.text, this.severity);

  final String id;
  final String text;
  final SongIssueSeverity severity;

  bool get isBlocking => severity == SongIssueSeverity.blocking;

  static SongIssue? byId(String id) =>
      SongIssue.values.where((i) => i.id == id).firstOrNull;
}
