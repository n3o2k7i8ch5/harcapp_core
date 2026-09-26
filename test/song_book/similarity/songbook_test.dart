import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/similarity/similarity.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

import 'perturbations.dart';

/// Pary ze śpiewnika, które są tą samą piosenką pod innym tytułem albo
/// w innej wersji — powinny zniknąć z bazy, a do tego czasu mechanizm ma je
/// widzieć na czerwono.
const _sameSong = [
  ('o!_zielona_kraina@trzecia_milosc', 'o!_zielona_milosc@trzecia_milosc'),
  ('o!_watra_ii', 'o!_watra_iii'),
  ('o!_konie_wojny_trzydziestoletniej@jacek_kaczmarski', 'o!_koniec_wojny_trzydziestoletniej@jacek_kaczmarski'),
  ('o!_kierunki@dominika_konarska', 'o!_polnoc_i_poludnie'),
  ('o!_kierunki@dominika_konarska', 'o!_kierunki_harcerskie@dominika_konarska'),
  ('o!_bieszczady@jacek_kaczmarski', 'o!_piec_glosow_z_kraju___bieszczady@jacek_kaczmarski'),
  ('o!_oliwska_szanta', 'o!_szanta_oliwska@cztery_refy'),
  ('o!_stracanie_aniolow@jacek_kaczmarski&przemyslaw_gintrowski&zbigniew_lapinski', 'o!_stracenie_aniolow@jacek_kaczmarski'),
  ('o!_cichutkim_krokiem_wspolne_prawa', 'o!_te_wspolne_prawa'),
  ('o!_busola', 'o!_przeczucie@gdanska_formacja_szantowa'),
  ('o!_madonna', 'o!_polsko_ruska_madonna@bez_jacka'),
  ('o!_hanging_tree@jennifer_lawrence', 'o!_the_hanging_tree@rachel_zegler'),
  ('o!_pedziwiatr_wiatr', 'o!_wiatr'),
  ('o!_poezja@na_bani', 'o!_poezja_dla_k@na_bani'),
  ('o!_1944', 'oc!_1944_w_okopie'),
  ('o!_prosze_ksiedz_bernardyna', 'oc!_prosze_ksiedza_bernardyna'),
  ('o!_rapsod_o_warnenczyku_wersja_podstawowa', 'o!_warna'),
  ('o!_jest_taki_samotny_dom@budka_suflera', 'o!_wagnerowski_ton@budka_suflera'),
  ('o!_czar_ogniska', 'o!_czardasz'),
];

/// Znane przeróbki i piosenki na tę samą melodię. Część ma mało wspólnego
/// tekstu — łapią je chwyty, metrum albo ten sam film.
const _related = [
  ('o!_ostatnia_nocka', 'o!_ostatnia_warta@yugopolis__maciej_malenczuk'),
  ('o!_piesn_plecakownikow@7_dh_dragon_im_1_dywizji_pancernej', 'o!_piesn_wielorybnikow'),
  ('o!_na_jednej_z_dzikich_plaz', 'o!_w_jednym_z_dzikich_mcdonaldow@antoni_sledz'),
  ('o!_bialy_dunajec', 'o!_zlot_grunwaldzki@wojownicy'),
  ('o!_brudna_calibra@', 'o!_szara_lilijka'),
  ('o!_onim', 'o!_szara_lilijka'),
  ('o!_autobiografia', 'o!_autobuografia_jolki_jolki'),
  ('o!_ale_jazz!@sanah', 'o!_harcerski_jazz@zastep_swarogi'),
  ('o!_jesien_idzie_nie_ma_na_to_rady', 'o!_wiesiek_idzie@artur_andrus'),
  ('o!_mary_i_john', 'o!_mrowka_i_pajak'),
  ('o!_900_mil', 'o!_900_pioniorek@8_dsh_feniksy_z_przysieka'),
  ('o!_harcerskie_szycie@21_wdh_mglawica', 'o!_hiszpanskie_dziewczyny'),
  ('o!_grosza_daj_wiedzminowi@jaskier', 'o!_szyszke_daj_harcerzowi@12_dh_silva'),
  ('o!_jak_to_dobrze_byc_harcerzem', 'o!_sosenka_39_dh'),
  ('o!_wedrowiec', 'o!_wedrowne_ostrezyny'),
  ('o!_duch_gor@michal_zielen', 'o!_wladca_morz@michal_zielen'),
  ('o!_bieszczadzki_trakt', 'o!_sepowy_trakt'),
  ('o!_pokrzywa', 'o!_stokrotka'),
  ('o!_dom_wschodzacego_slonca@kult', 'o!_w_wieziennym_szpitalu'),
];

