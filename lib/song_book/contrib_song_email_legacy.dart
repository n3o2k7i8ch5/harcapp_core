// Legacy email composer for song contributions.
// Kept as a reference for the older format that parseContribEmail still needs
// to fall back to. New emails should be composed via contrib_song_email.dart.

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/utils.dart';

import 'contrib_song_email.dart';
import 'package:harcapp_core/values/people/contributor_identity.dart';

bool _isContributorNew(ContributorIdentity contribId) {
  if(contribId.emailRef == null) return true;
  if(!allRegisteredPeopleByEmailMap.containsKey(contribId.emailRef)) return true;

  return false;
}

bool _isPersonsFirstSong(List<SongCore> songs){
  bool isPersonsFirstSong = false;
  for (SongCore song in songs)
    for (ContributorIdentity contribId in song.contribId)
      if (_isContributorNew(contribId)) {
        isPersonsFirstSong = true;
        break;
      }

  return isPersonsFirstSong;
}

String registeredPersonToObjectStringLegacy(RegisteredContributorPerson registered, {List<ContributorIdentity> contribIds = const []}) =>
    _registeredPersonToObjectString(registered, contribIds: contribIds);

String _registeredPersonToObjectString(RegisteredContributorPerson registered, {List<ContributorIdentity> contribIds = const []}){
  final person = registered.person;

  final contribIdEmails = <String>[
    for(final c in contribIds)
      if(c.emailRef != null) c.emailRef!,
  ];
  final emails = registered.emails.isNotEmpty ? registered.emails : contribIdEmails;

  final personFields = <String>[];
  if(person.name.isNotEmpty) personFields.add("name: '${person.name}'");
  if(person.druzyna != null && person.druzyna!.isNotEmpty) personFields.add("druzyna: '${person.druzyna}'");
  if(person.srodowisko != null) personFields.add("srodowisko: Srodowisko.custom('${person.srodowisko!.displayName}')");
  if(person.rankInstr != null) personFields.add("rankInstr: RankInstr.${person.rankInstr!.name}");
  if(person.rankHarc != null) personFields.add("rankHarc: RankHarc.${person.rankHarc!.name}");
  if(person.comment != null && person.comment!.isNotEmpty) personFields.add("comment: '${person.comment}'");

  final varName = remPolChars(person.name).toUpperCase().replaceAll(' ', '_');
  final emailsLiteral = '[${emails.map((e) => '"$e"').join(', ')}]';

  return [
    'RegisteredContributorPerson $varName = const RegisteredContributorPerson(',
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
    RegisteredContributorPerson? registered,
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
  RegisteredContributorPerson? registered,
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
  RegisteredContributorPerson? registered,
}) {

  bool isPersonsFirstSong = _isPersonsFirstSong(songs);

  return _baseMessageLegacy(source, acceptRulesVersion, isPersonsFirstSong, registered);

}
