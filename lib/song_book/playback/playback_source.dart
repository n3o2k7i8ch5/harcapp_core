/// Skąd ma lecieć dźwięk: konkretne nagranie mp3 albo film piosenki.
library;

import 'package:harcapp_core/song_book/song_core.dart';

import 'song_audio.dart';

/// Dwa rodzaje źródeł jako dwa typy — `switch` po nich jest wyczerpujący,
/// a nagranie ma tylko [Mp3Source], bez `audio!`.
sealed class PlaybackSource {

  final SongCore song;

  const PlaybackSource(this.song);

  const factory PlaybackSource.mp3(SongCore song, SongAudio audio) = Mp3Source;
  const factory PlaybackSource.youtube(SongCore song) = YoutubeSource;

  /// Nagranie — `null` przy filmie. Zostaje dla gospodarzy (apka buduje z niego
  /// powiadomienie); w rdzeniu rozróżniamy typem.
  SongAudio? get audio;

  bool get isYoutube => this is YoutubeSource;

  /// Adres do otwarcia poza odtwarzaczem: film na YouTube albo sam plik mp3.
  /// Tego używa podgląd na stronie zamiast grać.
  String? get externalUrl => switch (this) {
        Mp3Source(:final audio) => audio.url,
        YoutubeSource() => song.youtubeUrl,
      };

  @override
  bool operator ==(Object other) =>
      other is PlaybackSource &&
      other.song.id == song.id &&
      other.audio?.fileName == audio?.fileName;

  @override
  int get hashCode => Object.hash(song.id, audio?.fileName);

}

/// Konkretne nagranie mp3.
final class Mp3Source extends PlaybackSource {

  @override
  final SongAudio audio;

  const Mp3Source(super.song, this.audio);

}

/// Film piosenki z YouTube'a.
final class YoutubeSource extends PlaybackSource {

  const YoutubeSource(super.song);

  @override
  SongAudio? get audio => null;

}

/// Wszystkie źródła piosenki, w kolejności kafelków: nagrania, potem film.
List<PlaybackSource> playbackSourcesOf(SongCore song) => [
  for (final SongAudio audio in AudioMeta.audiosOf(song.id)) PlaybackSource.mp3(song, audio),
  if (song.youtubeVideoId?.isNotEmpty ?? false) PlaybackSource.youtube(song),
];

/// Co odpalić, gdy nikt nie wybrał: mp3 ma pierwszeństwo — lepszy dźwięk
/// i nie wymaga WebView. `null`, gdy piosenka nie ma czym grać.
PlaybackSource? preferredPlaybackSourceOf(SongCore song) => playbackSourcesOf(song).firstOrNull;
