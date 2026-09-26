import 'song_issue.dart';

/// Co autor zadeklarował: nowa piosenka czy poprawka istniejącej.
enum SubmissionKind{
  newSong('new'),
  correction('correction');

  const SubmissionKind(this.id);
  final String id;

  /// Rodzaj po id. Nieznane albo brakujące id to błąd, nie „nowa” —
  /// po cichu zgadnięty rodzaj zmieniłby poprawkę w nową piosenkę.
  static SubmissionKind byId(String? id) =>
      values.where((k) => k.id == id).firstOrNull ??
      (throw FormatException('Nieznany rodzaj zgłoszenia: „$id”'));
}

/// Jedna wiadomość z wątku zgłoszenia.
///
/// Wątek to **rozmowa**: dopisek autora, Twoja odpowiedź, jego odpowiedź na
/// nią. Dlatego ślad niesie listę, a nie jeden zlepiony napis — inaczej
/// w edytorze wszystko ląduje w jednym dymku i nie widać, kto co powiedział
/// ani kiedy.
class PiosenkomatMessage{

  static const String PARAM_TEXT = 'text';
  static const String PARAM_AT = 'at';
  static const String PARAM_OURS = 'ours';

  final String text;
  /// Kiedy przyszła. `null` w mejlach bez daty.
  final DateTime? at;
  /// Czy to odpowiedź ze skrzynki HarcAppa, czyli **Twoja** — a nie autora.
  final bool isOurs;

  const PiosenkomatMessage(this.text, {this.at, this.isOurs = false});

  Map<String, dynamic> toJsonMap() => {
    PARAM_TEXT: text,
    if(at != null) PARAM_AT: at!.toIso8601String(),
    // Tylko odstępstwo od domyślnego „od autora” — plik ma nieść to, co
    // niesie treść, a nie powtarzać `false` przy każdej wiadomości.
    if(isOurs) PARAM_OURS: true,
  };

  /// `null`, gdy wiadomość nie ma treści — pusty dymek nic nie mówi.
  static PiosenkomatMessage? fromJsonMap(Map<String, dynamic> map){
    final text = (map[PARAM_TEXT] as String? ?? '').trim();
    if(text.isEmpty) return null;
    return PiosenkomatMessage(
      text,
      at: DateTime.tryParse(map[PARAM_AT] as String? ?? ''),
      isOurs: map[PARAM_OURS] as bool? ?? false,
    );
  }

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
/// (`withPiosenkomatData`), a `piosenkomat prepare` zdejmuje je przed wgraniem.
class PiosenkomatData{

  static const String PARAM_KIND = 'kind';
  static const String PARAM_OLD_APP = 'old_app';
  static const String PARAM_APP_VERSION = 'app_version';
  static const String PARAM_SENDER = 'sender';
  static const String PARAM_SENDER_IS_CONTRIBUTOR = 'sender_is_contributor';
  static const String PARAM_SENT_AT = 'sent_at';
  static const String PARAM_CONVERSATION = 'conversation';
  static const String PARAM_CORRECTION_MESSAGE = 'correction_message';
  static const String PARAM_CORRECTION_TARGET = 'correction_target';
  /// Klucz obecny tylko wtedy, gdy cel poprawki jest domysłem.
  static const String PARAM_CORRECTION_TARGET_GUESSED = 'correction_target_guessed';
  static const String PARAM_THREAD_ID = 'thread_id';
  static const String PARAM_RUN = 'run';
  static const String PARAM_ISSUES = 'issues';
  static const String PARAM_ACCEPTED = 'accepted';
  static const String PARAM_REVIEW_NOTE = 'review_note';

  final SubmissionKind kind;
  /// Czy zgłoszenie przyszło ze starej apki. Wiedza o nadawcy, nie o piosence:
  /// takiemu autorowi piosenkomat odpisze, żeby apkę zaktualizował.
  final bool isOldApp;
  /// Wersja apki, z której poszło zgłoszenie. Niesie ją plik zgłoszenia, więc
  /// jest tylko przy nowym formacie.
  final String? appVersion;
  /// Adres, z którego przyszło zgłoszenie. Widoczny w pasku piosenkomatu —
  /// to jedyne miejsce, gdy nie doklejono go do karty osoby dodającej.
  final String? sender;
  /// Czy nadawca zgłasza **własną** piosenkę. Przy `false` jego adres służy
  /// wyłącznie do odpisania i nie trafia do `people.dart`. Stare zgłoszenia
  /// tego nie niosą — dla nich `true`.
  final bool senderIsContributor;
  /// Data wysłania mejla-reprezentanta zgłoszenia.
  final DateTime? sentAt;
  /// Cała rozmowa z wątku, od najstarszej: dopiski autora i Twoje odpowiedzi.
  final List<PiosenkomatMessage> conversation;
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
  /// Twój tekst z pola „Odpowiedź do autora” — pójdzie do nadawcy zgłoszenia.
  /// Niezależny od [accepted]: da się i odrzucić z wyjaśnieniem („dorzuć
  /// chwyty i wejdzie”), i przyjąć z uwagą („dodałem, popraw literówkę”).
  /// Piosenkomat robi z tego szkic w wątku.
  final String? reviewNote;

