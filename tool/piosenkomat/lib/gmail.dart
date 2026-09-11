import 'dart:convert';
import 'dart:io';

import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'hrcpsng.dart';
import 'model.dart';

/// `modify` etykietuje, `send` odpisuje autorom ze starej apki. Zmiana tej
/// listy unieważnia zapisany token — trzeba zalogować się jeszcze raz.
final List<String> kGmailScopes = [
  GmailApi.gmailModifyScope,
  GmailApi.gmailSendScope,
];

String defaultCredentialsPath() => p.join('secrets', 'credentials.json');
String defaultTokenPath() => p.join('secrets', 'gmail_token.json');

class GmailMailbox {
  GmailMailbox(this._api);

  final GmailApi _api;
  final Map<String, String> _idByName = {};
  final Map<String, String> _nameById = {};
  DateTime _lastCall = DateTime.fromMillisecondsSinceEpoch(0);

  /// Gmail liczy limit w jednostkach na minutę. Trzymamy stałe tempo,
  /// a przy 403/429 czekamy i próbujemy jeszcze raz.
  Future<T> _call<T>(Future<T> Function() fn) async {
    const minGap = Duration(milliseconds: 60);
    var wait = const Duration(seconds: 5);
    for (var attempt = 1;; attempt++) {
      final since = DateTime.now().difference(_lastCall);
      if (since < minGap) await Future.delayed(minGap - since);
      _lastCall = DateTime.now();
      try {
        return await fn();
      } on DetailedApiRequestError catch (e) {
        final quota = e.status == 429
            || (e.status == 403 && (e.message ?? '').toLowerCase().contains('quota'));
        if (!quota || attempt >= 7) rethrow;
        stdout.writeln('Limit Gmail API, czekam ${wait.inSeconds}s…');
        await Future.delayed(wait);
        wait *= 2;
      }
    }
  }

  static Future<GmailMailbox> connect({
    required File credentialsFile,
    required File tokenFile,
  }) async {
    if (!credentialsFile.existsSync()) {
      throw FileSystemException(
          'Brak credentials.json, zobacz README', credentialsFile.path);
    }
    final clientId = _clientIdFromFile(credentialsFile);
    final mailbox = GmailMailbox(GmailApi(await _authClient(clientId, tokenFile)));
    await mailbox._loadLabels();
    return mailbox;
  }

  /// ID pasujące do [query]. Gmail zwraca od najnowszych; domyślnie
  /// bierzemy [limit] najstarszych.
  Future<List<String>> listIds(
    String query, {
    int? limit,
    bool newest = false,
  }) async {
    final ids = <String>[];
    String? page;
    do {
      final resp = await _call(() => _api.users.messages.list(
            'me',
            q: query,
            maxResults: 500,
            pageToken: page,
          ));
      ids.addAll([for (final m in resp.messages ?? const <Message>[]) m.id!]);
      page = resp.nextPageToken;
    } while (page != null && !(newest && limit != null && ids.length >= limit));

    if (limit == null) return newest ? ids : ids.reversed.toList();
    return newest
        ? ids.take(limit).toList()
        : ids.reversed.take(limit).toList();
  }

