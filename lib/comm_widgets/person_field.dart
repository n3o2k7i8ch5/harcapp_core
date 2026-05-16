import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/dialog/route.dart' as harcapp_dialog;
import 'package:harcapp_core/comm_widgets/person_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/person_editor_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

/// Karta z osobą + edycja przez [PersonEditorDialog].
/// Pusty stan: przycisk z plus-ikoną i napisem [emptyLabel].
/// Wypełniony stan: [PersonCard] (tappable -> dialog) + X do wyczyszczenia.
class PersonField extends StatelessWidget {
  final Person? person;
  final void Function(Person? person) onChanged;
  final String emptyLabel;
  final String dialogTitle;

  const PersonField({
    required this.person,
    required this.onChanged,
    this.emptyLabel = 'Dodaj osobę',
    this.dialogTitle = 'Dane osoby',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final has = person != null;
    return Material(
      color: cardEnab_(context),
      borderRadius: BorderRadius.circular(AppCard.defRadius),
      clipBehavior: Clip.hardEdge,
      child: has
          ? Row(
              children: [
                Expanded(
                  child: SimpleButton(
                    onTap: () => _showEditDialog(context),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimen.iconMarg),
                      child: PersonCard(person!),
                    ),
                  ),
                ),
                SimpleButton.from(
                  context: context,
                  margin: EdgeInsets.zero,
                  icon: MdiIcons.close,
                  onTap: () => onChanged(null),
                ),
              ],
            )
          : SimpleButton(
              onTap: () => _showEditDialog(context),
              child: Padding(
                padding: const EdgeInsets.all(Dimen.iconMarg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(MdiIcons.accountPlusOutline, color: iconEnab_(context)),
                    const SizedBox(width: Dimen.iconMarg),
                    Text(
                      emptyLabel,
                      style: AppTextStyle(
                        color: iconEnab_(context),
                        fontSize: Dimen.textSizeBig,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _showEditDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      harcapp_dialog.DialogRoute(
        builder: (ctx) => PersonEditorDialog(
          initialPerson: person,
          onAccepted: onChanged,
          title: dialogTitle,
          cancelText: 'Anuluj',
        ),
      ),
    );
  }
}
