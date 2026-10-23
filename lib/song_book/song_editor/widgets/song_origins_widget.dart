import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_dropdown.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:provider/provider.dart';

import '../../song_origin.dart';
import '../providers.dart';

/// Sekcja „Pochodzenie”: każde to wiersz rodzaj + nazwa („Z bajki” + „Shrek”).
///
/// Rodzaj z tagiem (z bajki → `#ZBajek`) od razu dokłada ten tag do piosenki:
/// filtr w apce działa po tagach, a test śpiewnika pilnuje, żeby się zgadzały.
/// Usunięcie pochodzenia tagu nie zdejmuje — piosenka bywa z bajki, choć nie
/// wiadomo, z której.
class SongOriginsWidget extends StatelessWidget{

  final void Function(List<SongOrigin>)? onChanged;
  final EdgeInsets titlePadding;
  final EdgeInsets listPadding;

  const SongOriginsWidget({this.onChanged, this.titlePadding = EdgeInsets.zero, this.listPadding = EdgeInsets.zero, super.key});

  void _ensureTag(BuildContext context, CurrentItemProvider prov, SongOriginType type){
    final tag = type.tag;
    if(tag == null) return;
    final tagsProv = TagsProvider.of(context);
    tagsProv.add(tag);
    prov.setTags(tagsProv.checkedTags, notify: false);
  }

  @override
  Widget build(BuildContext context) => Consumer<CurrentItemProvider>(
    builder: (context, prov, child) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        Padding(
          padding: titlePadding,
          child: TitleShortcutRowWidget(
            title: 'Pochodzenie',
            textAlign: TextAlign.left,
            trailing: AppDropdown<SongOriginType>(
              items: SongOriginType.values,
              onSelected: (type){
                prov.addOrigin(type);
                _ensureTag(context, prov, type);
                onChanged?.call(prov.origins);
              },
              child: SimpleButton.from(
                context: context,
                icon: MdiIcons.plus,
                margin: EdgeInsets.zero,
                onTap: null,
              ),
            ),
          ),
        ),

        for(int i=0; i<prov.origins.length; i++)
          Padding(
            key: ObjectKey(prov.originControllers[i]),
            padding: listPadding + EdgeInsets.only(bottom: i < prov.origins.length - 1? Dimen.defMarg: 0),
            child: Row(
              children: [

                AppDropdown<SongOriginType>(
                  items: SongOriginType.values,
                  onSelected: (type){
                    prov.setOriginType(i, type);
                    _ensureTag(context, prov, type);
                    onChanged?.call(prov.origins);
                  },
                  child: SimpleButton.from(
                    context: context,
                    icon: prov.origins[i].type.icon,
                    text: prov.origins[i].type.label,
                    textColor: iconEnab_(context),
                    color: backgroundIcon_(context),
                    radius: AppCard.defRadius,
                    margin: EdgeInsets.zero,
                    onTap: null,
                  ),
                ),

                const SizedBox(width: Dimen.defMarg),

                Expanded(
                  child: AppTextFieldHint(
                    controller: prov.originControllers[i],
                    hint: '${prov.origins[i].type.valueHint}:',
                    style: AppTextStyle(
                      fontSize: Dimen.textSizeBig,
                      fontWeight: weightHalfBold,
                      color: textEnab_(context),
                    ),
                    hintStyle: AppTextStyle(
                      fontSize: Dimen.textSizeBig,
                      color: hintEnab_(context),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    onAnyChanged: (values){
                      prov.setOriginValue(i, values[0], notify: false);
                      onChanged?.call(prov.origins);
                    },
                  ),
                ),

                AppButton(
                  icon: Icon(MdiIcons.close),
                  onTap: (){
                    prov.removeOriginAt(i);
                    onChanged?.call(prov.origins);
                  },
                ),

              ],
            ),
          ),

        if(prov.origins.isEmpty)
          Padding(
            padding: listPadding + const EdgeInsets.all(Dimen.iconMarg),
            child: Text(
              'Z bajki, z filmu, z serialu, z musicalu albo czego to przeróbka.',
              style: AppTextStyle(
                fontWeight: weightHalfBold,
                color: hintEnab_(context),
                fontSize: Dimen.textSizeBig,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),

      ],
    ),
  );

}
