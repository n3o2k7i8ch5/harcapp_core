import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/contrib_reply.dart';

import 'mailbox.dart';
import 'model.dart';

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

/// Treść odpowiedzi w każdym wątku jednego autora, po id wątku. Każdy tekst
/// z przeglądu to mejl w swoim wątku; w wątku ze starej apki niesie blok o niej.
/// Gdy żaden go nie niesie, a autor na niego czeka — jeden mejl z samym
/// blokiem, w najnowszym takim wątku. [threads] od najstarszego.
///
/// [blockElsewhere]: autor czeka już na blok w wątku spoza przebiegu — tam
/// go dostanie, więc tutaj go nie ma. Blok idzie raz na autora.
Map<String, String> wantedReplies(List<ReplyThread> threads, {bool blockElsewhere = false}) {
  final out = <String, String>{
    for (final t in threads)
      if (t.note != null)
        t.threadId: composeContribReply(reviewNote: t.note, oldApp: t.oldApp && !blockElsewhere)!,
  };
  final carried = threads.any((t) => t.note != null && t.oldApp);
  final waiting = [for (final t in threads) if (t.oldApp && t.note == null) t];
  if (!blockElsewhere && !carried && waiting.isNotEmpty) {
    out[waiting.last.threadId] = composeContribReply(oldApp: true)!;
  }
  return out;
}

/// Co zrobić ze szkicem w wątku.
enum DraftStep {
  /// Nic tu nie ma i nie ma być.
  none,
  create,
  /// Szkic już taki, jaki ma być.
  keep,
  /// Szkic bez ludzkiego tekstu (sama ramka i blok) — wolno go przeliczyć.
  rewrite,
  /// Szkic bez ludzkiego tekstu w wątku, w którym odpowiedzi ma nie być.
  delete,
  /// Szkic z tekstem inny niż plan — Twój; zostaje, a narzędzie mówi o różnicy.
  differs,
  /// Szkic nie w naszym kształcie albo nieczytelny — zostaje nietknięty.
  manual,
}

/// Jedna reguła dla każdego szkicu: narzędzie rusza tylko szkic, w którym nie
/// ma ludzkiego tekstu — samą ramkę i blok o starej apce. Szkic z tekstem jest
/// Twój, choćby tekst przyszedł z przeglądu: poprawki w Gmailu nie mogą
/// zniknąć przy kolejnym `review --push`. [body] `null` przy [exists] —
/// szkicu nie da się odczytać; [want] `null` — odpowiedzi ma tu nie być.
DraftStep draftStep({required bool exists, String? body, String? want}) {
  if (!exists) return want == null ? DraftStep.none : DraftStep.create;
  if (body == null || !isToolShapedReply(body)) return DraftStep.manual;
  final text = _squash(replyNoteOf(body));
  if (want == null) return text.isEmpty ? DraftStep.delete : DraftStep.differs;
  if (_squash(body) == _squash(want)) return DraftStep.keep;
  // Sam tekst się zgadza, różni się ramka (np. doszedł blok) — przeliczenie
  // niczego Twojego nie zmieni.
  if (text.isEmpty || text == _squash(replyNoteOf(want))) return DraftStep.rewrite;
  return DraftStep.differs;
}

