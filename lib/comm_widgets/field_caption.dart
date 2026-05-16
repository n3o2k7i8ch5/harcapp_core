import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/values/dimen.dart';

/// Mały opis pod polem input. Jednolity styl: rozmiar `textSizeSmall`, kolor
/// `hintEnab_`, padding boczny `Dimen.sideMarg`. Używać wszędzie, gdzie pod
/// inputem ma być krótka instrukcja albo wyjaśnienie po co dane pole jest.
class FieldCaption extends StatelessWidget {
  final String text;

  const FieldCaption(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimen.sideMarg),
        child: Text(
          text,
          style: AppTextStyle(
            fontSize: Dimen.textSizeSmall,
            color: hintEnab_(context),
          ),
        ),
      );
}
