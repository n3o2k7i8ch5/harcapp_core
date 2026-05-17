import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/contributor_ref_field.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'package:harcapp_core/values/people/contributor_ref.dart';
import '../providers.dart';

class ContributorRefListWidget extends StatefulWidget{

  final void Function(List<ContributorRef>)? onChanged;
  final EdgeInsets titlePadding;
  final EdgeInsets listPadding;

  const ContributorRefListWidget({this.onChanged, this.titlePadding = EdgeInsets.zero, this.listPadding = EdgeInsets.zero, super.key});

  @override
  State<StatefulWidget> createState() => ContributorRefListWidgetState();

}

class ContributorRefListWidgetState extends State<ContributorRefListWidget>{

  void Function(List<ContributorRef>)? get onChanged => widget.onChanged;

  void _addEmpty(CurrentItemProvider prov){
    prov.insertContribId(ContributorRef());
    onChanged?.call(prov.contribId);
  }

  @override
  Widget build(BuildContext context) => Consumer<CurrentItemProvider>(
    builder: (context, prov, child) =>
        Column(
          children: [

            Padding(
              padding: widget.titlePadding,
              child: TitleShortcutRowWidget(
                title: prov.contribId.length <= 1?'Osoba dodająca':'Osoby dodające',
                textAlign: TextAlign.left,
                trailing: AppButton(
                  icon: Icon(MdiIcons.plus),
                  onTap: prov.contribId.isNotEmpty && prov.contribId.last.isEmpty
                      ? null
                      : () => _addEmpty(prov),
                ),
              ),
            ),

            AnimatedListView(
              padding: widget.listPadding,
              items: prov.contribId,
              itemBuilder: (context, index){
                final entry = prov.contribId[index];
                return Padding(
                  key: ObjectKey(entry),
                  padding: EdgeInsets.only(bottom: index < prov.contribId.length - 1?Dimen.defMarg:0),
                  child: ContributorRefField(
                    identity: entry,
                    emptyLabel: 'Dodaj osobę dodającą',
                    dialogTitle: 'Osoba dodająca',
                    onChanged: (id){
                      if(id == null || id.isEmpty){
                        if(prov.contribId.length <= 1)
                          prov.setContribIdAt(index, ContributorRef());
                        else
                          prov.removeContribIdAt(index);
                      } else {
                        prov.setContribIdAt(index, id);
                      }
                      onChanged?.call(prov.contribId);
                    },
                  ),
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              enterTransition: [FadeIn()],
              exitTransition: [SlideInUp(), FadeIn()],
              isSameItem: (a, b) => identical(a, b),
            ),

            Padding(
              padding: widget.listPadding + const EdgeInsets.symmetric(vertical: Dimen.iconMarg, horizontal: Dimen.iconMarg),
              child: Text(
                'Podaj email, by połączyć swoje piosenki jednolitym podpisem. Sam email nie będzie widoczny.',
                style: AppTextStyle(
                    fontWeight: weightHalfBold,
                    color: hintEnab_(context),
                    fontSize: Dimen.textSizeBig,
                    height: 1.2
                ),
                textAlign: TextAlign.center,
              ),
            ),

          ],
        ),

  );

}
