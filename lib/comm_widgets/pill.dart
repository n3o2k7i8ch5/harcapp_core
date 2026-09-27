import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';

/// Pastylka: pełne zaokrąglenie, półprzezroczyste tło, ikona i tekst
/// w pełnym kolorze. Jeden kształt dla uwag piosenkomatu, badge'a POPRAWKA
/// i dowodów podobieństwa — inaczej każda wyglądałaby trochę inaczej.
class Pill extends StatelessWidget{

  final Color color;
  final IconData icon;
  final String label;
  /// Mała wersja do listy: mniejsza czcionka, płasko.
  final bool compact;

  const Pill({required this.color, required this.icon, required this.label, this.compact = false, super.key});

  @override
  Widget build(BuildContext context){
    final fontSize = compact? Dimen.textSizeTiny: Dimen.textSizeSmall;
    final pad = compact? Dimen.defMarg/2: Dimen.iconMarg;
    return SimpleButton(
      radius: 100,
      elevation: 0,
      color: color.withValues(alpha: 0.15),
      // Z lewej mniej niż z prawej: tam siedzi ikona, która ma własny odstęp.
      // Równy padding dookoła odsuwał ją od krawędzi bardziej niż od góry.
      padding: EdgeInsets.only(
        left: pad/2,
        right: pad,
        top: compact? 2: pad/2,
        bottom: compact? 2: pad/2,
      ),
      onTap: null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: fontSize + 2, color: color),
          SizedBox(width: pad/2),
          Text(
            label,
            style: AppTextStyle(fontSize: fontSize, fontWeight: weightHalfBold, color: color),
            maxLines: 1,
          ),
        ],
      ),
    );
  }

}
