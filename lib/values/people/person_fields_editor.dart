import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/comm_widgets/rank_harc_input_field.dart';
import 'package:harcapp_core/comm_widgets/rank_instr_input_field.dart';
import 'package:harcapp_core/comm_widgets/srodowisko_input_field.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

/// Wewnętrzny formularz [Person]: name, druzyna, srodowisko, rank harc., rank instr.
///
/// Trzyma swój stan i kontrolery. Czytaj wynik przez `key.currentState!.currentPerson`,
/// nadpisuj zewnętrznie (np. po autofill z emaila) przez `key.currentState!.setPerson(p)`.
class PersonFieldsEditor extends StatefulWidget {
  final Person? initialPerson;
  final FocusNode? nameFocus;
  final void Function(Person)? onChanged;

  const PersonFieldsEditor({
    this.initialPerson,
    this.nameFocus,
    this.onChanged,
    super.key,
  });

  @override
  State<PersonFieldsEditor> createState() => PersonFieldsEditorState();
}

class PersonFieldsEditorState extends State<PersonFieldsEditor> {

  late TextEditingController nameController;
  late TextEditingController druzynaController;
  Srodowisko? srodowisko;
  RankInstr? rankInstr;
  RankHarc? rankHarc;

  Person get currentPerson => Person(
    name: nameController.text.trim(),
    druzyna: druzynaController.text.trim(),
    srodowisko: srodowisko,
    rankInstr: rankInstr,
    rankHarc: rankHarc,
  );

  /// Imperatywne nadpisanie pól (np. po znalezieniu osoby po emailu).
  void setPerson(Person p){
    setState((){
      nameController.text = p.name;
      druzynaController.text = p.druzyna ?? '';
      srodowisko = p.srodowisko;
      rankInstr = p.rankInstr;
      rankHarc = p.rankHarc;
    });
    widget.onChanged?.call(currentPerson);
  }

  @override
  void initState() {
    final p = widget.initialPerson;
    nameController = TextEditingController(text: p?.name);
    druzynaController = TextEditingController(text: p?.druzyna);
    srodowisko = p?.srodowisko;
    rankInstr = p?.rankInstr;
    rankHarc = p?.rankHarc;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    druzynaController.dispose();
    super.dispose();
  }

  void _emit() => widget.onChanged?.call(currentPerson);

  @override
  Widget build(BuildContext context) => Column(
    children: [

      _Container(
        child: AppTextFieldHint(
          hint: 'Imię i nazwisko:',
          hintTop: 'Imię i nazwisko',
          style: AppTextStyle(fontSize: Dimen.textSizeBig),
          controller: nameController,
          focusNode: widget.nameFocus,
          contentPadding: const EdgeInsets.only(left: 16),
          onChanged: (_, __){
            setState((){});
            _emit();
          },
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
          onChanged: (_, __) => _emit(),
        ),
      ),

      const SizedBox(height: Dimen.sideMarg),

      SrodowiskoInputField(
        value: srodowisko,
        onChanged: (s){
          setState(() => srodowisko = s);
          _emit();
        },
      ),

      const SizedBox(height: Dimen.sideMarg),

      _Container(
        child: RankHarcInputField(
          rankHarc,
          onChanged: (value){
            setState(() => rankHarc = value);
            _emit();
          },
          withIcon: false,
        ),
      ),

      const SizedBox(height: Dimen.sideMarg),

      _Container(
        child: RankInstrInputField(
          rankInstr,
          onChanged: (value){
            setState(() => rankInstr = value);
            _emit();
          },
          withIcon: false,
        ),
      ),

    ],
  );
}

class _Container extends StatelessWidget {
  final Widget child;
  const _Container({required this.child});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppCard.defRadius),
      color: cardEnab_(context),
    ),
    child: Padding(
      padding: EdgeInsets.all(Dimen.defMarg / 2),
      child: SizedBox(
        height: Dimen.iconFootprint,
        child: child,
      ),
    ),
  );
}
