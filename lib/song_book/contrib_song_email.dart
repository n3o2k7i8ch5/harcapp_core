import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/utils.dart';

import 'package:harcapp_core/values/people/contributor_ref.dart';

bool _isContributorNew(ContributorRef contribRefs) {
  if(contribRefs.emailRef == null) return true;
  if(!allRegisteredPeopleByEmailMap.containsKey(contribRefs.emailRef)) return true;

  return false;
}

bool _isPersonsFirstSong(List<SongCore> songs){
  bool isPersonsFirstSong = false;
  for (SongCore song in songs)
    for (ContributorRef contribRefs in song.contribRefs)
      if (_isContributorNew(contribRefs)) {
        isPersonsFirstSong = true;
        break;
      }

  return isPersonsFirstSong;
}

enum SongSource{
  application,
  web;

  String get displayName {
    switch(this) {
      case SongSource.application:
        return "Aplikacja ${Platform.isIOS?'iOS':Platform.isAndroid?'Android':''}".trim();
      case SongSource.web:
        return "harcapp.web.app";
    }
  }

  static SongSource? fromDisplayName(String value){
    String v = value.trim();
    if(v == SongSource.web.displayName) return SongSource.web;
    if(v.startsWith('Aplikacja')) return SongSource.application;
    return null;
  }
}

String _registeredPersonToJsonBlock(RegisteredContributor registered, {List<ContributorRef> contribRefs = const []}){
  final contribRefEmails = <String>[
    for(final c in contribRefs)
      if(c.emailRef != null) c.emailRef!,
  ];

  final Map jsonMap = registered.person.toApiJsonMap();
  jsonMap['email'] = registered.emails.isNotEmpty ? registered.emails : contribRefEmails;

  return const JsonEncoder.withIndent('  ').convert(jsonMap);
}

String composeContribSongEmailSubject({
  required SongCore song,
  required bool isNewSong,
}){
  bool isPersonsFirstSong = _isPersonsFirstSong([song]);
  return '${isNewSong?'Nowa piosenka':'Poprawka piosenki'} "${song.title}" (${isPersonsFirstSong?' + świeżak + ':' - weteran - '})';
}

String _baseMessage(
    SongSource source,
    String? acceptRulesVersion,
    bool isPersonsFirstSong,
    RegisteredContributor? registered,
    List<ContributorRef> contribRefs,
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
        '\n```json'
        '\n${_registeredPersonToJsonBlock(registered, contribRefs: contribRefs)}'
        '\n```'
    }";

Future<String> composeContribSongEmail({
  required SongCore song,
  required SongSource source,
  String? acceptRulesVersion,
  RegisteredContributor? registered,
  required bool isNewSong,
  String? updateComment
}) async {

  bool isPersonsFirstSong = _isPersonsFirstSong([song]);

  String encodedSong = await song.code;

  return "${_baseMessage(source, acceptRulesVersion, isPersonsFirstSong, registered, song.contribRefs)}"
      "${
          updateComment != null?
          '\n'
          '\n### Propozycja poprawki:'
          '\n'
          '\n```text'
          '\n$updateComment'
          '\n```':
          ''
      }"
      "\n"
      "\n### Kod piosenki:"
      "\n"
      "\n```json"
      "\n$encodedSong"
      "\n```";
}

String composeContribAttachedSongsEmailSubject({
  required List<SongCore> songs,
}){
  bool isPersonsFirstSong = _isPersonsFirstSong(songs);
  return 'Piosenki ${songs.length} (${isPersonsFirstSong?' + świeżak + ':' - weteran - '})';
}

String composeContribAttachedSongsEmail({
  required List<SongCore> songs,
  required SongSource source,
  String? acceptRulesVersion,
  RegisteredContributor? registered,
}) {

  bool isPersonsFirstSong = _isPersonsFirstSong(songs);

  List<ContributorRef> allContribRefs = [
    for(SongCore song in songs) ...song.contribRefs
  ];

  return _baseMessage(source, acceptRulesVersion, isPersonsFirstSong, registered, allContribRefs);

}
