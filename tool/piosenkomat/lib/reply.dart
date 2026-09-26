import 'dart:io';

import 'package:harcapp_core/song_book/contrib_reply.dart';

import 'classify.dart';
import 'gmail.dart';
import 'model.dart';

/// Mejl z kolejki `reply`: jego id i wątek, w którym leży.
typedef QueuedMessage = ({String id, String threadId});

/// Jeden mejl `reply`: odpowiedź w wątku **jednej** piosenki, żeby uwaga była
/// przy piosence, a odpowiedź autora wracała do właściwego wątku.
class PlannedReply {
  final String sender;
  final String threadId;
  /// Wiadomości tego wątku z kolejki — po wysyłce zmieniają etykiety.
  final List<String> messageIds;
  /// Twój tekst z przeglądu; `null` = mejl z samym blokiem o starej apce.
  final String? reviewNote;
  /// Wątek ze starej apki — blok o niej idzie w środku.
  final bool oldApp;
  /// Wiadomości autora z innych wątków, które czekały tylko na blok o starej
  /// apce. Ten mejl go niesie, więc `reply/old-app` schodzi też z nich.
  final List<String> alsoClearsOldApp;

  const PlannedReply({
    required this.sender,
    required this.threadId,
    required this.messageIds,
    required this.reviewNote,
    required this.oldApp,
    this.alsoClearsOldApp = const [],
  });

  /// Odpowiadamy na najnowszą wiadomość wątku.
  String get targetMessageId => messageIds.last;

  String get text => composeContribReply(reviewNote: reviewNote, oldApp: oldApp)!;

  LabelChange get labels => labelsAfterReply(sentReviewNote: reviewNote != null);
}

/// Odpowiedzi jednego autora i to, na co nie ma czego napisać.
typedef AuthorReplies = ({List<PlannedReply> replies, List<String> nothingToSay});

/// Plan odpowiedzi jednego autora: mejl w każdym wątku, do którego napisałeś
/// odpowiedź w przeglądzie. Blok o starej apce idzie w każdej odpowiedzi
/// w wątku ze starej apki; gdy żadna go nie niesie, a autor na niego czeka —
/// jeden mejl z samym blokiem, w jego najnowszym takim wątku.
///
/// [messages] od najstarszego. [reviewNotes]: id wątku → tekst z przeglądu.
/// W [AuthorReplies.nothingToSay] lądują wiadomości, dla których nie ma ani
/// tekstu, ani starej apki — ich etykiety zostają, żeby sprawa nie zginęła.
AuthorReplies planAuthorReplies(
  String sender,
  List<QueuedMessage> messages, {
  required Map<String, String> reviewNotes,
  required Set<String> oldAppIds,
}) {
  // Wątki w kolejności najnowszej wiadomości: `messages` jest od najstarszego.
  final byThread = <String, List<String>>{};
  for (final m in messages) {
    // Wyjęcie i wstawienie przesuwa wątek na koniec mapy.
    final ids = byThread.remove(m.threadId) ?? [];
    byThread[m.threadId] = ids..add(m.id);
  }

  String? noteOf(String threadId) {
    final note = reviewNotes[threadId]?.trim() ?? '';
    return note.isEmpty ? null : note;
  }
  bool isOldApp(List<String> ids) => ids.any(oldAppIds.contains);

  final replies = <PlannedReply>[];
  final waitingForBlock = <MapEntry<String, List<String>>>[];
  final nothingToSay = <String>[];
  for (final e in byThread.entries) {
    final note = noteOf(e.key);
    final oldApp = isOldApp(e.value);
    if (note != null) {
      replies.add(PlannedReply(
          sender: sender, threadId: e.key, messageIds: e.value, reviewNote: note, oldApp: oldApp));
    } else if (oldApp) {
      waitingForBlock.add(e);
    } else {
      nothingToSay.addAll(e.value);
    }
  }

  if (waitingForBlock.isNotEmpty) {
    final carrierIndex = replies.lastIndexWhere((r) => r.oldApp);
    if (carrierIndex >= 0) {
      final carrier = replies[carrierIndex];
      replies[carrierIndex] = PlannedReply(
        sender: sender,
        threadId: carrier.threadId,
        messageIds: carrier.messageIds,
        reviewNote: carrier.reviewNote,
        oldApp: true,
        alsoClearsOldApp: [for (final e in waitingForBlock) ...e.value],
      );
    } else {
      final latest = waitingForBlock.last;
      replies.add(PlannedReply(
        sender: sender,
        threadId: latest.key,
        messageIds: latest.value,
        reviewNote: null,
        oldApp: true,
        alsoClearsOldApp: [
          for (final e in waitingForBlock)
            if (e.key != latest.key) ...e.value,
        ],
      ));
    }
  }
  return (replies: replies, nothingToSay: nothingToSay);
}

// ---------------------------------------------------------------------------
// Silnik `reply`: kolejka z Gmaila, szkice, wysyłka
// ---------------------------------------------------------------------------

