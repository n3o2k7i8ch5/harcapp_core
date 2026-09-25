/// Nazwy plików `.hrcpsng`, po których piosenkomat poznaje etap przeglądu.
/// Jedno miejsce dla narzędzia i dla edytora na stronie — inaczej literówka
/// po jednej stronie rozjeżdża przegląd po cichu.
library;

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

const String kSongFileExtension = 'hrcpsng';

/// Co piosenkomat wypluł do przeglądu.
String candidatesFileName(SubmissionKind kind) =>
    'candidates-${kind.id}.$kSongFileExtension';

/// Co wraca z przeglądu — z werdyktami i odpowiedziami do autorów.
String reviewedFileName(SubmissionKind kind) =>
    'reviewed-${kind.id}.$kSongFileExtension';

/// Po `prepare`: bez śladu piosenkomatu, gotowe do wklejenia w `all_songs`.
String finalFileName(SubmissionKind kind) =>
    'final-${kind.id}.$kSongFileExtension';

/// Nazwa, pod jaką edytor ma zapisać [songs].
///
/// `reviewed-*` to obietnica, że to ta sama paczka co `candidates-*`, tylko
/// przejrzana — dlatego wymaga, by **każda** piosenka była z piosenkomatu
/// i wszystkie tego samego rodzaju. Poza tym nazwa neutralna.
///
/// Rodzaj czytamy z samych piosenek, nie z zapamiętanego „co wczytano”: ślad
/// jedzie z piosenką i wraca w pliku, więc nie ma stanu do rozjechania.
String suggestedSaveFileName(List<SongRaw> songs) {
  final kind = piosenkomatReviewKind(songs);
  if (kind != null) return reviewedFileName(kind);
  return '${songs.length}_songs.$kSongFileExtension';
}

/// Rodzaj paczki z przeglądu, albo `null`, gdy to nie paczka z przeglądu:
/// piosenka bez śladu piosenkomatu, wymieszane rodzaje albo pusto.
SubmissionKind? piosenkomatReviewKind(List<SongRaw> songs) {
  if (songs.isEmpty) return null;
  SubmissionKind? kind;
  for (final song in songs) {
    final data = song.piosenkomatData;
    if (data == null) return null;
    if (kind != null && data.kind != kind) return null;
    kind = data.kind;
  }
  return kind;
}
