import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/contrib_reply.dart';

import 'mailbox.dart';
import 'model.dart';
import 'plan.dart';

/// Odpowiedź do autora czeka w Gmailu jako **szkic** w wątku jego zgłoszenia
/// — to jedyny jej stan. Etykieta `reply/*` mówi, że czeka, szkic — co pójdzie.
/// Szkice zakłada `scan --push` (blok o starej apce) i `review --push` (Twój
/// tekst z przeglądu); `reply --push` tylko je wysyła.

// ---------------------------------------------------------------------------
// Co ma być w szkicach
// ---------------------------------------------------------------------------

/// Wątek przebiegu z tym, czego potrzebuje odpowiedź w nim.
typedef ReplyThread = ({
  String threadId,
  String sender,
  /// Od najstarszej — odpowiadamy na ostatnią.
  List<String> messageIds,
  /// Czeka na blok o starej apce (`reply/old-app`).
  bool oldApp,
  /// Twój tekst z przeglądu; `null`, gdy wątek na niego nie czeka.
  String? note,
});

/// Wątki przebiegu, jakie widzą szkice: kto, na co czeka i jaki tekst z [notes]
/// ma dostać. Tekst liczy się tylko w wątku, który czeka na odpowiedź
/// z przeglądu (`reply/review-note`). [labels] — etykiety po mejlu takie, jakie
/// będą po zmianach wypychanych przez komendę.
List<ReplyThread> replyThreadsOf(RunPlan plan, Map<String, Set<String>> labels,
        [Map<String, String> notes = const {}]) =>
    [
      for (final MapEntry(key: thread, value: t) in plan.threads.entries)
        if (t.sender case final sender?)
          (
            threadId: thread,
            sender: sender,
            messageIds: t.messages,
            oldApp: plan.labelsOfThread(thread, labels).contains(SongLabel.replyOldApp.label),
            note: plan.labelsOfThread(thread, labels).contains(SongLabel.replyReviewNote.label)
                ? notes[thread]
                : null,
          ),
    ];

/// Co zrobić ze szkicem w wątku.
enum DraftStep {
  /// Nic tu nie ma i nie ma być.
  none,
  create,
  /// Szkic już taki, jaki ma być.
  keep,
  /// Szkic poprawiony w Gmailu, a przegląd od tamtej pory się nie zmienił —
  /// Twoja wersja wygrywa, bez uwag.
  edited,
  /// Szkic bez Twojego tekstu z Gmaila — sama ramka i blok albo dokładnie to,
  /// co narzędzie wpisało — wolno go przeliczyć.
  rewrite,
  /// Taki szkic w wątku, w którym odpowiedzi ma nie być.
  delete,
  /// Szkic poprawiony w Gmailu, a przegląd też się zmienił (albo nie wiadomo,
  /// co narzędzie wpisało) — zostaje, a narzędzie mówi o różnicy.
  differs,
  /// Szkic nie w naszym kształcie albo nieczytelny — zostaje nietknięty.
  manual,
}

/// Jedna reguła dla każdego szkicu: narzędzie rusza tylko szkic, którego nie
/// poprawiałeś w Gmailu — samą ramkę, blok o starej apce albo tekst dokładnie
/// taki, jaki samo wpisało ([written]). Poprawki z Gmaila nie mogą zniknąć przy
/// kolejnym `review --push`. [body] `null` przy [exists] — szkicu nie da się
/// odczytać; [want] `null` — odpowiedzi ma tu nie być; [written] `null` — nie
/// wiadomo, co narzędzie wpisało, więc szkic z tekstem jest Twój.
DraftStep draftStep({required bool exists, String? body, String? want, String? written}) {
  if (!exists) return want == null ? DraftStep.none : DraftStep.create;
  if (body == null || !isToolShapedReply(body)) return DraftStep.manual;
  final text = _squash(replyNoteOf(body));
  final untouched = written != null && _squash(body) == _squash(written);
  if (want == null) return text.isEmpty || untouched ? DraftStep.delete : DraftStep.differs;
  if (_squash(body) == _squash(want)) return DraftStep.keep;
  // Sam tekst się zgadza, różni się ramka (np. doszedł blok) — przeliczenie
  // niczego Twojego nie zmieni.
  if (text.isEmpty || untouched || text == _squash(replyNoteOf(want))) return DraftStep.rewrite;
  if (written != null && _squash(replyNoteOf(written)) == _squash(replyNoteOf(want))) return DraftStep.edited;
  return DraftStep.differs;
}

