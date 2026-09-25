import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/report.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/plan.dart';
import 'package:piosenkomat/review.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

const _new = SubmissionKind.newSong;

/// Stan po `scan`: „Czysta” bez zarzutu (`ready-to-add`), „Bez YT” do
/// przeglądu (`needs-review`).
Future<(RunPlan, List<SongRaw>)> _scan() async {
  final items = classifyBatch([
    msgFrom(await completeEmail(song: sampleSong(title: 'Czysta', lyrics: 'Zupelnie inne slowa tutaj')), id: 'ok'),
    msgFrom(await completeEmail(song: sampleSong(title: 'Bez YT', yt: null, lyrics: 'Wlazl kotek na plotek')), id: 'yt'),
  ], book: SongBook.empty);
  expect(items.first.isClean, isTrue);
  expect(items.last.labels, contains(kLabelNeedsReview));
  return (RunPlan.fromClassified(items), [for (final c in items) c.song!]);
}

Future<(RunPlan, List<SongRaw>, List<ReviewCandidate>)> _proposed() async {
  final (plan, songs) = await _scan();
  return (plan, songs, collectCandidates(plan, roundTrip(songs), _new));
}

Map<String, LabelChange> _changes(
        RunPlan plan, List<SongRaw> reviewed, List<ReviewCandidate> proposed) =>
    reviewLabelChanges(
        [reviewDiff(kind: _new, candidates: proposed, reviewed: reviewed)], plan);

void main() {
  test('wróciła z przeglądu → „w pliku”; bez zarzutu nie rusza się wcale', () async {
    final (plan, songs, proposed) = await _proposed();
    final changes = _changes(plan, roundTrip(songs), proposed);
    expect(changes.containsKey('ok'), isFalse,
        reason: '„ready-to-add” już wisi, nie ma czego przestawiać');
    expect(changes['yt']!.$1, [kLabelReadyToAdd]);
    expect(changes['yt']!.$2, kNeedsReviewLabels);
  });

  test('wyrzucona na stronie → rejected/after-review', () async {
    final (plan, songs, proposed) = await _proposed();
    final changes = _changes(plan, roundTrip([songs.first]), proposed);
    expect(changes['yt']!.$1, [kLabelRejectedAfterReview]);
    expect(changes['yt']!.$2, contains(kLabelReadyToAdd));
  });

  test('odrzucona z wyjaśnieniem to pytanie do autora, nie odrzut', () async {
    // Piosenka może jeszcze wrócić z chwytami, więc „rejected” byłoby kłamstwem.
    final (plan, songs, proposed) = await _proposed();
    final reviewed = roundTrip(songs);
    final yt = reviewed.firstWhere((s) => s.title == 'Bez YT');
    yt.piosenkomatData = yt.piosenkomatData!.copyWith(
        accepted: () => false, reviewNote: () => 'Dorzuć YouTube i wejdzie.');
    final changes = _changes(plan, reviewed, proposed);
    expect(changes['yt']!.$1, [kLabelReplyReviewNote]);
    expect(changes['yt']!.$1, isNot(contains(kLabelRejectedAfterReview)));
  });

  test('przyjęta z uwagą wchodzi i zaczepia autora', () async {
    final (plan, songs, proposed) = await _proposed();
    final reviewed = roundTrip(songs);
    final ok = reviewed.firstWhere((s) => s.title == 'Czysta');
    ok.piosenkomatData = ok.piosenkomatData!
        .copyWith(reviewNote: () => 'Dodałem, popraw literówkę.');
    final changes = _changes(plan, reviewed, proposed);
    expect(changes['ok']!.$1, [kLabelReadyToAdd, kLabelReplyReviewNote],
        reason: 'bez zarzutu, ale z uwagą — musi ruszyć mimo „ready-to-add”');
    expect(changes['ok']!.$2, kNeedsReviewLabels);
  });

  test('etykiety idą na wszystkie wiadomości wątku', () async {
    final (plan, songs) = await _scan();
    final withReply = RunPlan(
      createdAt: plan.createdAt,
      labelsByMessage: {...plan.labelsByMessage, 'yt2': plan.labelsByMessage['yt']!},
      songsByThread: plan.songsByThread,
      messagesByThread: {...plan.messagesByThread, 'yt': ['yt', 'yt2']},
    );
    final proposed = collectCandidates(withReply, roundTrip(songs), _new);
    final changes = _changes(withReply, roundTrip(songs), proposed);
    expect(changes['yt2']!.$1, changes['yt']!.$1);
    expect(changes['yt2']!.$2, changes['yt']!.$2);
  });

  test('raport liczy nowe, poprawki, odrzuty i „rzuć okiem”', () async {
    final book = bookWith([sampleSong(title: 'W apce', lyrics: 'Ala ma kota\nA kot ma Ale')]);
    final report = formatRunReport(classifyBatch([
      msgFrom(await completeEmail(song: sampleSong(title: 'Czysta', lyrics: 'Zupelnie inne slowa')), id: 'ok'),
      msgFrom(await completeEmail(song: sampleSong(title: 'Bez YT', yt: null, lyrics: 'Wlazl kotek na plotek')), id: 'yt'),
      msgFrom(await completeEmail(isNew: false, song: sampleSong(title: 'W apce', lyrics: 'Ala ma kota\nA kot ma Ale\nX')), id: 'corr'),
      msgFrom(await completeEmail(song: sampleSong(title: 'W apce', lyrics: 'Ala ma kota\nA kot ma Ale')), id: 'dup'),
      msgFrom(await completeEmail(song: sampleSong(title: 'W apce', lyrics: 'Ala ma kota\nA kot ma Ale'), userMessage: 'hej'), id: 'msg'),
      msgFrom('From: a@b.pl\nSubject: Cześć\n\nCześć, mam pytanie', id: 'raw'),
    ], book: book));
    expect(report, contains('ZGŁOSZEŃ        6'));
    expect(report, contains('  nie do odczytu 1'));
    expect(report, contains('NOWE            2'));
    expect(report, contains('  bez zarzutu   1'));
    expect(report, contains('  z uwagami     1'));
    expect(report, contains('POPRAWKI        1'));
    expect(report, contains('  już w apce    2'), reason: 'identyczna z dopiskiem też jest odrzutem');
    expect(report, contains('RZUĆ OKIEM      2'), reason: 'identyczna z dopiskiem + nie do odczytania');
    expect(report, contains('missing-youtube'));
    expect(report, contains('Kształt mejla:'));
    expect(report, contains('fenced'));
    expect(report, contains('[ok]'));
    expect(report, contains('NIEPARS  Cześć'));
  });
}
