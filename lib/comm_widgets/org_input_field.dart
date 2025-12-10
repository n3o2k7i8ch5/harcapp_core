import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/values/org.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'hint_dropdown_widget.dart';

class OrgInputField extends StatelessWidget{

  final Org? org;

  final bool enabled;
  final bool dimTextOnDisabled;
  final void Function(Org?)? onChanged;
  final bool asterisk;
  final bool withIcon;

  const OrgInputField(
      this.org,
      { this.enabled = true,
        this.dimTextOnDisabled = true,
        this.onChanged,
        this.asterisk = false,
        this.withIcon = true,
        super.key
      });

  @override
  Widget build(BuildContext context) => HintDropdownWidget<Org?>(
    hint: 'Org. harcerska:${asterisk?' *':''}',
    hintTop: 'Organizacja harcerska',
    // MdiIcons.googleCirclesExtended
    leading: withIcon?Icon(MdiIcons.homeVariantOutline, color: iconDisab_(context)):null,
    value: org,
    onChanged: (value) async => onChanged?.call(value),
    onCleared: () async => onChanged?.call(null),
    enabled: enabled,
    items: [
      DropdownMenuItem<Org>(
        value: Org.zhp,
        child: Text('ZHP', style: AppTextStyle(color: enabled?textEnab_(context):dimTextOnDisabled?textDisab_(context):textEnab_(context))),
      ),
      DropdownMenuItem<Org>(
        value: Org.zhr,
        child: Text('ZHR', style: AppTextStyle(color: enabled?textEnab_(context):dimTextOnDisabled?textDisab_(context):textEnab_(context))),
      ),
      DropdownMenuItem<Org>(
        value: Org.fse,
        child: Text('FSE', style: AppTextStyle(color: enabled?textEnab_(context):dimTextOnDisabled?textDisab_(context):textEnab_(context))),
      ),
      DropdownMenuItem<Org>(
        value: Org.sh,
        child: Text('SH', style: AppTextStyle(color: enabled?textEnab_(context):dimTextOnDisabled?textDisab_(context):textEnab_(context))),
      ),
      DropdownMenuItem<Org>(
        value: Org.zhpNL,
        child: Text('ZHPnL', style: AppTextStyle(color: enabled?textEnab_(context):dimTextOnDisabled?textDisab_(context):textEnab_(context))),
      ),
      DropdownMenuItem<Org>(
        value: Org.hrp,
        child: Text('HRP', style: AppTextStyle(color: enabled?textEnab_(context):dimTextOnDisabled?textDisab_(context):textEnab_(context))),
      ),
    ],
  );

}