/// Kolejka `reply` pogrupowana po autorze.
class ReplyQueue {
  /// Mejle każdego autora, od najstarszego.
  final Map<String, List<String>> bySender;
  final Map<String, ReplyTarget> replyTargetById;
  final int unknownSenderCount;
  /// `-n` uciął kolejkę: czekają kolejni autorzy.
  final bool truncated;

  const ReplyQueue(this.bySender, this.replyTargetById,
      {required this.unknownSenderCount, required this.truncated});

  List<String> get senders => bySender.keys.toList()..sort();
}

/// Nadawcy nie da się poznać bez nagłówka, a ten kosztuje 20 jednostek, więc
/// przy `-n` przestajemy czytać, gdy mamy już tylu autorów, ilu obsłużymy.
Future<ReplyQueue> groupBySender(
  GmailMailbox mailbox,
  List<String> ids, {
  required String query,
  required int? limit,
  required bool Function(String) inScope,
}) async {
  final bySender = <String, List<String>>{};
  final replyTargetById = <String, ReplyTarget>{};
  var unknownSenderCount = 0;
  var truncated = false;
  for (final id in ids) {
    if (limit != null && bySender.length >= limit) {
      truncated = true;
      break;
    }
    final target = await mailbox.replyTarget(id);
    replyTargetById[id] = target;
    final sender = emailFromHeader(target.to);
    if (sender == null || sender == kInboxEmail) {
      unknownSenderCount++;
      continue;
    }
    bySender.putIfAbsent(sender, () => []).add(id);
  }
  // Urwany przegląd zna tylko część mejli wybranych autorów, a etykieta musi
  // zejść ze wszystkich. Reszta to jedno zapytanie na autora zamiast czytania
  // nagłówków całej kolejki.
  if (truncated) {
    for (final sender in bySender.keys.toList()) {
      // Nawiasy, bo `--query` z `OR` bez nich łapałby cudze mejle:
      // `a OR b from:x` to dla Gmaila `a OR (b from:x)`. Zakres jak na
      // starcie: bez tego mejl autora z innego przebiegu straciłby etykietę,
      // a uwaga do niego (w cudzym `decisions.json`) nigdy by nie wyszła.
      bySender[sender] = [
        for (final id in await mailbox.listIds('($query) from:$sender'))
          if (inScope(id)) id,
      ];
      for (final id in bySender[sender]!) {
        replyTargetById[id] ??= await mailbox.replyTarget(id);
      }
    }
  }
  return ReplyQueue(bySender, replyTargetById,
      unknownSenderCount: unknownSenderCount, truncated: truncated);
}

void printReplyQueue(ReplyQueue queue, Map<String, AuthorReplies> plans) {
  for (final sender in queue.senders) {
    final plan = plans[sender]!;
    stdout.writeln('  → $sender  ${plural(plan.replies.length, 'odpowiedź', 'odpowiedzi', 'odpowiedzi')}');
    for (final r in plan.replies) {
      final what = r.reviewNote == null
          ? 'sam blok o starej apce'
          : r.oldApp ? 'odpowiedź + blok o starej apce' : 'odpowiedź';
      stdout.writeln('      wątek [${r.threadId}]  $what');
    }
    if (plan.nothingToSay.isNotEmpty) {
      stdout.writeln('      ${plural(plan.nothingToSay.length, 'mejl', 'mejle', 'mejli')} '
          'bez tekstu z przeglądu — etykieta zostaje');
    }
  }
  if (queue.truncated) {
    stdout.writeln('  (w kolejce czekają kolejni autorzy — `-n` bierze najstarszych)');
  }
  if (queue.unknownSenderCount > 0) {
    stdout.writeln('Pomijam ${plural(queue.unknownSenderCount, 'mejl', 'mejle', 'mejli')} '
        'bez czytelnego nadawcy; etykieta zostaje.');
  }
}

/// Jedno odpalenie `reply --push`: kolejka i plan — mejl na piosenkę, w jej
/// wątku ([planAuthorReplies]).
class ReplyRun {
  final GmailMailbox mailbox;
  final ReplyQueue queue;
  final Map<String, AuthorReplies> plans;
  final Map<String, String> draftIdByThread;

  ReplyRun({
    required this.mailbox,
    required this.queue,
    required this.plans,
    required this.draftIdByThread,
  });

  Iterable<PlannedReply> get _replies => plans.values.expand((a) => a.replies);

  int get _nothingToSay => plans.values.fold(0, (n, a) => n + a.nothingToSay.length);

  ReplyTarget _targetOf(PlannedReply r) => queue.replyTargetById[r.targetMessageId]!;

  /// Etykiety po wysyłce: wątek odpowiedzi plus wątki, które czekały tylko na
  /// blok o starej apce, a ten poszedł tym mejlem.
  Future<void> _relabel(PlannedReply r) async {
    final (add, remove) = r.labels;
    await mailbox.batchModify(r.messageIds, add: add, remove: remove);
    if (r.alsoClearsOldApp.isNotEmpty) {
      await mailbox.batchModify(r.alsoClearsOldApp, add: const [], remove: [kLabelReplyOldApp]);
    }
  }

