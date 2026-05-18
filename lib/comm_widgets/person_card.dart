import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/color_pack_app.dart';
import 'package:harcapp_core/values/org.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

class PersonCard extends StatelessWidget{

  String get name => person.name;
  RankHarc? get rankHarc => person.rankHarc;
  RankInstr? get rankInstr => person.rankInstr;
  String? get druzyna => person.druzyna;
  Srodowisko? get srodowisko => person.srodowisko;
  Org? get org => person.org;
  String? get comment => person.comment;

  final Person person;
  final double textSize;
  final Color? textColor;

  final bool selectable;

  const PersonCard(this.person, {this.textSize = Dimen.textSizeBig, this.textColor, this.selectable = false, super.key});

  @override
  Widget build(BuildContext context) {
    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _children(context),
    );
    return selectable ? SelectionArea(child: body) : body;
  }

  List<Widget> _children(BuildContext context) {
    final defaultColor = textColor ?? textEnab_(context);
    final lines = srodowisko?.displayLines ?? const <String>[];

    // Gdy pełna nazwa organizacji jest jedyną informacją o środowisku,
    // pomijamy skrót w nawiasie obok imienia i renderujemy tę nazwę na dole
    // w kolorze organizacji. W innym wypadku skrót jest obok imienia, a
    // pełna nazwa organizacji nie powtarza się w liście linii środowiska.
    final orgOnly = org != null
        && lines.length == 1
        && lines.first == org!.fullName;

    final showOrgInline = org != null && !orgOnly;

    final visibleLines = (org != null && !orgOnly)
        ? lines.where((l) => l != org!.fullName).toList()
        : lines;

    final srodowiskoColor = orgOnly
        ? org!.colors.avgColor(isDark(context))
        : defaultColor;

    return [
      _buildHeader(context, defaultColor, showOrgInline: showOrgInline),
      if(druzyna != null) _buildLine(druzyna!, defaultColor),
      for(final line in visibleLines) _buildLine(line, srodowiskoColor),
    ];
  }

  Widget _buildHeader(BuildContext context, Color color, {required bool showOrgInline}) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            if(rankHarc != null && !_renderRankAfterName(rankHarc!))
              Text('${rankHarc!.shortName} ', style: AppTextStyle(fontSize: textSize, color: color)),
            if(rankInstr != null)
              Text('${rankInstr!.shortName}. ', style: AppTextStyle(fontSize: textSize, color: color)),
            Text(name, style: AppTextStyle(fontSize: textSize, fontWeight: weightHalfBold, color: color)),
            if(rankHarc != null && _renderRankAfterName(rankHarc!))
              Text(' ${rankHarc!.shortName}', style: AppTextStyle(fontSize: textSize, color: color)),
            if(showOrgInline) _buildOrgChip(context, color),
          ],
        ),
      );

  Widget _buildOrgChip(BuildContext context, Color baseColor) => Text.rich(
        TextSpan(
          style: AppTextStyle(fontSize: textSize, color: baseColor, fontWeight: weightHalfBold),
          children: [
            const TextSpan(text: ' ('),
            TextSpan(
              text: org!.shortName.$1,
              style: TextStyle(color: org!.colors.avgColor(isDark(context))),
            ),
            const TextSpan(text: ')'),
          ],
        ),
      );

  Widget _buildLine(String text, Color color) => Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(text, style: AppTextStyle(fontSize: textSize, color: color)),
      );

  static bool _renderRankAfterName(RankHarc r) =>
      r == RankHarc.zhpHOc ||
      r == RankHarc.zhpHOd ||
      r == RankHarc.zhpHRc ||
      r == RankHarc.zhpHRd;
}
