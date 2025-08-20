import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/values/people.dart';

import 'add_person.dart';

bool _isPersonsFirstSong(ContributorIdentity contribId){
  if(contribId.emailRef == null) return true;
  if(!allPeopleByEmailMap.containsKey(contribId.emailRef)) return true;

  return false;
}

String personToObjectString(Person person, List<ContributorIdentity> contribIds){
  late String newPersonCode;

  bool hasName = person.name.isNotEmpty;
  bool hasDruzyna = person.druzyna != null && person.druzyna!.isNotEmpty;
  bool hasHufiec = person.hufiec != null && person.hufiec!.isNotEmpty;
  bool hasRankInstr = person.rankInstr != null;
  bool hasRankHarc = person.rankHarc != null;
  bool hasOrg = person.org != null;

  List<String> addPersEmails = [];
  for(ContributorIdentity contribId in contribIds)
    if(contribId.emailRef != null) addPersEmails.add(contribId.emailRef!);

  newPersonCode = "const Person ${remPolChars(person.name).toUpperCase().replaceAll(' ', '_')} = Person(";
  if(hasName) newPersonCode += "\n  name: '${person.name}',";
  if(hasDruzyna) newPersonCode += "\n  druzyna: '${person.druzyna}',";
  if(hasHufiec) newPersonCode += "\n  hufiec: '${person.hufiec}',";
  if(hasRankInstr) newPersonCode += "\n  rankInstr: RankInstr.${person.rankInstr?.shortName},";
  if(hasRankHarc) newPersonCode += "\n  rankHarc: RankHarc.${person.rankHarc?.shortName},";
  if(hasOrg) newPersonCode += "\n  org: ${person.org},";
  newPersonCode += "\n  email: [${(person.email.isEmpty?addPersEmails:person.email).map((email) => '"$email"').join(', ')}]";
  newPersonCode += "\n);";

  return newPersonCode;
}

Future<String> composeContribSongEmail(
  SongCore song,
  String? acceptRulesVersion,
  Person? person,
  bool isNewSong,
  String? updateComment
) async {

  bool isPersonsFirstSong = false;
  for (ContributorIdentity contribId in song.addPers)
    if (_isPersonsFirstSong(contribId)) {
      isPersonsFirstSong = true;
      break;
    }

  String? personObjectString = person == null?
  null:
  personToObjectString(
    person,
    song.addPers
  );

  String encodedSong = await song.code;

  return "Przesyłam propozycję piosenki!"
      "\n"
      "\nZnam i akceptuję zasady dodawania piosenek do aplikacji HarcApp (${acceptRulesVersion}, dostępne na www.harcapp.web.app/song_contribution_rules)."
      "\n"
      "\n- - - - - - Nie edytuj poniższego tekstu - - - - - -"
      "\n"
      "\n### Osoba dodająca (${isPersonsFirstSong?' + świeżak + ':' - weteran - '}):"
      "\n"
      "\n$personObjectString"
      "\n"
      "${updateComment != null?'\n### Propozycja poprawki:\n\n$updateComment':''}"
      "\n"
      "\n### Kod piosenki:"
      "\n"
      "\n$encodedSong";

}