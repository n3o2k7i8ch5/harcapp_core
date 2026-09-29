import 'dart:convert';

import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

class HrcpsngImportError implements Exception {
  final String message;
  HrcpsngImportError(this.message);

  @override
  String toString() => 'HrcpsngImportError: $message';
}

/// W pliku piosenek to samo id więcej niż raz. Plik to mapa `id → piosenka`,
/// ale w JSON-ie da się dopisać drugi wpis pod tym samym kluczem — a zwykły
/// `jsonDecode` po cichu zostawia z nich ostatni.
class HrcpsngDuplicateIdError implements Exception {
  final List<String> ids;
  HrcpsngDuplicateIdError(this.ids);

  String get message => 'Zdublowane id piosenek: ${ids.join(', ')}';

  @override
  String toString() => 'HrcpsngDuplicateIdError: $message';
}

/// Rozszerzenie pliku piosenek.
const String kSongFileExtension = 'hrcpsng';

/// Sekcje pliku piosenek.
const List<String> kHrcpsngSections = ['official', 'conf'];

/// Wpisy sekcji (`id`, wpis) w kolejności z pliku, **z powtórzeniami**.
/// Rzuca [FormatException], gdy to nie JSON.
Map<String, List<(String, Object?)>> hrcpsngEntries(String content){
  if(jsonDecode(content) is! Map) throw const FormatException('Plik piosenek nie jest obiektem JSON');
  return {
    for(final e in _rawSections(content).entries)
      e.key: [for(final (id, value) in e.value) (id, jsonDecode(value))],
  };
}

/// Id, które w sekcjach pliku występują więcej niż raz — po kluczach, tak
/// jak stoją w pliku. Bez dekodowania piosenek, więc tanio; [content] musi
/// być poprawnym JSON-em (sprawdzonym wcześniej `jsonDecode`).
List<String> hrcpsngDuplicateIds(String content) =>
    _duplicatesOf([for(final entries in _rawSections(content).values) for(final (id, _) in entries) id]);

/// Sekcje jako (id, surowy JSON wpisu). Ostatnie wystąpienie sekcji wygrywa,
/// jak w `jsonDecode`.
Map<String, List<(String, String)>> _rawSections(String content){
  final top = _JsonScanner(content).members();
  return {
    for(final section in kHrcpsngSections)
      section: [
        if(top.lastWhere((m) => m.$1 == section, orElse: () => (section, 'null')).$2 case final raw
            when raw.trimLeft().startsWith('{'))
          ..._JsonScanner(raw).members(),
      ],
  };
}

List<String> _duplicatesOf(Iterable<String> ids){
  final seen = <String>{};
  return {for(final id in ids) if(!seen.add(id)) id}.toList();
}

/// Piosenki z pliku `.hrcpsng`: `(oficjalne, niejawne)`, w kolejności `index`.
///
/// Którą jest piosenka, mówi przedrostek id (`o!_` albo `oc!_`), nie sekcja:
/// id to tożsamość piosenki (ulubione, albumy, oceny), więc zostaje, jakie
/// jest. Sekcja dokłada przedrostek tylko do id, które nie ma żadnego —
/// nigdy drugiego obok pierwszego (`o!_oc!_…`).
///
/// Zdublowane id domyślnie wczytują się jako osobne piosenki — warsztat na
/// stronie pokaże je na czerwono i nie da zapisać pliku, dopóki ich nie
/// usuniesz. [allowDuplicateIds] `false` (śpiewnik `all_songs`, który nigdy
/// nie może ich mieć) rzuca wtedy [HrcpsngDuplicateIdError] i nic nie wczytuje.
(List<SongRaw>, List<SongRaw>) importHrcpsng(String content, {bool allowDuplicateIds = true}) {
  final Map<String, List<(String, Object?)>> entries;
  try{
    entries = hrcpsngEntries(content);
  } catch(e){
    throw HrcpsngImportError('Błąd odczytu pliku (błąd dekodowania JSON)');
  }

  List<SongRaw> section(String name, String prefix){
    final songs = <(int, int, SongRaw)>[];
    for(final (i, (fileName, entry)) in entries[name]!.indexed){
      try {
        final songPackMap = entry as Map<String, dynamic>;
        final song = SongRaw.fromApiRespMap(fileName, songPackMap['song']);
        if(!song.isOfficial && !song.isConfid) song.id = prefix + song.id;
        songs.add((songPackMap['index'] as int, i, song));
      } catch(e){
        throw HrcpsngImportError('Błąd odczytu pliku (błąd dekodowania piosenki $fileName)');
      }
    }
    // Po `index`, przy remisie (wklejony wpis z innego pliku) — w kolejności z pliku.
    songs.sort((a, b) => a.$1 != b.$1 ? a.$1.compareTo(b.$1) : a.$2.compareTo(b.$2));
    return [for(final (_, _, song) in songs) song];
  }

  final songs = [...section('official', 'o!_'), ...section('conf', 'oc!_')];
  final offSongs = [for(final s in songs) if(!s.isConfid) s];
  final confSongs = [for(final s in songs) if(s.isConfid) s];

  if(!allowDuplicateIds){
    final duplicates = _duplicatesOf([for(final s in [...offSongs, ...confSongs]) s.id]);
    if(duplicates.isNotEmpty) throw HrcpsngDuplicateIdError(duplicates);
  }
  return (offSongs, confSongs);
}

