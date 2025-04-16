import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';

import 'poradnik.dart';

const String poradnik_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci = "czynniki_i_mechanizmy_ksztaltowania_duchowosci";
const String poradnik_title_czynniki_i_mechanizmy_ksztaltowania_duchowosci = "Czynniki i mechanizmy kształtowania duchowości";
Poradnik poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci = Poradnik(
  name: poradnik_name_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
  title: poradnik_title_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
  pageCount: 13,
  description: 'Poradnik dla pracujących wychowawczo (instruktorów harcerskich i innych organizacji wychowawczych), poruszający następujące zagadnienia:'
      '\n'
      '\nJakie prawa rządzą kształtowaniem duchowości?'
      '\n'
      '\nJakie mechanizmy i zjawiska wpływają na rozwój duchowy?',
  coverTitle: 'CZYNNIKI I MECHANIZMY\nKSZTAŁTOWANIA\nDUCHOWOŚCI',
  coverSource: 'Freepik (freepik)',
  formats: [FileFormat.pdf, FileFormat.docx],
  titleColor: Colors.black,
  coverTitleBuilder: (context, poradnik, width, height) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Text(
        'CZYNNIKI I MECHANIZMY\nKSZTAŁTOWANIA\nDUCHOWOŚCI',
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
);


const String poradnik_name_dwie_roty_dwoch_przyrzeczen_harcerskich = "dwie_roty_dwoch_przyrzeczen_harcerskich";
const String poradnik_title_dwie_roty_dwoch_przyrzeczen_harcerskich = "Dwie roty dwóch Przyrzeczeń";
Poradnik poradnik_dwie_roty_dwoch_przyrzeczen_harcerskich = Poradnik(
  name: poradnik_name_dwie_roty_dwoch_przyrzeczen_harcerskich,
  title: poradnik_title_dwie_roty_dwoch_przyrzeczen_harcerskich,
  pageCount: 16,
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
  coverSource: 'Daniel Iwanicki',
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
);

const String poradnik_name_o_strukturze_duchowosci = "o_strukturze_duchowosci";
const String poradnik_title_o_strukturze_duchowosci = "O strukturze duchowości";
Poradnik poradnik_o_strukturze_duchowosci = Poradnik(
  name: poradnik_name_o_strukturze_duchowosci,
  title: poradnik_title_o_strukturze_duchowosci,
  pageCount: 25,
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
  coverTitle: 'O STRUKTURZE\nDUCHOWOŚCI',
  coverSource: 'Daniel Iwanicki',
  formats: [FileFormat.pdf, FileFormat.docx],
  titleColor: Colors.black,
  coverTitleBuilder: (context, poradnik, width, height) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Text(
        'O STRUKTURZE\nDUCHOWOŚCI',
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
);

const String poradnik_name_przykladowa_strategia_rozwoju_duchowego = "przykladowa_strategia_rozwoju_duchowego";
const String poradnik_title_przykladowa_strategia_rozwoju_duchowego = "Przykładowa strategia rozwoju duchowego";
Poradnik poradnik_przykladowa_strategia_rozwoju_duchowego = Poradnik(
  name: poradnik_name_przykladowa_strategia_rozwoju_duchowego,
  title: poradnik_title_przykladowa_strategia_rozwoju_duchowego,
  pageCount: 15,
  description: 'Poradnik dla osób pracujących wychowawczo (instruktorów harcerskich i innych organizacji wychowawczych), przedstawiajacy przykładową strategię kształtowania u wychowanków określonej duchowości',
  coverTitle: 'PRZYKŁADOWA STRATEGIA\nROZWOJU DUCHOWEGO',
  coverSource: 'Freepik (freepik)',
  formats: [FileFormat.pdf, FileFormat.docx],
  titleColor: Colors.black,
  coverTitleBuilder: (context, poradnik, width, height) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Text(
        'PRZYKŁADOWA STRATEGIA\nROZWOJU DUCHOWEGO',
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
);

const String poradnik_name_wychowanie_przez_wysmianie = "wychowanie_przez_wysmianie";
const String poradnik_title_wychowanie_przez_wysmianie = "Wychowanie przez wyśmianie";
Poradnik poradnik_wychowanie_przez_wysmianie = Poradnik(
  name: poradnik_name_wychowanie_przez_wysmianie,
  title: poradnik_title_wychowanie_przez_wysmianie,
  pageCount: 5,
  description: 'Poradnik dla osób pracujących wychowawczo (instruktorów harcerskich i innych organizacji wychowawczych), poruszający następujące m.in. zagadnienia:'
      '\n'
      '\nJak komunikować się z grupami nastolatków, gdzie wszystko jest sprowadzane do memu, żartu i jest aktywnie obśmiewane?',
  coverTitle: 'WYCHOWANIE\nPRZEZ WYŚMIANIE',
  coverSource: 'Freepik (freepik)',
  formats: [FileFormat.pdf, FileFormat.docx],
  titleColor: Colors.white,
  coverTitleBuilder: (context, poradnik, width, height) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Text(
        'WYCHOWANIE\nPRZEZ WYŚMIANIE',
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
);

List<Poradnik> allPoradniks = [
  poradnik_o_strukturze_duchowosci,
  poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
  poradnik_dwie_roty_dwoch_przyrzeczen_harcerskich,
  poradnik_przykladowa_strategia_rozwoju_duchowego,
  poradnik_wychowanie_przez_wysmianie,
];