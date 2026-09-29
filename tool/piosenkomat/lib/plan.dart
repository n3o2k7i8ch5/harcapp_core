import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/values/people/utils.dart';

import 'hrcpsng.dart';
import 'model.dart';

/// Piosenka, którą automat wstawił do pliku kandydatów. Wiąże wpis
/// w `.hrcpsng` ze zgłoszeniem (wątkiem), nawet gdy strona zgubi
/// `thread_id` przy eksporcie.
class PlannedSong {
  final String songId;
  final String title;
  /// Pozostałe adresy z bloku „Osoba dodająca”. Piosenka niesie tylko jeden
  /// (`email_ref`), a `people.dart` powstaje dopiero po przeglądzie, więc
  /// reszta musi tu przeczekać.
  final List<String> otherEmails;
  final SubmissionKind kind;

  const PlannedSong({
    required this.songId,
    required this.title,
    this.kind = SubmissionKind.newSong,
    this.otherEmails = const [],
  });

  Map<String, dynamic> toJson() => {
        'song_id': songId,
        'title': title,
        'kind': kind.id,
        if (otherEmails.isNotEmpty) 'other_emails': otherEmails,
      };

  factory PlannedSong.fromJson(Map<String, dynamic> json) => PlannedSong(
        songId: json['song_id'] as String,
        title: json['title'] as String,
        kind: SubmissionKind.byId(json['kind'] as String?),
        otherEmails:
            ((json['other_emails'] ?? const []) as List).cast<String>(),
      );
}

/// Nazwa przebiegu: data i godzina `scan --push`, np. `run-2026-09-28T101500`.
/// Tak nazywa się też jego katalog w archiwum i pole `run` w piosenkach.
String newRunId(DateTime at) =>
    'run-${at.toIso8601String().substring(0, 19).replaceAll(':', '')}';

/// Wątek przebiegu, czyli jedno zgłoszenie: jego wiadomości, etykiety, które
/// automat nadaje każdej z nich, piosenka w pliku kandydatów i kto zgłaszał.
class PlannedThread {
  /// Od najstarszej — etykiety idą na wszystkie.
  final List<String> messages;
  final List<String> labels;
  /// `null`, gdy zgłoszenie nie poszło do pliku kandydatów.
  final PlannedSong? song;
  /// Po nim szkice odpowiedzi liczą się per autor, a `people.dart` dokłada
  /// adresy z planu. `null`, gdy nadawca nieczytelny.
  final String? sender;

  const PlannedThread({required this.messages, required this.labels, this.song, this.sender});

  Map<String, dynamic> toJson() => {
        'messages': messages,
        'labels': labels,
        if (song != null) 'song': song!.toJson(),
        if (sender != null) 'sender': sender,
      };

  factory PlannedThread.fromJson(Map<String, dynamic> json) => PlannedThread(
        messages: (json['messages'] as List).cast<String>(),
        labels: (json['labels'] as List).cast<String>(),
        song: switch (json['song']) { final Map<String, dynamic> song => PlannedSong.fromJson(song), _ => null },
        sender: json['sender'] as String?,
      );
}

/// Plan przebiegu (`plan.json`), czyli zapisany wynik `scan`: jego wątki
/// z tym, co automat nadaje, co poszło do pliku i kto zgłaszał. Po nim
/// `review` i `finalize` wiedzą, które mejle są ich — bez ponownego czytania
/// skrzynki.
class RunPlan {
  final String id;
  final DateTime createdAt;
  /// Kiedy `scan --push` skończył: etykiety i szkice są w Gmailu. `null` —
  /// przerwany w połowie; kolejny `scan --push` go dokończy.
  final DateTime? pushedAt;
  /// Po id wątku — jeden wątek to jedno zgłoszenie.
  final Map<String, PlannedThread> threads;

  RunPlan({
    required this.id,
    required this.createdAt,
    required this.threads,
    this.pushedAt,
  });

  factory RunPlan.fromClassified(List<Classified> items, {required String id}) => RunPlan(
        id: id,
        createdAt: DateTime.now(),
        threads: {
          for (final c in items)
            c.submission.threadId: PlannedThread(
              messages: [for (final m in c.submission.messages) m.id],
              labels: [...c.labels, SongLabel.auto.label],
              song: c.goesToFile
                  ? PlannedSong(
                      songId: c.song!.id,
                      title: c.song!.title,
                      kind: c.submission.kind,
                      otherEmails: _otherEmailsOf(c),
                    )
                  : null,
              sender: c.submission.sender,
            ),
        },
      );

