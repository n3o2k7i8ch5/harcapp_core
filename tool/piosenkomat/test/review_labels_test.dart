import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:piosenkomat/classify.dart';
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
  expect(items.last.labels, contains(SongLabel.needsReview.label));
  return (RunPlan.fromClassified(items, id: 'test'), [for (final c in items) c.song!]);
}

Future<(RunPlan, List<SongRaw>, List<ReviewCandidate>)> _candidates() async {
  final (plan, songs) = await _scan();
  return (plan, songs, collectCandidates(plan, roundTrip(songs), _new));
}

Map<String, LabelChange> _changes(
        RunPlan plan, List<SongRaw> reviewed, List<ReviewCandidate> candidates) =>
    reviewLabelChanges(
      [reviewDiff(kind: _new, candidates: candidates, reviewed: reviewed)],
      plan,
      // Stan po `scan --push`.
      {for (final e in plan.labelsByMessage.entries) e.key: e.value.toSet()},
    ).changes;

void main() {
  test('wróciła z przeglądu → „w pliku”; bez zarzutu nie rusza się wcale', () async {
    final (plan, songs, candidates) = await _candidates();
    final changes = _changes(plan, roundTrip(songs), candidates);
    expect(changes.containsKey('ok'), isFalse,
        reason: '„ready-to-add” już wisi, nie ma czego przestawiać');
    expect(changes['yt']!.$1, [SongLabel.readyToAdd.label]);
    expect(changes['yt']!.$2, unorderedEquals([SongLabel.needsReview.label, SongLabel.missingData.label]),
        reason: 'schodzi to, co mejl ma, a nie cała lista');
  });

  test('wyrzucona na stronie → rejected/after-review', () async {
    final (plan, songs, candidates) = await _candidates();
    final changes = _changes(plan, roundTrip([songs.first]), candidates);
    expect(changes['yt']!.$1, [SongLabel.rejectedAfterReview.label]);
    expect(changes['yt']!.$2, contains(SongLabel.needsReview.label));
  });

  test('odrzucona z wyjaśnieniem to pytanie do autora, nie odrzut', () async {
    // Piosenka może jeszcze wrócić z chwytami, więc „rejected” byłoby kłamstwem.
    final (plan, songs, candidates) = await _candidates();
    final reviewed = roundTrip(songs);
    final yt = reviewed.firstWhere((s) => s.title == 'Bez YT');
    yt.piosenkomatData = yt.piosenkomatData!.copyWith(
        rejected: true, reviewNote: () => 'Dorzuć YouTube i wejdzie.');
    final changes = _changes(plan, reviewed, candidates);
    expect(changes['yt']!.$1, [SongLabel.replyReviewNote.label]);
    expect(changes['yt']!.$1, isNot(contains(SongLabel.rejectedAfterReview.label)));
  });

  test('przyjęta z uwagą wchodzi i zaczepia autora', () async {
    final (plan, songs, candidates) = await _candidates();
    final reviewed = roundTrip(songs);
    final ok = reviewed.firstWhere((s) => s.title == 'Czysta');
    ok.piosenkomatData = ok.piosenkomatData!
        .copyWith(reviewNote: () => 'Dodałem, popraw literówkę.');
    final changes = _changes(plan, reviewed, candidates);
    expect(changes['ok']!.$1, [SongLabel.replyReviewNote.label],
        reason: 'bez zarzutu, ale z uwagą — musi ruszyć mimo „ready-to-add”, które już ma');
    expect(changes['ok']!.$2, isEmpty, reason: 'bez zarzutu nie miała nic do zdjęcia');
  });

  test('etykiety idą na wszystkie wiadomości wątku', () async {
    final (plan, songs) = await _scan();
    final yt = plan.threads['yt']!;
    final withReply = RunPlan(
      id: 'test',
      createdAt: plan.createdAt,
      threads: {
        ...plan.threads,
        'yt': PlannedThread(messages: ['yt', 'yt2'], labels: yt.labels, song: yt.song, sender: yt.sender),
      },
    );
    final candidates = collectCandidates(withReply, roundTrip(songs), _new);
    final changes = _changes(withReply, roundTrip(songs), candidates);
    expect(changes['yt2']!.$1, changes['yt']!.$1);
    expect(changes['yt2']!.$2, changes['yt']!.$2);
  });
}