/// Niepowiązane, choć coś je łączy: wokalizy („laj la”), krótkie frazy
/// („jeszcze raz”, „wszystko co mam”), angielskie słowa, tytuł ukryty
/// użyty jak tag, długa piosenka „zawierająca” słownictwo krótkiej.
const _unrelated = [
  ('o!_sto_lat', 'o!_koleda_dla_nieobecnych'),
  ('o!_polnoc', 'o!_biale_golebie@stare_dobre_malzenstwo'),
  ('o!_duch_gor@michal_zielen', 'o!_biale_golebie@stare_dobre_malzenstwo'),
  ('o!_sluchaj_izraelu@2tm23', 'o!_jestem_kims@norbert_sliwka'),
  ('o!_oto_pan_bog_przyjdzie', 'o!_alleluja_pl'),
  ('o!_evry_night@mandaryna', 'o!_hit_the_road_jack@ray_charles'),
  ('o!_korespondencja_klasowa@jacek_kaczmarski', 'o!_wolanie_do_kogos_na_swiecie@mikroklimat'),
  ('o!_dzis_pozno_pojde_spac', 'o!_wodymidaj'),
  ('o!_paradise_by_the_dashboard_light', 'o!_treat_you_better@shawn_mendes'),
];

void main() {
  late final List<SongRaw> book;
  late final SongIndex<SongRaw> index;

  setUpAll(() {
    final (official, conf) = importHrcpsng(File('assets/songs/all_songs.hrcpsng').readAsStringSync());
    book = [...official, ...conf];
    index = SongIndex(book);
  });

  MatchLevel? between(String a, String b) => levelOf(compare(SongProfile(index.byId(a)!), SongProfile(index.byId(b)!)));

  group('pary ze śpiewnika:', () {
    test('ta sama piosenka pod innym tytułem albo w innej wersji', () {
      for (final (a, b) in _sameSong) {
        expect(between(a, b)?.isSameSong, isTrue, reason: '$a ~ $b: ${between(a, b)}');
      }
    });

    test('przeróbki i ta sama melodia', () {
      for (final (a, b) in _related) {
        final l = between(a, b);
        expect(l?.byContent, isTrue, reason: '$a ~ $b: $l');
        expect(l?.isSameSong, isFalse, reason: '$a ~ $b: przeróbka to nie ta sama piosenka');
      }
    });

    test('niepowiązane, choć coś je łączy', () {
      for (final (a, b) in _unrelated) {
        expect(between(a, b)?.byContent ?? false, isFalse, reason: '$a ~ $b: ${between(a, b)}');
      }
    });
  });

  test('tło: ile par w całym śpiewniku coś łączy', () {
    // Strażnik progów: gdy po zmianie reguł ta liczba skoczy, znaczy, że
    // mechanizm zaczął łączyć przypadkowe pary. Przy przyroście śpiewnika
    // trzeba ją przejrzeć i przestawić.
    final pairs = <MatchLevel, Set<String>>{};
    final sw = Stopwatch()..start();
    for (var i = 0; i < book.length; i++) {
      final song = book[i];
      for (final m in index.matches(index.profiles[i], exclude: (s) => identical(s, song))) {
        pairs.putIfAbsent(m.level!, () => {}).add(([song.id, m.song.id]..sort()).join(' ~ '));
      }
    }
    final counts = {for (final l in MatchLevel.values) l: pairs[l]?.length ?? 0};
    // ignore: avoid_print
    print('pary w śpiewniku: $counts (${sw.elapsedMilliseconds} ms na ${book.length} zapytań)');
    final sameSong = MatchLevel.values.where((l) => l.isSameSong).fold(0, (a, l) => a + counts[l]!);
    final byContent = MatchLevel.values.where((l) => l.byContent).fold(0, (a, l) => a + counts[l]!);
    // Stan z września 2026: 36 par tej samej piosenki, 82 połączone treścią.
    expect(sameSong, inInclusiveRange(30, 42));
    expect(byContent, inInclusiveRange(70, 95));
  });

  group('scenariusze — zgłoszenie pod nowym tytułem:', () {
    // Co trzeba złapać i jak: dla każdej zmiany odsetek piosenek, przy
    // których wniosek jest taki, jak trzeba.
    bool same(MatchLevel? l) => l?.isSameSong ?? false;
    // (zmiana, jaki wniosek jest dobry, minimalny odsetek dobrych wniosków).
    // Zmierzone na 60 piosenkach: 98–100% wszędzie — progi mają zapas na
    // losowość, nie na gorszy mechanizm.
    final cases = <String, (Perturbation, bool Function(MatchLevel?), double)>{
      'inne tylko metadane': (metadataOnly, same, 0.97),
      'refren nieoznaczony': (refrainNotMarked, same, 0.97),
      'refren tylko raz': (refrainOnce, same, 0.97),
      'refren na początku': (refrainFirst, same, 0.97),
      'inna kolejność zwrotek': (reorderVerses, same, 0.97),
      '+1 zwrotka': (addVerses(1), same, 0.97),
      '+4 zwrotki': (addVerses(4), (l) => l == MatchLevel.longer, 0.95),
      'tylko 1. zwrotka': (firstVerseOnly, (l) => l == MatchLevel.shorter, 0.95),
      'literówki w 5% słów': (typos(0.05), same, 0.97),
      'literówki w 20% słów': (typos(0.20), same, 0.9),
      'sklejone wersy': (joinLines, same, 0.97),
      'transpozycja': (transposeUp2, same, 0.97),
      'wszystko naraz': (everything, same, 0.95),
      'przeróbka: 40% słów': (parody(0.4), (l) => (l?.byContent ?? false) && !l!.isSameSong, 0.9),
      'przeróbka: 60% słów': (parody(0.6), (l) => l?.byContent ?? false, 0.85),
    };

    for (final MapEntry(key: name, value: (change, ok, minRate)) in cases.entries) {
      test(name, () {
        final r = Random(7);
        final eligible = [
          for (var i = 0; i < book.length; i++)
            if (index.profiles[i].words.length >= 40 && book[i].songParts.length >= 2) i
        ]..shuffle(r);
        var n = 0, hits = 0, closest = 0;
        for (final i in eligible) {
          if (n == 60) break;
          final json = change(songJson(book[i]), r, book);
          if (json == null) continue;
          json['title'] = 'Zupełnie nowy tytuł $n';
          json['hid_titles'] = <String>[];
          final probe = SongProfile(fromJson('probe_$n', json));
          n++;
          if (ok(levelOf(compare(probe, index.profiles[i])))) hits++;
          if (identical(index.closest(probe)?.song, book[i])) closest++;
        }
        // ignore: avoid_print
        print('$name: ${(100 * hits / n).round()}% wniosków, ${(100 * closest / n).round()}% closest (n=$n)');
        expect(hits / n, greaterThanOrEqualTo(minRate));
        // Ta sama piosenka pod nowym tytułem ma wygrać z każdą inną —
        // piosenkomat bierze właśnie najsilniejsze trafienie.
        if (ok(MatchLevel.sameSong) || ok(MatchLevel.longer) || ok(MatchLevel.shorter)) {
          expect(closest / n, greaterThanOrEqualTo(0.95));
        }
      });
    }
  });
}
