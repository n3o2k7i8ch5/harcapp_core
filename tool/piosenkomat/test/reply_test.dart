import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:test/test.dart';

void main() {
  test('propozycja to cały mejl, jaki dostanie autor', () {
    final note = proposeContribReplyNote([SongIssue.missingChords])!;

    expect(note, startsWith(kReplyGreeting));
    expect(note, endsWith(kReplyClosing));
    expect(note, contains('brakuje chwytów'));
    expect(note, contains(kOneSongPerMailReplyBlock));
    expect(note, isNot(contains('NIE JEST JUŻ ROZWIJANA')));

    // Stara apka wchodzi do propozycji, a nie doklejana jest po drodze.
    final oldApp =
        proposeContribReplyNote([SongIssue.missingChords], oldApp: true)!;
    expect(oldApp, contains(kOldAppReplyBlock));
    expect(oldApp.indexOf('brakuje chwytów'),
        lessThan(oldApp.indexOf(kOldAppReplyBlock)));
    expect(oldApp, endsWith(kReplyClosing));

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

  test('uwaga idzie do autora dosłownie, nic się nie dokleja', () {
    final note = proposeContribReplyNote([SongIssue.missingChords])!;
    expect(composeContribReply(notes: [note]), note);

    // Nawet gdy wołający prosi o bloki: uwaga jest już całym mejlem, a autor
    // ma dostać dokładnie to, co było widać w polu.
    expect(
        composeContribReply(notes: [note], oldApp: true, oneSongPerMail: true),
        note);

    // Kilka piosenek jednego autora → jeden mejl ze wszystkimi uwagami.
    final many = composeContribReply(notes: ['Pierwsza.', 'Druga.'])!;
    expect(many, contains('Pierwsza.'));
    expect(many, contains('Druga.'));

    // Nie ma o czym pisać — żadnego pustego szkicu.
    expect(composeContribReply(), isNull);
    expect(composeContribReply(notes: ['  ']), isNull);
    expect(composeContribReply(oneSongPerMail: true), isNull,
        reason: 'sama prośba to za mało, żeby zaczepiać autora');
  });

  test('sama stara apka: mejl bez autora składa narzędzie', () {
    final z = composeContribReply(oldApp: true, oneSongPerMail: true)!;
    expect(z, startsWith(kReplyGreeting));
    expect(z, contains(kOldAppReplyBlock));
    expect(z.indexOf(kOneSongPerMailReplyBlock), lessThan(z.indexOf(kReplyClosing)));

    // Stara treść to dokładnie złożenie bez uwag — nic się nikomu nie zmieniło.
    expect(oldestFormatReplyMessage, composeContribReply(oldApp: true));
  });

  test('własny szkic poznajemy po kształcie, nie po treści', () {
    // Uwaga mogła się zmienić, a poprzedniej nikt nie pamięta.
    final note = proposeContribReplyNote([SongIssue.missingChords])!;
    expect(isToolShapedReply(note), isTrue);
    expect(isToolShapedReply(composeContribReply(oldApp: true)!), isTrue);
    expect(isToolShapedReply('$note\n\nPS. dopisane ręcznie'), isFalse,
        reason: 'coś po pożegnaniu to ręczna robota w Gmailu');
    expect(isToolShapedReply('Hej!\n\n$note'), isFalse);
    expect(isToolShapedReply(note.replaceAll('\n', '\r\n')), isTrue,
        reason: 'Gmail oddaje CRLF');
  });

  test('co wypada przy przeliczeniu — do pokazania, nie do zgubienia', () {
    final przed = composeContribReply(notes: ['Brakuje chwytów.'])!;
    final po = composeContribReply(notes: ['Brakuje YouTube.'])!;
    expect(paragraphsDroppedBy(przed, po), ['Brakuje chwytów.']);
    expect(paragraphsDroppedBy(przed, przed), isEmpty);
  });
}
