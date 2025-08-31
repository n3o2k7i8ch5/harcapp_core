import 'package:flutter/material.dart';
import 'package:harcapp_core/song_book/song_editor/providers.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/song_tags.dart';
import 'package:provider/provider.dart';

class SongEditorApp extends StatelessWidget{

  final Widget Function(BuildContext, Widget?) builder;

  const SongEditorApp({
    required this.builder
  });

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CurrentItemProvider(song: SongRaw.empty())),
      ChangeNotifierProvider(create: (context) => RefrenEnabProvider(true)),
      ChangeNotifierProvider(create: (context) => RefrenPartProvider()),
      ChangeNotifierProvider(create: (context) => TagsProvider(SongTag.ALL, [])),
    ],
    builder: builder
  );

}
