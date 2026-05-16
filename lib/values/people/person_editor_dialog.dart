import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_navigator.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/person_fields_editor.dart';

class PersonEditorDialog extends StatefulWidget{

  final Person? initialPerson;
  final void Function(Person)? onChanged;
  final void Function(Person)? onAccepted;

  final String title;
  final String? description;
  final String saveText;
  final String? cancelText;

  const PersonEditorDialog({
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
  State<StatefulWidget> createState() => PersonEditorDialogState();

}

class PersonEditorDialogState extends State<PersonEditorDialog>{

  final GlobalKey<PersonFieldsEditorState> _fieldsKey = GlobalKey();
  final FocusNode _nameFocus = FocusNode();
  String _name = '';

  Person get currentPerson => _fieldsKey.currentState?.currentPerson
      ?? Person(name: widget.initialPerson?.name ?? '');

  bool get _canAccept => _name.trim().isNotEmpty;

  @override
  void initState() {
    _name = widget.initialPerson?.name ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(Dimen.sideMarg)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
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

                        PersonFieldsEditor(
                          key: _fieldsKey,
                          initialPerson: widget.initialPerson,
                          nameFocus: _nameFocus,
                          onChanged: (p){
                            setState(() => _name = p.name);
                            widget.onChanged?.call(p);
                          },
                        ),

                      ],
                    ),
                  ),
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
                          if(!_canAccept){
                            AppScaffold.showMessage(context, text: 'Podaj imię i nazwisko');
                            _nameFocus.requestFocus();
                            return;
                          }
                          widget.onAccepted?.call(currentPerson);
                          popPage(context, root: true);
                        },
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    ),
  );

}
