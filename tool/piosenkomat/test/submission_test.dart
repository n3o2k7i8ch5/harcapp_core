import 'dart:convert';

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/submission/submission_email.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/people.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

Classified _classify(String eml, {SongBook? book, String id = 'm1'}) =>
    classify(msgFrom(eml, id: id), book: book ?? SongBook.empty);

void main() {

  test('obieg w obie strony: co zapisane, to wczytane', () {
    final song = sampleSong(title: 'Barka');
    final file = SongSubmissionFile(
      source: SubmissionOrigin.appAndroid,
      appVersion: '2.4.1',
      rulesVersion: 'v05.10.2025',
      submissions: [
        SongSubmission(
          kind: SubmissionKind.correction,
          correctedSongId: 'o!_barka',
          correctionMessage: 'poprawka chwytu w refrenie',
          senderIsContributor: false,
          contributor: const RegisteredContributor(
            person: Person(name: 'Jan Kowalski'),
            emails: ['jan.kowalski@example.com'],
          ),
          song: song,
        ),
      ],
    );

    final back = SongSubmissionFile.decode(file.encode());
    expect(back.format, kSubmissionFormat);
    expect(back.source, SubmissionOrigin.appAndroid);
    expect(back.appVersion, '2.4.1');
    expect(back.rulesVersion, 'v05.10.2025');
    final s = back.submissions.single;
    expect(s.kind, SubmissionKind.correction);
    expect(s.correctedSongId, 'o!_barka');
    expect(s.correctionMessage, 'poprawka chwytu w refrenie');
    expect(s.senderIsContributor, isFalse);
    expect(s.contributor?.person.name, 'Jan Kowalski');
    expect(s.contributor?.emails, ['jan.kowalski@example.com']);
    expect(s.song.title, 'Barka');
    expect(s.song.text, song.text);
    expect(s.song.chords, song.chords);
  });

  test('suma liczy się z postaci kanonicznej, nie z formatowania', () {
    final file = SongSubmissionFile(submissions: [
      SongSubmission(kind: SubmissionKind.newSong, song: sampleSong()),
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
      SongSubmission(kind: SubmissionKind.newSong, song: sampleSong(title: 'Barka')),
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
      SongSubmission(kind: SubmissionKind.newSong, song: sampleSong()),
    ]).encode();
    expect(
      () => SongSubmissionFile.decode(raw.substring(0, raw.length ~/ 2)),
      throwsA(isA<SubmissionFileError>()
          .having((e) => e.kind, 'kind', SubmissionFileErrorKind.corrupted)),
    );
  });

  test('nowsza wersja formatu nie jest zgadywana', () {
    final map = SongSubmissionFile(submissions: [
      SongSubmission(kind: SubmissionKind.newSong, song: sampleSong()),
    ]).toJsonMap()
      ..[SongSubmissionFile.PARAM_FORMAT] = kSubmissionFormat + 1;
    map[SongSubmissionFile.PARAM_DIGEST] = submissionDigest(map);
    expect(
      () => SongSubmissionFile.decode(jsonEncode(map)),
      throwsA(isA<SubmissionFileError>()
          .having((e) => e.kind, 'kind', SubmissionFileErrorKind.unknownFormat)),
    );
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
      submissions: [SongSubmission(kind: SubmissionKind.newSong, song: sampleSong())],
      origin: SubmissionOrigin.appAndroid,
      acceptRulesVersion: 'v05.10.2025',
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
      '### Poprawiana piosenka:',
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
      submissions: [SongSubmission(kind: SubmissionKind.newSong, song: sampleSong())],
      origin: SubmissionOrigin.appAndroid,
      acceptRulesVersion: 'v05.10.2025',
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

  test('.eml z załącznikiem przechodzi cały przebieg', () {
    final mail = submissionEmail(userMessage: 'Dorzućcie proszę chwyty.');
    final m = msgFrom(mail.eml);
    expect(m.isSongSubmission, isTrue);
    expect(m.submissionAttachment, isNotNull);
    expect(m.subject, contains('[hrcpsng/app]'));

    final c = classify(m, book: SongBook.empty);
    expect(c.destination, Destination.candidateNew);
    expect(c.submission.shape, EmailShape.file);
    expect(c.submission.origin, SubmissionOrigin.appAndroid);
    expect(c.submission.appVersion, '2.4.1');
    expect(c.submission.sender, 'jan.testowy@example.com');
    expect(c.submission.consentVersion, 'v05.10.2025');
    expect(c.submission.userMessage, 'Dorzućcie proszę chwyty.');
    expect(issuesOf(c), [SongIssue.hasUserMessage]);
    expect(c.song!.contributorData!.acceptedContributionRulesVersion, 'v05.10.2025');
    expect(c.song!.piosenkomatData!.sender, 'jan.testowy@example.com');
    expect(c.song!.piosenkomatData!.isOldApp, isFalse);
    expect(c.song!.piosenkomatData!.appVersion, '2.4.1');
  });

  test('rodzaj bierze się z pliku, nie z tematu', () {
    final mail = submissionEmail(submissions: [
      SongSubmission(
        kind: SubmissionKind.correction,
        correctedSongId: 'o!_barka',
        correctionMessage: 'poprawiony refren',
        song: sampleSong(title: 'Barka'),
      ),
    ]);
    // Temat da się zmienić w kliencie; plik rozstrzyga i tak.
    final mangled = mail.eml.replaceFirst('Subject: Poprawka piosenki', 'Subject: Nowa piosenka');
    // Poprawka musi się różnić od pierwowzoru: identyczna trafia do „sam mejl”.
    final book = bookWith([
      sampleSong(title: 'Barka', chordsText: 'C G a\nC G a')..id = 'o!_barka',
    ]);
    final c = _classify(mangled, book: book);
    expect(c.destination, Destination.candidateCorrection);
    expect(c.submission.declaredCorrectionTarget, 'o!_barka');
    expect(c.submission.correctionTarget, 'o!_barka');
    expect(c.submission.correctionTargetGuessed, isFalse);
    expect(c.submission.correctionMessage, 'poprawiony refren');
    expect(issuesOf(c), isEmpty);
  });

  test('uszkodzony załącznik: odrzut z „rzuć okiem”, nie worek „nie umiem”', () {
    final mail = submissionEmail(mangle: (f) => f.replaceFirst('Piosenka', 'Piosenki'));
    final c = _classify(mail.eml);
    expect(c.destination, Destination.rejectCorruptedFile);
    expect(issuesOf(c), [SongIssue.corruptedSubmissionFile]);
    expect(c.labels, containsAll([kLabelRejectedCorruptedFile, kLabelHaveALook]));
    expect(c.labels, isNot(contains(kLabelRejectedUnparsable)));
    expect(c.labels.any((l) => l.startsWith(kLabelNeedsReview)), isFalse,
        reason: 'piosenki nie ma w pliku, piosenkomat nie ma tu nic do roboty');
    expect(kToolLabels, containsAll([kLabelRejectedCorruptedFile, kLabelHaveALook]),
        reason: 'bez tego --push wywali się na brakującej etykiecie');
  });

  test('nieznana wersja formatu ma własną etykietę', () {
    final mail = submissionEmail(mangle: (raw) {
      final map = (jsonDecode(raw) as Map).cast<String, dynamic>()
        ..[SongSubmissionFile.PARAM_FORMAT] = kSubmissionFormat + 1;
      map[SongSubmissionFile.PARAM_DIGEST] = submissionDigest(map);
      return jsonEncode(map);
    });
    final c = _classify(mail.eml);
    expect(issuesOf(c), [SongIssue.unknownSubmissionFormat]);
    expect(c.labels, containsAll([kLabelRejectedUnknownFormat, kLabelHaveALook]));
    expect(kToolLabels, contains(kLabelRejectedUnknownFormat));
  });

  test('kilka zgłoszeń w pliku: nic nie wchodzi, mejl do ręcznego ogarnięcia', () {
    final mail = submissionEmail(submissions: [
      SongSubmission(kind: SubmissionKind.newSong, song: sampleSong(title: 'Pierwsza')),
      SongSubmission(kind: SubmissionKind.newSong, song: sampleSong(title: 'Druga')),
      SongSubmission(kind: SubmissionKind.newSong, song: sampleSong(title: 'Trzecia')),
    ]);
    final c = _classify(mail.eml);
    expect(c.destination, Destination.multipleSongs);
    expect(c.goesToFile, isFalse);
    expect(c.decision.detail, contains('3 zgłoszeń'));
    expect(c.labels, unorderedEquals([kLabelMultipleSongs, kLabelHaveALook]));
    // Nie rozstrzygamy, więc mejl zostaje nieprzeczytany.
    expect(withReadOnClose((c.labels, const <String>[])).$2, isNot(contains('UNREAD')));
  });

  test('kilka zgłoszeń, pierwsze identyczne z apką — i tak nie odrzut', () {
    final w = sampleSong(title: 'W apce');
    final mail = submissionEmail(submissions: [
      SongSubmission(kind: SubmissionKind.newSong, song: w),
      SongSubmission(kind: SubmissionKind.newSong, song: sampleSong(title: 'Nowa')),
    ]);
    final c = classify(msgFrom(mail.eml), book: bookWith([sampleSong(title: 'W apce')]));
    expect(c.destination, Destination.multipleSongs);
    expect(c.labels, contains(kLabelHaveALook));
  });

  test('piosenki z takiego mejla nie są punktem odniesienia w paczce', () {
    final multi = submissionEmail(submissions: [
      SongSubmission(kind: SubmissionKind.newSong, song: sampleSong(title: 'Barka')),
      SongSubmission(kind: SubmissionKind.newSong, song: sampleSong(title: 'Inna')),
    ]);
    final single = submissionEmail(song: sampleSong(title: 'Barka'));
    final out = classifyBatch(
        [msgFrom(multi.eml, id: 'multi'), msgFrom(single.eml, id: 'single')],
        book: SongBook.empty);
    final byId = {for (final c in out) c.message.id: c};
    expect(byId['multi']!.destination, Destination.multipleSongs);
    expect(byId['single']!.isClean, isTrue,
        reason: 'druga „Barka” siedzi w mejlu, który do pliku nie idzie');
  });

  test('wysyłka w cudzym imieniu: adres nadawcy tylko do odpisania', () {
    final song = sampleSong(title: 'Cudza');
    final mail = submissionEmail(submissions: [
      SongSubmission(
        kind: SubmissionKind.newSong,
        senderIsContributor: false,
        contributor: const RegisteredContributor(
          person: Person(name: 'Ewa Nieobecna'),
          emails: [],
        ),
        song: song,
      ),
    ]);
    final c = _classify(mail.eml);
    expect(c.submission.senderIsContributor, isFalse);
    expect(c.submission.sender, 'jan.testowy@example.com',
        reason: 'odpisać i tak trzeba mieć gdzie');
    expect(
      [for (final r in c.song!.contribRefs) r.emailRef],
      isNot(contains('jan.testowy@example.com')),
      reason: 'wkład nie jest nadawcy',
    );
    // Karta wskazanej osoby ma dojechać do przeglądu — bez adresu, ale ma.
    expect(
      [for (final r in c.song!.contribRefs) r.person?.name],
      contains('Ewa Nieobecna'),
    );
    expect(
      c.song!.contribRefs
          .firstWhere((r) => r.person?.name == 'Ewa Nieobecna')
          .emailRef,
      anyOf(isNull, isEmpty),
    );
    expect(c.song!.piosenkomatData!.senderIsContributor, isFalse);
    // I to samo na końcu przebiegu: do data.dart taki nadawca nie wchodzi.
    final people = collectPeople(contributorSourcesOf([c.song!]));
    expect(people.newContributors, isEmpty);
    expect(people.senderNotContributorByEmail.keys, ['jan.testowy@example.com']);
  });

  test('kilka kart osób dodających: adresu nie doklejamy, uwaga zostaje', () {
    final song = sampleSong(title: 'Wspólna');
    song.contribRefs = [
      const ContributorRef(person: Person(name: 'Ala Testowa')),
      const ContributorRef(person: Person(name: 'Ola Testowa')),
    ];
    final mail = submissionEmail(submissions: [
      SongSubmission(kind: SubmissionKind.newSong, song: song),
    ]);
    final c = _classify(mail.eml);
    expect(issuesOf(c), contains(SongIssue.severalContributors));
    expect(
      [for (final r in c.song!.contribRefs) r.emailRef],
      isNot(contains('jan.testowy@example.com')),
    );
  });

  test('zgłoszenie ze strony jest odsiewane, nie przeoczone', () {
    final mail = submissionEmail(origin: SubmissionOrigin.web);
    final m = msgFrom(mail.eml);
    expect(m.hasWebSubjectMarker, isTrue);
    expect(m.isSongSubmission, isFalse);
    expect(isWebSubmission(m), isTrue);

    // Temat człowiek może zmienić — wtedy rozstrzyga pole `source` w pliku.
    final noMarker = msgFrom(mail.eml.replaceFirst(' [hrcpsng/web]', ''), id: 'm2');
    expect(noMarker.isSongSubmission, isTrue);
    expect(isWebSubmission(noMarker), isTrue);
  });

  test('mejl przejściowy z dwoma załącznikami: wygrywa .hrcpsngsbm', () async {
    // Stary załącznik i stara treść niosą jedną piosenkę, nowy plik drugą.
    // Rozstrzyga nowy: tylko on niesie fakty o zgłoszeniu.
    final stara = sampleSong(title: 'Stara', lyrics: 'Tekst starej piosenki o morzu');
    final nowa = sampleSong(title: 'Nowa', lyrics: 'Zupełnie inny tekst o górach');

    final oldEml = await completeEmail(song: stara);
    final oldBody = oldEml.substring(oldEml.indexOf('\n\n') + 2);
    final mail = composeSongSubmissionEmail(
      submissions: [SongSubmission(kind: SubmissionKind.newSong, song: nowa)],
      origin: SubmissionOrigin.appAndroid,
      acceptRulesVersion: 'v05.10.2025',
    );

    String emlWith(String submissionFile) => mimeEmail(
          subject: mail.subject,
          body: oldBody,
          attachments: {
            'song_stara.hrcpsng': encodeHrcpsng([stara]),
            mail.fileName: submissionFile,
          },
        );

    final m = msgFrom(emlWith(mail.fileContent));
    expect(m.songAttachment, isNotNull, reason: 'stary załącznik też ma być widziany');
    expect(m.submissionAttachment, isNotNull);

    final c = classify(m, book: SongBook.empty);
    expect(c.title, 'Nowa');
    expect(c.submission.shape, EmailShape.file);

    // Gdy nowy plik jest uszkodzony, stara ścieżka jest wykonalna — ale nie
    // wolno po cichu z niej skorzystać: dane mogą się różnić.
    final broken = classify(
      msgFrom(emlWith(mail.fileContent.replaceFirst('Nowa', 'Nowaa')), id: 'm2'),
      book: SongBook.empty,
    );
    expect(broken.destination, Destination.rejectCorruptedFile);
    expect(issuesOf(broken), [SongIssue.corruptedSubmissionFile]);
  });

  test('prawdziwy kształt z klienta: złamany nagłówek, zagnieżdżony MIME, QP', () {
    // Gmail składa tak: `multipart/mixed` wokół `multipart/alternative`,
    // treść quoted-printable, temat złamany w połowie, załącznik w base64.
    final file = composeSongSubmissionEmail(
      submissions: [SongSubmission(kind: SubmissionKind.newSong, song: sampleSong())],
      origin: SubmissionOrigin.appAndroid,
      acceptRulesVersion: 'v05.10.2025',
    ).fileContent;
    final eml = 'From: Jan Testowy <jan.testowy@example.com>\n'
        'Subject: Nowa piosenka "Piosenka testowa XYZ"\n'
        ' [hrcpsng/app]\n'
        'Date: Thu, 11 Sep 2026 10:00:00 +0200\n'
        'Content-Type: multipart/mixed; boundary="OUTER"\n'
        '\n'
        '--OUTER\n'
        'Content-Type: multipart/alternative; boundary="INNER"\n'
        '\n'
        '--INNER\n'
        'Content-Type: text/plain; charset="UTF-8"\n'
        'Content-Transfer-Encoding: quoted-printable\n'
        '\n'
        'Zapomnia=C5=82em doda=C4=87: refren dwa =\n'
        'razy.\n'
        '\n'
        '$kSubmissionConsentBar\n'
        '\n'
        'Znam i akceptuj=C4=99 zasady.\n'
        '--INNER\n'
        'Content-Type: text/html; charset="UTF-8"\n'
        '\n'
        '<div>Zapomnia&#322;em</div>\n'
        '--INNER--\n'
        '--OUTER\n'
        'Content-Type: application/octet-stream; name="$kSubmissionFileName"\n'
        'Content-Disposition: attachment; filename="$kSubmissionFileName"\n'
        'Content-Transfer-Encoding: base64\n'
        '\n'
        '${base64.encode(utf8.encode(file))}\n'
        '--OUTER--\n';

    final m = msgFrom(eml);
    expect(m.subject, contains('[hrcpsng/app]'), reason: 'nagłówek złamany w połowie');
    expect(m.date, DateTime.utc(2026, 9, 11, 8));
    expect(m.body, startsWith('Zapomniałem dodać: refren dwa razy.'));
    expect(m.body, isNot(contains('<div>')), reason: 'treść bierzemy z text/plain');
    expect(m.submissionAttachment, file);

    final c = classify(m, book: SongBook.empty);
    expect(c.destination, Destination.candidateNew);
    expect(c.submission.userMessage, 'Zapomniałem dodać: refren dwa razy.');
  });

  test('ślad: stara apka jako flaga, bez wartości domyślnych w pliku', () {
    final map = const PiosenkomatData(
            isOldApp: true, sender: 'a@b.pl', appVersion: '2.4.1')
        .toJsonMap();
    expect(map[PiosenkomatData.PARAM_OLD_APP], isTrue);
    expect(PiosenkomatData.fromJsonMap(map).isOldApp, isTrue);
    expect(map['app_version'], '2.4.1');
    expect(map.containsKey('sender_is_contributor'), isFalse);
    expect(PiosenkomatData.fromJsonMap(map).sender, 'a@b.pl');
    expect(PiosenkomatData.fromJsonMap(map).senderIsContributor, isTrue);
  });

  test('stary format dalej działa obok nowego', () async {
    final old = await completeEmail(userMessage: 'dopisek ze starego mejla');
    final c = _classify(old);
    expect(c.destination, Destination.candidateNew);
    expect(c.submission.shape, EmailShape.fenced);
    expect(c.submission.userMessage, 'dopisek ze starego mejla');
    expect(c.submission.senderIsContributor, isTrue);
  });
}
