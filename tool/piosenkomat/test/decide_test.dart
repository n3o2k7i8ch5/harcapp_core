import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:piosenkomat/decide.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Tabela decyzji w jednym miejscu: fakty o zgłoszeniu (`Submission`, bez
/// mejla) → dokąd trafia, jakie uwagi, czy „rzuć okiem” i cel poprawki.
/// Wiersze idą za README („Jak automat decyduje”, „Uwagi”). Jak mejl składa
/// się w te fakty, sprawdzają testy klasyfikacji — tu tylko sama tabela.

const _a = 'Płonie ognisko i szumią knieje\nDrużynowy jest wśród nas\n'
    'Opowiada starodawne dzieje\nBohaterski wskrzesza czas';
const _b = 'Zupełnie inny tekst o morzu\nŻagle na wietrze i sól na wargach\nDaleko od lasu i od ogniska';
const _extra = 'Hej harcerze do ogniska\nNiech się niesie pieśń daleko\nZa lasami i górami\nAż po morze i po rzeki';
const _more = 'Gwiazdy świecą nad obozem\nWarta stoi przy namiotach\nCisza nocna nad jeziorem\nWiatr szeleści w starych sosnach';

List<String> _lines(String text) => text.split('\n');

/// Piosenka w apce, z którą porównujemy. Inne id niż zgłoszenie — wspólne id
/// to osobny dowód.
SongRaw _inApp({String id = 'o!_ognisko', String title = 'Płonie ognisko', String lyrics = _a}) =>
    sampleSong(id: id, title: title, lyrics: lyrics);

/// Piosenka zgłoszona.
SongRaw _sent({
  String title = 'Płonie ognisko',
  String lyrics = _a,
  String chordsText = 'a d e\na d e',
  bool chords = true,
  String? yt = _fromLyrics,
}) =>
    yt == _fromLyrics
        ? sampleSong(id: 'o!_zgloszona', title: title, lyrics: lyrics, chordsText: chordsText, chords: chords)
        : sampleSong(id: 'o!_zgloszona', title: title, lyrics: lyrics, chordsText: chordsText, chords: chords, yt: yt);

const _fromLyrics = '\u0000z tekstu';

AppMatch _match(SongRaw sent, SongRaw app) =>
    SongMatch(song: app, similarities: compare(SongProfile(sent), SongProfile(app)));

/// Zgłoszenie z samych faktów. Domyślnie: nowa piosenka od znanego nadawcy,
/// ze zgodą, bez dopisku i bez niczego podobnego w apce.
Submission _facts({
  SubmissionKind kind = SubmissionKind.newSong,
  SongRaw? song,
  bool noSong = false,
  SongRaw? app,
  String? declared,
  IdLookup? lookup,
  List<String> candidates = const [],
  String? sender = 'jan@example.com',
  String? acceptedRulesVersion = 'v05.10.2025',
  String? userMessage,
  String? correctionMessage,
  bool severalContributors = false,
  bool contributorGuessed = false,
  int submissionCount = 1,
  SubmissionFileErrorKind? fileError,
}) {
  final s = noSong ? null : (song ?? _sent());
  final message = ContribMessage(id: 'm', body: '', subject: 'Nowa piosenka', from: 'Jan <jan@example.com>');
  return Submission(
    message: message,
    messages: [message],
    kind: kind,
    title: s?.title ?? 'Nowa piosenka',
    song: s,
    profile: s == null ? null : SongProfile(s),
    appMatch: s == null || app == null ? null : _match(s, app),
    declaredCorrectionTarget: declared,
    declaredTargetLookup: lookup,
    declaredTargetCandidates: candidates,
    sender: sender,
    acceptedRulesVersion: acceptedRulesVersion,
    conversation: [if (userMessage != null) PiosenkomatMessage(userMessage)],
    correctionMessage: correctionMessage,
    hasSeveralContributors: severalContributors,
    contributorEmailGuessed: contributorGuessed,
    submissionCount: submissionCount,
    fileError: fileError,
    fileErrorMessage: fileError?.name,
  );
}

/// Najbliższe inne zgłoszenie z paczki.
BatchMatch _partner(Submission s, {bool newest = true, bool sameMainTitle = true, String? correctionTarget}) {
  final other = sampleSong(id: 'o!_inne', title: 'Płonie ognisko', lyrics: _a);
  return BatchMatch(
    song: other,
    messageId: 'inne',
    title: other.title,
    similarities: compare(s.profile!, SongProfile(other)),
    isNewestInBatch: newest,
    correctionTarget: correctionTarget,
    sameMainTitle: sameMainTitle,
  );
}

const _correction = SubmissionKind.correction;

final _variantLyrics = [_lines(_a)[0], _lines(_a)[2], _lines(_extra)[0], _lines(_extra)[1]].join('\n');
final _relatedLyrics = [_lines(_a)[0], _lines(_a)[2], ..._lines(_extra)].join('\n');
final _relatedApp = [..._lines(_a), ..._lines(_more)].join('\n');

typedef _Row = ({
  String name,
  Submission facts,
  BatchMatch? batch,
  Destination destination,
  List<SongIssue> issues,
  bool haveALook,
  ({String id, bool guessed})? target,
});

_Row _row(String name, Submission facts,
        {BatchMatch? batch,
        Destination destination = Destination.candidate,
        List<SongIssue> issues = const [],
        bool haveALook = false,
        ({String id, bool guessed})? target}) =>
    (name: name, facts: facts, batch: batch, destination: destination, issues: issues, haveALook: haveALook, target: target);

List<_Row> _table() {
  final unparsable = _facts(noSong: true);
  final newer = _facts();
  final similarInBatch = _facts(song: _sent(title: 'Inny tytuł'));
  final targetInBatch = _facts(
      kind: _correction, song: _sent(lyrics: '$_a\nDopisana zwrotka'), app: _inApp(), declared: 'o!_ognisko', lookup: IdLookup.exact);
  final titleInBatch = _facts(
      kind: _correction, song: _sent(lyrics: '$_a\nDopisana zwrotka'), app: _inApp(), declared: 'o!_ognisko', lookup: IdLookup.exact);
  return [
    // --- bez piosenki: odrzut z powodem, zawsze „rzuć okiem”
    _row('nie do odczytania → rejectUnparsable', unparsable,
        destination: Destination.rejectUnparsable, haveALook: true),
    _row('załącznik w nowszej wersji → rejectUnknownFormat',
        _facts(noSong: true, fileError: SubmissionFileErrorKind.unknownFormat),
        destination: Destination.rejectUnknownFormat, haveALook: true),
    _row('zepsuty załącznik → rejectCorruptedFile',
        _facts(noSong: true, fileError: SubmissionFileErrorKind.badDigest),
        destination: Destination.rejectCorruptedFile, haveALook: true),
    _row('kilka piosenek w jednym mejlu → multipleSongs', _facts(submissionCount: 2),
        destination: Destination.multipleSongs, haveALook: true),

    // --- paczka i apka: odrzuty
    _row('starsza kopia identycznego z paczki → rejectDuplicate', newer,
        batch: _partner(newer, newest: false), destination: Destination.rejectDuplicate),
    _row('identyczna z apką → rejectAlreadyInApp', _facts(app: _inApp(id: 'o!_inna')),
        destination: Destination.rejectAlreadyInApp),
    _row('identyczna z apką, z dopiskiem → + rzuć okiem', _facts(app: _inApp(id: 'o!_inna'), userMessage: 'Dodajcie drugi głos'),
        destination: Destination.rejectAlreadyInApp, haveALook: true),
    _row('poprawka identyczna z apką, z propozycją poprawki → + rzuć okiem',
        _facts(kind: _correction, app: _inApp(id: 'o!_inna'), correctionMessage: 'zła tonacja'),
        destination: Destination.rejectAlreadyInApp, haveALook: true),

    // --- wspólne uwagi
    _row('czysta nowa → kandydat bez uwag', _facts()),
    _row('adres doklejony do karty na zgadywanie → guessed-contributor', _facts(contributorGuessed: true),
        issues: [SongIssue.guessedContributor]),
    _row('kilka kart osób → several-contributors', _facts(severalContributors: true),
        issues: [SongIssue.severalContributors]),
    _row('bez zgody → no-consent', _facts(acceptedRulesVersion: null), issues: [SongIssue.noConsent]),
    _row('bez nadawcy → no-contributor-email', _facts(sender: null), issues: [SongIssue.noContributorEmail]),
    _row('dopisek autora → user-message', _facts(userMessage: 'Śpiewamy to na obozie'), issues: [SongIssue.userMessage]),

    // --- nowa: kompletność
    _row('bez tytułu → missing-title', _facts(song: _sent(title: '')), issues: [SongIssue.missingTitle]),
    _row('bez chwytów → missing-chords', _facts(song: _sent(chords: false)), issues: [SongIssue.missingChords]),
    _row('bez YouTube → missing-youtube', _facts(song: _sent(yt: null)), issues: [SongIssue.missingYoutube]),

    // --- nowa względem apki: poziomy
    _row('sameSong, inne chwyty → chords-differ-from-app',
        _facts(song: _sent(chordsText: 'C G a\nC G a'), app: _inApp()), issues: [SongIssue.chordsDifferFromApp]),
    _row('sameSong, inny film → metadata-differ-from-app',
        _facts(song: _sent(yt: 'xxxxxxxxxxx'), app: _inApp()), issues: [SongIssue.metadataDifferFromApp]),
    _row('longer → more-verses-than-app', _facts(song: _sent(lyrics: '$_a\nDopisana zwrotka'), app: _inApp()),
        issues: [SongIssue.moreVersesThanApp]),
    _row('shorter → fewer-verses-than-app', _facts(app: _inApp(lyrics: '$_a\nJedna nowa linijka')),
        issues: [SongIssue.fewerVersesThanApp]),
    _row('variant → variant-of-app', _facts(song: _sent(lyrics: _variantLyrics), app: _inApp()),
        issues: [SongIssue.variantOfApp]),
    _row('related → similar-text-in-app',
        _facts(song: _sent(title: 'Knieje', lyrics: _relatedLyrics), app: _inApp(lyrics: _relatedApp)),
        issues: [SongIssue.similarTextInApp]),
    _row('ten sam tytuł, inna treść → same-title-in-app', _facts(song: _sent(lyrics: _b), app: _inApp()),
        issues: [SongIssue.sameTitleInApp]),
    _row('to samo id, poza tym nic → kandydat bez uwagi',
        _facts(song: _sent(title: 'Morze', lyrics: _b), app: _inApp(id: 'o!_zgloszona'))),

    // --- nowa względem paczki
    _row('ten sam tytuł główny w paczce → same-title-in-batch', newer,
        batch: _partner(newer), issues: [SongIssue.sameTitleInBatch]),
    _row('podobna treść w paczce → similar-text-in-batch', similarInBatch,
        batch: _partner(similarInBatch, sameMainTitle: false), issues: [SongIssue.similarTextInBatch]),

    // --- poprawka: cel
    _row('cel wskazany i jest, dopisane zwrotki → kandydat bez uwag',
        _facts(kind: _correction, song: _sent(lyrics: '$_a\nDopisana zwrotka'), app: _inApp(), declared: 'o!_ognisko', lookup: IdLookup.exact),
        target: (id: 'o!_ognisko', guessed: false)),
    _row('cel wskazany bez @wykonawca → guessed-correction-target',
        _facts(kind: _correction, song: _sent(lyrics: '$_a\nDopisana zwrotka'), app: _inApp(), declared: 'o!_ognisko@stary', lookup: IdLookup.withoutPerformer),
        issues: [SongIssue.guessedCorrectionTarget], target: (id: 'o!_ognisko', guessed: true)),
    _row('cel wskazany, a nie ma go w śpiewniku → no-target-in-app',
        _facts(kind: _correction, app: _inApp(lyrics: '$_a\nJedna nowa linijka'), declared: 'o!_nie_ma'),
        issues: [SongIssue.noTargetInApp]),
    _row('cel wskazany, bez wykonawcy pasuje kilka → no-target-in-app',
        _facts(kind: _correction, song: _sent(lyrics: '$_a\nDopisana zwrotka'), app: _inApp(), declared: 'o!_ognisko@x', lookup: IdLookup.ambiguous, candidates: ['o!_ognisko@a', 'o!_ognisko@b']),
        issues: [SongIssue.noTargetInApp]),
    _row('bez celu, blisko (longer) → zgadnięty',
        _facts(kind: _correction, song: _sent(lyrics: '$_a\nDopisana zwrotka'), app: _inApp()),
        issues: [SongIssue.guessedCorrectionTarget], target: (id: 'o!_ognisko', guessed: true)),
    _row('bez celu, wariant → zgadnięty, ale differs-from-target',
        _facts(kind: _correction, song: _sent(lyrics: _variantLyrics), app: _inApp()),
        issues: [SongIssue.guessedCorrectionTarget, SongIssue.differsFromTarget], target: (id: 'o!_ognisko', guessed: true)),
    _row('bez celu, related z tym samym tytułem → zgadnięty, differs-from-target',
        _facts(kind: _correction, song: _sent(lyrics: _relatedLyrics), app: _inApp(lyrics: _relatedApp)),
        issues: [SongIssue.guessedCorrectionTarget, SongIssue.differsFromTarget], target: (id: 'o!_ognisko', guessed: true)),
    _row('bez celu, related z innym tytułem → za słabo, no-target-in-app',
        _facts(kind: _correction, song: _sent(title: 'Knieje', lyrics: _relatedLyrics), app: _inApp(lyrics: _relatedApp)),
        issues: [SongIssue.noTargetInApp]),
    _row('bez celu, nic w apce → no-target-in-app', _facts(kind: _correction), issues: [SongIssue.noTargetInApp]),
    _row('cel wskazany, fragment piosenki (shorter) → differs-from-target',
        _facts(kind: _correction, app: _inApp(lyrics: '$_a\nJedna nowa linijka'), declared: 'o!_ognisko', lookup: IdLookup.exact),
        issues: [SongIssue.differsFromTarget], target: (id: 'o!_ognisko', guessed: false)),
    _row('cel wskazany, wariant → differs-from-target',
        _facts(kind: _correction, song: _sent(lyrics: _variantLyrics), app: _inApp(), declared: 'o!_ognisko', lookup: IdLookup.exact),
        issues: [SongIssue.differsFromTarget], target: (id: 'o!_ognisko', guessed: false)),
    _row('poprawka nie dostaje missing-*', _facts(kind: _correction, song: _sent(chords: false, yt: null)),
        issues: [SongIssue.noTargetInApp]),

    // --- poprawka względem paczki
    _row('druga poprawka tego samego celu w paczce → same-target-in-batch', targetInBatch,
        batch: _partner(targetInBatch, correctionTarget: 'o!_ognisko'), issues: [SongIssue.sameTargetInBatch],
        target: (id: 'o!_ognisko', guessed: false)),
    _row('poprawka innego celu, ten sam tytuł w paczce → same-title-in-batch', titleInBatch,
        batch: _partner(titleInBatch, correctionTarget: 'o!_inna'), issues: [SongIssue.sameTitleInBatch],
        target: (id: 'o!_ognisko', guessed: false)),
  ];
}

void main() {
  group('przygotowane poziomy — na nich stoi tabela', () {
    MatchLevel? level(SongRaw sent, SongRaw app) => _match(sent, app).level;
    test('każdy wiersz porównuje z apką na zamierzonym poziomie', () {
      expect(level(_sent(), _inApp(id: 'o!_inna')), MatchLevel.identical);
      expect(level(_sent(chordsText: 'C G a\nC G a'), _inApp()), MatchLevel.sameSong);
      expect(level(_sent(lyrics: '$_a\nDopisana zwrotka'), _inApp()), MatchLevel.longer);
      expect(level(_sent(), _inApp(lyrics: '$_a\nJedna nowa linijka')), MatchLevel.shorter);
      expect(level(_sent(lyrics: _variantLyrics), _inApp()), MatchLevel.variant);
      expect(level(_sent(title: 'Knieje', lyrics: _relatedLyrics), _inApp(lyrics: _relatedApp)), MatchLevel.related);
      expect(level(_sent(lyrics: _relatedLyrics), _inApp(lyrics: _relatedApp)), MatchLevel.related);
      expect(level(_sent(lyrics: _b), _inApp()), MatchLevel.sameTitleDifferentText);
      expect(level(_sent(title: 'Morze', lyrics: _b), _inApp(id: 'o!_zgloszona')), MatchLevel.sameIdDifferentSong);
    });
  });

  group('decide — tabela', () {
    for (final row in _table()) {
      test(row.name, () {
        final got = decide(row.facts, batch: row.batch);
        expect(got.destination, row.destination);
        expect([for (final i in got.issues) i.issue], row.issues);
        expect(got.haveALook, row.haveALook);
        expect(got.correctionTarget, row.target);
      });
    }
  });

  test('pickCorrectionTarget: ten sam wynik, co w decyzji — paczka grupuje po nim', () {
    for (final row in _table()) {
      if (row.destination != Destination.candidate || !row.facts.isCorrection) continue;
      expect(pickCorrectionTarget(row.facts), decide(row.facts, batch: row.batch).correctionTarget, reason: row.name);
    }
  });
}
