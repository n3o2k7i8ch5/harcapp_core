import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/values/rank_instr.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'hint_dropdown_widget.dart';

class RankInstrInputField extends StatelessWidget{

  final RankInstr? rankInstr;
  final bool enabled;
  final bool dimTextOnDisabled;
  final void Function(RankInstr?)? onChanged;
  final bool asterisk;
  final bool withIcon;

  const RankInstrInputField(
      this.rankInstr,
      { this.enabled = true,
        this.dimTextOnDisabled = true,
        this.onChanged,
        this.asterisk = false,
        this.withIcon = true,
        super.key
      });

  @override
  Widget build(BuildContext context) => HintDropdownWidget<RankInstr?>(
    hint: 'Stopień instr.:${asterisk?' *':''}',
    hintTop: 'Stopień instruktorski',
    // MdiIcons.handshakeOutline
    leading: withIcon?Icon(MdiIcons.lighthouse, color: iconDisab_(context)):null,
    enabled: enabled,
    value: rankInstr,
    onChanged: (value) => onChanged?.call(value),
    onCleared: () => onChanged?.call(null),
    items: [
      DropdownMenuItem<RankInstr>(
        value: RankInstr.pwd,
        child: Text('Przewodnik', style: AppTextStyle(color: enabled?textEnab_(context):dimTextOnDisabled?textDisab_(context):textEnab_(context))),
      ),
      DropdownMenuItem<RankInstr>(
        value: RankInstr.phm,
        child: Text('Podharcmistrz', style: AppTextStyle(color: enabled?textEnab_(context):dimTextOnDisabled?textDisab_(context):textEnab_(context))),
      ),
      DropdownMenuItem<RankInstr>(
        value: RankInstr.hm,
        child: Text('Harcmistrz', style: AppTextStyle(color: enabled?textEnab_(context):dimTextOnDisabled?textDisab_(context):textEnab_(context))),
      ),
    ],
  );

}