  Future<ContribMessage> getMessage(String id) async {
    final msg = await _call(() => _api.users.messages.get('me', id, format: 'full'));
    String? songAttachment;
    for (final part in msg.payload?.parts ?? const <MessagePart>[]) {
      final attId = part.body?.attachmentId;
      if (attId == null || !(part.filename ?? '').endsWith('.hrcpsng')) continue;
      final att = await _call(() => _api.users.messages.attachments.get('me', id, attId));
      if (att.data != null) songAttachment = _decode(att.data!);
      break;
    }
    final headers = _headersOf(msg.payload);
    return ContribMessage(
      id: msg.id ?? id,
      body: _plainText(msg.payload),
      subject: headers['subject'],
      from: headers['from'],
      isReply: (headers['in-reply-to'] ?? headers['references'] ?? '')
          .trim()
          .isNotEmpty,
      date: msg.internalDate == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              int.parse(msg.internalDate!), isUtc: true),
      labels: {
        for (final lid in msg.labelIds ?? const <String>[])
          _nameById[lid] ?? lid,
      },
      songAttachment: songAttachment,
    );
  }

  /// Odpowiedź w wątku [message]: ten sam `threadId`, `In-Reply-To`
  /// i `References`, żeby u autora wpadła pod jego zgłoszenie, a nie jako
  /// osobny mejl znikąd.
  Future<void> replyTo(ReplyTarget target, String text) async {
    final raw = _mimeReply(target, text);
    await _call(() => _api.users.messages.send(
          Message()
            ..raw = base64Url.encode(utf8.encode(raw))
            ..threadId = target.threadId,
          'me',
        ));
  }

  /// Dane potrzebne do odpowiedzi. Osobny strzał po nagłówki, bo
  /// [ContribMessage] ich nie niesie.
  Future<ReplyTarget> replyTarget(String messageId) async {
    final msg = await _call(() => _api.users.messages.get('me', messageId,
        format: 'metadata',
        metadataHeaders: ['From', 'Subject', 'Message-ID', 'References']));
    final headers = _headersOf(msg.payload);
    return ReplyTarget(
      messageId: msg.id ?? messageId,
      threadId: msg.threadId ?? messageId,
      to: headers['from'] ?? '',
      subject: headers['subject'] ?? '',
      rfcMessageId: headers['message-id'],
      references: headers['references'],
    );
  }

  /// Odpowiedź poszła: mejl schodzi z kolejki „do odpisania”.
  Future<void> markReplied(String messageId) => _modify(
        messageId,
        add: [_idByName[kLabelOldAppReplied]!],
        remove: [_idByName[kLabelOldAppToReply]!],
      );

  /// Nazwy etykiet mejla. Tylko metadane, bez treści.
  Future<Set<String>> labelsOf(String messageId) async {
    final msg = await _call(() => _api.users.messages.get('me', messageId, format: 'minimal'));
    return {
      for (final id in msg.labelIds ?? const <String>[]) _nameById[id] ?? id,
    };
  }

  Future<void> _loadLabels() async {
    final existing = await _call(() => _api.users.labels.list('me'));
    for (final l in existing.labels ?? const <Label>[]) {
      if (l.name == null || l.id == null) continue;
      _idByName[l.name!] = l.id!;
      _nameById[l.id!] = l.name!;
    }
  }

  /// Tworzy brakujące etykiety narzędzia. Ludzkich nie rusza.
  Future<void> ensureToolLabels() async {
    for (final name in kToolLabels) {
      if (_idByName.containsKey(name)) continue;
      final created = await _call(() => _api.users.labels.create(
            Label()
              ..name = name
              ..labelListVisibility = 'labelShow'
              ..messageListVisibility = 'show',
            'me',
          ));
      _idByName[name] = created.id!;
      _nameById[created.id!] = name;
    }
  }

  Future<void> addLabels(String messageId, Iterable<String> names) => _modify(
        messageId,
        add: [for (final n in names) _idByName[n]!],
      );

  /// Zdejmuje etykiety nadane przez pomyłkę (`unapply`). Nazw, których nie ma
  /// w skrzynce, nie ruszamy — nie ma czego zdejmować.
  Future<void> removeLabels(String messageId, Iterable<String> names) => _modify(
        messageId,
        remove: [
          for (final n in names)
            if (_idByName[n] case final id?) id,
        ],
      );

  /// Odrzucona po Twoim przeglądzie: schodzi „w pliku”, wchodzi powód.
  /// `Auto` zostaje, bo to automat ją zaproponował.
  Future<void> rejectAfterReview(String messageId) => _modify(
        messageId,
        add: [_idByName[kLabelRejectedAfterReview]!],
        remove: [_idByName[kLabelReady]!],
      );

  /// Gotowa do dodania → Zatwierdzona i dodana, przeczytane. `Auto` zostaje.
  Future<void> commitReady(String messageId) => _modify(
        messageId,
        add: [_idByName[kLabelDone]!],
        remove: [_idByName[kLabelReady]!, 'UNREAD'],
      );

  Future<void> _modify(
    String messageId, {
    List<String>? add,
    List<String>? remove,
  }) =>
      _call(() => _api.users.messages.modify(
            ModifyMessageRequest()
              ..addLabelIds = add
              ..removeLabelIds = remove,
            'me',
            messageId,
          ));
}

/// Mejl, na który odpisujemy, wraz z tym, co trzeba wpisać w nagłówki.
class ReplyTarget {
  final String messageId;
  final String threadId;
  final String to;
  final String subject;
  final String? rfcMessageId;
  final String? references;