  const PiosenkomatData({
    this.kind = SubmissionKind.newSong,
    this.isOldApp = false,
    this.appVersion,
    this.sender,
    this.senderIsContributor = true,
    this.sentAt,
    this.conversation = const [],
    this.correctionMessage,
    this.correctionTarget,
    this.correctionTargetGuessed = false,
    this.threadId,
    this.run,
    this.issues = const [],
    this.accepted,
    this.reviewNote,
  });

  PiosenkomatData copyWith({
    bool? Function()? accepted,
    String? Function()? reviewNote,
  }) => PiosenkomatData(
    kind: kind,
    isOldApp: isOldApp,
    appVersion: appVersion,
    sender: sender,
    senderIsContributor: senderIsContributor,
    sentAt: sentAt,
    conversation: conversation,
    correctionMessage: correctionMessage,
    correctionTarget: correctionTarget,
    correctionTargetGuessed: correctionTargetGuessed,
    threadId: threadId,
    run: run,
    issues: issues,
    accepted: accepted == null? this.accepted: accepted(),
    reviewNote: reviewNote == null? this.reviewNote: reviewNote(),
  );

  bool get isCorrection => kind == SubmissionKind.correction;

  /// Co napisał **autor**, bez Twoich odpowiedzi — tego dotyczy uwaga
  /// `has-user-message` i z tego robi się propozycja odpowiedzi.
  String? get userMessage {
    final own = [for(final m in conversation) if(!m.isOurs) m.text];
    return own.isEmpty? null: own.join('\n\n');
  }
  /// Werdykt do użycia: brak przełącznika znaczy „wchodzi”.
  bool get goesIn => accepted ?? true;
  /// Czy jest co wysłać autorowi.
  bool get hasReviewNote => (reviewNote ?? '').trim().isNotEmpty;

  Map<String, dynamic> toJsonMap() => {
    PARAM_KIND: kind.id,
    if(isOldApp) PARAM_OLD_APP: true,
    if(appVersion != null) PARAM_APP_VERSION: appVersion,
    if(sender != null) PARAM_SENDER: sender,
    if(!senderIsContributor) PARAM_SENDER_IS_CONTRIBUTOR: false,
    if(sentAt != null) PARAM_SENT_AT: sentAt!.toIso8601String(),
    if(conversation.isNotEmpty) PARAM_CONVERSATION: [for(final m in conversation) m.toJsonMap()],
    if(correctionMessage != null) PARAM_CORRECTION_MESSAGE: correctionMessage,
    if(correctionTarget != null) PARAM_CORRECTION_TARGET: correctionTarget,
    if(correctionTargetGuessed) PARAM_CORRECTION_TARGET_GUESSED: true,
    if(threadId != null) PARAM_THREAD_ID: threadId,
    if(run != null) PARAM_RUN: run,
    PARAM_ISSUES: issues.map((i) => i.toJsonMap()).toList(),
    if(accepted != null) PARAM_ACCEPTED: accepted,
    if(hasReviewNote) PARAM_REVIEW_NOTE: reviewNote!.trim(),
  };

  static PiosenkomatData fromJsonMap(Map<String, dynamic> map) => PiosenkomatData(
    kind: SubmissionKind.byId(map[PARAM_KIND] as String?),
    isOldApp: map[PARAM_OLD_APP] as bool? ?? false,
    appVersion: map[PARAM_APP_VERSION] as String?,
    sender: map[PARAM_SENDER] as String?,
    senderIsContributor: map[PARAM_SENDER_IS_CONTRIBUTOR] as bool? ?? true,
    sentAt: DateTime.tryParse(map[PARAM_SENT_AT] as String? ?? ''),
    conversation: [
      for(final raw in (map[PARAM_CONVERSATION] as List? ?? const []))
        if(raw is Map<String, dynamic>)
          if(PiosenkomatMessage.fromJsonMap(raw) case final message?) message
    ],
    correctionMessage: map[PARAM_CORRECTION_MESSAGE] as String?,
    correctionTarget: map[PARAM_CORRECTION_TARGET] as String?,
    correctionTargetGuessed: map[PARAM_CORRECTION_TARGET_GUESSED] as bool? ?? false,
    threadId: map[PARAM_THREAD_ID] as String?,
    run: map[PARAM_RUN] as String?,
    issues: [
      for(final raw in (map[PARAM_ISSUES] as List? ?? const []))
        if(raw is Map<String, dynamic>)
          if(PiosenkomatIssue.fromJsonMap(raw) case final issue?) issue
    ],
    accepted: map[PARAM_ACCEPTED] as bool?,
    reviewNote: map[PARAM_REVIEW_NOTE] as String?,
  );

}