/// Co zrobić ze szkicem jednego wątku — policzone, jeszcze nie zrobione.
/// [sentByHand]: szkicu nie ma, bo poszedł ręcznie z Gmaila — nic nie
/// zakładamy, etykiety przestawi `reply --push`.
typedef DraftPlan = ({ReplyThread thread, DraftStep step, String? want, String? draftId, bool sentByHand});

/// Szkice wątków przebiegu takie, jak mają być — [draftStep] per wątek, bez
/// ruszania Gmaila. [written] — co narzędzie samo wpisało do szkiców, po wątku.
Future<List<DraftPlan>> planDrafts(Mailbox mailbox, List<ReplyThread> threads,
    {required Map<String, String> written}) async {
  final drafts = await mailbox.draftIdByThread();
  final plans = <DraftPlan>[];
  for (final t in threads) {
    final draftId = drafts[t.threadId];
    final body = draftId == null ? null : await mailbox.draftBody(draftId);
    // Mejl na piosenkę, w jej wątku: tekst z przeglądu i — w **każdym** wątku
    // ze starej apki — blok o niej. Nigdy raz na autora: kto przysłał ze
    // starej apki trzy piosenki, dostaje blok w trzech mejlach.
    final want = composeContribReply(reviewNote: t.note, oldApp: t.oldApp);
    // Szkicu nie ma, a ostatnie słowo w wątku to nasza odpowiedź z tym, na co
    // wątek czeka — szkic poszedł ręcznie z Gmaila, a etykiety jeszcze o tym
    // nie wiedzą. Nowy szkic byłby drugim takim samym mejlem.
    final sentByHand = draftId == null &&
        want != null &&
        await _alreadySent(mailbox, t.threadId, expectsNote: t.note != null);
    plans.add((
      thread: t,
      step: sentByHand
          ? DraftStep.none
          : draftStep(exists: draftId != null, body: body, want: want, written: written[t.threadId]),
      want: want,
      draftId: draftId,
      sentByHand: sentByHand,
    ));
  }
  return plans;
}

/// Ile szkiców trzeba by założyć, przeliczyć albo skasować.
int draftChanges(List<DraftPlan> plans) =>
    plans.where((d) => const {DraftStep.create, DraftStep.rewrite, DraftStep.delete}.contains(d.step)).length;

/// Szkice wątków przebiegu takie, jak mają być ([planDrafts]). Bez [push] tylko
/// wypisuje, co by zrobił. [written] — co narzędzie samo wpisało do szkiców,
/// po wątku; z [push] dopisuje do niego to, co wpisze teraz. Zwraca, ile
/// szkiców założyło, przeliczyło albo skasowało — na sucho: ile by.
Future<int> syncDrafts(Mailbox mailbox, List<ReplyThread> threads,
    {required bool push, required Map<String, String> written}) async {
  final plans = await planDrafts(mailbox, threads, written: written);
  final counts = {for (final step in DraftStep.values) step: 0};
  for (final (:thread, :step, :want, :draftId, :sentByHand) in plans) {
    final t = thread;
    final where = '${t.sender} [${t.threadId}]';
    if (sentByHand) {
      stdout.writeln('  ✓ $where: odpowiedź już wysłana z Gmaila — szkicu nie zakładam, '
          'etykiety przestawi reply --push');
      continue;
    }
    counts[step] = counts[step]! + 1;
    switch (step) {
      case DraftStep.none || DraftStep.edited:
        break;
      case DraftStep.keep:
        // Zgodny z przeglądem — odtąd wolno go przeliczać jak wpisany przez nas.
        if (push) written[t.threadId] = want!;
      case DraftStep.create:
        stdout.writeln('  + $where: ${_describe(want!)}');
        if (push) {
          await mailbox.draftReplyTo(await mailbox.replyTarget(t.messageIds.last, to: t.sender), want);
          written[t.threadId] = want;
        }
      case DraftStep.rewrite:
        stdout.writeln('  ~ $where: przeliczam szkic — ${_describe(want!)}');
        if (push) {
          await mailbox.updateDraft(
              draftId!, await mailbox.replyTarget(t.messageIds.last, to: t.sender), want);
          written[t.threadId] = want;
        }
      case DraftStep.delete:
        stdout.writeln('  - $where: szkic bez odpowiedzi w planie — kasuję');
        if (push) {
          await mailbox.deleteDraft(draftId!);
          written.remove(t.threadId);
        }
      case DraftStep.differs:
        stdout.writeln(want == null
            ? '  ! $where: w szkicu jest tekst, a odpowiedzi tu już nie ma — skasuj go w Gmailu'
            : '  ! $where: szkic różni się od przeglądu — popraw go w Gmailu albo skasuj, '
                'a review --push założy nowy');
      case DraftStep.manual:
        if (want != null) stdout.writeln('  ! $where: szkic ruszony ręcznie — zostawiam');
    }
  }

  final changed = counts[DraftStep.create]! + counts[DraftStep.rewrite]! + counts[DraftStep.delete]!;
  if (changed == 0 && counts[DraftStep.differs]! == 0) return 0;
  stdout.writeln(sentence([
    '${push ? 'Szkice' : 'Szkice (na sucho)'}: '
        '${plural(counts[DraftStep.create]!, 'nowy', 'nowe', 'nowych')}',
    if (counts[DraftStep.rewrite]! > 0)
      plural(counts[DraftStep.rewrite]!, 'przeliczony', 'przeliczone', 'przeliczonych'),
    if (counts[DraftStep.delete]! > 0)
      plural(counts[DraftStep.delete]!, 'skasowany', 'skasowane', 'skasowanych'),
    if (counts[DraftStep.differs]! > 0)
      plural(counts[DraftStep.differs]!, 'do sprawdzenia', 'do sprawdzenia', 'do sprawdzenia'),
  ]));
  return changed;
}

