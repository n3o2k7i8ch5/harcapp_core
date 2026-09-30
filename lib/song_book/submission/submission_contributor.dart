/// Nadawca i zgoda ze zgłoszenia, wpisane w piosenkę — jedna reguła dla
/// piosenkomatu i dla ręcznego wklejania mejla na stronie.
library;

import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';
import 'package:harcapp_core/values/people/utils.dart';

/// Wersja regulaminu w `contributor_data`, gdy zgody nie ma — z jakiegokolwiek
/// powodu: stara apka o nią nie pytała, ktoś ją wykreślił, pole zginęło. Do
/// wygrepowania, gdyby trzeba było doprosić autorów o zgodę.
const String kNoConsentRulesVersion = 'brak';

/// Zgoda z mejla: wersja regulaminu, którą autor zaakceptował; `null` — zgody
/// nie ma.
String? submissionConsent(ParsedContribEmail parsed){
  final rules = parsed.acceptedRulesVersion?.trim();
  return (rules?.isEmpty ?? true)? null: rules;
}

/// Wersja regulaminu, jaką [applySubmissionContributor] wpisze do
/// `contributor_data`: z danych, które przyniosła piosenka, ze zgody w mejlu,
/// a bez niej [kNoConsentRulesVersion].
String submissionRulesVersion(ParsedContribEmail parsed) =>
    parsed.song.contributorData?.acceptedRulesVersion ?? submissionConsent(parsed) ?? kNoConsentRulesVersion;

/// Wpisuje w piosenkę zgłoszenia nadawcę i zgodę.
///
/// `contributor_data`: to, co przyniosła piosenka (stary format je niósł),
/// a czego brak — [sender], [date] i [submissionRulesVersion].
///
/// Adres nadawcy trafia do jedynej karty osoby bez adresu: apka wysyła kartę
/// w `add_pers` **bez** adresu, a adres jedzie osobno — doklejony jako drugi
/// wpis robiłby z jednej osoby dwie, kartę i goły mejl pod nią. Kilka kart bez
/// adresu (współautorzy) albo żadnej → osobny wpis. Przy kilku kartach
/// w ogóle i przy `sender_is_contributor: false` adres nie trafia nigdzie
/// (nie wiadomo, czyj to wkład), a karta osoby wchodzi bez niego.
///
/// `true`, gdy adres trafił do karty na zgadywanie: format nie mówi, czy
/// nadawca to osoba dodająca.
bool applySubmissionContributor(ParsedContribEmail parsed, {required String? sender, DateTime? date}){
  final song = parsed.song;
  final email = sender == null? null: normalizedEmail(sender);
  final fromEmail = song.contributorData;
  song.contributorData = ContributorData(
    email: fromEmail?.email ?? email ?? '',
    contributionDate: fromEmail?.contributionDate ?? date ?? DateTime.now(),
    acceptedRulesVersion: submissionRulesVersion(parsed),
  );

  final attachSender = (parsed.senderIsContributor ?? true)
      && song.contribRefs.where((c) => c.person != null).length < 2;
  if(!attachSender){
    // Adres nadawcy nie wchodzi, ale karta osoby owszem — bez adresu, bo tylko
    // ona mówi, komu przypisać wkład.
    final person = parsed.registered?.person;
    final name = person?.name.trim().toLowerCase() ?? '';
    final missing = name.isNotEmpty
        && !song.contribRefs.any((c) => (c.person?.name ?? '').trim().toLowerCase() == name);
    if(missing) song.contribRefs.add(ContributorRef(person: person));
  }

  final known = email == null || song.contribRefs.any((c) => normalizedEmail(c.emailRef ?? '') == email);
  if(known || !attachSender) return false;

  final withoutEmail = [
    for(var i = 0; i < song.contribRefs.length; i++)
      if(song.contribRefs[i].person != null && (song.contribRefs[i].emailRef ?? '').isEmpty) i,
  ];
  if(withoutEmail.length == 1){
    final i = withoutEmail.single;
    final c = song.contribRefs[i];
    song.contribRefs[i] = ContributorRef(person: c.person, emailRef: email, userKeyRef: c.userKeyRef);
    // Z `sender_is_contributor: true` to fakt z pliku, bez niego — domysł.
    return parsed.senderIsContributor == null;
  }
  song.contribRefs.add(ContributorRef(person: parsed.registered?.person, emailRef: email));
  return false;
}
