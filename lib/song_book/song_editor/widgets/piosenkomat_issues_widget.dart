import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:provider/provider.dart';

import '../providers.dart';

/// Kolor uwagi po wadze: blokada na czerwono, decyzja na pomarańczowo.
Color piosenkomatIssueColor(BuildContext context, SongIssue issue) => switch(issue.severity){
  SongIssueSeverity.blocking => Colors.red,
  SongIssueSeverity.decision => Colors.orange,
};

IconData piosenkomatIssueIcon(SongIssue issue) => switch(issue.severity){
  SongIssueSeverity.blocking => MdiIcons.alertOctagonOutline,
  SongIssueSeverity.decision => MdiIcons.helpCircleOutline,
};

/// Nagłówek piosenkomatu nad przeglądaną piosenką: badge POPRAWKA, dopiski
/// autora do przeczytania i pastylki z uwagami.
///
/// Wszystko tu jest **tylko do czytania**. Pastylki są dla przeglądającego,
/// nie dla narzędzia — piosenkomat po przeglądzie ich nie sprawdza; piosenka
/// jest w pliku → wchodzi, nie ma → odrzucona.
///
/// Świadomie osobne od [SongTagsWidget] i od błędów edytora: to nie są tagi
/// piosenki (te widzi użytkownik apki) ani walidacja treści (tę edytor liczy
/// sam) — tylko ślad narzędzia, które zgłoszenie przyniosło.
class PiosenkomatHeaderWidget extends StatelessWidget{

  final EdgeInsets padding;
  /// Tytuł poprawianej piosenki po `correctionTarget` — strona zna piosenki
  /// z apki, rdzeń nie.
  final String? Function(String songId)? titleOfAppSong;

  const PiosenkomatHeaderWidget({
    this.padding = EdgeInsets.zero,
    this.titleOfAppSong,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Consumer<CurrentItemProvider>(
    builder: (context, prov, child){

      final PiosenkomatData? data = prov.song.piosenkomatData;
      if(data == null) return const SizedBox.shrink();
      if(!data.isCorrection && !data.hasMessages && data.issues.isEmpty)
        return const SizedBox.shrink();

      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              if(data.isCorrection) ...[
                _CorrectionBadge(data, titleOfAppSong: titleOfAppSong),
                const SizedBox(height: Dimen.defMarg),
              ],

              if(data.hasMessages) ...[
                _MessagesFrame(data),
                const SizedBox(height: Dimen.defMarg),
              ],

              if(data.issues.isNotEmpty)
                PiosenkomatIssuesWidget(data.issues),

            ],
          ),
        ),
      );

    },
  );

}

/// Rząd pastylek — od lewej, zawijany.
class PiosenkomatIssuesWidget extends StatelessWidget{

  final List<PiosenkomatIssue> issues;
  final bool compact;

  const PiosenkomatIssuesWidget(this.issues, {this.compact = false, super.key});

  @override
  Widget build(BuildContext context) => Wrap(
    alignment: WrapAlignment.start,
    spacing: compact? Dimen.defMarg/2: Dimen.defMarg,
    runSpacing: compact? Dimen.defMarg/2: Dimen.defMarg,
    children: [
      for(final issue in issues) PiosenkomatIssuePill(issue, compact: compact),
    ],
  );

}

/// Jedna pastylka w stylu [Tag] z apki: karta o pełnym zaokrągleniu, bez
/// obramowania. Na pastylce sam kod uwagi (`missing-youtube`) — krótki
/// i jednoznaczny; polski opis i szczegół w podpowiedzi. O wadze mówi kolor
/// ikony z przodu, nie tło — tło zostaje neutralne.
class PiosenkomatIssuePill extends StatelessWidget{

  final PiosenkomatIssue issue;
  /// Mała wersja do listy: mniejsza czcionka, płasko.
  final bool compact;

  const PiosenkomatIssuePill(this.issue, {this.compact = false, super.key});

