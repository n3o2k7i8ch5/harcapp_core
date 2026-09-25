import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/reply.dart';
import 'package:test/test.dart';

void main() {
  test('propozycja to sama sprawa — ramkę dokłada narzędzie', () {
    final note = proposeContribReplyNote([SongIssue.missingChords])!;
    expect(note, startsWith('Niestety widzę, że brakuje chwytów.'));
    expect(note, isNot(contains(kReplyGreeting)));
    expect(note, isNot(contains(kReplyClosing)));
    expect(note, isNot(contains(kReplyFooter)));

    // Kolejność braków po `SongIssue`, nie po kolejności pastylek.
    expect(
        proposeContribReplyNote([
          SongIssue.missingYoutube,
          SongIssue.missingTitle,
          SongIssue.missingChords,
        ])!,
        contains('tytułu, chwytów i linku do YT'));

    // Nie każda pastylka to pytanie do autora.
    expect(proposeContribReplyNote([]), isNull);
    expect(proposeContribReplyNote([SongIssue.hasUserMessage]), isNull);
  });

  test('mejl: powitanie, odpowiedź, blok starej apki, pożegnanie, stopka pod kreską', () {
    final mail = composeContribReply(reviewNote: ' Super:) ', oldApp: true)!;
    expect(mail, startsWith('$kReplyGreeting\n\nSuper:)\n\n$kOldAppReplyBlock'));
    expect(mail, endsWith('$kReplyClosing\n\n$kReplyFooter'));
    expect(kReplyFooter, startsWith('$kReplyFooterRule\n'));
    expect(kReplyFooterRule, isNot(startsWith('--')),
        reason: '`-- ` to separator podpisu — część klientów go zwija');

    final newApp = composeContribReply(reviewNote: 'Super:)')!;
    expect(newApp, isNot(contains(kOldAppReplyBlock)));
  });

  test('szara ramka w edytorze to dokładnie reszta mejla', () {
    for (final oldApp in [false, true]) {
      final frame = contribReplyFrame(oldApp: oldApp);
      expect(composeContribReply(reviewNote: 'X', oldApp: oldApp),
          '${frame.before}\n\nX\n\n${frame.after}');
    }
  });

  test('nie ma o czym pisać — żadnego pustego szkicu', () {
    expect(composeContribReply(), isNull);
    expect(composeContribReply(reviewNote: '  '), isNull);
  });

  test('sama stara apka: mejl z samym blokiem', () {
    final z = composeContribReply(oldApp: true)!;
    expect(z, '$kReplyGreeting\n\n$kOldAppReplyBlock\n\n$kReplyClosing\n\n$kReplyFooter');
    // `const` dla strony — musi być tym samym mejlem.
    expect(oldestFormatReplyMessage, z);
  });

  test('własny szkic poznajemy po kształcie, nie po treści', () {
    final mail = composeContribReply(reviewNote: 'Brakuje chwytów.')!;
    expect(isToolShapedReply(mail), isTrue);
    expect(isToolShapedReply(composeContribReply(oldApp: true)!), isTrue);
    expect(isToolShapedReply('$mail\n\nPS. dopisane ręcznie'), isFalse,
        reason: 'coś po stopce to ręczna robota w Gmailu');
    expect(isToolShapedReply('Hej!\n\n$mail'), isFalse);
    expect(isToolShapedReply('Super:)'), isFalse,
        reason: 'goła odpowiedź bez ramki to nie nasz szkic');
    expect(isToolShapedReply(mail.replaceAll('\n', '\r\n')), isTrue,
        reason: 'Gmail oddaje CRLF');
  });

  test('co wypada przy przeliczeniu — do pokazania, nie do zgubienia', () {
    final przed = composeContribReply(reviewNote: 'Brakuje chwytów.')!;
    final po = composeContribReply(reviewNote: 'Brakuje YouTube.')!;
    expect(paragraphsDroppedBy(przed, po), ['Brakuje chwytów.']);
    expect(paragraphsDroppedBy(przed, przed), isEmpty);
  });

  group('planAuthorReplies — mejl na piosenkę, w jej wątku', () {
    AuthorReplies plan(
      List<(String, String)> messages, {
      Map<String, String> notes = const {},
      Set<String> oldApp = const {},
    }) =>
        planAuthorReplies(
          'autor@example.com',
          [for (final (id, thread) in messages) (id: id, threadId: thread)],
          reviewNotes: notes,
          oldAppIds: oldApp,
        );

    test('dwie piosenki z uwagami → dwa mejle, każdy w swoim wątku', () {
      final p = plan([('a1', 'A'), ('b1', 'B')],
          notes: {'A': 'Brakuje chwytów.', 'B': 'Podziel na zwrotki.'});
      expect(p.replies.map((r) => r.threadId), ['A', 'B']);
      expect(p.replies.map((r) => r.reviewNote), ['Brakuje chwytów.', 'Podziel na zwrotki.']);
      expect(p.replies.first.text, isNot(contains('Podziel na zwrotki.')));
      expect(p.nothingToSay, isEmpty);
    });

    test('kilka wiadomości w wątku → jeden mejl, odpowiedź na najnowszą', () {
      final p = plan([('a1', 'A'), ('a2', 'A')], notes: {'A': 'Super:)'});
      expect(p.replies.single.messageIds, ['a1', 'a2']);
      expect(p.replies.single.targetMessageId, 'a2');
    });

    test('stara apka: blok w odpowiedzi, a wątki bez uwagi schodzą razem z nią', () {
      final p = plan([('a1', 'A'), ('b1', 'B'), ('c1', 'C')],
          notes: {'B': 'Super:)'}, oldApp: {'a1', 'b1', 'c1'});
      final r = p.replies.single;
      expect(r.threadId, 'B');
      expect(r.oldApp, isTrue);
      expect(r.text, contains(kOldAppReplyBlock));
      expect(r.alsoClearsOldApp, ['a1', 'c1']);
    });

    test('stara apka bez żadnej uwagi → jeden mejl z samym blokiem, w najnowszym wątku', () {
      final p = plan([('a1', 'A'), ('b1', 'B')], oldApp: {'a1', 'b1'});
      final r = p.replies.single;
      expect(r.threadId, 'B');
      expect(r.reviewNote, isNull);
      expect(r.alsoClearsOldApp, ['a1']);
      // Sam blok nie odpowiada na `reply/review-note` — ta etykieta zostaje.
      expect(r.labels.$1, isEmpty);
      expect(r.labels.$2, [kLabelReplyOldApp]);
    });

    test('uwaga do piosenki z nowej apki nie niesie bloku — dostaje go osobny mejl', () {
      final p = plan([('a1', 'A'), ('b1', 'B')], notes: {'B': 'Super:)'}, oldApp: {'a1'});
      expect(p.replies.map((r) => (r.threadId, r.reviewNote, r.oldApp)),
          [('B', 'Super:)', false), ('A', null, true)]);
    });

    test('kolejka bez tekstu i bez starej apki → etykieta zostaje', () {
      final p = plan([('a1', 'A')]);
      expect(p.replies, isEmpty);
      expect(p.nothingToSay, ['a1']);
    });

    test('po odpowiedzi z uwagą wątek czeka na autora', () {
      final r = plan([('a1', 'A')], notes: {'A': 'Super:)'}).replies.single;
      expect(r.labels.$1, [kLabelWaitingForAuthor]);
    });
  });
}
