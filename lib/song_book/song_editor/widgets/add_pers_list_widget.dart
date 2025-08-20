import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../add_person.dart';
import '../providers.dart';

class AddPersWidget extends StatelessWidget{

  static const double height = 2*Dimen.defMarg + 2*Dimen.defMarg + Dimen.defMarg + 2*Dimen.iconFootprint;

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
            padding: EdgeInsets.only(left: Dimen.iconMarg, top: Dimen.defMarg),
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

  final void Function(List<ContributorIdentity>)? onAddPersChanged;

  const AddPersListWidget({this.onAddPersChanged});

  @override
  State<StatefulWidget> createState() => AddPersListWidgetState();

}

class AddPersListWidgetState extends State<AddPersListWidget>{

  void Function(List<ContributorIdentity>)? get onAddPersChanged => widget.onAddPersChanged;

  @override
  Widget build(BuildContext context) => Consumer<CurrentItemProvider>(
    builder: (context, prov, child) =>
        Column(
          children: [

            Padding(
              padding: EdgeInsets.only(left: Dimen.iconMarg, right: Dimen.defMarg),
              child: TitleShortcutRowWidget(
                title: prov.addPersData.length <= 1?'Osoba dodająca':'Osoby dodające',
                textAlign: TextAlign.start,
                //icon: MdiIcons.tagOutline,
                trailing: IconButton(
                  icon: Icon(MdiIcons.plus),
                  onPressed: (){
                    prov.addPersData.add(
                      (
                        TextEditingController(),
                        TextEditingController(),
                        TextEditingController()
                      )
                    );
                    prov.notify();
                  },
                ),
              ),
            ),

            AnimatedListView(
              items: prov.addPersData,
              itemBuilder: (context, index) =>
                  AddPersWidget(
                    prov.addPersData[index].$1,
                    prov.addPersData[index].$2,

                    onChanged: (){

                      List<ContributorIdentity> data = prov.addPersData.map((addPersData) => ContributorIdentity(
                        name: addPersData.$1.text,
                        emailRef: addPersData.$2.text,
                        userKeyRef: addPersData.$3.text,
                      )).toList();

                      prov.setAddPers(data);
                      onAddPersChanged?.call(data);
                    },
                    onRemoveTap: () {
                      prov.addPersData.removeAt(index);
                      prov.notify();
                    },
                    key: ValueKey(prov.addPersData[index]),
                  ),
              shrinkWrap: true,
              enterTransition: [FadeIn()],
              exitTransition: [SlideInUp(), FadeIn()],
              isSameItem: (a, b) => a.hashCode == b.hashCode,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [

                if(prov.addPersData.isEmpty)
                  SizedBox(
                    height: AddPersWidget.height + 2*Dimen.iconMarg + 2*Dimen.textSizeBig,
                    child: SimpleButton(
                      radius: AppCard.bigRadius,
                      onTap: (){
                        prov.addPersData.add((
                            TextEditingController(),
                            TextEditingController(),
                            TextEditingController()
                        ));
                        prov.notify();
                      },
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                            SizedBox(height: Dimen.iconMarg),

                            Icon(MdiIcons.accountPlusOutline, color: hintEnab_(context)),

                            SizedBox(height: Dimen.iconMarg),

                            Text(
                              'Pusto!\nUzupełnij swoje imię :)',
                              textAlign: TextAlign.center,
                              style: AppTextStyle(
                                color: hintEnab_(context),
                                fontSize: Dimen.textSizeBig,
                              ),
                            ),

                            SizedBox(height: Dimen.iconMarg),

                          ]
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimen.iconMarg, horizontal: Dimen.iconMarg),
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

          ],
        ),





    //     ImplicitlyAnimatedReorderableList<Tuple3<TextEditingController, TextEditingController, TextEditingController>>(
    //   physics: BouncingScrollPhysics(),
    //   items: prov.addPersData,
    //   insertDuration: Duration(milliseconds: prov.addPersData.length<=1?0:200),
    //   removeDuration: Duration(milliseconds: prov.addPersData.length==0?0:500),
    //   areItemsTheSame: (oldItem, newItem) => oldItem.hashCode == newItem.hashCode,
    //   onReorderFinished: (item, from, to, newItems){
    //     prov.addPersData = newItems;
    //   },
    //   itemBuilder: (context, itemAnimation, item, index) => Reorderable(
    //     key: ValueKey(item.hashCode),
    //     builder: (context, dragAnimation, inDrag) {
    //
    //       return SizeFadeTransition(
    //           sizeFraction: 0.7,
    //           curve: Curves.easeInOut,
    //           animation: itemAnimation,
    //           child:AddPersWidget(
    //               item.item1,
    //               item.item2,
    //
    //               onChanged: (){
    //
    //                 List<AddPerson> data = prov.addPersData.map((addPersData) => AddPerson(
    //                   name: addPersData.item1.text,
    //                   emailRef: addPersData.item2.text,
    //                   userKeyRef: addPersData.item3.text,
    //                 )).toList();
    //
    //                 prov.setAddPers(data);
    //                 onAddPersChanged?.call(data);
    //               },
    //               onRemoveTap: () {
    //                 prov.addPersData.removeAt(index);
    //                 prov.notify();
    //               },
    //             key: ValueKey(item),
    //           )
    //       );
    //
    //     },
    //   ),
    //
    //   header: Padding(
    //     padding: EdgeInsets.only(left: Dimen.iconMarg, right: Dimen.defMarg),
    //     child: TitleShortcutRowWidget(
    //       title: prov.addPersData.length <= 1?'Osoba dodająca':'Osoby dodające',
    //       textAlign: TextAlign.start,
    //       //icon: MdiIcons.tagOutline,
    //       trailing: IconButton(
    //         icon: Icon(MdiIcons.plus),
    //         onPressed: (){
    //           prov.addPersData.add(Tuple3(
    //               TextEditingController(),
    //               TextEditingController(),
    //               TextEditingController()
    //           ));
    //           prov.notify();
    //         },
    //       ),
    //     ),
    //   ),
    //
    //   footer: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //
    //       if(prov.addPersData.isEmpty)
    //         SizedBox(
    //           height: AddPersWidget.height + 2*Dimen.iconMarg + 2*Dimen.textSizeBig,
    //           child: SimpleButton(
    //             radius: AppCard.bigRadius,
    //             onTap: (){
    //               prov.addPersData.add(Tuple3(
    //                   TextEditingController(),
    //                   TextEditingController(),
    //                   TextEditingController()
    //               ));
    //               prov.notify();
    //             },
    //             child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.stretch,
    //                 children: [
    //
    //                   SizedBox(height: Dimen.iconMarg),
    //
    //                   Icon(MdiIcons.accountPlusOutline, color: hintEnab_(context)),
    //
    //                   SizedBox(height: Dimen.iconMarg),
    //
    //                   Text(
    //                     'Pusto!\nUzupełnij swoje imię :)',
    //                     textAlign: TextAlign.center,
    //                     style: AppTextStyle(
    //                       color: hintEnab_(context),
    //                       fontSize: Dimen.textSizeBig,
    //                     ),
    //                   ),
    //
    //                   SizedBox(height: Dimen.iconMarg),
    //
    //                 ]
    //             ),
    //           ),
    //         )
    //       else
    //         Padding(
    //           padding: EdgeInsets.symmetric(vertical: Dimen.iconMarg, horizontal: Dimen.iconMarg),
    //           child: Text(
    //             'Podaj email, by połączyć swoje piosenki jednolitym podpisem. Sam email nie będzie widoczny.',
    //             style: AppTextStyle(
    //               fontWeight: weightHalfBold,
    //               color: hintEnab_(context),
    //               fontSize: Dimen.textSizeBig,
    //               height: 1.2
    //             ),
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //
    //     ],
    //   ),
    //
    //   shrinkWrap: true,
    // ),
  );

}