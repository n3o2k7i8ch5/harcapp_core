import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/song_element.dart';
import 'package:harcapp_core/song_book/submission/submission_email.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:harcapp_core/values/people/models.dart';

SongRaw _song({String title = 'Piosenka testowa XYZ'}) {
  final s = SongRaw.empty(id: 'tmp');
  s.title = title;
  s.hasRefren = false;
  s.songParts = [SongPart.from(SongElement('Ala ma kota a kot ma ale\nW lesie gra muzyka', 'a d e\na d e', false))];
  return s;
}

void main() {
  test('obieg w obie strony: co zapisane, to wczytane', () {
    final song = _song(title: 'Barka');
    final file = SongSubmissionFile(
      origin: SubmissionOrigin.appAndroid,
      appVersion: '2.4.1',
      acceptedRulesVersion: 'v05.10.2025',
      submissions: [
        SongSubmission(
          kind: SubmissionKind.correction,
          correctionTarget: 'o!_barka',
          correctionMessage: 'poprawka chwytu w refrenie',
          senderIsContributor: false,
          registered: const RegisteredContributor(
            person: Person(name: 'Jan Kowalski'),
            emails: ['jan.kowalski@example.com'],
          ),
          song: song,
        ),
      ],
    );

    final back = SongSubmissionFile.decode(file.encode());
    expect(back.format, kSubmissionFormat);
    expect(back.origin, SubmissionOrigin.appAndroid);
    expect(back.appVersion, '2.4.1');
    expect(back.acceptedRulesVersion, 'v05.10.2025');
    final s = back.submissions.single;
    expect(s.kind, SubmissionKind.correction);
    expect(s.correctionTarget, 'o!_barka');
    expect(s.correctionMessage, 'poprawka chwytu w refrenie');
    expect(s.senderIsContributor, isFalse);
    expect(s.registered?.person.name, 'Jan Kowalski');
    expect(s.registered?.emails, ['jan.kowalski@example.com']);
    expect(s.song.title, 'Barka');
    expect(s.song.text, song.text);
    expect(s.song.chords, song.chords);
  });

  test('suma liczy się z postaci kanonicznej, nie z formatowania', () {
    final file = SongSubmissionFile(submissions: [
      SongSubmission(kind: SubmissionKind.newSong, song: _song()),
    ]);
    final map = file.toJsonMap();
    // Klucze w innej kolejności i inne wcięcia to ten sam plik.
    final shuffled = {
      for (final k in map.keys.toList().reversed) k: map[k],
    };
    expect(submissionDigest(shuffled), map[SongSubmissionFile.PARAM_DIGEST]);
    expect(SongSubmissionFile.decode(jsonEncode(shuffled)).submissions, hasLength(1));
  });

  test('ręczna edycja pliku psuje sumę', () {
    final raw = SongSubmissionFile(submissions: [
      SongSubmission(kind: SubmissionKind.newSong, song: _song(title: 'Barka')),
    ]).encode();
    final edited = raw.replaceFirst('Barka', 'Barka poprawiona');
    expect(
      () => SongSubmissionFile.decode(edited),
      throwsA(isA<SubmissionFileError>()
          .having((e) => e.kind, 'kind', SubmissionFileErrorKind.badDigest)),
    );
  });

  test('obcięty plik to plik uszkodzony, nie pusty', () {
    final raw = SongSubmissionFile(submissions: [
      SongSubmission(kind: SubmissionKind.newSong, song: _song()),
    ]).encode();
    expect(
      () => SongSubmissionFile.decode(raw.substring(0, raw.length ~/ 2)),
      throwsA(isA<SubmissionFileError>()
          .having((e) => e.kind, 'kind', SubmissionFileErrorKind.corrupted)),
    );
  });

  test('nowsza wersja formatu nie jest zgadywana', () {
    final map = SongSubmissionFile(submissions: [
      SongSubmission(kind: SubmissionKind.newSong, song: _song()),
    ]).toJsonMap()
      ..[SongSubmissionFile.PARAM_FORMAT] = kSubmissionFormat + 1;
    map[SongSubmissionFile.PARAM_DIGEST] = submissionDigest(map);
    expect(
      () => SongSubmissionFile.decode(jsonEncode(map)),
      throwsA(isA<SubmissionFileError>()
          .having((e) => e.kind, 'kind', SubmissionFileErrorKind.unknownFormat)),
    );
  });

  test('pole złego typu z poprawną sumą to plik uszkodzony, nie wywrotka', () {
    Map<String, dynamic> fileWith(void Function(Map<String, dynamic> map) edit) {
      final map = SongSubmissionFile(submissions: [
        SongSubmission(kind: SubmissionKind.newSong, song: _song()),
      ]).toJsonMap();
      edit(map);
      return map..[SongSubmissionFile.PARAM_DIGEST] = submissionDigest(map);
    }

    for (final map in [
      fileWith((m) => m[SongSubmissionFile.PARAM_ORIGIN] = 5),
      fileWith((m) => (m[SongSubmissionFile.PARAM_SUBMISSIONS] as List).first
          [SongSubmission.PARAM_SENDER_IS_CONTRIBUTOR] = 'tak'),
    ]) {
      expect(
        () => SongSubmissionFile.decode(jsonEncode(map)),
        throwsA(isA<SubmissionFileError>()
            .having((e) => e.kind, 'kind', SubmissionFileErrorKind.corrupted)),
      );
    }
  });

  test('plik bez zgłoszeń', () {
    final map = SongSubmissionFile(submissions: const []).toJsonMap();
    expect(
      () => SongSubmissionFile.decode(jsonEncode(map)),
      throwsA(isA<SubmissionFileError>()
          .having((e) => e.kind, 'kind', SubmissionFileErrorKind.noSubmissions)),
    );
  });

  test('nazwa załącznika: krótka i czysto ASCII', () {
    // Długą albo niełacińską klient pocztowy zakoduje po RFC 2231, a takiej
    // czytnik `.eml` nie odczyta.
    expect(kSubmissionFileName,
        matches(RegExp('^[a-z]+\\.$kSubmissionFileExtension\$')));
    expect(kSubmissionFileName.length, lessThan(30));
  });

  test('treść ma dwie belki i nic maszynowego', () {
    final mail = composeSongSubmissionEmail(
      submissions: [SongSubmission(kind: SubmissionKind.newSong, song: _song())],
      origin: SubmissionOrigin.appAndroid,
      acceptedRulesVersion: 'v05.10.2025',
    );
    expect(mail.subject, contains('[hrcpsng/app]'));
    expect(mail.subject, isNot(contains('świeżak')));
    expect(mail.body, contains(kSubmissionConsentBar));
    expect(mail.body, contains(kSubmissionStructuralBar));
    expect(mail.body, contains(mail.fileName));
    expect(mail.body, contains(kSubmissionOneSongPerMailNote));
    for (final gone in const [
      '### Kod piosenki:',
      '### Osoba dodająca',
      '### Propozycja poprawki:',
      '### Źródło piosenki:',
      'Miejsce na własną wiadomość',
      'Nie edytuj poniższego',
    ]) {
      expect(mail.body, isNot(contains(gone)), reason: '„$gone” miało zniknąć z treści');
    }
  });

  test('dopisek autora to wszystko nad zamrożoną belką', () {
    final mail = composeSongSubmissionEmail(
      submissions: [SongSubmission(kind: SubmissionKind.newSong, song: _song())],
      origin: SubmissionOrigin.appAndroid,
      acceptedRulesVersion: 'v05.10.2025',
    );
    expect(extractSubmissionUserMessage(mail.body), isNull,
        reason: 'sama podpowiedź to nie dopisek');
    final withNote = mail.body.replaceFirst(
        kSubmissionUserMessagePlaceholder, 'Hej, tę piosenkę śpiewamy na obozie.');
    expect(extractSubmissionUserMessage(withNote), 'Hej, tę piosenkę śpiewamy na obozie.');
    // Cytowanie w odpowiedzi nie może zgubić dopisku.
    final quoted = withNote.split('\n').map((l) => '> $l').join('\n');
    expect(extractSubmissionUserMessage(quoted), 'Hej, tę piosenkę śpiewamy na obozie.');
    expect(extractSubmissionUserMessage('mejl w starym kształcie'), isNull);
  });
}
