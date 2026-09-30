import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/submission/submission_contributor.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';
import 'package:harcapp_core/values/people/models.dart';

ParsedContribEmail _parsed(List<ContributorRef> refs, {String? rules = 'v05.10.2025'}) => ParsedContribEmail(
  song: SongRaw.empty(id: 'o!_x')..title = 'X'..contribRefs = refs,
  senderEmail: null,
  acceptedRulesVersion: rules,
  registered: null,
  userMessage: null,
  shape: ContribEmailShape.legacy,
);

void main(){
  const jan = Person(name: 'Jan Testowy');

  test('jedyna karta bez adresu dostaje adres nadawcy — jedna osoba, nie dwie', (){
    final p = _parsed([ContributorRef(person: jan)]);
    final guessed = applySubmissionContributor(p, sender: 'Jan@Example.com');
    expect(p.song.contribRefs, hasLength(1));
    expect(p.song.contribRefs.single.person?.name, 'Jan Testowy');
    expect(p.song.contribRefs.single.emailRef, 'jan@example.com');
    expect(guessed, isTrue, reason: 'format nie mówi, czy nadawca to ta osoba');
  });

  test('bez zgody: w contributor_data „brak”, do wygrepowania', (){
    final p = _parsed([], rules: null);
    applySubmissionContributor(p, sender: 'jan@example.com');
    expect(p.song.contributorData!.acceptedRulesVersion, kNoConsentRulesVersion);
    expect(p.song.contributorData!.email, 'jan@example.com');
  });

  test('kilka kart: nie wiadomo, czyj to wkład — adresu nie doklejamy nigdzie', (){
    final p = _parsed([ContributorRef(person: jan), ContributorRef(person: const Person(name: 'Anna'))]);
    applySubmissionContributor(p, sender: 'jan@example.com');
    expect(p.song.contribRefs.map((c) => c.emailRef), everyElement(isNull));
  });
}
