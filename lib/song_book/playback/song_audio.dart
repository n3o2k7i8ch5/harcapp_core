/// Nagrania mp3 piosenek: metadane z `assets/songs/audio_meta.json`.
///
/// Plik leży w rdzeniu od zawsze, a czytała go tylko apka. Rejestr jest tu,
/// żeby strona i apka widziały te same nagrania — i żeby nagrania **nie**
/// były polem piosenki: `.hrcpsng` ich nie niesie, edytor ich nie edytuje,
/// to osobna lista obok śpiewnika.
library;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Jedno nagranie. [source] to skąd pochodzi (zwykle link do YouTube'a) —
/// do pokazania, nie do grania.
class SongAudio {

  static const String baseUrl = 'https://gitlab.com/n3o2k7i8ch5/harcapp_data/-/raw/master/songs_audio/';

  final String fileName;
  final String? performer;
  final String? source;

  const SongAudio(this.fileName, {this.performer, this.source});

  String get url => '$baseUrl$fileName';

  /// `null`, gdy wpis nie ma pliku — wtedy nie ma czego grać.
  static SongAudio? fromJsonMap(Map map) {
    final file = map['file'];
    if (file is! String || file.trim().isEmpty) return null;
    return SongAudio(
      file.trim(),
      performer: _nonEmpty(map['performer']),
      source: _nonEmpty(map['source']),
    );
  }

  static String? _nonEmpty(Object? raw) {
    if (raw is! String) return null;
    final trimmed = raw.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  @override
  bool operator ==(Object other) => other is SongAudio && other.fileName == fileName;

  @override
  int get hashCode => fileName.hashCode;

}

/// Rejestr: id piosenki → jej nagrania. Ładowany raz, z assetu rdzenia.
///
/// Statyczny, bo asset jest jeden i ma kilkadziesiąt wpisów. Ładować na
/// **głównym** izolacie — stan ustawiony w `compute` nie wraca.
class AudioMeta {

  static const String assetPath = 'packages/harcapp_core/assets/songs/audio_meta.json';

  static Map<String, List<SongAudio>> _byId = const {};
  static bool _loaded = false;

  static bool get loaded => _loaded;

  static List<SongAudio> audiosOf(String songId) => _byId[songId] ?? const [];

  static Future<void> load() async {
    if (_loaded) return;
    set(parse(await rootBundle.loadString(assetPath)));
  }

  /// Zepsuty wpis nie wywala reszty: nagranie bez pliku odpada po cichu,
  /// piosenka z niczym sensownym w środku — też.
  static Map<String, List<SongAudio>> parse(String json) {
    final decoded = jsonDecode(json);
    if (decoded is! Map) return const {};
    final out = <String, List<SongAudio>>{};
    for (final entry in decoded.entries) {
      final raw = entry.value;
      if (raw is! List) continue;
      final audios = [
        for (final item in raw)
          if (item is Map)
            if (SongAudio.fromJsonMap(item) case final audio?) audio,
      ];
      if (audios.isNotEmpty) out[entry.key.toString()] = audios;
    }
    return out;
  }

  @visibleForTesting
  static void set(Map<String, List<SongAudio>> byId) {
    _byId = byId;
    _loaded = true;
  }

  @visibleForTesting
  static void reset() {
    _byId = const {};
    _loaded = false;
  }

}
