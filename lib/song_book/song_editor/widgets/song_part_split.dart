import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/dialog/app_dialog.dart';
import 'package:harcapp_core/values/dimen.dart';

import '../../song_element.dart';
import '../song_raw.dart';
import 'song_part_card.dart';

typedef _SplitChunk = ({String text, String chords, bool shift});

final RegExp _paragraphBreak = RegExp(r'\n{2,}');

List<String> _splitParagraphs(String value){
  final chunks = value.split(_paragraphBreak).map((c) => c.trim()).toList();
  while(chunks.isNotEmpty && chunks.last.isEmpty) chunks.removeLast();
  return chunks;
}

/// Distributes `chordChunks` (length [m]) across `textCount` slots (length [n]).
/// - m == n: 1:1 mapping.
/// - m  > n: consecutive chord chunks are merged proportionally.
/// - m  < n: chord chunks are spread evenly, leaving the gaps empty.
List<String> _distributeChords(List<String> chordChunks, int textCount){
  final n = textCount;
  final m = chordChunks.length;

  if(m == n) return chordChunks;

  final result = List<String>.filled(n, '');

  if(m > n){
    for(int i = 0; i < n; i++){
      final from = (m * i / n).floor();
      final to = (m * (i + 1) / n).floor();
      result[i] = chordChunks
          .sublist(from, to)
          .where((c) => c.isNotEmpty)
          .join('\n');
    }
  }else if(m > 0){
    for(int i = 0; i < m; i++){
      final target = (n * i / m).floor();
      result[target] = chordChunks[i];
    }
  }

  return result;
}

List<_SplitChunk>? _computeSplit(SongPart part){
  final textChunks = _splitParagraphs(part.getText())
      .where((c) => c.isNotEmpty)
      .toList();
  if(textChunks.length <= 1) return null;

  final chordChunks = _splitParagraphs(part.chords);
  final chordsAssigned = _distributeChords(chordChunks, textChunks.length);

  return [
    for(int i = 0; i < textChunks.length; i++)
      (text: textChunks[i], chords: chordsAssigned[i], shift: part.shift),
  ];
}

bool canSplitSongPart(SongPart part) => _computeSplit(part) != null;

Future<void> openSplitSongPartDialog(
  BuildContext context, {
  required SongPart part,
  required void Function(List<SongPart> newParts) onConfirm,
  double? maxWidth,
}){
  final chunks = _computeSplit(part);
  assert(chunks != null, 'openSplitSongPartDialog called on a non-splittable part — guard with canSplitSongPart first.');

  return openAppDialog(
    context: context,
    title: 'Podziel zwrotkę na ${chunks!.length}',
    closable: true,
    scrollable: true,
    maxWidth: maxWidth,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for(int i = 0; i < chunks.length; i++) ...[
          if(i > 0) SizedBox(height: Dimen.defMarg),
          Material(
            color: cardEnab_(context),
            borderRadius: BorderRadius.circular(AppCard.bigRadius),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimen.defMarg),
              child: SongPartCard(
                type: SongPartType.ZWROTKA,
                songPart: SongPart.from(SongElement(chunks[i].text, chunks[i].chords, chunks[i].shift)),
              ),
            ),
          ),
        ],
      ],
    ),
    buttons: [
      AppDialogButton(
        text: 'Anuluj',
        onTap: () => Navigator.pop(context),
      ),
      AppDialogButton(
        text: 'Podziel',
        onTap: (){
          Navigator.pop(context);
          onConfirm([
            for(final c in chunks)
              SongPart.from(SongElement(c.text, c.chords, c.shift)),
          ]);
        },
      ),
    ],
  );
}

