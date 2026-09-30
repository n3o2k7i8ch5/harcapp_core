import 'dart:convert';

import 'package:piosenkomat/mailbox.dart';
import 'package:piosenkomat/model.dart';
import 'package:harcapp_core/values/strings.dart';

/// Wiadomość w skrzynce na niby.
class FakeMail {
  final String id;
  final String threadId;
  final String from;
  final String subject;
  final String body;
  /// Cały mejl (`.eml`) — gdy test potrzebuje prawdziwego zgłoszenia
  /// z załącznikiem. Wtedy temat i nadawca są z niego.
  final String? raw;
  /// Nasza wysłana (`SENT`).
  final bool sent;
  final Set<String> labels;

  FakeMail(this.id, this.threadId,
      {String from = 'Jan <jan@example.com>',
      String subject = 'Nowa piosenka',
      this.body = '',
      this.raw,
      this.sent = false,
      Set<String>? labels})
      : labels = labels ?? {},
        from = raw == null ? from : ContribMessage.fromEml(raw, id: id).from ?? from,
        subject = raw == null ? subject : ContribMessage.fromEml(raw, id: id).subject ?? subject;
}

/// Skrzynka w pamięci — tyle Gmaila, ile potrzebują komendy. Query rozumie
/// tylko to, co one wysyłają: [labelQuery] (kilka w [anyLabelQuery] to
/// „albo”), `-`[labelQuery] i `-subject:"…"`. Resztę kolejki (tematy,
/// znaczniki) uznaje za spełnioną — w skrzynce na niby są same zgłoszenia.
class FakeMailbox implements Mailbox {
  final List<FakeMail> mails = [];
  final Map<String, ({String threadId, String body})> drafts = {};
  /// Adresat każdego szkicu (`To:`), po id szkicu.
  final Map<String, String> draftTo = {};
  /// Treści wysłanych przez nas odpowiedzi, w kolejności.
  final List<({String threadId, String text})> sentTexts = [];
  var _next = 0;

  FakeMail add(FakeMail m) {
    mails.add(m);
    return m;
  }

  FakeMail _mail(String id) => mails.firstWhere((m) => m.id == id);

  @override
  String threadOf(String messageId) =>
      mails.where((m) => m.id == messageId).firstOrNull?.threadId ?? messageId;

  @override
  Future<List<String>> listIds(String query, {int? limit, bool newest = false}) async {
    final labels = [
      for (final m in RegExp(r'(?<!-)label:(\S+?)(?=\)|\s|$)').allMatches(query)) m[1]!,
    ];
    final withoutLabels = {
      for (final m in RegExp(r'-label:(\S+)').allMatches(query)) m[1]!,
    };
    final withoutSubjects = [
      for (final m in RegExp(r'-subject:"([^"]+)"').allMatches(query)) m[1]!,
    ];
    var ids = [
      for (final m in mails)
        if ((labels.isEmpty || labels.any((l) => m.labels.map(labelQueryName).contains(l))) &&
            !m.labels.map(labelQueryName).any(withoutLabels.contains) &&
            !withoutSubjects.any(m.subject.contains))
          m.id,
    ];
    if (newest) ids = ids.reversed.toList();
    return limit == null ? ids : ids.take(limit).toList();
  }

  @override
  Future<List<ContribMessage>> getMessages(List<String> ids,
          {void Function(int done, int total)? onProgress}) async =>
      [
        for (final id in ids)
          if (_mail(id) case final m)
            m.raw == null
                ? ContribMessage(id: m.id, threadId: m.threadId, body: m.body, subject: m.subject, from: m.from, labels: m.labels)
                : ContribMessage.fromEmlBytes(utf8.encode(m.raw!), id: m.id, threadId: m.threadId, labels: m.labels),
      ];

  @override
  Future<Map<String, List<String>>> sentIdsByThread() async {
    final out = <String, List<String>>{};
    for (final m in mails.where((m) => m.sent)) {
      out.putIfAbsent(m.threadId, () => []).add(m.id);
    }
    return out;
  }

  @override
  Future<Map<String, Set<String>>> songLabelsByMessage() async => {
        for (final m in mails)
          if (m.labels.where(isSongLabel).toSet() case final l when l.isNotEmpty) m.id: l,
      };

  @override
  Future<void> ensureToolLabels() async {}

  @override
  Future<void> batchModify(List<String> messageIds, {List<String>? add, List<String>? remove}) async {
    for (final id in messageIds) {
      final m = _mail(id);
      m.labels
        ..removeAll(remove ?? const [])
        ..addAll(add ?? const []);
    }
  }

  @override
  Future<ReplyTarget> replyTarget(String messageId, {required String to}) async {
    final m = _mail(messageId);
    return ReplyTarget(messageId: m.id, threadId: m.threadId, to: to, subject: m.subject);
  }

  @override
  Future<ThreadSummary> threadSummary(String threadId) async {
    final inThread = [for (final m in mails) if (m.threadId == threadId) m];
    return ThreadSummary.fromSent(
      threadId,
      [for (final m in inThread) (id: m.id, sent: m.sent)],
      subject: inThread.firstOrNull?.subject ?? '',
      from: inThread.firstOrNull?.from ?? '',
    );
  }

  void _send(String threadId, String text) {
    sentTexts.add((threadId: threadId, text: text));
    add(FakeMail('sent${_next++}', threadId, from: '$kHarcappEmail', body: text, sent: true));
  }

  @override
  Future<String> draftReplyTo(ReplyTarget target, String text) async {
    final id = 'draft${_next++}';
    drafts[id] = (threadId: target.threadId, body: text);
    draftTo[id] = target.to;
    return id;
  }

  @override
  Future<Map<String, String>> draftIdByThread() async =>
      {for (final e in drafts.entries) e.value.threadId: e.key};

  @override
  Future<void> updateDraft(String draftId, ReplyTarget target, String text) async {
    drafts[draftId] = (threadId: target.threadId, body: text);
    draftTo[draftId] = target.to;
  }

  @override
  Future<String?> draftBody(String draftId) async => drafts[draftId]?.body;

  @override
  Future<void> deleteDraft(String draftId) async => drafts.remove(draftId);

  @override
  Future<void> sendDraft(String draftId) async {
    final d = drafts.remove(draftId)!;
    _send(d.threadId, d.body);
  }
}
