import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/song_core.dart';

/// Pola robocze piosenkomatu. `prepare` zdejmuje je przed wklejeniem do
/// `all_songs`, więc w bazie nie ma ich prawa być — niosą adresy nadawców,
/// rozmowy z autorami i id wątków ze skrzynki.
const _workFields = {
  SongCore.PARAM_PIOSENKOMAT,
  SongCore.PARAM_BASED_ON_SONG_ID,
  'email_thread_id',
};

void main() {
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

    expect(found, isEmpty, reason: 'Wklejone do all_songs bez `piosenkomat prepare`?');
  });
}
