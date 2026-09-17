import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
import 'package:test/test.dart';

void main() {
  test('mejl do autora składa się z kawałków, nie pisze od nowa', () {
    final noteOnly = composeContribReply(notes: ['Brakuje chwytów.'])!;
    expect(noteOnly, contains('Brakuje chwytów.'));
    expect(noteOnly, isNot(contains('NIE JEST JUŻ ROZWIJANA')));

    // Ten sam autor ze starej apki: jeden mejl, obie sprawy, uwaga przed blokiem.
    final both = composeContribReply(notes: ['Brakuje chwytów.'], oldApp: true)!;
    expect(both.indexOf('Brakuje chwytów.'),
        lessThan(both.indexOf('NIE JEST JUŻ ROZWIJANA')));

    // Kilka piosenek jednego autora → jeden mejl ze wszystkimi uwagami.
    final many = composeContribReply(notes: ['Brak chwytów.', 'Brak YouTube.'])!;
    expect(many, contains('Brak chwytów.'));
    expect(many, contains('Brak YouTube.'));

    // Nie ma o czym pisać — żadnego pustego szkicu.
    expect(composeContribReply(), isNull);
    expect(composeContribReply(notes: ['  ']), isNull);

    // Stara treść to dokładnie złożenie bez uwag — nic się nikomu nie zmieniło.
    expect(oldestFormatReplyMessage, composeContribReply(oldApp: true));
  });

  test('prośba o osobny mejl na piosenkę dokleja się przed pożegnaniem', () {
    final z = composeContribReply(notes: ['Brakuje chwytów.'], oneSongPerMail: true)!;
    expect(z, contains(kOneSongPerMailReplyBlock));
    expect(z.indexOf(kOneSongPerMailReplyBlock), lessThan(z.indexOf(kReplyClosing)));
    expect(composeContribReply(notes: ['Brakuje chwytów.'])!,
        isNot(contains(kOneSongPerMailReplyBlock)));
    expect(composeContribReply(oneSongPerMail: true), isNull,
        reason: 'sama prośba to za mało, żeby zaczepiać autora');
  });

  test('własny szkic poznajemy po kształcie, nie po treści', () {
    // Uwaga mogła się zmienić, a poprzedniej nikt nie pamięta.
    final noteOnly = composeContribReply(notes: ['Brakuje chwytów.'])!;
    expect(isToolShapedReply(noteOnly), isTrue);
    expect(isToolShapedReply(composeContribReply(notes: ['x'], oldApp: true)!), isTrue);
    expect(isToolShapedReply('$noteOnly\n\nPS. dopisane ręcznie'), isFalse,
        reason: 'coś po „Czuwaj!” to ręczna robota w Gmailu');
    expect(isToolShapedReply('Hej!\n\n$noteOnly'), isFalse);
    expect(isToolShapedReply(noteOnly.replaceAll('\n', '\r\n')), isTrue,
        reason: 'Gmail oddaje CRLF');
  });

  test('co wypada przy przeliczeniu — do pokazania, nie do zgubienia', () {
    final przed = composeContribReply(notes: ['Brakuje chwytów.'])!;
    final po = composeContribReply(notes: ['Brakuje YouTube.'])!;
    expect(paragraphsDroppedBy(przed, po), ['Brakuje chwytów.']);
    expect(paragraphsDroppedBy(przed, przed), isEmpty);
  });
}