  /// Ten sam plan po skończonym `scan --push`.
  RunPlan pushed(DateTime at) => RunPlan(id: id, createdAt: createdAt, pushedAt: at, threads: threads);

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt.toIso8601String(),
        if (pushedAt != null) 'pushed_at': pushedAt!.toIso8601String(),
        'threads': {for (final e in threads.entries) e.key: e.value.toJson()},
      };

  factory RunPlan.fromJson(Map<String, dynamic> json) => RunPlan(
        id: json['id'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        pushedAt: switch (json['pushed_at']) { final String at => DateTime.parse(at), _ => null },
        threads: {
          for (final e in (json['threads'] as Map<String, dynamic>).entries)
            e.key: PlannedThread.fromJson(e.value as Map<String, dynamic>),
        },
      );

  /// Etykiety po **wiadomości** — Gmail zmienia etykiety mejli, nie wątków.
  late final Map<String, List<String>> labelsByMessage = {
    for (final t in threads.values)
      for (final m in t.messages) m: t.labels,
  };

  /// Wiadomości wątku. Plan zna wszystkie wątki przebiegu, więc pusta lista
  /// znaczy, że pytasz o wątek spoza niego.
  List<String> messagesOf(String threadId) => threads[threadId]?.messages ?? const [];

  /// Etykiety wszystkich wiadomości wątku razem, według [labels] (mejl →
  /// etykiety). Etykiety idą na cały wątek, więc to etykiety zgłoszenia.
  Set<String> labelsOfThread(String threadId, Map<String, Set<String>> labels) =>
      {for (final id in messagesOf(threadId)) ...?labels[id]};

  /// Wątki przebiegu, w których automat trzyma [label] ([hasToolLabel]).
  List<String> threadsWith(Map<String, Set<String>> current, SongLabel label) => [
        for (final thread in threads.keys)
          if (hasToolLabel(labelsOfThread(thread, current), label)) thread,
      ];
}

/// Adresy z bloku „Osoba dodająca” poza adresem nadawcy — ten jest już
/// w `email_ref` piosenki.
List<String> _otherEmailsOf(Classified c) {
  final sender = normalizedEmail(c.submission.sender ?? '');
  return [
    for (final e in c.submission.registered?.emails ?? const <String>[])
      if (normalizedEmail(e) case final n when n.isNotEmpty && n != sender) e.trim(),
  ];
}

/// Dodatkowe adresy z przebiegu, po nadawcy — tyle, ile `people.dart`
/// potrzebuje od planu.
Map<String, List<String>> otherEmailsBySender(RunPlan plan) {
  final out = <String, List<String>>{};
  for (final t in plan.threads.values) {
    final sender = normalizedEmail(t.sender ?? '');
    final others = t.song?.otherEmails ?? const [];
    if (sender.isEmpty || others.isEmpty) continue;
    final into = out.putIfAbsent(sender, () => []);
    for (final e in others) {
      if (!into.contains(e)) into.add(e);
    }
  }
  return out;
}

/// Czy przebieg jest w Gmailu: choć jeden jego mejl ma znacznik automatu.
/// Stawia go `scan --push`, zdejmuje `unlabel`.
bool isRunInGmail(RunPlan plan, Map<String, Set<String>> current) =>
    plan.labelsByMessage.keys.any((id) => current[id]?.contains(SongLabel.auto.label) ?? false);

/// Mejle z otwartym werdyktem automatu: czekają na `review` albo `finalize`.
/// Póki są, przebieg jest otwarty — gdziekolwiek jest jego katalog.
List<String> openVerdicts(Map<String, Set<String>> current) => [
      for (final MapEntry(key: id, value: labels) in current.entries)
        if (hasToolLabel(labels, SongLabel.readyToAdd) || hasToolLabel(labels, SongLabel.needsReview)) id,
    ];

/// Co `unlabel` zdejmie. Swoje automat poznaje po znaczniku `song/auto` —
/// Ty go nie wieszasz, więc Twoje ręczne etykiety zostają nietknięte.
/// [scope] to mejle cofanego przebiegu; `null` — cała skrzynka.
///
/// Bezpiecznik: mejla z `song/added` nie ruszamy bez [force] — piosenka jest
/// już w apce, a zdjęcie etykiet wepchnęłoby ją z powrotem do kolejki.
({Map<String, List<String>> toRemove, int outsideScope, int added}) unlabelChanges(
  Map<String, Set<String>> current, {
  Set<String>? scope,
  bool force = false,
}) {
  final toRemove = <String, List<String>>{};
  var outsideScope = 0;
  var added = 0;
  for (final e in current.entries) {
    if (!e.value.contains(SongLabel.auto.label)) continue;
    if (scope != null && !scope.contains(e.key)) {
      outsideScope++;
      continue;
    }
    if (e.value.contains(SongLabel.added.label) && !force) {
      added++;
      continue;
    }
    final labels = [for (final l in kToolLabels) if (e.value.contains(l)) l];
    if (labels.isNotEmpty) toRemove[e.key] = labels;
  }
  return (toRemove: toRemove, outsideScope: outsideScope, added: added);
}

void writePlan(String path, RunPlan plan) =>
    writeText(path, const JsonEncoder.withIndent('  ').convert(plan.toJson()));

RunPlan readPlan(String path) {
  final file = File(path);
  if (!file.existsSync()) throw FileSystemException('Nie ma pliku planu', path);
  return RunPlan.fromJson(jsonDecode(file.readAsStringSync()) as Map<String, dynamic>);
}
