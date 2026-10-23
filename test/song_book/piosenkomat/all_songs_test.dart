import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_origin.dart';

/// Pola robocze piosenkomatu. `review --push` zdejmuje je w `final-*`, zanim
/// trafią do `all_songs`, więc w bazie nie ma ich prawa być — niosą adresy nadawców,
/// rozmowy z autorami i id wątków ze skrzynki.
const _workFields = {
  SongCore.PARAM_PIOSENKOMAT,
  SongCore.PARAM_BASED_ON_SONG_ID,
};

void main() {
  test('all_songs nie ma zdublowanych id — każdy czytnik zgubiłby jedną z piosenek', () {
    final content = File('assets/songs/all_songs.hrcpsng').readAsStringSync();
    expect(hrcpsngDuplicateIds(content), isEmpty,
        reason: 'napraw all_songs: pod każdym id jedna piosenka');
    expect(() => importHrcpsng(content, allowDuplicateIds: false), returnsNormally);
  });

  test('all_songs nie niesie pól roboczych piosenkomatu', () {
    final db = jsonDecode(File('assets/songs/all_songs.hrcpsng').readAsStringSync());

    final found = <String>[];
    void walk(Object? node, String path) {
      if (node is Map) {
        for (final e in node.entries) {
          final at = '$path/${e.key}';
          if (_workFields.contains(e.key)) found.add(at);
          walk(e.value, at);
        }
      } else if (node is List) {
        for (var i = 0; i < node.length; i++) walk(node[i], '$path[$i]');
      }
    }
    walk(db, '');

    expect(found, isEmpty, reason: 'Wklejone do all_songs z reviewed-* zamiast z final-*?');
  });

  test('pochodzenie: każdy wpis da się pokazać, a rodzaj z tagiem ma swój tag', () {
    final db = jsonDecode(File('assets/songs/all_songs.hrcpsng').readAsStringSync()) as Map;

    final problems = <String>[];
    for (final section in db.values) {
      for (final MapEntry(key: id, value: entry) in (section as Map).entries) {
        final song = entry['song'] as Map;
        final raw = song[SongCore.PARAM_ORIGINS];
        if (raw == null) continue;
        final origins = SongOrigin.listFromJson(raw);
        if (raw is! List || raw.isEmpty || origins.length != raw.length) {
          problems.add('$id: pochodzenie nie do odczytania albo pusta lista: $raw');
        }
        // Filtr w apce działa po tagach — piosenka z bajki bez #ZBajek by z niego wypadła.
        final tags = song[SongCore.PARAM_TAGS] as List? ?? const [];
        for (final origin in origins) {
          if (origin.type.tag case final tag? when !tags.contains(tag)) problems.add('$id: „${origin.text}” bez $tag');
        }
      }
    }

    expect(problems, isEmpty);
  });
}
