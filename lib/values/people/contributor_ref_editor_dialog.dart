import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_navigator.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';
import 'package:harcapp_core/values/people/person_fields_editor.dart';
import 'package:harcapp_core/values/people/utils.dart';

/// Dialog edycji [ContributorRef] — pole „Email" na górze + ten sam zestaw
/// pól co `PersonEditorDialog` (przez `PersonFieldsEditor`). Wpisanie znanego
/// maila (zarejestrowanej osoby w [allRegisteredPeopleByEmailMap]) auto-uzupełnia
/// pozostałe pola.
class ContributorRefEditorDialog extends StatefulWidget {

  final ContributorRef? initial;
  final void Function(ContributorRef)? onChanged;
  final void Function(ContributorRef)? onAccepted;

  final String title;
  final String? description;
  final String saveText;
  final String? cancelText;

  const ContributorRefEditorDialog({
    this.initial,
    this.onChanged,
    this.onAccepted,
    this.title = 'Osoba dodająca',
    this.description,
    this.saveText = 'Ok',
    this.cancelText,
    super.key,
  });

  @override
  State<ContributorRefEditorDialog> createState() => _ContributorRefEditorDialogState();
}

class _ContributorRefEditorDialogState extends State<ContributorRefEditorDialog> {

  final GlobalKey<PersonFieldsEditorState> _fieldsKey = GlobalKey();
  final FocusNode _nameFocus = FocusNode();
  late TextEditingController emailController;
  String? _userKeyRef;
  String _name = '';

  @override
  void initState() {
    final init = widget.initial;
    emailController = TextEditingController(text: init?.emailRef);
    final resolved = init?.resolve() ?? init?.person;
    _userKeyRef = init?.userKeyRef ??
        (init?.emailRef == null
            ? null
            : allRegisteredPeopleByEmailMap[init!.emailRef!.trim().toLowerCase()]?.userKey);
    _name = resolved?.name ?? '';
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  ContributorRef get current => ContributorRef(
    person: _fieldsKey.currentState?.currentPerson ?? widget.initial?.person,
    emailRef: emailController.text.trim().isEmpty ? null : emailController.text.trim(),
    userKeyRef: _userKeyRef,
  );

  bool get _canAccept => _name.trim().isNotEmpty;

  void _onEmailChanged(String value){
    final hit = allRegisteredPeopleByEmailMap[value.trim().toLowerCase()];
    if(hit != null){
      _fieldsKey.currentState?.setPerson(hit.person);
      setState((){
        _userKeyRef = hit.userKey;
        _name = hit.person.name;
      });
    }
    widget.onChanged?.call(current);
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

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppCard.defRadius),
                            color: cardEnab_(context),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(Dimen.defMarg / 2),
                            child: SizedBox(
                              height: Dimen.iconFootprint,
                              child: AppTextFieldHint(
                                hint: 'Email:',
                                hintTop: 'Email',
                                style: AppTextStyle(fontSize: Dimen.textSizeBig),
                                controller: emailController,
                                contentPadding: const EdgeInsets.only(left: 16),
                                onChanged: (_, value) => _onEmailChanged(value),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: Dimen.sideMarg),

                        PersonFieldsEditor(
                          key: _fieldsKey,
                          initialPerson: widget.initial?.resolve() ?? widget.initial?.person,
                          nameFocus: _nameFocus,
                          onChanged: (p){
                            setState(() => _name = p.name);
                            widget.onChanged?.call(current);
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
                          widget.onAccepted?.call(current);
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