/// Czy ostatnia wiadomość wątku to nasza wysłana odpowiedź z tym, na co
/// wątek czeka ([sentCovers]).
Future<bool> _alreadySent(Mailbox mailbox, String threadId, {required bool expectsNote}) async {
  final summary = await mailbox.threadSummary(threadId);
  if (!summary.ourReplyIsLatest) return false;
  final last = await mailbox.getMessages([summary.messageIds.last]);
  return sentCovers(last.single.body, expectsNote: expectsNote);
}

String _describe(String text) {
  final withNote = replyNoteOf(text).trim().isNotEmpty;
  final withBlock = carriesOldAppBlock(text);
  return withNote
      ? withBlock ? 'odpowiedź + blok o starej apce' : 'odpowiedź'
      : 'sam blok o starej apce';
}

// ---------------------------------------------------------------------------
// Wysyłka
// ---------------------------------------------------------------------------

/// `reply`: szkice z kolejki odpowiedzi (`reply/*`) w świat — z Twoimi
/// poprawkami z Gmaila, jeśli są. Kolejka jest jedna, dla wszystkich
/// przebiegów. Wysłana odpowiedź — przez narzędzie albo ręcznie z Gmaila —
/// zdejmuje kolejkę tylko ze **swojego** wątku: blok o starej apce należy się
/// każdemu wątkowi ze starej apki, nie raz autorowi. [limit] — najwyżej tyle
/// mejli (Gmail tnie ok. 500 na dobę).
/// Zwraca, w ilu wątkach coś się nie udało — te zostają w kolejce.
Future<int> sendReplies(Mailbox mailbox, {required bool push, int? limit}) async {
  final queued = await mailbox.listIds(anyLabelQuery(kReplyQueueLabels));
  if (queued.isEmpty) {
    stdout.writeln('Nikt nie czeka na odpowiedź.');
    return 0;
  }
  final expectsNote = (await mailbox.listIds(labelQuery(SongLabel.replyReviewNote.label))).toSet();
  final byThread = <String, List<String>>{};
  for (final id in queued) {
    byThread.putIfAbsent(mailbox.threadOf(id), () => []).add(id);
  }
  final drafts = await mailbox.draftIdByThread();

  var sent = 0, byHand = 0, skipped = 0, failed = 0;
  for (final MapEntry(key: thread, value: ids) in byThread.entries) {
    if (limit != null && sent >= limit) {
      stdout.writeln('  (w kolejce czekają kolejne — `-n` ${emailCount(limit)})');
      break;
    }
    final summary = await mailbox.threadSummary(thread);
    final author = emailFromHeader(summary.from) ?? summary.from;
    final where = '$author  ${summary.subject}  [$thread]';
    final withNote = ids.any(expectsNote.contains);
    final labels = labelsAfterReply(sentReviewNote: withNote);
    try {
      final draftId = drafts[thread];
      if (draftId == null) {
        if (summary.ourReplyIsLatest) {
          // Szkicu nie ma, a ostatnie słowo w wątku jest nasze — wysłany
          // ręcznie z Gmaila. Drugiego mejla autor dostać nie może.
          stdout.writeln('  ✓ $where: już odpisane ręcznie');
          byHand++;
          if (push) await mailbox.batchModify(ids, add: labels.$1, remove: labels.$2);
        } else {
          stdout.writeln('  ! $where: brak szkicu — odpisz z Gmaila '
              '(w otwartym przebiegu szkic odtworzy review --push)');
          skipped++;
        }
        continue;
      }
      final body = await mailbox.draftBody(draftId);
      if (staleDraftReason(body, expectsNote: withNote) case final reason?) {
        stdout.writeln('  ! $where: $reason');
        skipped++;
        continue;
      }
      stdout.writeln('  → $where: ${_describe(body!)}');
      sent++;
      if (push) {
        await mailbox.sendDraft(draftId);
        // Zaraz po wysyłce, żeby ewentualna wywrotka nie kosztowała drugiego mejla.
        await mailbox.batchModify(ids, add: labels.$1, remove: labels.$2);
      }
    } catch (e) {
      // Etykieta zostaje, więc następny przebieg spróbuje jeszcze raz.
      stderr.writeln('  ! $where: $e');
      failed++;
    }
  }
  stdout.writeln(sentence([
    '${push ? 'Wysłano' : 'Do wysłania'} ${plural(sent, 'odpowiedź', 'odpowiedzi', 'odpowiedzi')}',
    if (byHand > 0) plural(byHand, 'już odpisana ręcznie', 'już odpisane ręcznie', 'już odpisanych ręcznie'),
    if (skipped > 0) '$skipped do ogarnięcia (zostają w kolejce)',
    if (failed > 0) '${plural(failed, 'nieudana', 'nieudane', 'nieudanych')} (zostają w kolejce)',
  ]));
  return failed;
}