/// Plik piosenek z gotowych wpisów (`id`, piosenka jako mapa), w podanej
/// kolejności — ona jest `index`. Pliku ze zdublowanym id nie zapisujemy:
/// [HrcpsngDuplicateIdError]. Wyjątek to [allowDuplicateIds] — roboczy stan
/// warsztatu na stronie, który ma przetrwać odświeżenie razem z duplikatem
/// do naprawienia.
String encodeHrcpsngEntries({
  required List<(String, Map)> official,
  List<(String, Map)> conf = const [],
  bool allowDuplicateIds = false,
}){
  if(!allowDuplicateIds){
    final duplicates = _duplicatesOf([for(final (id, _) in [...official, ...conf]) id]);
    if(duplicates.isNotEmpty) throw HrcpsngDuplicateIdError(duplicates);
  }
  // Ręcznie, nie przez mapę: mapa zgubiłaby powtórzony klucz.
  String section(List<(String, Map)> entries) => '{${[
    for(final (i, (id, song)) in entries.indexed)
      '${jsonEncode(id)}:${jsonEncode({'song': song, 'index': i})}',
  ].join(',')}}';
  return '{"official":${section(official)},"conf":${section(conf)}}';
}

/// Przechodzi po poprawnym JSON-ie i wypisuje pola obiektu **z powtórzeniami**
/// — tego `jsonDecode` nie umie. Poprawność sprawdza wcześniej `jsonDecode`.
class _JsonScanner{

  static const int _quote = 0x22, _backslash = 0x5C, _colon = 0x3A, _comma = 0x2C;
  static const int _openObject = 0x7B, _closeObject = 0x7D, _openArray = 0x5B, _closeArray = 0x5D;

  final String s;
  int i = 0;

  _JsonScanner(this.s);

  int get _c => s.codeUnitAt(i);

  static bool _isWs(int c) => c == 0x20 || c == 0x09 || c == 0x0A || c == 0x0D;

  void _ws(){
    while(i < s.length && _isWs(_c)) i++;
  }

  /// Za cudzysłów zamykający; [decode] — z wartością napisu.
  String? _string({bool decode = false}){
    final start = i++;
    while(_c != _quote){
      if(_c == _backslash) i++;
      i++;
    }
    i++;
    return decode? jsonDecode(s.substring(start, i)) as String: null;
  }

  void _value(){
    _ws();
    final c = _c;
    if(c == _quote){
      _string();
      return;
    }
    if(c == _openObject || c == _openArray){
      final close = c == _openObject? _closeObject: _closeArray;
      i++;
      _ws();
      if(_c == close){
        i++;
        return;
      }
      while(true){
        if(c == _openObject){
          _ws();
          _string();
          _ws();
          i++; // ':'
        }
        _value();
        _ws();
        if(s.codeUnitAt(i++) == _comma) continue;
        return;
      }
    }
    // Liczba, true, false, null.
    while(i < s.length && !_isWs(_c) && _c != _comma && _c != _closeObject && _c != _closeArray) i++;
  }

  /// Pola obiektu, od którego zaczyna się tekst: (klucz, surowa wartość).
  List<(String, String)> members(){
    _ws();
    i++; // '{'
    final out = <(String, String)>[];
    _ws();
    if(_c == _closeObject) return out;
    while(true){
      _ws();
      final key = _string(decode: true)!;
      _ws();
      assert(_c == _colon);
      i++;
      _ws();
      final start = i;
      _value();
      out.add((key, s.substring(start, i)));
      _ws();
      if(s.codeUnitAt(i++) == _comma) continue;
      return out;
    }
  }

}
