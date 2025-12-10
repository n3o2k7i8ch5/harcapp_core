import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/values/rank_harc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'hint_dropdown_widget.dart';

class RankHarcInputField extends StatelessWidget{

  final RankHarc? rankHarc;
  final bool enabled;
  final bool dimTextOnDisabled;
  final void Function(RankHarc?)? onChanged;
  final bool asterisk;
  final bool withIcon;

  const RankHarcInputField(
      this.rankHarc,
      { this.enabled = true,
        this.dimTextOnDisabled = true,
        this.onChanged,
        this.asterisk = false,
        this.withIcon = true,
        super.key
      });

  @override
  Widget build(BuildContext context) => HintDropdownWidget<RankHarc?>(
    hint: 'Stopień harc.:${asterisk?' *':''}',
    hintTop: 'Stopień harcerski',
    leading: withIcon?Icon(MdiIcons.chevronDoubleRight, color: iconDisab_(context)):null,
    enabled: enabled,
    value: rankHarc,

    onChanged: (value) => onChanged?.call(value),
    onCleared: () => onChanged?.call(null),
    items: RankHarc.values.map((r) => DropdownMenuItem<RankHarc>(
      value: r,
      child: Text(
        r.longName(withOrg: true),
        style: AppTextStyle(
          color: enabled?textEnab_(context):dimTextOnDisabled?textDisab_(context):textEnab_(context)
        )
      ),
    )).toList(),
  );

}