  const ReplyTarget({
    required this.messageId,
    required this.threadId,
    required this.to,
    required this.subject,
    this.rfcMessageId,
    this.references,
  });
}

/// RFC 822 odpowiedzi. Temat i treść po polsku, więc base64 + UTF-8.
String _mimeReply(ReplyTarget target, String text) {
  final subject = target.subject.startsWith('Re:')
      ? target.subject
      : 'Re: ${target.subject}';
  final references = [
    if ((target.references ?? '').trim().isNotEmpty) target.references!.trim(),
    if (target.rfcMessageId != null) target.rfcMessageId!,
  ].join(' ');
  final headers = <String, String>{
    'To': target.to,
    'Subject': _encodeHeader(subject),
    if (target.rfcMessageId != null) 'In-Reply-To': target.rfcMessageId!,
    if (references.isNotEmpty) 'References': references,
    'MIME-Version': '1.0',
    'Content-Type': 'text/plain; charset="UTF-8"',
    'Content-Transfer-Encoding': 'base64',
  };
  final body = base64.encode(utf8.encode(text));
  return [
    for (final e in headers.entries) '${e.key}: ${e.value}',
    '',
    // Base64 w mejlu łamie się co 76 znaków.
    for (var i = 0; i < body.length; i += 76)
      body.substring(i, i + 76 > body.length ? body.length : i + 76),
  ].join('\r\n');
}

/// Nagłówek z polskimi znakami: RFC 2047.
String _encodeHeader(String value) => value.codeUnits.every((c) => c < 128)
    ? value
    : '=?UTF-8?B?${base64.encode(utf8.encode(value))}?=';

String _plainText(MessagePart? part) {
  if (part == null) return '';
  if (part.mimeType == 'text/plain' && part.body?.data != null) {
    return _decode(part.body!.data!);
  }
  for (final child in part.parts ?? const <MessagePart>[]) {
    final text = _plainText(child);
    if (text.trim().isNotEmpty) return text;
  }
  if (part.body?.data != null) return _decode(part.body!.data!);
  return '';
}

String _decode(String data) => utf8.decode(base64.decode(base64.normalize(data)));

/// Nagłówki po małych literach: `subject`, `from`, `in-reply-to`…
Map<String, String> _headersOf(MessagePart? part) => {
      for (final h in part?.headers ?? const <MessagePartHeader>[])
        if (h.name != null && h.value != null) h.name!.toLowerCase(): h.value!,
    };

ClientId _clientIdFromFile(File file) {
  final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final installed = (json['installed'] ?? json['web']) as Map<String, dynamic>;
  return ClientId(
    installed['client_id'] as String,
    installed['client_secret'] as String?,
  );
}

Future<AutoRefreshingAuthClient> _authClient(ClientId id, File tokenFile) async {
  if (tokenFile.existsSync()) {
    final json = jsonDecode(tokenFile.readAsStringSync()) as Map<String, dynamic>;
    final credentials = AccessCredentials(
      AccessToken(
        json['token_type'] as String? ?? 'Bearer',
        json['access_token'] as String,
        DateTime.parse(json['expiry'] as String),
      ),
      json['refresh_token'] as String?,
      (json['scopes'] as List).cast<String>(),
    );
    final scopes = credentials.scopes.toSet();
    if (kGmailScopes.every(scopes.contains)) {
      return autoRefreshingClient(id, credentials, http.Client());
    }
    stdout.writeln('Zapisany token nie ma uprawnienia do wysyłki. '
        'Zaloguj się jeszcze raz, żeby je nadać.');
  }

  final client = await clientViaUserConsent(id, kGmailScopes, (url) {
    stdout.writeln('Zaloguj się w przeglądarce na $kInboxEmail. '
        'Jeśli okno się nie otworzyło, wejdź na:\n$url');
    // Otwieramy sami, bo link kopiowany z terminala bywa ucinany.
    final opener = Platform.isMacOS ? 'open' : 'xdg-open';
    Process.run(opener, [url]).ignore();
  });
  writeText(tokenFile.path, jsonEncode({
    'token_type': client.credentials.accessToken.type,
    'access_token': client.credentials.accessToken.data,
    'expiry': client.credentials.accessToken.expiry.toUtc().toIso8601String(),
    'refresh_token': client.credentials.refreshToken,
    'scopes': client.credentials.scopes,
  }));
  return client;
}
