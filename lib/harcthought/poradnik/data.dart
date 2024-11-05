import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';

import 'poradnik.dart';

List<Poradnik> allPoradniks = [
  
  Poradnik(
    name: 'dwie_roty_dwoch_przyrzeczen_harcerskich',
    title: 'Dwie roty dwóch Przyrzeczeń',
    coverTitle: 'DWIE ROTY\nDWÓCH PRZYRZECZEŃ',
    formats: [PoradnikFormat.pdf, PoradnikFormat.docx],
    titleColor: Colors.white,
    coverTitleBuilder: (context, poradnik, width, height) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          'DWIE ROTY\nDWÓCH PRZYRZECZEŃ',
          style: AppTextStyle(
            color: poradnik.titleColor??Colors.black,
            fontSize: height*Poradnik.mainTitleHeightFactor,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: height*Poradnik.titlePaddingFactor),

        Text(
          'Poradnik dla drużynowych ZHP',
          style: AppTextStyle(
            color: poradnik.titleColor??Colors.black,
            fontSize: height*Poradnik.mainTitleHeightFactor,
          ),
          textAlign: TextAlign.center,
        ),

      ],
    ),
  )
  
];