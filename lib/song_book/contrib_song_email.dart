import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/utils.dart';

import 'package:harcapp_core/values/people/contributor_ref.dart';

bool isContributorsFirstSong(Iterable<String> emails){
  for(final e in emails)
    if(registeredPersonByEmail(e) != null)
      return false;

  return true;
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
  RegisteredContributor? registered,
}){
  final firstSong = isContributorsFirstSong(registered?.emails ?? const []);
  return '${isNewSong?'Nowa piosenka':'Poprawka piosenki'} "${song.title}" (${firstSong?' + świeżak + ':' - weteran - '})';
}

String _baseMessage(
    SongSource source,
    String? acceptRulesVersion,
    bool isContributorsFirstSong,
    RegisteredContributor? registered,
    List<ContributorRef> contribRefs,
    {String? correctedSongId}
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
        correctedSongId == null?
        '':
        '\n'
        '\n### Poprawiana piosenka:'
        '\n'
        '\n```'
        '\n$correctedSongId'
        '\n```'
    }"
    "${
        registered == null?
        '':
        '\n'
        '\n### Osoba dodająca (${isContributorsFirstSong?' + świeżak + ':' - weteran - '}):'
        '\n'
        '\n```json'
        '\n${_registeredPersonToJsonBlock(registered, contribRefs: contribRefs)}'
        '\n```'
    }";

/// [correctedSongId] to `lclId` piosenki, którą autor poprawia — jedziemy z nim
/// w mejlu, bo kod piosenki leci bez id (`withId: false`) i bez tej linii
/// piosenkomat musi zgadywać cel poprawki po tytule i tekście.
Future<String> composeContribSongEmail({
  required SongCore song,
  required SongSource source,
  String? acceptRulesVersion,
  RegisteredContributor? registered,
  required bool isNewSong,
  String? updateComment,
  String? correctedSongId,
}) async {

  final firstSong = isContributorsFirstSong(registered?.emails ?? const []);

  String encodedSong = await song.code;

  return "${_baseMessage(source, acceptRulesVersion, firstSong, registered, song.contribRefs, correctedSongId: isNewSong? null: correctedSongId)}"
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
  RegisteredContributor? registered,
}){
  final firstSong = isContributorsFirstSong(registered?.emails ?? const []);
  return 'Piosenki ${songs.length} (${firstSong?' + świeżak + ':' - weteran - '})';
}

String composeContribAttachedSongsEmail({
  required List<SongCore> songs,
  required SongSource source,
  String? acceptRulesVersion,
  RegisteredContributor? registered,
}) {

  final firstSong = isContributorsFirstSong(registered?.emails ?? const []);

  List<ContributorRef> allContribRefs = [
    for(SongCore song in songs) ...song.contribRefs
  ];

  return _baseMessage(source, acceptRulesVersion, firstSong, registered, allContribRefs);

}
