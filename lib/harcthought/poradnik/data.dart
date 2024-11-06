import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';

import 'poradnik.dart';

List<Poradnik> allPoradniks = [
  
  Poradnik(
    name: 'dwie_roty_dwoch_przyrzeczen_harcerskich',
    title: 'Dwie roty dwóch Przyrzeczeń',
    description: 'Poradnik dla drużynowych ZHP poruszający następujące m.in. zagadnienia:'
        '\n'
        '\nCzym jest i do czego służy Przyrzeczenie Harcerskie?'
        '\n'
        '\nJakie są różnice między dwoma rotami alternatywnych Przyrzeczeń Harcerskich? Co z nich wynika?'
        '\n'
        '\nKto decyduje o tym, które Przyrzeczenie składa harcerz?'
        '\n'
        '\nJak przeprowadić proces wyboru i złożenia Przyrzeczenia Harcerskiego?',
    coverTitle: 'DWIE ROTY\nDWÓCH PRZYRZECZEŃ',
    formats: [FileFormat.pdf, FileFormat.docx],
    titleColor: Colors.white,
    coverTitleBuilder: (context, poradnik, width, height) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          'DWIE ROTY\nDWÓCH PRZYRZECZEŃ',
          style: AppTextStyle(
            color: poradnik.titleColor??Colors.black,
            fontSize: height*Poradnik.mainTitleHeightFactor,
            fontWeight: weight.halfBold
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: height*Poradnik.titlePaddingFactor),

        Container(
          width: width*0.63,
          height: height*0.003,
          color: poradnik.titleColor??Colors.black,
        ),

        SizedBox(height: height*Poradnik.titlePaddingFactor),

        Text(
          'Poradnik dla drużynowych ZHP',
          style: AppTextStyle(
            color: poradnik.titleColor??Colors.black,
            fontSize: height*Poradnik.subTitleHeightFactor,
          ),
          textAlign: TextAlign.center,
        ),

      ],
    ),
  ),

  Poradnik(
    name: 'o_strukturze_i_ksztaltowaniu_duchowosci',
    title: 'O strukturze i kształtowaniu duchowości',
    description: 'Poradnik dla osób pracujących wychowawczo (instruktorów harcerskich i innych organizacji wychowawczych), poruszający następujące m.in. zagadnienia:'
        '\n'
        '\nCzym jest duchowość?'
        '\n'
        '\nJaka jest relacja między duchowością a wychowaniem?'
        '\n'
        '\nJaka jest relacja między duchowością a innymi sferami rozwoju człowieka?'
        '\n'
        '\nJaka jest relacja między duchowością a religijnością i religią?'
        '\n'
        '\nJakie mechanizmy i zjawiska wpływają na rozwój duchowy?'
        '\n'
        '\nJak w sposób skuteczny pracować nad duchowością młodego człowieka?',
    coverTitle: 'O STRUKTURZE\nI KSZTAŁTOWANIU\nDUCHOWOŚCI',
    formats: [FileFormat.pdf, FileFormat.docx],
    titleColor: Colors.black,
    coverTitleBuilder: (context, poradnik, width, height) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          'O STRUKTURZE\nI KSZTAŁTOWANIU\nDUCHOWOŚCI',
          style: AppTextStyle(
              color: poradnik.titleColor??Colors.black,
              fontSize: height*Poradnik.mainTitleHeightFactor,
              fontWeight: weight.halfBold
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: height*Poradnik.titlePaddingFactor),

        Container(
          width: width*0.63,
          height: height*0.003,
          color: poradnik.titleColor??Colors.black,
        ),

        SizedBox(height: height*Poradnik.titlePaddingFactor),

        Text(
          'Poradnik w pracy wychowawczej',
          style: AppTextStyle(
            color: poradnik.titleColor??Colors.black,
            fontSize: height*Poradnik.subTitleHeightFactor,
          ),
          textAlign: TextAlign.center,
        ),

      ],
    ),
  ),

];