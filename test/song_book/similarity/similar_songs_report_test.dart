import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/similarity/similarity.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

const _report = 'tool/similar_songs.md';

/// Przepisuje [_report]: zestawy piosenek ze śpiewnika, które coś łączy
/// treścią — ta sama piosenka pod kilkoma tytułami, warianty, przeróbki.
/// Na żądanie, bo zwykły przebieg testów nie powinien zmieniać plików:
///
///     WRITE_SIMILAR_SONGS=1 flutter test test/song_book/similarity/similar_songs_report_test.dart
void main() {
  test('zestawy podobnych piosenek → $_report',
      skip: Platform.environment['WRITE_SIMILAR_SONGS'] == null ? 'ustaw WRITE_SIMILAR_SONGS=1, żeby przepisać raport' : false,
      () {
    final (official, conf) = importHrcpsng(File('assets/songs/all_songs.hrcpsng').readAsStringSync());
    final book = [...official, ...conf];
    final index = SongIndex<SongRaw>(book);
    final at = {for (var i = 0; i < book.length; i++) book[i]: i};

    // Pary połączone treścią (tytuł i id same nie wystarczą).
    // Dowody zawsze od piosenki o mniejszym numerze, żeby para miała jeden opis.
    final pairs = <(int, int), List<Similarity>>{};
    for (var i = 0; i < book.length; i++) {
      for (final m in index.matches(index.profiles[i], exclude: (s) => identical(s, book[i]))) {
        if (!(m.level?.byContent ?? false)) continue;
        final j = at[m.song]!;
        final key = i < j ? (i, j) : (j, i);
        pairs.putIfAbsent(key, () => compare(index.profiles[key.$1], index.profiles[key.$2]));
      }
    }

    // Zestaw = spójna składowa: A~B i B~C to jeden zestaw.
    final parent = [for (var i = 0; i < book.length; i++) i];
    int root(int i) => parent[i] == i ? i : parent[i] = root(parent[i]);
    for (final (a, b) in pairs.keys) {
      parent[root(a)] = root(b);
    }
    final sets = <int, List<int>>{};
    for (final (a, b) in pairs.keys) {
      sets.putIfAbsent(root(a), () => []);
      for (final x in [a, b]) {
        if (!sets[root(a)]!.contains(x)) sets[root(a)]!.add(x);
      }
    }

    MatchLevel strongest(List<int> members) => pairs.entries
        .where((e) => members.contains(e.key.$1))
        .map((e) => levelOf(e.value) ?? MatchLevel.related)
        .reduce((a, b) => a.index <= b.index ? a : b);

    final ordered = sets.values.toList()
      ..sort((a, b) {
        final byLevel = strongest(a).index.compareTo(strongest(b).index);
        return byLevel != 0 ? byLevel : book[a.first].title.compareTo(book[b.first].title);
      });

    String who(SongRaw s) => '„${s.title}”${s.performers.isEmpty ? '' : ' (${s.performers.join(', ')})'} `${s.id}`';

    final out = StringBuffer()
      ..writeln('# Podobne piosenki w śpiewniku')
      ..writeln()
      ..writeln('Zestawy piosenek z `assets/songs/all_songs.hrcpsng`, które łączy treść: ta sama piosenka')
      ..writeln('pod kilkoma tytułami albo w kilku wersjach (do scalenia?), warianty i przeróbki.')
      ..writeln('Liczone modułem `lib/song_book/similarity/` — tym samym, co piosenkomat i strona.')
      ..writeln('Sam wspólny tytuł się nie liczy.')
      ..writeln()
      ..writeln('Przepisanie po zmianach w śpiewniku:')
      ..writeln()
      ..writeln('```')
      ..writeln('WRITE_SIMILAR_SONGS=1 flutter test test/song_book/similarity/similar_songs_report_test.dart')
      ..writeln('```')
      ..writeln()
      ..writeln('${ordered.length} zestawów, ${pairs.length} par.');

    String? section;
    for (final members in ordered) {
      final level = strongest(members);
      final title = level.isSameSong ? 'Ta sama piosenka' : 'Warianty i przeróbki';
      if (title != section) {
        out
          ..writeln()
          ..writeln('## $title');
        section = title;
      }
      out
        ..writeln()
        ..writeln('### ${members.map((i) => '„${book[i].title}”').join(' · ')}')
        ..writeln();
      for (final i in members) {
        out.writeln('- ${who(book[i])}');
      }
      out.writeln();
      for (final e in pairs.entries) {
        if (!members.contains(e.key.$1)) continue;
        final level = levelOf(e.value)?.text ?? 'podobna';
        out.writeln('  - „${book[e.key.$1].title}” ~ „${book[e.key.$2].title}”: **$level** — ${similaritiesText(e.value)}');
      }
    }
    File(_report).writeAsStringSync(out.toString());
    // ignore: avoid_print
    print('$_report: ${ordered.length} zestawów, ${pairs.length} par');
  });
}
