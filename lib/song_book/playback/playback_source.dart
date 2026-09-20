/// Skąd ma lecieć dźwięk: konkretne nagranie mp3 albo film piosenki.
library;

import 'package:harcapp_core/song_book/song_core.dart';

import 'song_audio.dart';

class PlaybackSource {

  final SongCore song;

  /// `null` oznacza film z YouTube'a.
  final SongAudio? audio;

  const PlaybackSource.mp3(this.song, SongAudio this.audio);
  const PlaybackSource.youtube(this.song) : audio = null;

  bool get isYoutube => audio == null;

  /// Adres do otwarcia poza odtwarzaczem: film na YouTube albo sam plik mp3.
  /// Tego używa podgląd na stronie zamiast grać.
  String? get externalUrl => isYoutube ? song.youtubeUrl : audio!.url;

  @override
  bool operator ==(Object other) =>
      other is PlaybackSource &&
      other.song.id == song.id &&
      other.audio?.fileName == audio?.fileName;

  @override
  int get hashCode => Object.hash(song.id, audio?.fileName);

}

/// Wszystkie źródła piosenki, w kolejności kafelków: nagrania, potem film.
List<PlaybackSource> playbackSourcesOf(SongCore song) => [
  for (final SongAudio audio in AudioMeta.audiosOf(song.id)) PlaybackSource.mp3(song, audio),
  if (song.youtubeVideoId?.isNotEmpty ?? false) PlaybackSource.youtube(song),
];

/// Co odpalić, gdy nikt nie wybrał: mp3 ma pierwszeństwo — lepszy dźwięk
/// i nie wymaga WebView. `null`, gdy piosenka nie ma czym grać.
PlaybackSource? preferredPlaybackSourceOf(SongCore song) => playbackSourcesOf(song).firstOrNull;
