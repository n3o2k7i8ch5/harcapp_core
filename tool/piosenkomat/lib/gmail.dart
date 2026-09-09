import 'dart:convert';
import 'dart:io';

import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'model.dart';

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
    final headers = {
      for (final h in msg.payload?.headers ?? const <MessagePartHeader>[])
        if (h.name != null && h.value != null) h.name!.toLowerCase(): h.value!,
    };
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

  /// Czy mejl ma już jakąś etykietę zaczynającą się od [prefix]. Tylko metadane.
  Future<bool> hasAnyLabel(String messageId, {required String prefix}) async {
    final msg = await _call(() => _api.users.messages.get('me', messageId, format: 'minimal'));
    return (msg.labelIds ?? const <String>[])
        .map((id) => _nameById[id] ?? id)
        .any((n) => n == prefix || n.startsWith('$prefix/'));
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
    return autoRefreshingClient(id, credentials, http.Client());
  }

  final client = await clientViaUserConsent(id, [GmailApi.gmailModifyScope], (url) {
    stdout.writeln('Zaloguj się w przeglądarce na $kInboxEmail. '
        'Jeśli okno się nie otworzyło, wejdź na:\n$url');
    // Otwieramy sami, bo link kopiowany z terminala bywa ucinany.
    final opener = Platform.isMacOS ? 'open' : 'xdg-open';
    Process.run(opener, [url]).ignore();
  });
  tokenFile.parent.createSync(recursive: true);
  tokenFile.writeAsStringSync(jsonEncode({
    'token_type': client.credentials.accessToken.type,
    'access_token': client.credentials.accessToken.data,
    'expiry': client.credentials.accessToken.expiry.toUtc().toIso8601String(),
    'refresh_token': client.credentials.refreshToken,
    'scopes': client.credentials.scopes,
  }));
  return client;
}
