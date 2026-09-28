import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_old_app.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
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
    expect(proposeContribReplyNote([SongIssue.userMessage]), isNull);
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
    expect(oldAppReplyMessage, z);
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

  test('z mejla do dymka: sama odpowiedź, bez ramki', () {
    expect(replyNoteOf(composeContribReply(reviewNote: 'Brakuje chwytów.', oldApp: true)!),
        'Brakuje chwytów.');
    expect(replyNoteOf(composeContribReply(reviewNote: 'Dwa akapity.\n\nNaprawdę dwa.')!),
        'Dwa akapity.\n\nNaprawdę dwa.');
    // Sam blok o starej apce: nie ma czego pokazać.
    expect(replyNoteOf(composeContribReply(oldApp: true)!), isEmpty);
    // Mejl pisany ręcznie wraca cały.
    expect(replyNoteOf(' Cześć, piszę sam. '), 'Cześć, piszę sam.');
  });

  test('blok o starej apce rozpoznany także w szkicu przełamanym przez Gmaila', () {
    final withBlock = composeContribReply(reviewNote: 'Super:)', oldApp: true)!;
    expect(carriesOldAppBlock(withBlock), isTrue);
    expect(carriesOldAppBlock(withBlock.replaceAll('. ', '.\n')), isTrue);
    expect(carriesOldAppBlock(composeContribReply(reviewNote: 'Super:)')!), isFalse);
    expect(replyNoteOf(withBlock.replaceAll('. ', '.\n')), 'Super:)',
        reason: 'przełamany blok to dalej ramka, nie Twój tekst');
  });

  group('wantedReplies — mejl na piosenkę, w jej wątku, blok raz na autora', () {
    ReplyThread thread(String id, {String? note, bool oldApp = false}) =>
        (threadId: id, sender: 'autor@example.com', messageIds: ['${id}1'], oldApp: oldApp, note: note);

    test('dwie piosenki z uwagami → dwa mejle, każdy w swoim wątku', () {
      final w = wantedReplies([thread('A', note: 'Brakuje chwytów.'), thread('B', note: 'Podziel na zwrotki.')]);
      expect(w.keys, ['A', 'B']);
      expect(w['A'], contains('Brakuje chwytów.'));
      expect(w['A'], isNot(contains('Podziel na zwrotki.')));
    });

    test('stara apka: blok w odpowiedzi, bez osobnego mejla z samym blokiem', () {
      final w = wantedReplies(
          [thread('A', oldApp: true), thread('B', note: 'Super:)', oldApp: true), thread('C', oldApp: true)]);
      expect(w.keys, ['B']);
      expect(carriesOldAppBlock(w['B']!), isTrue);
    });

    test('stara apka bez żadnej uwagi → jeden mejl z samym blokiem, w najnowszym wątku', () {
      final w = wantedReplies([thread('A', oldApp: true), thread('B', oldApp: true)]);
      expect(w.keys, ['B']);
      expect(replyNoteOf(w['B']!), isEmpty);
    });

    test('uwaga do piosenki z nowej apki nie niesie bloku — dostaje go osobny mejl', () {
      final w = wantedReplies([thread('A', oldApp: true), thread('B', note: 'Super:)')]);
      expect(w.keys, unorderedEquals(['A', 'B']));
      expect(carriesOldAppBlock(w['B']!), isFalse);
      expect(carriesOldAppBlock(w['A']!), isTrue);
    });

    test('autor czeka na blok w wątku z innego przebiegu → tu bloku nie ma', () {
      final w = wantedReplies([thread('A', oldApp: true), thread('B', note: 'Super:)', oldApp: true)],
          blockElsewhere: true);
      expect(w.keys, ['B']);
      expect(carriesOldAppBlock(w['B']!), isFalse);
    });

    test('bez tekstu i bez starej apki nie ma czego pisać', () {
      expect(wantedReplies([thread('A')]), isEmpty);
    });
  });
}
