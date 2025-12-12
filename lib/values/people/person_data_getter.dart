import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_navigator.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/comm_widgets/org_input_field.dart';
import 'package:harcapp_core/comm_widgets/rank_harc_input_field.dart';
import 'package:harcapp_core/comm_widgets/rank_instr_input_field.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/values/org.dart';
import 'package:harcapp_core/values/people/person.dart';
import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';

class PersonDataDialog extends StatefulWidget{

  final Person? initialPerson;
  final void Function(Person)? onChanged;
  final void Function(Person)? onAccepted;

  final String title;
  final String? description;
  final String saveText;
  final String? cancelText;

  const PersonDataDialog({
    this.initialPerson,
    this.onChanged,
    this.onAccepted,
    this.title = 'Twoje dane',
    this.description,
    this.saveText = 'Ok',
    this.cancelText,
    super.key
  });

  @override
  State<StatefulWidget> createState() => PersonDataDialogState();

}

class PersonDataDialogState extends State<PersonDataDialog>{

  Person? get initialPerson => widget.initialPerson;

  late TextEditingController nameController;
  late TextEditingController druzynaController;
  late TextEditingController hufiecController;
  RankInstr? rankInstr;
  RankHarc? rankHarc;
  Org? org;

  Person get currentPerson => Person(
      name: nameController.text.trim(),
      druzyna: druzynaController.text.trim(),
      hufiec: hufiecController.text.trim(),
      rankInstr: rankInstr,
      rankHarc: rankHarc,
      org: org
  );

  @override
  void initState() {
    nameController = TextEditingController(text: initialPerson?.name);
    druzynaController = TextEditingController(text: initialPerson?.druzyna);
    hufiecController = TextEditingController(text: initialPerson?.hufiec);
    rankInstr = initialPerson?.rankInstr;
    rankHarc = initialPerson?.rankHarc;
    org = initialPerson?.org;

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(Dimen.sideMarg)),
      child: Material(
          borderRadius: BorderRadius.circular(AppCard.bigRadius),
          clipBehavior: Clip.hardEdge,
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                AppBarX(title: widget.title),

                Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(Dimen.sideMarg),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [

                          if(widget.description != null)
                            Text(
                              widget.description!,
                              style: AppTextStyle(fontSize: Dimen.textSizeBig),
                            ),

                          const SizedBox(height: Dimen.sideMarg),

                          _Container(
                            child: AppTextFieldHint(
                              hint: 'Imię i nazwisko:',
                              hintTop: 'Imię i nazwisko',
                              style: AppTextStyle(fontSize: Dimen.textSizeBig),
                              controller: nameController,
                              contentPadding: const EdgeInsets.only(left: 16),
                              onChanged: (_, __) => widget.onChanged?.call(currentPerson),
                            ),
                          ),

                          const SizedBox(height: Dimen.sideMarg),

                          _Container(
                              child: AppTextFieldHint(
                                hint: 'Drużyna:',
                                hintTop: 'Drużyna',
                                style: AppTextStyle(fontSize: Dimen.textSizeBig),
                                controller: druzynaController,
                                contentPadding: const EdgeInsets.only(left: 16),
                                onChanged: (_, __) => widget.onChanged?.call(currentPerson),
                              )
                          ),

                          const SizedBox(height: Dimen.sideMarg),

                          _Container(
                              child: AppTextFieldHint(
                                hint: 'Hufiec:',
                                hintTop: 'Hufiec',
                                style: AppTextStyle(fontSize: Dimen.textSizeBig),
                                controller: hufiecController,
                                contentPadding: const EdgeInsets.only(left: 16),
                                onChanged: (_, __) => widget.onChanged?.call(currentPerson),
                              )
                          ),

                          const SizedBox(height: Dimen.sideMarg),

                          _Container(
                              child: RankHarcInputField(
                                rankHarc,
                                onChanged: (value){
                                  setState(() => rankHarc = value);
                                  widget.onChanged?.call(currentPerson);
                                },
                                withIcon: false,
                              )
                          ),

                          const SizedBox(height: Dimen.sideMarg),

                          _Container(
                              child: RankInstrInputField(
                                rankInstr,
                                onChanged: (value){
                                  setState(() => rankInstr = value);
                                  widget.onChanged?.call(currentPerson);
                                },
                                withIcon: false,
                              )
                          ),

                          const SizedBox(height: Dimen.sideMarg),

                          _Container(
                              child: OrgInputField(
                                org,
                                onChanged: (value){
                                  setState(() => org = value);
                                  widget.onChanged?.call(currentPerson);
                                },
                                withIcon: false,
                              )
                          ),

                        ],
                      ),
                    )
                ),

                Padding(
                  padding: EdgeInsets.all(Dimen.sideMarg),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      if(widget.cancelText != null)
                        SimpleButton.from(
                          context: context,
                          margin: EdgeInsets.zero,
                          text: widget.cancelText,
                          onTap: () => popPage(context, root: true),
                        ),

                      const SizedBox(width: Dimen.defMarg),

                      SimpleButton.from(
                          context: context,
                          margin: EdgeInsets.zero,
                          text: widget.saveText,
                          onTap: (){
                            widget.onAccepted?.call(currentPerson);
                            popPage(context, root: true);
                          }
                      )

                    ],
                  ),
                )

              ],
            ),
          )
      ),
    ),
  );

}

class _Container extends StatelessWidget{

  final Widget child;

  const _Container({required this.child});

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppCard.defRadius),
        color: cardEnab_(context),
      ),
      child: Padding(
        padding: EdgeInsets.all(Dimen.defMarg/2),
        child: SizedBox(
          height: Dimen.iconFootprint,
          child: child,
        ),
      )
  );

}