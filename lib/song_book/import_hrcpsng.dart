import 'dart:convert';

import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

class HrcpsngImportError implements Exception {
  final String message;
  HrcpsngImportError(this.message);

  @override
  String toString() => 'HrcpsngImportError: $message';
}

(List<SongRaw>, List<SongRaw>) importHrcpsng(String content) {
  Map<String, dynamic> songMap;
  try{
    songMap = jsonDecode(content);
  } catch(e){
    throw HrcpsngImportError('Błąd odczytu pliku (błąd dekodowania JSON)');
  }

  Map<String, dynamic>? offSongsMap;
  try {
    offSongsMap = songMap['official'];
  } catch(e){
    throw HrcpsngImportError('Błąd odczytu pliku (brak sekcji "official")');
  }

  List<SongRaw?> offSongs;
  if(offSongsMap == null) offSongs = [];
  else {
    offSongs = List.filled(offSongsMap.keys.length, null, growable: true);

    for(String fileName in offSongsMap.keys){
      try {
        Map<String, dynamic> songPackMap = offSongsMap[fileName];
        SongRaw song = SongRaw.fromApiRespMap(fileName, songPackMap['song']);

        if (!song.isOfficial) song.id = 'o!_' + song.id;
        offSongs[songPackMap['index']] = song;
      } catch(e){
        throw HrcpsngImportError('Błąd odczytu pliku (błąd dekodowania piosenki ${fileName})');
      }
    }
  }

  Map<String, dynamic>? confSongsMap = songMap['conf'];
  List<SongRaw?> confSongs;
  if(confSongsMap == null) confSongs = [];
  else{
    confSongs = List.filled(confSongsMap.keys.length, null, growable: true);

    for(String fileName in confSongsMap.keys){
      try {
        Map<String, dynamic> songPackMap = confSongsMap[fileName];
        SongRaw song = SongRaw.fromApiRespMap(fileName, songPackMap['song']);

        if (!song.isConfid) song.id = 'oc!_' + song.id;
        confSongs[songPackMap['index']] = song;
      } catch(e){
        throw HrcpsngImportError('Błąd odczytu pliku (błąd dekodowania piosenki ${fileName})');
      }
    }
  }

  return (offSongs.cast<SongRaw>(), confSongs.cast<SongRaw>());
}