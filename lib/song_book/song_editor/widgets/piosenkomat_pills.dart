import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_widgets/pill.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';

/// Dzień w podpisach piosenkomatu: „6 wrz”, z rokiem, gdy nie bieżący.
String piosenkomatDay(DateTime at) => dateToString(at.toLocal(), shortMonth: true, showYear: null);

/// Badge POPRAWKA i pastylki uwag — w karcie przeglądu i, w wersji
/// [compact], na liście piosenek. Nic, gdy nie ma czego pokazać.
class PiosenkomatPills extends StatelessWidget{

  final PiosenkomatData data;
  /// Mała wersja do listy: mniejsze pastylki, badge bez celu i daty.
  final bool compact;
  /// Tytuł poprawianej piosenki po `correctionTarget` — strona zna piosenki
  /// z apki, rdzeń nie.
  final String? Function(String songId)? titleOfAppSong;
  final EdgeInsets padding;

  const PiosenkomatPills(this.data, {this.compact = false, this.titleOfAppSong, this.padding = EdgeInsets.zero, super.key});

  @override
  Widget build(BuildContext context){
    if(!data.isCorrection && data.issues.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: padding,
      child: PillWrap(
        compact: compact,
        children: [
          if(data.isCorrection) _CorrectionBadge(data, compact: compact, titleOfAppSong: titleOfAppSong),
          for(final issue in data.issues) _IssuePill(issue, compact: compact),
        ],
      ),
    );
  }

}

/// Jedna uwaga w stylu [Tag] z apki: na pastylce sam kod uwagi
/// (`missing-youtube`) — krótki i jednoznaczny; polski opis i szczegół
/// w podpowiedzi. O wadze mówi kolor: blokada na czerwono, decyzja na
/// pomarańczowo.
class _IssuePill extends StatelessWidget{

  final PiosenkomatIssue issue;
  final bool compact;

  const _IssuePill(this.issue, {required this.compact});

  @override
  Widget build(BuildContext context){
    final (color, icon) = switch(issue.issue.severity){
      SongIssueSeverity.blocking => (Colors.red, MdiIcons.alertOctagonOutline),
      SongIssueSeverity.decision => (Colors.orange, MdiIcons.helpCircleOutline),
    };
    return Tooltip(
      // Przy „user-message” szczegółem jest sama wiadomość — a tę widać
      // wyżej w dymku. Powtarzanie jej w podpowiedzi to szum.
      message: [
        issue.issue.text,
        if(issue.detail != null && issue.issue != SongIssue.userMessage)
          issue.detail!,
      ].join('\n'),
      child: Pill(color: color, icon: icon, label: issue.issue.id, compact: compact),
    );
  }

}

class _CorrectionBadge extends StatelessWidget{

  final PiosenkomatData data;
  final bool compact;
  final String? Function(String songId)? titleOfAppSong;

  const _CorrectionBadge(this.data, {required this.compact, this.titleOfAppSong});

  @override
  Widget build(BuildContext context){
    final target = data.correctionTarget;
    final targetTitle = target == null? null: titleOfAppSong?.call(target) ?? target;
    final sentAt = data.sentAt;

    final label = compact
        ? 'POPRAWKA'
        : [
            'POPRAWKA',
            if(targetTitle != null) '→ $targetTitle',
            if(sentAt != null) '· ${piosenkomatDay(sentAt)}',
          ].join(' ');

    return Tooltip(
      message: target == null
          ? 'Poprawka — nie wiadomo, której piosenki w apce (${SongIssue.noTargetInApp.id})'
          : 'Poprawka piosenki $target',
      child: Pill(
        color: accent_(context),
        icon: MdiIcons.pencilOutline,
        label: label,
        compact: compact,
      ),
    );
  }

}
