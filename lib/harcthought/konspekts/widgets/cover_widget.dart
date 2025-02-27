import 'package:flutter/material.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

class KonspektCoverWidget extends StatelessWidget{

  final Konspekt konspekt;

  const KonspektCoverWidget(this.konspekt);

  @override
  Widget build(BuildContext context) {
    if(konspekt.upToDate)
      return Image.asset(
        konspekt.coverPath,
        fit: BoxFit.cover,
      );

    return Container(
        foregroundDecoration: BoxDecoration(
          color: Colors.grey,
          backgroundBlendMode: BlendMode.saturation,
        ),
        child: Image.asset(
          konspekt.coverPath,
          fit: BoxFit.cover,
        ),
      );
  }

}