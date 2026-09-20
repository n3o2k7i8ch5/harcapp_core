import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/playback/playback_source.dart';
import 'package:harcapp_core/song_book/playback/song_audio.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

// Wycinek prawdziwego `audio_meta.json`.
const _json = '''
{
    "o!_bagno": [
        {"file": "bagno.0.mp3", "performer": null, "source": "https://www.youtube.com/watch?v=7BJZaNN_Sl0"}
    ],
    "o!_ballada_o_morzu@hania_czajkowska": [
        {"file": "ballada_o_morzu.hania_czajkowska.mp3", "performer": "Hania Czajkowska", "source": "https://www.youtube.com/watch?v=gr78WI3KWdU"},
        {"file": "", "performer": "Bez pliku"},
        "to nie jest mapa"
    ],
    "o!_pusta": [],
    "o!_zepsuta": "nie lista"
}
''';

SongRaw song(String id, {String? yt}) {
  final s = SongRaw.empty(id: id);
  s.title = id;
  s.youtubeVideoId = yt;
  return s;
}

void main() {

  tearDown(AudioMeta.reset);

  group('AudioMeta.parse:', () {
    test('czyta wpisy, gubi zepsute po cichu', () {
      final got = AudioMeta.parse(_json);
      expect(got.keys, ['o!_bagno', 'o!_ballada_o_morzu@hania_czajkowska']);
      expect(got['o!_bagno']!.single.performer, isNull);
      expect(got['o!_bagno']!.single.source, 'https://www.youtube.com/watch?v=7BJZaNN_Sl0');
      // Nagranie bez pliku i wpis, który nie jest mapą — odpadają.
      expect(got['o!_ballada_o_morzu@hania_czajkowska']!.map((a) => a.fileName),
          ['ballada_o_morzu.hania_czajkowska.mp3']);
    });

    test('url składa się z bazy i nazwy pliku', () {
      expect(const SongAudio('bagno.0.mp3').url, '${SongAudio.baseUrl}bagno.0.mp3');
    });

    test('nie-JSON i nie-mapa → pusto, bez wyjątku', () {
      expect(AudioMeta.parse('[]'), isEmpty);
      expect(AudioMeta.parse('{}'), isEmpty);
    });
  });

  group('playbackSourcesOf:', () {
    test('nagrania przed filmem; bez rejestru — tylko film', () {
      final s = song('o!_bagno', yt: 'abc');
      expect(playbackSourcesOf(s).map((p) => p.isYoutube), [true],
          reason: 'rejestr niezaładowany');

      AudioMeta.set(AudioMeta.parse(_json));
      final sources = playbackSourcesOf(s);
      expect(sources.map((p) => p.isYoutube), [false, true]);
      expect(sources.first.audio!.fileName, 'bagno.0.mp3');
      expect(preferredPlaybackSourceOf(s), sources.first);
    });

    test('bez filmu i bez nagrań → pusto, preferowane null', () {
      expect(playbackSourcesOf(song('o!_nic')), isEmpty);
      expect(preferredPlaybackSourceOf(song('o!_nic')), isNull);
      expect(playbackSourcesOf(song('o!_nic', yt: '')), isEmpty, reason: 'puste id filmu to brak filmu');
    });

    test('externalUrl: film ze schematem, mp3 pod swoim adresem', () {
      AudioMeta.set(AudioMeta.parse(_json));
      final s = song('o!_bagno', yt: 'abc');
      final [mp3, yt] = playbackSourcesOf(s);
      expect(yt.externalUrl, 'https://www.youtube.com/watch?v=abc');
      expect(mp3.externalUrl, '${SongAudio.baseUrl}bagno.0.mp3');
    });

    test('równość po id piosenki i pliku, nie po obiekcie', () {
      AudioMeta.set(AudioMeta.parse(_json));
      final a = playbackSourcesOf(song('o!_bagno', yt: 'x'));
      final b = playbackSourcesOf(song('o!_bagno', yt: 'x'));
      expect(a, b);
      expect(a.first.hashCode, b.first.hashCode);
      expect(a.first, isNot(a.last));
    });
  });

  test('SongCore.youtubeUrl: pełny link albo null', () {
    expect(song('x', yt: 'abc').youtubeUrl, 'https://www.youtube.com/watch?v=abc');
    expect(song('x').youtubeUrl, isNull);
    expect(song('x', yt: '').youtubeUrl, isNull);
  });

}