/// Szkice wątków przebiegu takie, jak mają być ([wantedReplies] per autor,
/// [draftStep] per wątek). Bez [push] tylko wypisuje, co by zrobił.
Future<void> syncDrafts(Mailbox mailbox, List<ReplyThread> threads, {required bool push}) async {
  final drafts = await mailbox.draftIdByThread();
  final runMessages = {for (final t in threads) ...t.messageIds};
  final bySender = <String, List<ReplyThread>>{};
  for (final t in threads) {
    bySender.putIfAbsent(t.sender, () => []).add(t);
  }

  final counts = {for (final step in DraftStep.values) step: 0};
  for (final MapEntry(key: sender, value: own) in bySender.entries) {
    final relevant = own.any((t) => t.oldApp || t.note != null || drafts.containsKey(t.threadId));
    if (!relevant) continue;
    // Blok raz na autora: czeka na niego wątek z innego przebiegu? Tam go
    // dostanie, a wysłany zdejmie `reply/old-app` ze wszystkich wątków.
    final blockElsewhere = own.any((t) => t.oldApp) &&
        (await mailbox.listIds('label:${labelQueryName(SongLabel.replyOldApp.label)} from:$sender'))
            .any((id) => !runMessages.contains(id));
    final wanted = wantedReplies(own, blockElsewhere: blockElsewhere);

    for (final t in own) {
      final draftId = drafts[t.threadId];
      final body = draftId == null ? null : await mailbox.draftBody(draftId);
      final want = wanted[t.threadId];
      final step = draftStep(exists: draftId != null, body: body, want: want);
      counts[step] = counts[step]! + 1;
      final where = '$sender [${t.threadId}]';
      switch (step) {
        case DraftStep.none || DraftStep.keep:
          break;
        case DraftStep.create:
          stdout.writeln('  + $where: ${_describe(want!)}');
          if (push) await mailbox.draftReplyTo(await mailbox.replyTarget(t.messageIds.last, to: sender), want);
        case DraftStep.rewrite:
          stdout.writeln('  ~ $where: przeliczam szkic — ${_describe(want!)}');
          if (push) {
            await mailbox.updateDraft(
                draftId!, await mailbox.replyTarget(t.messageIds.last, to: sender), want);
          }
        case DraftStep.delete:
          stdout.writeln('  - $where: szkic bez odpowiedzi w planie — kasuję');
          if (push) await mailbox.deleteDraft(draftId!);
        case DraftStep.differs:
          stdout.writeln(want == null
              ? '  ! $where: w szkicu jest tekst, a odpowiedzi tu już nie ma — skasuj go w Gmailu'
              : '  ! $where: szkic różni się od przeglądu — popraw go w Gmailu albo skasuj, '
                  'a review --push założy nowy');
        case DraftStep.manual:
          if (want != null) stdout.writeln('  ! $where: szkic ruszony ręcznie — zostawiam');
      }
    }
  }

  final changed = counts[DraftStep.create]! + counts[DraftStep.rewrite]! + counts[DraftStep.delete]!;
  if (changed == 0 && counts[DraftStep.differs]! == 0) return;
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
/// przebiegów. Blok o starej apce idzie raz na autora: wysłany — przez
/// narzędzie albo ręcznie z Gmaila — zdejmuje `reply/old-app` ze **wszystkich**
/// wątków autora. [limit] — najwyżej tyle mejli (Gmail tnie ok. 500 na dobę).
Future<void> sendReplies(Mailbox mailbox, {required bool push, int? limit}) async {
  final oldApp = labelQueryName(SongLabel.replyOldApp.label);
  final reviewNote = labelQueryName(SongLabel.replyReviewNote.label);
  final queued = await mailbox.listIds('(label:$oldApp OR label:$reviewNote)');
  if (queued.isEmpty) {
    stdout.writeln('Nikt nie czeka na odpowiedź.');
    return;
  }
  final waitsForBlock = (await mailbox.listIds('label:$oldApp')).toSet();
  final expectsNote = (await mailbox.listIds('label:$reviewNote')).toSet();
  final byThread = <String, List<String>>{};
  for (final id in queued) {
    byThread.putIfAbsent(mailbox.knownThreadOf(id) ?? id, () => []).add(id);
  }
  final drafts = await mailbox.draftIdByThread();
  final summaries = {for (final t in byThread.keys) t: await mailbox.threadSummary(t)};
  // Najpierw szkice, potem odpisane ręcznie, na końcu reszta: blok, który
  // poszedł, zdejmuje kolejkę z pozostałych wątków autora, zanim do nich
  // dojdzie kolej — nie ma ich wtedy po co zgłaszać.
  int order(String t) => drafts.containsKey(t) ? 0 : summaries[t]!.ourReplyIsLatest ? 1 : 2;
  final threads = [
    for (final rank in const [0, 1, 2]) ...byThread.keys.where((t) => order(t) == rank),
  ];
  // Mejle, którym blok poszedł w innym wątku — zostaje im tylko tekst z przeglądu.
  final blockSent = <String>{};
  Future<void> blockWentTo(String author) async {
    final waiting = await mailbox.listIds('label:$oldApp from:$author');
    blockSent.addAll(waiting);
    if (push && waiting.isNotEmpty) await mailbox.batchModify(waiting, remove: [SongLabel.replyOldApp.label]);
  }

  var sent = 0, byHand = 0, skipped = 0, failed = 0;
  for (final thread in threads) {
    final ids = [
      for (final id in byThread[thread]!)
        if (!blockSent.contains(id) || expectsNote.contains(id)) id,
    ];
    if (ids.isEmpty) continue;
    if (limit != null && sent >= limit) {
      stdout.writeln('  (w kolejce czekają kolejne — `-n` ${plural(limit, 'mejl', 'mejle', 'mejli')})');
      break;
    }
    final summary = summaries[thread]!;
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
          if (ids.any(waitsForBlock.contains)) await blockWentTo(author);
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
      if (carriesOldAppBlock(body)) await blockWentTo(author);
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

/// Białe znaki zbite do spacji: Gmail potrafi przełamać linie szkicu.
String _squash(String s) => s.replaceAll(RegExp(r'\s+'), ' ').trim();

/// Podsumowanie: pierwsza część i niezerowe dodatki po przecinku.
String sentence(List<String> parts) => '${parts.join(', ')}.';