  Future<void> undraftAll(Set<String> draftIds) async {
    var removed = 0;
    var failed = 0;
    for (final draftId in draftIds) {
      try {
        await mailbox.deleteDraft(draftId);
      } catch (e) {
        stderr.writeln('  ! szkic $draftId: $e');
        failed++;
        continue;
      }
      removed++;
    }
    stdout
      ..writeln(sentence([
        'Sprzątnięto ${plural(removed, 'szkic', 'szkice', 'szkiców')}',
        if (failed > 0) plural(failed, 'nieudany', 'nieudane', 'nieudanych'),
      ]))
      ..writeln('Nikt nic nie dostał — autorzy zostają w kolejce `reply`.');
  }

  Future<void> draftAll() async {
    var created = 0;
    var updated = 0;
    var unchanged = 0;
    var failed = 0;
    for (final r in _replies) {
      final text = r.text;
      final where = '${r.sender} [${r.threadId}]';
      try {
        if (draftIdByThread[r.threadId] case final draftId?) {
          // Szkic w tym wątku już jest. Przeliczamy go od nowa — ale tylko
          // szkic w naszym kształcie; Twoją ręczną robotę zostawiamy.
          final body = await mailbox.draftBody(draftId);
          switch (draftActionFor(body, text)) {
            case DraftAction.unchanged:
              unchanged++;
            case DraftAction.rewrite:
              // Akapity, których w nowej treści nie będzie, wypisujemy — to
              // Twoja jedyna szansa, żeby zobaczyć, co wypadło.
              final dropped = paragraphsDroppedBy(body!, text);
              await mailbox.updateDraft(draftId, _targetOf(r), text);
              updated++;
              for (final paragraph in dropped) {
                stdout.writeln('  ~ $where: ze szkicu wypadło: „$paragraph”');
              }
            case DraftAction.leaveManual:
              stdout.writeln('  ~ $where: szkic '
                  '${body == null ? 'nieczytelny' : 'ruszony ręcznie'} — zostawiam jak jest');
              unchanged++;
          }
          continue;
        }
        await mailbox.draftReplyTo(_targetOf(r), text);
      } catch (e) {
        // Bez szkicu, więc następny przebieg spróbuje jeszcze raz.
        stderr.writeln('  ! $where: $e');
        failed++;
        continue;
      }
      created++;
    }
    stdout.writeln(sentence([
      'Przygotowano ${plural(created, 'szkic', 'szkice', 'szkiców')}',
      if (updated > 0) plural(updated, 'zaktualizowany', 'zaktualizowane', 'zaktualizowanych'),
      if (unchanged > 0) '$unchanged bez zmian',
      if (_nothingToSay > 0) '$_nothingToSay bez treści (pominięte)',
      if (failed > 0)
        '${plural(failed, 'nieudany', 'nieudane', 'nieudanych')} (zostają w kolejce)',
    ]));
    if (created + updated + unchanged > 0) {
      stdout.writeln('Przejrzyj i popraw w Gmailu, potem: ./piosenkomat reply --push');
    }
  }

  Future<void> sendAll() async {
    var sent = 0;
    var repliedByHand = 0;
    var failed = 0;
    for (final r in _replies) {
      try {
        if (draftIdByThread[r.threadId] case final draftId?) {
          // Z Twoimi poprawkami, jeśli jakieś zrobiłeś.
          await mailbox.sendDraft(draftId);
        } else if (await mailbox.ourReplyIsLatest(r.threadId)) {
          // Szkic zniknął, a ostatnie słowo w wątku jest nasze — wysłany
          // ręcznie z Gmaila. Drugiego mejla autor dostać nie może. Jeśli od
          // tamtej pory autor odpisał, to nowa sprawa: składamy mejl normalnie.
          await _relabel(r);
          repliedByHand++;
          continue;
        } else {
          await mailbox.replyTo(_targetOf(r), r.text);
        }
      } catch (e) {
        // Etykieta zostaje, więc następny przebieg spróbuje jeszcze raz.
        stderr.writeln('  ! ${r.sender} [${r.threadId}]: $e');
        failed++;
        continue;
      }
      sent++;
      // Zaraz po wysyłce, żeby ewentualna wywrotka nie kosztowała drugiego mejla.
      await _relabel(r);
    }
    stdout.writeln(sentence([
      'Wysłano ${plural(sent, 'odpowiedź', 'odpowiedzi', 'odpowiedzi')}',
      if (repliedByHand > 0)
        plural(repliedByHand, 'już odpisany ręcznie', 'już odpisane ręcznie',
            'już odpisanych ręcznie'),
      if (_nothingToSay > 0) '$_nothingToSay bez treści (pominięte)',
      if (failed > 0)
        '${plural(failed, 'nieudany', 'nieudane', 'nieudanych')} (zostają w kolejce)',
    ]));
  }
}

/// Podsumowanie: pierwsza część i niezerowe dodatki po przecinku.
String sentence(List<String> parts) => '${parts.join(', ')}.';
