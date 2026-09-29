import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/values/dimen.dart';

import 'piosenkomat_pills.dart';

/// Rozmowa ze zgłoszenia: co przyszło od osoby dodającej i co jej odpiszesz.
/// Propozycja poprawki idzie pierwsza i osobno — to pole formularza, nie
/// wiadomość z wątku. Potem każda wiadomość z wątku we własnym dymku, po
/// swojej stronie: autor z lewej, Twoje odpowiedzi z prawej. Zlepek
/// wszystkiego w jednym dymku nie mówił ani kto co powiedział, ani kiedy.
class PiosenkomatConversationView extends StatelessWidget{

  final PiosenkomatData data;
  final Key fieldKey;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  /// Klik w gwiazdkę: propozycja odpowiedzi do wstawienia w pole.
  final ValueChanged<String> onPropose;

  const PiosenkomatConversationView({
    required this.data,
    required this.fieldKey,
    required this.controller,
    required this.onChanged,
    required this.onPropose,
    super.key,
  });

  @override
  Widget build(BuildContext context){
    final correction = data.correctionMessage ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if(correction.isNotEmpty)
          _Bubble(title: 'Propozycja poprawki', text: correction),

        for(final message in data.conversation)
          _Bubble(
            mine: message.isOurs,
            title: _messageTitle(message),
            text: message.text,
          ),

        _ReplyComposer(
          frame: contribReplyFrame(oldApp: data.isOldApp),
          fieldKey: fieldKey,
          controller: controller,
          proposal: proposeContribReplyNote(data.issues.map((i) => i.issue)),
          onChanged: onChanged,
          onPropose: onPropose,
        ),
      ],
    );
  }

}

/// Pole odpowiedzi w dymku, w ramce reszty mejla.
///
/// Bez własnego tytułu: etykietę niesie samo pole — na pustym jest
/// podpowiedzią w środku, a gdy zaczniesz pisać, wjeżdża nad tekst. Taka sama
/// zawsze, niezależnie od werdyktu. Gwiazdka — jak przy AI, ale bez modelu:
/// skleja uwagę z pastylek `missing-*`. Widać ją tylko, gdy jest co
/// zaproponować; klik nie wysyła mejla, tylko wypełnia pole. Szara ramka nad
/// polem i pod nim to reszta mejla, którą dokłada `reply` — ta sama funkcja,
/// więc podgląd nie rozjedzie się z tym, co wyjdzie. Twoje jest tylko pole:
/// ramki nie da się zapomnieć ani zepsuć.
class _ReplyComposer extends StatelessWidget{

  final ({String before, String after}) frame;
  final Key fieldKey;
  final TextEditingController controller;
  /// Propozycja z pastylek; `null` — gwiazdki nie ma.
  final String? proposal;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onPropose;

  const _ReplyComposer({
    required this.frame,
    required this.fieldKey,
    required this.controller,
    required this.proposal,
    required this.onChanged,
    required this.onPropose,
  });

  @override
  Widget build(BuildContext context) => _Bubble(
    mine: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ReplyFrameText(frame.before),
        const SizedBox(height: Dimen.defMarg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTextFieldHint(
                key: fieldKey,
                hint: 'Odpowiedz…',
                // Po wstawieniu z gwiazdki kontroler ma już tekst, a pływająca
                // etykieta liczy się w `initState` — bez tego „Odpowiedz…”
                // siada na propozycji.
                alwaysShowTopHint: controller.text.isNotEmpty,
                controller: controller,
                maxLines: null,
                showUnderline: false,
                contentPadding: EdgeInsets.zero,
                style: AppTextStyle(fontSize: Dimen.textSizeNormal, color: textEnab_(context)),
                hintStyle: AppTextStyle(fontSize: Dimen.textSizeNormal, color: hintEnab_(context)),
                onChanged: (_, text) => onChanged(text),
              ),
            ),
            if(proposal case final note?)
              AppButton(
                icon: Icon(MdiIcons.starFourPoints),
                color: accent_(context),
                tooltip: 'Zaproponuj odpowiedź',
                onTap: () => onPropose(note),
              ),
          ],
        ),
        const SizedBox(height: Dimen.defMarg),
        _ReplyFrameText(frame.after),
      ],
    ),
  );

}

/// Podpis dymka: kto i kiedy. Bez daty, gdy mejl jej nie niósł — pusty
/// nawias mówiłby mniej niż sam podpis.
String _messageTitle(PiosenkomatMessage message){
  final who = message.isOurs? 'Ty': 'Osoba dodająca';
  final at = message.at;
  return at == null? who: '$who · ${piosenkomatDay(at)}';
}

/// Część mejla, którą dokłada narzędzie — na szaro i bez edycji.
class _ReplyFrameText extends StatelessWidget{

  final String text;

  const _ReplyFrameText(this.text);

  @override
  Widget build(BuildContext context) => SelectableText(
    text,
    style: AppTextStyle(fontSize: Dimen.textSizeNormal, color: hintEnab_(context)),
  );

}

/// Dymek rozmowy: prostokątny, bez dziubka. Od osoby dodającej — z lewej,
/// na neutralnym tle; Twoja odpowiedź — z prawej, na tle akcentu.
class _Bubble extends StatelessWidget{

  final String? title;
  final String? text;
  final Widget? child;
  final bool mine;

  const _Bubble({this.title, this.text, this.child, this.mine = false});

  @override
  Widget build(BuildContext context){
    final accent = accent_(context);
    return Padding(
      padding: const EdgeInsets.only(top: Dimen.defMarg),
      child: Align(
        alignment: mine? Alignment.centerRight: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width*0.85,
          ),
          child: Material(
            color: mine
                ? accent.withValues(alpha: 0.15)
                : backgroundIcon_(context),
            borderRadius: BorderRadius.circular(AppCard.defRadius),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimen.defMarg*2,
                vertical: Dimen.defMarg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(title != null) ...[
                    Text(title!, style: AppTextStyle(
                      fontSize: Dimen.textSizeSmall,
                      fontWeight: weightHalfBold,
                      color: mine? accent: hintEnab_(context),
                    )),
                    const SizedBox(height: 2),
                  ],
                  child ?? SelectableText(text!, style: AppTextStyle(
                    fontSize: Dimen.textSizeNormal, color: textEnab_(context))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
