import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/song/song_core.dart';
import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';
import 'package:implicitly_animated_reorderable_list_2/transitions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../providers.dart';

class AddPersWidget extends StatelessWidget{

  static const double height = 2*Dimen.defMarg + 2*Dimen.defMarg + Dimen.defMarg + 2*Dimen.ICON_FOOTPRINT;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final void Function()? onChanged;
  final void Function()? onRemoveTap;

  const AddPersWidget(this.nameController, this.emailController, {this.onChanged, this.onRemoveTap, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(Dimen.defMarg),
    child: Material(
      color: cardEnab_(context),
      borderRadius: BorderRadius.circular(AppCard.bigRadius),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: EdgeInsets.all(Dimen.defMarg),
        child: Material(
          borderRadius: BorderRadius.circular(AppCard.bigRadius - 6),
          clipBehavior: Clip.hardEdge,
          color: background_(context),
          child: Padding(
            padding: EdgeInsets.only(left: Dimen.ICON_MARG, top: Dimen.defMarg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextFieldHint(
                        hint: 'Imię i nazwisko:',
                        hintTop: 'Imię i nazwisko',
                        controller: nameController,
                        onChanged: (_, __) => onChanged?.call(),
                      ),
                      Row(
                        children: [

                          if(emailController.text.isEmpty)
                            IconButton(
                              icon: Icon(MdiIcons.alertCircleOutline, color: Colors.red),
                              onPressed: () => AppScaffold.showMessage(context, 'Podaj email, by zyskać wieczystą sławę'),
                            ),

                          Expanded(
                            child: AppTextFieldHint(
                              hint: 'Email:',
                              hintTop: 'Email',
                              controller: emailController,
                              onChanged: (_, __) => onChanged?.call(),
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(MdiIcons.close),
                    onPressed: onRemoveTap
                )
              ],
            ),
          ),
        ),
      )
    ),
  );

}

class AddPersListWidget extends StatefulWidget{

  final void Function(List<AddPerson>)? onAddPersChanged;

  const AddPersListWidget({this.onAddPersChanged});

  @override
  State<StatefulWidget> createState() => AddPersListWidgetState();

}

class AddPersListWidgetState extends State<AddPersListWidget>{

  void Function(List<AddPerson>)? get onAddPersChanged => widget.onAddPersChanged;

  @override
  Widget build(BuildContext context) => Consumer<CurrentItemProvider>(
    builder: (context, prov, child) => ImplicitlyAnimatedReorderableList<Tuple3<TextEditingController, TextEditingController, TextEditingController>>(
      physics: BouncingScrollPhysics(),
      items: prov.addPersData,
      insertDuration: Duration(milliseconds: prov.addPersData.length<=1?0:200),
      removeDuration: Duration(milliseconds: prov.addPersData.length==0?0:500),
      areItemsTheSame: (oldItem, newItem) => oldItem.hashCode == newItem.hashCode,
      onReorderFinished: (item, from, to, newItems){
        prov.addPersData = newItems;
      },
      itemBuilder: (context, itemAnimation, item, index) => Reorderable(
        key: ValueKey(item.hashCode),
        builder: (context, dragAnimation, inDrag) {

          return SizeFadeTransition(
              sizeFraction: 0.7,
              curve: Curves.easeInOut,
              animation: itemAnimation,
              child:AddPersWidget(
                  item.item1,
                  item.item2,

                  onChanged: (){

                    List<AddPerson> data = prov.addPersData.map((addPersData) => AddPerson(
                      name: addPersData.item1.text,
                      emailRef: addPersData.item2.text,
                      userKeyRef: addPersData.item3.text,
                    )).toList();

                    prov.setAddPers(data);
                    onAddPersChanged?.call(data);
                  },
                  onRemoveTap: () {
                    prov.addPersData.removeAt(index);
                    prov.notify();
                  },
                key: ValueKey(item),
              )
          );

        },
      ),

      header: Padding(
        padding: EdgeInsets.only(left: Dimen.ICON_MARG, right: Dimen.defMarg),
        child: TitleShortcutRowWidget(
          title: prov.addPersData.length <= 1?'Osoba dodająca':'Osoby dodające',
          textAlign: TextAlign.start,
          //icon: MdiIcons.tagOutline,
          trailing: IconButton(
            icon: Icon(MdiIcons.plus),
            onPressed: (){
              prov.addPersData.add(Tuple3(
                  TextEditingController(),
                  TextEditingController(),
                  TextEditingController()
              ));
              prov.notify();
            },
          ),
        ),
      ),

      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          if(prov.addPersData.isEmpty)
            SizedBox(
              height: AddPersWidget.height + 2*Dimen.ICON_MARG + 2*Dimen.TEXT_SIZE_BIG,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(height: Dimen.ICON_MARG),

                    Icon(MdiIcons.accountPlusOutline, color: hintEnab_(context)),

                    SizedBox(height: Dimen.ICON_MARG),

                    Text(
                      'Pusto!\nUzupełnij swoje imię :)',
                      textAlign: TextAlign.center,
                      style: AppTextStyle(
                        color: hintEnab_(context),
                        fontSize: Dimen.TEXT_SIZE_BIG,
                      ),
                    ),

                    SizedBox(height: Dimen.ICON_MARG),

                  ]
              ),
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(vertical: Dimen.ICON_MARG, horizontal: Dimen.ICON_MARG),
              child: Text(
                'Podaj email, by połączyć swoje piosenki jednolitym podpisem. Sam email nie będzie widoczny.',
                style: AppTextStyle(
                  fontWeight: weight.halfBold,
                  color: hintEnab_(context),
                  fontSize: Dimen.TEXT_SIZE_BIG
                ),
                textAlign: TextAlign.center,
              ),
            ),

        ],
      ),

      shrinkWrap: true,
    ),
  );

}