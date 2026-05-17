// Legacy email composer for song contributions.
// Kept as a reference for the older format that parseContribEmail still needs
// to fall back to. New emails should be composed via contrib_song_email.dart.

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/utils.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

import 'contrib_song_email.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';

bool _isContributorNew(ContributorRef contribId) {
  if(contribId.emailRef == null) return true;
  if(!allRegisteredPeopleByEmailMap.containsKey(contribId.emailRef)) return true;

  return false;
}

bool _isPersonsFirstSong(List<SongCore> songs){
  bool isPersonsFirstSong = false;
  for (SongCore song in songs)
    for (ContributorRef contribId in song.contribId)
      if (_isContributorNew(contribId)) {
        isPersonsFirstSong = true;
        break;
      }

  return isPersonsFirstSong;
}

String registeredPersonToObjectStringLegacy(RegisteredContributor registered, {List<ContributorRef> contribIds = const []}) =>
    _registeredPersonToObjectString(registered, contribIds: contribIds);

/// Emituje literał Darta dla [Srodowisko]: preferuje konstruktor strukturalny
/// (`hufiec`/`choragiew`/`okreg`/`org`) gdy odpowiedni slug jest ustawiony;
/// `custom` używamy tylko jako fallback (gdy nic nie ma slugów, ale jest tekst
/// `custom`).
String _srodowiskoToObjectString(Srodowisko s){
  final args = <String>[];
  String primary;
  if(s.hufiecSlug != null){
    primary = "Srodowisko.hufiec('${s.hufiecSlug}'";
    if(!s.showHufiec) args.add('showHufiec: false');
    if(!s.showChoragiew) args.add('showChoragiew: false');
    if(!s.showOkreg) args.add('showOkreg: false');
    if(!s.showOrg) args.add('showOrg: false');
  } else if(s.choragiewSlug != null){
    primary = "Srodowisko.choragiew('${s.choragiewSlug}'";
    if(!s.showChoragiew) args.add('showChoragiew: false');
    if(!s.showOkreg) args.add('showOkreg: false');
    if(!s.showOrg) args.add('showOrg: false');
  } else if(s.okregSlug != null){
    primary = "Srodowisko.okreg('${s.okregSlug}'";
    if(!s.showOkreg) args.add('showOkreg: false');
    if(!s.showOrg) args.add('showOrg: false');
  } else if(s.orgSlug != null){
    primary = "Srodowisko.org('${s.orgSlug}'";
    if(!s.showOrg) args.add('showOrg: false');
  } else {
    return "Srodowisko.custom('${s.custom ?? s.displayName}')";
  }
  return args.isEmpty ? '$primary)' : '$primary, ${args.join(', ')})';
}

String _registeredPersonToObjectString(RegisteredContributor registered, {List<ContributorRef> contribIds = const []}){
  final person = registered.person;

  final contribIdEmails = <String>[
    for(final c in contribIds)
      if(c.emailRef != null) c.emailRef!,
  ];
  final emails = registered.emails.isNotEmpty ? registered.emails : contribIdEmails;

  final personFields = <String>[];
  if(person.name.isNotEmpty) personFields.add("name: '${person.name}'");
  if(person.druzyna != null && person.druzyna!.isNotEmpty) personFields.add("druzyna: '${person.druzyna}'");
  if(person.srodowisko != null) personFields.add("srodowisko: ${_srodowiskoToObjectString(person.srodowisko!)}");
  if(person.rankInstr != null) personFields.add("rankInstr: RankInstr.${person.rankInstr!.name}");
  if(person.rankHarc != null) personFields.add("rankHarc: RankHarc.${person.rankHarc!.name}");
  if(person.comment != null && person.comment!.isNotEmpty) personFields.add("comment: '${person.comment}'");

  final varName = remPolChars(person.name).toUpperCase().replaceAll(' ', '_');
  final emailsLiteral = '[${emails.map((e) => '"$e"').join(', ')}]';

  return [
    'RegisteredContributor $varName = const RegisteredContributor(',
    '  person: Person(',
    for(final f in personFields) '    $f,',
    '  ),',
    '  emails: $emailsLiteral,',
    ');',
  ].join('\n');
}

String composeContribSongEmailSubjectLegacy({
  required SongCore song,
  required bool isNewSong,
}){
  bool isPersonsFirstSong = _isPersonsFirstSong([song]);
  return '${isNewSong?'Nowa piosenka':'Poprawka piosenki'} "${song.title}" (${isPersonsFirstSong?' + świeżak + ':' - weteran - '})';
}

String _baseMessageLegacy(
    SongSource source,
    String? acceptRulesVersion,
    bool isPersonsFirstSong,
    RegisteredContributor? registered,
    ) => "- - - - - - Miejsce na własną wiadomość - - - - - -"
    "\n"
    "\n[Jeśli chcesz coś dodać, skomentować, lub wyjaśnić, możesz to zrobić tutaj.]"
    "\n"
    "\n- - - - - - Zasady dodawania piosenek - - - - - -"
    "\n"
    "\nZnam i akceptuję zasady dodawania piosenek do aplikacji HarcApp (${acceptRulesVersion}, dostępne na www.harcapp.web.app/song_contribution_rules)."
    "\n"
    "\n- - - - - - Nie edytuj poniższego - - - - - -"
    "\n"
    "\n### Źródło piosenki: ${source.displayName}"
    "${
    registered == null?
    '':
    '\n'
        '\n### Osoba dodająca (${isPersonsFirstSong?' + świeżak + ':' - weteran - '}):'
        '\n'
        '\n${_registeredPersonToObjectString(registered)}'
}";

Future<String> composeContribSongEmailLegacy({
  required SongCore song,
  required SongSource source,
  String? acceptRulesVersion,
  RegisteredContributor? registered,
  required bool isNewSong,
  String? updateComment
}) async {

  bool isPersonsFirstSong = _isPersonsFirstSong([song]);

  String encodedSong = await song.code;

  return "${_baseMessageLegacy(source, acceptRulesVersion, isPersonsFirstSong, registered)}"
      "${
      updateComment != null?
      '\n'
          '\n### Propozycja poprawki:'
          '\n'
          '\n$updateComment':
      ''
  }"
      "\n"
      "\n### Kod piosenki:"
      "\n"
      "\n$encodedSong";
}

String composeContribAttachedSongsEmailSubjectLegacy({
  required List<SongCore> songs,
}){
  bool isPersonsFirstSong = _isPersonsFirstSong(songs);
  return 'Piosenki ${songs.length} (${isPersonsFirstSong?' + świeżak + ':' - weteran - '})';
}

String composeContribAttachedSongsEmailLegacy({
  required List<SongCore> songs,
  required SongSource source,
  String? acceptRulesVersion,
  RegisteredContributor? registered,
}) {

  bool isPersonsFirstSong = _isPersonsFirstSong(songs);

  return _baseMessageLegacy(source, acceptRulesVersion, isPersonsFirstSong, registered);

}
