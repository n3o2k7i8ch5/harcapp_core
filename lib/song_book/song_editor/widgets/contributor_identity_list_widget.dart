import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/comm_widgets/border_material.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../contributor_identity.dart';
import '../providers.dart';

class ContributorIdentityWidget extends StatelessWidget{

  static const double height = 2*Dimen.defMarg + 2*Dimen.defMarg + Dimen.defMarg + 2*Dimen.iconFootprint;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final void Function()? onChanged;
  final void Function()? onRemoveTap;

  const ContributorIdentityWidget(this.nameController, this.emailController, {this.onChanged, this.onRemoveTap, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) => BorderMaterial(
      child: Padding(
        padding: EdgeInsets.only(left: Dimen.iconMarg, top: Dimen.defMarg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppTextFieldHint(
                    hint: 'Imię i nazwisko:',
                    hintTop: 'Imię i nazwisko',
                    controller: nameController,
                    onChanged: (_, __) => onChanged?.call(),
                  ),
                ),

                AppButton(
                    icon: Icon(MdiIcons.close),
                    onTap: onRemoveTap
                )
              ],
            ),
            Row(
              children: [

                Expanded(
                  child: AppTextFieldHint(
                    hint: 'Email:',
                    hintTop: 'Email',
                    controller: emailController,
                    onChanged: (_, __) => onChanged?.call(),
                  ),
                ),

                if(emailController.text.isEmpty)
                  AppButton(
                    icon: Icon(MdiIcons.alertCircleOutline, color: Colors.red),
                    onTap: () => AppScaffold.showMessage(context, text: 'Podaj email, by zyskać wieczystą sławę'),
                  ),

              ],
            )
          ],
        ),
      ),
  );

}

class ContributorIdentityListWidget extends StatefulWidget{

  final void Function(List<ContributorIdentity>)? onChanged;
  final EdgeInsets titlePadding;
  final EdgeInsets listPadding;

  const ContributorIdentityListWidget({this.onChanged, this.titlePadding = EdgeInsets.zero, this.listPadding = EdgeInsets.zero, super.key});

  @override
  State<StatefulWidget> createState() => ContributorIdentityListWidgetState();

}

class ContributorIdentityListWidgetState extends State<ContributorIdentityListWidget>{

  void Function(List<ContributorIdentity>)? get onChanged => widget.onChanged;

  @override
  Widget build(BuildContext context) => Consumer<CurrentItemProvider>(
    builder: (context, prov, child) =>
        Column(
          children: [

            Padding(
              padding: widget.titlePadding,
              child: TitleShortcutRowWidget(
                title: prov.contribIdData.length <= 1?'Osoba dodająca':'Osoby dodające',
                textAlign: TextAlign.left,
                //icon: MdiIcons.tagOutline,
                trailing: AppButton(
                  icon: Icon(MdiIcons.plus),
                  onTap: (){
                    prov.contribIdData.add(
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
              padding: widget.listPadding,
              items: prov.contribIdData,
              itemBuilder: (context, index) =>
                  Padding(
                    key: ValueKey(prov.contribIdData[index]),
                    padding: EdgeInsets.only(bottom: index < prov.contribIdData.length - 1?Dimen.defMarg:0),
                    child: ContributorIdentityWidget(
                      prov.contribIdData[index].$1,
                      prov.contribIdData[index].$2,

                      onChanged: (){

                        List<ContributorIdentity> data = prov.contribIdData.map((contribIdData) => ContributorIdentity(
                          name: contribIdData.$1.text,
                          emailRef: contribIdData.$2.text,
                          userKeyRef: contribIdData.$3.text,
                        )).toList();

                        prov.setContribId(data);
                        onChanged?.call(data);
                      },
                      onRemoveTap: () {
                        prov.contribIdData.removeAt(index);
                        prov.notify();
                      },
                    ),
                  ),
              shrinkWrap: true,
              enterTransition: [FadeIn()],
              exitTransition: [SlideInUp(), FadeIn()],
              isSameItem: (a, b) => a.hashCode == b.hashCode,
            ),

            Padding(
              padding: widget.listPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [

                  if(prov.contribIdData.isEmpty)
                    SizedBox(
                      height: ContributorIdentityWidget.height + 2*Dimen.iconMarg + 2*Dimen.textSizeBig,
                      child: SimpleButton(
                        radius: AppCard.bigRadius,
                        onTap: (){
                          prov.contribIdData.add((
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
            ),

          ],
        ),

  );

}