import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/dialog/route.dart' as harcapp_dialog;
import 'package:harcapp_core/comm_widgets/person_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';
import 'package:harcapp_core/values/people/contributor_ref_editor_dialog.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

/// Karta z [ContributorRef] + edycja przez [ContributorRefEditorDialog].
/// Pusty stan: przycisk z plus-ikoną i napisem [emptyLabel].
/// Wypełniony stan: [PersonCard] (z [ContributorRef.resolve]) + X do wyczyszczenia.
class ContributorRefField extends StatelessWidget {
  final ContributorRef? identity;
  final void Function(ContributorRef? identity) onChanged;
  final String emptyLabel;
  final String dialogTitle;

  const ContributorRefField({
    required this.identity,
    required this.onChanged,
    this.emptyLabel = 'Dodaj osobę',
    this.dialogTitle = 'Dane osoby',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Person? resolved = identity?.resolve();
    final has = identity != null && identity!.isNotEmpty;
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
                      child: resolved != null
                          ? PersonCard(resolved)
                          : Text(
                              identity!.emailRef ?? identity!.userKeyRef ?? '',
                              style: AppTextStyle(fontSize: Dimen.textSizeBig),
                            ),
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
        builder: (ctx) => ContributorRefEditorDialog(
          initial: identity,
          onAccepted: onChanged,
          title: dialogTitle,
          cancelText: 'Anuluj',
        ),
      ),
    );
  }
}
