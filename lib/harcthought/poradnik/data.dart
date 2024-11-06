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
  )
  
];