  @override
  Widget build(BuildContext context){
    final color = piosenkomatIssueColor(context, issue.issue);
    final fontSize = compact? Dimen.textSizeTiny: Dimen.textSizeSmall;
    final pad = compact? Dimen.defMarg/2: Dimen.iconMarg;

    final pill = SimpleButton(
      radius: 100,
      elevation: compact? 0: AppCard.defElevation,
      color: compact? backgroundIcon_(context): cardEnab_(context),
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: compact? 2: pad/2),
      onTap: null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(piosenkomatIssueIcon(issue.issue), size: fontSize + 2, color: color),
          SizedBox(width: pad/2),
          Text(
            issue.issue.id,
            style: AppTextStyle(
              fontSize: fontSize,
              fontWeight: compact? weightNormal: weightHalfBold,
              color: textEnab_(context),
            ),
            maxLines: 1,
          ),
        ],
      ),
    );

    return Tooltip(
      message: [issue.issue.text, if(issue.detail != null) issue.detail!].join('\n'),
      child: pill,
    );
  }

}

/// Mały podgląd do listy piosenek — badge poprawki i pastylki, bez dopisków.
class PiosenkomatIssuesPreview extends StatelessWidget{

  final SongRaw song;

  const PiosenkomatIssuesPreview(this.song, {super.key});

  @override
  Widget build(BuildContext context){
    final data = song.piosenkomatData;
    if(data == null || (!data.isCorrection && data.issues.isEmpty))
      return const SizedBox.shrink();
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: Dimen.defMarg/2,
      runSpacing: Dimen.defMarg/2,
      children: [
        if(data.isCorrection) _CorrectionBadge(data, compact: true),
        for(final issue in data.issues) PiosenkomatIssuePill(issue, compact: true),
      ],
    );
  }

}

class _CorrectionBadge extends StatelessWidget{

  final PiosenkomatData data;
  final bool compact;
  final String? Function(String songId)? titleOfAppSong;

  const _CorrectionBadge(this.data, {this.compact = false, this.titleOfAppSong});

  @override
  Widget build(BuildContext context){
    final fontSize = compact? Dimen.textSizeTiny: Dimen.textSizeSmall;
    final pad = compact? Dimen.defMarg/2: Dimen.iconMarg;
    final accent = accent_(context);

    final target = data.correctionTarget;
    final targetTitle = target == null? null: titleOfAppSong?.call(target) ?? target;
    final when = data.sentAt == null? null: _day(data.sentAt!);

    final label = compact
        ? 'POPRAWKA'
        : [
            'POPRAWKA',
            if(targetTitle != null) '→ $targetTitle',
            if(when != null) '· $when',
          ].join(' ');

    return Tooltip(
      message: target == null
          ? 'Poprawka — nie wiadomo, której piosenki w apce (no-target-in-app)'
          : 'Poprawka piosenki $target',
      child: SimpleButton(
        radius: 100,
        elevation: 0,
        color: accent.withValues(alpha: 0.15),
        padding: EdgeInsets.symmetric(horizontal: pad, vertical: compact? 2: pad/2),
        onTap: null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(MdiIcons.pencilOutline, size: fontSize + 2, color: accent),
            SizedBox(width: pad/2),
            Text(
              label,
              style: AppTextStyle(fontSize: fontSize, fontWeight: weightHalfBold, color: accent),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  static String _day(DateTime d) => d.toLocal().toIso8601String().substring(0, 10);

}

/// Dopiski autora: do przeczytania, nie do ogarnięcia.
class _MessagesFrame extends StatelessWidget{

  final PiosenkomatData data;

  const _MessagesFrame(this.data);

  @override
  Widget build(BuildContext context){
    final correction = data.correctionMessage ?? '';
    final user = data.userMessage ?? '';
    return Material(
      color: backgroundIcon_(context),
      borderRadius: BorderRadius.circular(AppCard.defRadius),
      child: Padding(
        padding: const EdgeInsets.all(Dimen.iconMarg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if(correction.isNotEmpty)
              _message(context, 'Propozycja poprawki', correction),
            if(correction.isNotEmpty && user.isNotEmpty)
              const SizedBox(height: Dimen.defMarg),
            if(user.isNotEmpty)
              _message(context, 'Wiadomość od autora', user),
          ],
        ),
      ),
    );
  }

  Widget _message(BuildContext context, String title, String text) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(title, style: AppTextStyle(
        fontSize: Dimen.textSizeSmall, fontWeight: weightHalfBold, color: hintEnab_(context))),
      const SizedBox(height: 2),
      SelectableText(text, style: AppTextStyle(fontSize: Dimen.textSizeNormal, color: textEnab_(context))),
    ],
  );

}
