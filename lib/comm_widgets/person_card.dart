import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/color_pack_app.dart';
import 'package:harcapp_core/values/org.dart';
import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';

import '../values/people.dart';

class PersonCardSimple extends StatelessWidget{

  String get name => person.name;
  RankHarc? get rankHarc => person.rankHarc;
  RankInstr? get rankInstr => person.rankInstr;
  String? get druzyna => person.druzyna;
  String? get hufiec => person.hufiec;
  Org? get org => person.org;
  String? get comment => person.comment;

  final Person person;
  final Color? textColor;

  const PersonCardSimple(this.person, {this.textColor, super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          if(rankHarc != null
              && rankHarc != RankHarc.zhpHOc
              && rankHarc != RankHarc.zhpHOd
              && rankHarc != RankHarc.zhpHRc
              && rankHarc != RankHarc.zhpHRd
          ) Text('${rankHarcShortName(rankHarc)} ', style: AppTextStyle(fontSize: Dimen.textSizeBig, color: textColor??textEnab_(context))),
          if(rankInstr != null) Text('$rankInstr ', style: AppTextStyle(fontSize: Dimen.textSizeBig, color: textColor??textEnab_(context))),
          Text(name, style: AppTextStyle(fontSize: Dimen.textSizeBig, fontWeight: weightBold, color: textColor??textEnab_(context))),
          if(rankHarc == RankHarc.zhpHOc
              || rankHarc == RankHarc.zhpHOd
              || rankHarc == RankHarc.zhpHRc
              || rankHarc == RankHarc.zhpHRd
          ) Text(' ${rankHarcShortName(rankHarc)}', style: AppTextStyle(color: textColor??textEnab_(context))),
          Expanded(child: Container()),
        ],
      )
  );
}

class PersonCard extends StatelessWidget{

  String get name => person.name;
  RankHarc? get rankHarc => person.rankHarc;
  RankInstr? get rankInstr => person.rankInstr;
  String? get druzyna => person.druzyna;
  String? get hufiec => person.hufiec;
  Org? get org => person.org;
  String? get comment => person.comment;

  final Person person;
  final double textSize;
  final Color? textColor;

  final bool selectable;

  const PersonCard(this.person, {this.textSize = Dimen.textSizeBig, this.textColor, this.selectable = false, super.key});

  @override
  Widget build(BuildContext context) => SelectionArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              if(rankHarc != null
                  && rankHarc != RankHarc.zhpHOc
                  && rankHarc != RankHarc.zhpHOd
                  && rankHarc != RankHarc.zhpHRc
                  && rankHarc != RankHarc.zhpHRd
              ) Text('${rankHarcShortName(rankHarc)} ', style: AppTextStyle(fontSize: textSize, color: textColor??textEnab_(context))),
              if(rankInstr != null) Text('${rankInstrToStr(rankInstr!)}. ', style: AppTextStyle(fontSize: textSize, color: textColor??textEnab_(context))),
              Text(name, style: AppTextStyle(fontSize: textSize, fontWeight: weightHalfBold, color: textColor??textEnab_(context))),
              if(rankHarc == RankHarc.zhpHOc
                  || rankHarc == RankHarc.zhpHOd
                  || rankHarc == RankHarc.zhpHRc
                  || rankHarc == RankHarc.zhpHRd
              ) Text(' ${rankHarcShortName(rankHarc)}', style: AppTextStyle(fontSize: textSize, color: textColor??textEnab_(context))),
              //Expanded(child: Container()),
              if(org != null) Text(' (', style: AppTextStyle(fontSize: textSize, color: textColor??textEnab_(context), fontWeight: weightHalfBold)),
              if(org != null)
                Text(org!.shortName.$1, style: AppTextStyle(fontSize: textSize, color: org!.colors.avgColor(isDark(context)), fontWeight: weightHalfBold)),
              if(org != null) Text(')', style: AppTextStyle(fontSize: textSize, color: textColor??textEnab_(context), fontWeight: weightHalfBold)),

            ],
          ),
        ),

        if(hufiec != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(hufiec!, style: AppTextStyle(fontSize: textSize, color: textColor??textEnab_(context))),
          ),

        if(druzyna != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(druzyna!, style: AppTextStyle(fontSize: textSize, color: textColor??textEnab_(context))),
          ),

      ],
    ),
  );
}