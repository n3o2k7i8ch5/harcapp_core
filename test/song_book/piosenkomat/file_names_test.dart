import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/piosenkomat/file_names.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

void main() {
  test('nazwa zapisu z edytora liczy się z samych piosenek', () {
    SongRaw z(SubmissionKind kind) => SongRaw.empty(id: 'tmp')
      ..piosenkomatData = PiosenkomatData(kind: kind);

    // Cała paczka z przeglądu, jeden rodzaj.
    expect(
        suggestedSaveFileName([z(SubmissionKind.newSong), z(SubmissionKind.newSong)]),
        'reviewed-new.hrcpsng');
    expect(suggestedSaveFileName([z(SubmissionKind.correction)]),
        'reviewed-correction.hrcpsng');

    // Cokolwiek innego — nazwa neutralna.
    expect(suggestedSaveFileName([]), '0_songs.hrcpsng',
        reason: 'pusto');
    expect(suggestedSaveFileName([z(SubmissionKind.newSong), SongRaw.empty(id: 'tmp')]),
        '2_songs.hrcpsng',
        reason: 'piosenka dorzucona z ręki, bez śladu piosenkomatu');
    expect(
        suggestedSaveFileName([z(SubmissionKind.newSong), z(SubmissionKind.correction)]),
        '2_songs.hrcpsng',
        reason: 'nowe zmieszane z poprawkami — narzędzie czyta je osobno');
  });
}
