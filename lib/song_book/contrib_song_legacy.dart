// Legacy email composer for song contributions.
// Kept as a reference for the older format that parseContribEmail still needs
// to fall back to. New emails should be composed via contrib_song.dart.

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/values/people/person.dart';
import 'package:harcapp_core/values/people/utils.dart';

import 'contrib_song.dart';
import 'contributor_identity.dart';

bool _isContributorNew(ContributorIdentity contribId) {
  if(contribId.emailRef == null) return true;
  if(!allPeopleByEmailMap.containsKey(contribId.emailRef)) return true;

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

String personToObjectStringLegacy(Person person, {List<ContributorIdentity> contribIds = const []}) =>
    _personToObjectString(person, contribIds: contribIds);

String _personToObjectString(Person person, {List<ContributorIdentity> contribIds = const []}){
  late String newPersonCode;

  bool hasName = person.name.isNotEmpty;
  bool hasDruzyna = person.druzyna != null && person.druzyna!.isNotEmpty;
  bool hasSrodowisko = person.srodowisko != null && person.srodowisko!.isNotEmpty;
  bool hasRankInstr = person.rankInstr != null;
  bool hasRankHarc = person.rankHarc != null;
  bool hasOrg = person.org != null;
  bool hasComment = person.comment != null && person.comment!.isNotEmpty;

  List<String> contribIdEmails = [];
  for(ContributorIdentity contribId in contribIds)
    if(contribId.emailRef != null) contribIdEmails.add(contribId.emailRef!);

  newPersonCode = "Person ${remPolChars(person.name).toUpperCase().replaceAll(' ', '_')} = const Person(";
  if(hasName) newPersonCode += "\n  name: '${person.name}',";
  if(hasDruzyna) newPersonCode += "\n  druzyna: '${person.druzyna}',";
  if(hasSrodowisko) newPersonCode += "\n  hufiec: '${person.srodowisko}',";
  if(hasRankInstr) newPersonCode += "\n  rankInstr: RankInstr.${person.rankInstr?.name},";
  if(hasRankHarc) newPersonCode += "\n  rankHarc: RankHarc.${person.rankHarc?.name},";
  if(hasOrg) newPersonCode += "\n  org: ${person.org},";
  if(hasComment) newPersonCode += "\n  comment: '${person.comment}',";
  newPersonCode += "\n  email: [${(person.email.isEmpty?contribIdEmails:person.email).map((email) => '"$email"').join(', ')}]";
  newPersonCode += "\n);";

  return newPersonCode;
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
    Person? person,
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
        person == null?
        '':
        '\n'
        '\n### Osoba dodająca (${isPersonsFirstSong?' + świeżak + ':' - weteran - '}):'
        '\n'
        '\n${_personToObjectString(person)}'
    }";

Future<String> composeContribSongEmailLegacy({
  required SongCore song,
  required SongSource source,
  String? acceptRulesVersion,
  Person? person,
  required bool isNewSong,
  String? updateComment
}) async {

  bool isPersonsFirstSong = _isPersonsFirstSong([song]);

  String encodedSong = await song.code;

  return "${_baseMessageLegacy(source, acceptRulesVersion, isPersonsFirstSong, person)}"
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
  Person? person,
}) {

  bool isPersonsFirstSong = _isPersonsFirstSong(songs);

  return _baseMessageLegacy(source, acceptRulesVersion, isPersonsFirstSong, person);

}
