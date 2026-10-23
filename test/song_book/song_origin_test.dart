import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/similarity/similarity.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/song_editor/providers.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/song_editor/widgets/song_origins_widget.dart';
import 'package:harcapp_core/song_book/song_element.dart';
import 'package:harcapp_core/song_book/song_origin.dart';
import 'package:harcapp_core/song_book/song_tags.dart';
import 'package:provider/provider.dart';

const _shrek = SongOrigin(SongOriginType.animation, 'Shrek');

SongRaw _song(String id, String title, String text, {List<SongOrigin> origins = const []}){
  final s = SongRaw.empty(id: id)
    ..title = title
    ..hasRefren = false
    ..origins = origins;
  s.songParts = [SongPart.from(SongElement(text, 'a d e\na d e', false))];
  return s;
}

Map _json(SongRaw s) => s.toApiJsonMap(withId: false);

void main(){

  group('zapis i odczyt:', (){

    test('pochodzenie jedzie zaraz po tytułach ukrytych i wraca takie samo', (){
      final song = _song('o!_all_star', 'All Star', 'Somebody once told me\nThe world is gonna roll me',
          origins: [_shrek, const SongOrigin(SongOriginType.rewrite, '  Pieśń wielorybników ')]);

      final json = _json(song);
      final keys = json.keys.toList();
      expect(keys.indexOf(SongCore.PARAM_ORIGINS), keys.indexOf(SongCore.PARAM_HID_TITLES) + 1);
      expect(json[SongCore.PARAM_ORIGINS], [
        {'type': 'animation', 'value': 'Shrek'},
        {'type': 'rewrite', 'value': 'Pieśń wielorybników'},
      ]);
      expect(SongRaw.fromApiRespMap('o!_all_star', json).origins,
          [_shrek, const SongOrigin(SongOriginType.rewrite, 'Pieśń wielorybników')]);
    });

    test('bez pochodzenia — bez klucza, więc piosenki bez niego się nie zmieniają', (){
      expect(_json(_song('o!_x', 'X', 'Tekst')).containsKey(SongCore.PARAM_ORIGINS), isFalse);
    });

    test('pusta nazwa z edytora nie trafia do pliku', (){
      final song = _song('o!_x', 'X', 'Tekst', origins: [const SongOrigin(SongOriginType.film, '  ')]);
      expect(_json(song).containsKey(SongCore.PARAM_ORIGINS), isFalse);
      expect(song.isEmpty, isFalse, reason: 'tytuł i tekst są — pusta nazwa nic tu nie zmienia');
      expect((SongRaw.empty()..origins = [_shrek]).isEmpty, isFalse);
    });

    test('nieznany rodzaj i śmieci wypadają, reszta piosenki się wczytuje', (){
      final json = _json(_song('o!_x', 'X', 'Tekst'))
        ..[SongCore.PARAM_ORIGINS] = [
          {'type': 'game', 'value': 'Wiedźmin 3'},   // rodzaj z nowszej apki
          {'type': 'animation', 'value': ''},
          {'type': 'animation'},
          'Shrek',
          {'type': 'animation', 'value': 'Shrek'},
        ];
      final song = SongRaw.fromApiRespMap('o!_x', json);
      expect(song.origins, [_shrek]);
      expect(song.title, 'X');
    });

  });

  group('porównywarka:', (){

    test('wspólna bajka to nie wspólny tytuł', (){
      final a = SongProfile(_song('o!_all_star', 'All Star', 'Somebody once told me', origins: [_shrek]));
      final b = SongProfile(_song('o!_hallelujah', 'Hallelujah', 'I heard there was a secret chord', origins: [_shrek]));
      expect(compare(a, b).has<SameTitle>(), isFalse);
    });

    test('poprawka samego pochodzenia to różnica w opisie, nie „bez różnic”', (){
      const text = 'Somebody once told me\nThe world is gonna roll me';
      final app = SongProfile(_song('o!_all_star', 'All Star', text));
      final fixed = SongProfile(_song('o!_all_star', 'All Star', text, origins: [_shrek]));

      final s = compare(fixed, app);
      expect(s.metadataDiff?.fields, [MetadataField.origins]);
      expect(levelOf(s), MatchLevel.sameSong);
    });

  });

  group('edytor:', (){

    test('usunięcie jednego wiersza nie miesza nazw w pozostałych', (){
      final prov = CurrentItemProvider(song: _song('o!_x', 'X', 'Tekst',
          origins: [_shrek, const SongOrigin(SongOriginType.film, 'Igrzyska śmierci')]));
      prov.addOrigin(SongOriginType.musical);
      prov.originControllers[2].text = 'Metro';
      prov.setOriginValue(2, 'Metro');

      prov.removeOriginAt(0);

      expect(prov.origins, [
        const SongOrigin(SongOriginType.film, 'Igrzyska śmierci'),
        const SongOrigin(SongOriginType.musical, 'Metro'),
      ]);
      expect(prov.originControllers.map((c) => c.text), ['Igrzyska śmierci', 'Metro']);
    });

    test('nowa piosenka w edytorze — nowe pola nazw', (){
      final prov = CurrentItemProvider(song: _song('o!_x', 'X', 'Tekst', origins: [_shrek]));
      prov.setSong(_song('o!_y', 'Y', 'Tekst'));
      expect(prov.originControllers, isEmpty);
    });

    Future<(CurrentItemProvider, TagsProvider)> pumpEditor(WidgetTester tester, SongRaw song) async {
      final prov = CurrentItemProvider(song: song);
      final tags = TagsProvider(song.tags);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: prov),
              ChangeNotifierProvider.value(value: tags),
            ],
            child: const SingleChildScrollView(child: SongOriginsWidget()),
          ),
        ),
      ));
      return (prov, tags);
    }

    Future<void> pick(WidgetTester tester, Finder button, SongOriginType type) async {
      await tester.tap(button);
      await tester.pumpAndSettle();
      await tester.tap(find.text(type.label).last);
      await tester.pumpAndSettle();
    }

    testWidgets('„Z bajki” dokłada #ZBajek — do piosenki i do tagów edytora', (tester) async {
      final (prov, tags) = await pumpEditor(tester, _song('o!_x', 'X', 'Tekst'));

      await pick(tester, find.byIcon(MdiIcons.plus), SongOriginType.animation);

      expect(prov.origins, [const SongOrigin(SongOriginType.animation, '')]);
      expect(prov.song.tags, contains(SongTag.TAG_Z_BAJEK));
      expect(tags.checkedTags, contains(SongTag.TAG_Z_BAJEK));
    });

    testWidgets('rodzaj bez tagu (film) niczego nie dokłada', (tester) async {
      final (prov, tags) = await pumpEditor(tester, _song('o!_x', 'X', 'Tekst'));

      await pick(tester, find.byIcon(MdiIcons.plus), SongOriginType.film);

      expect(prov.origins.single.type, SongOriginType.film);
      expect(prov.song.tags, isEmpty);
      expect(tags.checkedTags, isEmpty);
    });

  });

}
