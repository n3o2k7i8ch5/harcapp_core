import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

Map _song(String title) => (SongRaw.empty(id: 'x')..title = title).toApiJsonMap(withId: false);

/// Plik z dopisanym ręcznie drugim wpisem pod tym samym kluczem — mapa tego
/// nie wyrazi, JSON owszem.
String _withDuplicate() =>
    '{"official":{'
    '"o!_barka":{"song":${jsonEncode(_song('Barka'))},"index":0},'
    '"o!_ognisko":{"song":${jsonEncode(_song('Ognisko'))},"index":1},'
    '"o!_barka":{"song":${jsonEncode(_song('Barka wklejona'))},"index":0}'
    '},"conf":{}}';

void main() {
  test('jsonDecode po cichu gubi zdublowany klucz — stąd własny odczyt', () {
    expect((jsonDecode(_withDuplicate())['official'] as Map), hasLength(2));
  });

  test('domyślnie duplikaty wczytują się jako osobne piosenki, w kolejności index', () {
    final (official, conf) = importHrcpsng(_withDuplicate());
    expect([for (final s in official) s.title], ['Barka', 'Barka wklejona', 'Ognisko'],
        reason: 'remis na index — w kolejności z pliku');
    expect([for (final s in official) s.id], ['o!_barka', 'o!_barka', 'o!_ognisko']);
    expect(conf, isEmpty);
    expect(hrcpsngDuplicateIds(_withDuplicate()), ['o!_barka']);
  });

  test('ściśle (all_songs): błąd z listą id i nic się nie wczytuje', () {
    expect(
      () => importHrcpsng(_withDuplicate(), allowDuplicateIds: false),
      throwsA(isA<HrcpsngDuplicateIdError>().having((e) => e.ids, 'ids', ['o!_barka'])),
    );
  });

  test('zapis: z duplikatem błąd, chyba że roboczy stan warsztatu', () {
    final entries = [('o!_barka', _song('Barka')), ('o!_barka', _song('Barka wklejona'))];
    expect(
      () => encodeHrcpsngEntries(official: entries),
      throwsA(isA<HrcpsngDuplicateIdError>().having((e) => e.ids, 'ids', ['o!_barka'])),
    );
    final cache = encodeHrcpsngEntries(official: entries, allowDuplicateIds: true);
    expect(importHrcpsng(cache).$1.map((s) => s.title), ['Barka', 'Barka wklejona'],
        reason: 'duplikat przeżywa zapis i odczyt, żeby dało się go naprawić');
  });

  test('zapis bez duplikatów to ten sam JSON, co mapa', () {
    final official = [('o!_barka', _song('Barka')), ('o!_ognisko', _song('Ognisko'))];
    expect(
      encodeHrcpsngEntries(official: official),
      jsonEncode({
        'official': {
          for (final (i, (id, song)) in official.indexed) id: {'song': song, 'index': i},
        },
        'conf': {},
      }),
    );
  });

  test('przedrostki id nigdy się nie sklejają: sekcja dokłada je tylko do gołego id', () {
    final content = jsonEncode({
      'official': {
        'oc!_barka': {'song': _song('Barka'), 'index': 0},
        'ognisko': {'song': _song('Ognisko'), 'index': 1},
      },
      'conf': {
        'o!_kotek': {'song': _song('Kotek'), 'index': 0},
        'tajna': {'song': _song('Tajna'), 'index': 1},
      },
    });
    final (official, conf) = importHrcpsng(content);
    expect([for (final s in official) s.id], ['o!_ognisko', 'o!_kotek'],
        reason: 'o liście mówi przedrostek id, nie sekcja');
    expect([for (final s in conf) s.id], ['oc!_barka', 'oc!_tajna']);
  });

  test('to nie JSON → błąd odczytu, jak dotąd', () {
    expect(() => importHrcpsng('{"official": {'), throwsA(isA<HrcpsngImportError>()));
  });
}
