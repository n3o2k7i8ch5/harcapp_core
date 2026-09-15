import 'song_issue.dart';

/// Co autor zadeklarował: nowa piosenka czy poprawka istniejącej.
enum SubmissionKind{
  newSong('new'),
  correction('correction');

  const SubmissionKind(this.id);
  final String id;

  static SubmissionKind byId(String? id) =>
      values.where((k) => k.id == id).firstOrNull ?? SubmissionKind.newSong;
}

/// Z której wersji apki przyszło zgłoszenie. Wiedza o nadawcy, nie o piosence:
/// autorowi ze starej apki piosenkomat odpisze, żeby ją zaktualizował.
enum SubmissionSource{
  currentApp('current-app'),
  oldApp('old-app');

  const SubmissionSource(this.id);
  final String id;

  static SubmissionSource byId(String? id) =>
      values.where((s) => s.id == id).firstOrNull ?? SubmissionSource.currentApp;
}

/// Jedna uwaga piosenkomatu do piosenki. [detail] mówi *z czym* kolizja albo
/// *co* dokładnie jest nie tak — bez tego „ten sam tytuł” nie niesie nic,
/// czego nie wiadomo z samej nazwy uwagi.
class PiosenkomatIssue{

  static const String PARAM_ISSUE = 'issue';
  static const String PARAM_DETAIL = 'detail';

  final SongIssue issue;
  final String? detail;

  const PiosenkomatIssue(this.issue, {this.detail});

  String get text => detail == null? issue.text: '${issue.text} — $detail';

  Map<String, dynamic> toJsonMap() => {
    PARAM_ISSUE: issue.id,
    if(detail != null) PARAM_DETAIL: detail,
  };

  /// `null`, gdy uwaga jest z nowszej wersji piosenkomatu niż ta apka —
  /// nieznanej uwagi nie umiemy pokazać, więc ją pomijamy.
  static PiosenkomatIssue? fromJsonMap(Map<String, dynamic> map){
    final issue = SongIssue.byId(map[PARAM_ISSUE] as String? ?? '');
    if(issue == null) return null;
    return PiosenkomatIssue(issue, detail: map[PARAM_DETAIL] as String?);
  }

}

/// Ślad piosenkomatu na piosence: **cechy** zgłoszenia (fakty) plus **uwagi**
/// (osądy) do przeglądu.
///
/// Jest `null` dla każdej normalnej piosenki — obecność tego pola znaczy
/// „ta piosenka jest w trakcie przeglądu”. Do `all_songs.hrcpsng` nigdy nie
/// jedzie: `SongRaw.toApiJsonMap` serializuje je tylko na wyraźne życzenie
/// (`withPiosenkomatData`), a `piosenkomat strip` zdejmuje je przed wgraniem.
class PiosenkomatData{

  static const String PARAM_KIND = 'kind';
  static const String PARAM_SOURCE = 'source';
  static const String PARAM_SENT_AT = 'sent_at';
  static const String PARAM_USER_MESSAGE = 'user_message';
  static const String PARAM_CORRECTION_MESSAGE = 'correction_message';
  static const String PARAM_CORRECTION_TARGET = 'correction_target';
  /// Klucz obecny tylko wtedy, gdy cel poprawki jest domysłem.
  static const String PARAM_CORRECTION_TARGET_GUESSED = 'correction_target_guessed';
  static const String PARAM_THREAD_ID = 'thread_id';
  static const String PARAM_RUN = 'run';
  static const String PARAM_ISSUES = 'issues';
  static const String PARAM_ACCEPTED = 'accepted';
  static const String PARAM_REPLY_TO_CONTRIBUTOR = 'reply_to_contributor';

  final SubmissionKind kind;
  final SubmissionSource source;
  /// Data wysłania mejla-reprezentanta zgłoszenia.
  final DateTime? sentAt;
  /// Co autor dopisał w polu „Jeśli chcesz coś dodać…”.
  final String? userMessage;
  /// Co autor napisał w bloku „Propozycja poprawki”. Przy poprawce oczekiwane.
  final String? correctionMessage;
  /// Którą piosenkę w apce poprawia (`lclId`); `null` = nie znaleziono.
  /// Skąd się wziął, mówi [correctionTargetGuessed].
  final String? correctionTarget;
  /// Czy [correctionTarget] to **domysł** narzędzia (najbliższa piosenka po
  /// tytule i tekście), a nie id podane przez apkę w zgłoszeniu. Poprawka
  /// podmienia piosenkę po id, więc przy domyśle trzeba spojrzeć, zanim
  /// wejdzie.
  final bool correctionTargetGuessed;
  /// Wątek Gmaila ze zgłoszeniem — po nim przegląd wiąże piosenkę
  /// ze zgłoszeniem, nawet gdy tytuł zmieni się przy poprawianiu.
  final String? threadId;
  /// Katalog przebiegu, z którego piosenka pochodzi (np. `import-2026-09-12T00`).
  final String? run;
  final List<PiosenkomatIssue> issues;
  /// Werdykt z przeglądu: `true` — do śpiewnika, `false` — nie. `null` znaczy
  /// „nie dotknięte”, czyli wchodzi: przełącznika dotykasz tylko przy tych,
  /// które odrzucasz, a pliki sprzed przełącznika dalej działają.
  ///
  /// Nieobecność piosenki w pliku zwrotnym **dalej** znaczy „odrzucona” —
  /// flaga tylko wygrywa, kiedy jest.
  final bool? accepted;
  /// Co napisać autorowi. Niezależne od [accepted]: da się i odrzucić
  /// z wyjaśnieniem („dorzuć chwyty i wejdzie”), i przyjąć z uwagą
  /// („dodałem, popraw literówkę”). Piosenkomat robi z tego szkic w wątku.
  final String? replyToContributor;

