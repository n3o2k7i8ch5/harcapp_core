import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/comm_widgets/dialog/app_dialog.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const String hal2026FeedbackFormUrl =
    'https://docs.google.com/forms/d/e/1FAIpQLScEjpiz8xbgzCr0CBO8eYn_fiSVcBrTqNwJCZUz4hBiVHn_5w/viewform?usp=publish-editor';

/// Slug of the obóz 2026 folder. Kept alongside the popup so call sites can
/// decide whether to trigger it without importing the loader.
const String hal2026FolderSlug = 'hal-2026';

/// Icon and label for the "fill the form" action button — kept here so web and
/// mobile pickers stay in sync.
IconData get hal2026FeedbackFormIcon => MdiIcons.commentQuoteOutline;
const String hal2026FeedbackFormButtonText = 'Zostaw kontakt';

const String _popupTitle = 'Podziel się wrażeniami';

const String _popupBody =
    'Super, że korzystasz z rozważań ewangelicznych!'
    '\n'
    '\nPo Twoim obozie, chcielibyśmy zapytać Cię o wrażenia z prowadzenia tej formy.'
    '\n'
    '\nZostaw nam swój kontakt - odezwiemy się, gdy Twój obóz dobiegnie końca.';

/// Opens the Google Form asking for feedback contact after the obóz 2026 apel
/// ewangeliczny PDF download. Pluggable [onOpenForm] lets hosts override the
/// link-launch (e.g. analytics, `target=_blank`); defaults to [launchURL].
Future<void> showHal2026FeedbackPopup(
  BuildContext context, {
  Future<void> Function()? onOpenForm,
}) =>
    openAppDialog(
      context: context,
      title: _popupTitle,
      closable: true,
      scrollable: true,
      maxWidth: 460,
      child: Builder(
        builder: (context) => Text(
          _popupBody,
          style: AppTextStyle(
            fontSize: Dimen.textSizeBig,
            color: textEnab_(context),
            height: 1.35,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
      buttons: [
        Builder(
          builder: (context) => AppDialogButton(
            text: 'Może później',
            textColor: hintEnab_(context),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        Builder(
          builder: (context) => AppDialogButton(
            text: hal2026FeedbackFormButtonText,
            onTap: () async {
              Navigator.of(context).pop();
              if (onOpenForm != null) {
                await onOpenForm();
              } else {
                launchURL(hal2026FeedbackFormUrl);
              }
            },
          ),
        ),
      ],
    );