/// Dlaczego szkicu **nie** wolno wysłać — `null`, gdy wolno.
///
/// Wolno tylko nasz szkic (powitanie na początku, „Czuwaj!” i stopka na końcu)
/// z tym, na co wątek czeka. Czeka na tekst z przeglądu ([expectsNote]) —
/// w szkicu ma być poza ramką jakikolwiek tekst: Twoje poprawki w środku,
/// także samego tekstu, idą w świat. Czeka tylko na blok o starej apce —
/// tekstu ma nie być. Inaczej to szkic sprzed przeglądu albo z tekstem, który
/// przegląd wycofał; wysłany, zgubiłby albo przemycił tekst do autora po
/// cichu, a etykiety mówiłyby, że wszystko poszło.
String? staleDraftReason(String? body, {required bool expectsNote}) {
  if (body == null) return 'szkic nieczytelny — wyślij go z Gmaila albo skasuj';
  if (!isToolShapedReply(body)) {
    return 'szkic nie w naszym kształcie (pisany ręcznie?) — wyślij go z Gmaila albo skasuj';
  }
  final hasNote = replyNoteOf(body).trim().isNotEmpty;
  if (expectsNote && !hasNote) {
    return 'w szkicu nie ma tekstu z przeglądu — review --push go przeliczy';
  }
  if (!expectsNote && hasNote) {
    return 'w szkicu jest tekst, a wątek czeka tylko na blok o starej apce '
        '(tekst wycofany przy przeglądzie?) — wyślij go z Gmaila, jeśli to Twój, albo skasuj';
  }
  return null;
}

/// Czy wysłana odpowiedź [body] niesie to, na co wątek czeka: tekst
/// z przeglądu ([expectsNote]), a bez niego — blok o starej apce. Po tym
/// poznajemy szkic wysłany ręcznie z Gmaila, także poprawiony przed wysyłką.
/// Sam blok wysłany wcześniej tekstu z przeglądu nie zastępuje.
bool sentCovers(String body, {required bool expectsNote}) =>
    isToolShapedReply(body) &&
    (expectsNote ? replyNoteOf(body).trim().isNotEmpty : carriesOldAppBlock(body));

/// Białe znaki zbite do spacji: Gmail potrafi przełamać linie szkicu.
String _squash(String s) => s.replaceAll(RegExp(r'\s+'), ' ').trim();

/// Podsumowanie: pierwsza część i niezerowe dodatki po przecinku.
String sentence(List<String> parts) => '${parts.join(', ')}.';