  const PiosenkomatData({
    this.kind = SubmissionKind.newSong,
    this.source = SubmissionSource.currentApp,
    this.sentAt,
    this.userMessage,
    this.correctionMessage,
    this.correctionTarget,
    this.correctionTargetGuessed = false,
    this.threadId,
    this.run,
    this.issues = const [],
    this.accepted,
    this.replyToContributor,
  });

  PiosenkomatData copyWith({
    bool? Function()? accepted,
    String? Function()? replyToContributor,
  }) => PiosenkomatData(
    kind: kind,
    source: source,
    sentAt: sentAt,
    userMessage: userMessage,
    correctionMessage: correctionMessage,
    correctionTarget: correctionTarget,
    correctionTargetGuessed: correctionTargetGuessed,
    threadId: threadId,
    run: run,
    issues: issues,
    accepted: accepted == null? this.accepted: accepted(),
    replyToContributor: replyToContributor == null? this.replyToContributor: replyToContributor(),
  );

  bool get isCorrection => kind == SubmissionKind.correction;
  bool get isOldApp => source == SubmissionSource.oldApp;
  bool get hasBlocking => issues.any((i) => i.issue.isBlocking);
  /// Czy jest coś od autora do przeczytania.
  bool get hasMessages => (userMessage ?? '').isNotEmpty || (correctionMessage ?? '').isNotEmpty;
  /// Werdykt do użycia: brak przełącznika znaczy „wchodzi”.
  bool get goesIn => accepted ?? true;
  /// Czy jest co wysłać autorowi.
  bool get hasReplyToContributor => (replyToContributor ?? '').trim().isNotEmpty;

  Map<String, dynamic> toJsonMap() => {
    PARAM_KIND: kind.id,
    PARAM_SOURCE: source.id,
    if(sentAt != null) PARAM_SENT_AT: sentAt!.toIso8601String(),
    if(userMessage != null) PARAM_USER_MESSAGE: userMessage,
    if(correctionMessage != null) PARAM_CORRECTION_MESSAGE: correctionMessage,
    if(correctionTarget != null) PARAM_CORRECTION_TARGET: correctionTarget,
    if(correctionTargetGuessed) PARAM_CORRECTION_TARGET_GUESSED: true,
    if(threadId != null) PARAM_THREAD_ID: threadId,
    if(run != null) PARAM_RUN: run,
    PARAM_ISSUES: issues.map((i) => i.toJsonMap()).toList(),
    if(accepted != null) PARAM_ACCEPTED: accepted,
    if(hasReplyToContributor) PARAM_REPLY_TO_CONTRIBUTOR: replyToContributor!.trim(),
  };

  static PiosenkomatData fromJsonMap(Map<String, dynamic> map) => PiosenkomatData(
    kind: SubmissionKind.byId(map[PARAM_KIND] as String?),
    source: SubmissionSource.byId(map[PARAM_SOURCE] as String?),
    sentAt: DateTime.tryParse(map[PARAM_SENT_AT] as String? ?? ''),
    userMessage: map[PARAM_USER_MESSAGE] as String?,
    correctionMessage: map[PARAM_CORRECTION_MESSAGE] as String?,
    correctionTarget: map[PARAM_CORRECTION_TARGET] as String?,
    correctionTargetGuessed: map[PARAM_CORRECTION_TARGET_GUESSED] as bool? ?? false,
    // `email_msg_id`: nazwa sprzed przejścia na wątki.
    threadId: (map[PARAM_THREAD_ID] ?? map['email_msg_id']) as String?,
    run: map[PARAM_RUN] as String?,
    issues: [
      for(final raw in (map[PARAM_ISSUES] as List? ?? const []))
        if(raw is Map<String, dynamic>)
          if(PiosenkomatIssue.fromJsonMap(raw) case final issue?) issue
    ],
    accepted: map[PARAM_ACCEPTED] as bool?,
    replyToContributor: map[PARAM_REPLY_TO_CONTRIBUTOR] as String?,
  );

}
