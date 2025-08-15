import 'package:flutter/material.dart';

enum Org{
  zhp, zhpZuch, zhr, zhrZuchChlop, zhrChlop, zhrZuchDziew, zhrDziew, fse, sh, zhpNL, hrp;

  String get fullName{
    switch(this){
      case Org.zhp: return 'Związek Harcerstwa Polskiego';
      case Org.zhpZuch: return 'Związek Harcerstwa Polskiego - Zuchy';
      case Org.zhr: return 'Związek Harcerstwa Rzeczypospolitej';
      case Org.zhrZuchChlop: return 'Związek Harcerstwa Rzeczypospolitej - Zuchy'; // ♂
      case Org.zhrChlop: return 'Związek Harcerstwa Rzeczypospolitej - Harcerze'; // ♂
      case Org.zhrZuchDziew: return 'Związek Harcerstwa Rzeczypospolitej - Zuchenki'; // ♀
      case Org.zhrDziew: return 'Związek Harcerstwa Rzeczypospolitej - Harcerki'; // ♀
      case Org.fse: return 'Federacja Skautingu Europejskiego';
      case Org.sh: return 'Stowarzyszenie Harcerskie';
      case Org.zhpNL: return 'Związek Harcerstwa Polskiego na Litwie';
      case Org.hrp: return 'Harcerstwo Rzeczypospolitej Polskiej';
    }
  }

  (String, String?) get shortName{
    switch(this){
      case Org.zhp: return ('ZHP', null);
      case Org.zhpZuch: return ('ZHP', 'ZUCH');
      case Org.zhr: return ('ZHR', null);
      case Org.zhrZuchChlop: return ('ZHR', 'Z-CHY'); // ♂
      case Org.zhrChlop: return ('ZHR', 'H-RZE'); // ♂
      case Org.zhrZuchDziew: return ('ZHR', 'Z-NKI'); // ♀
      case Org.zhrDziew: return ('ZHR', 'H-KI'); // ♀
      case Org.fse: return ('FSE', null);
      case Org.sh: return ('SH', null);
      case Org.zhpNL: return ('ZHPnL', null);
      case Org.hrp: return ('HRP', null);
    }
  }

  OrgColors get colors{
    switch(this){
      case Org.zhp: return OrgColors(
        colorMain: Colors.purple[900]!,
        colorAccent: Colors.red[900]!,
        colorDarkMain: Colors.purple,
        colorDarkAccent: Colors.red,
      );
      case Org.zhpZuch: return OrgColors(
        colorMain: Colors.orange[900]!,
        colorAccent: Colors.yellow[800]!,
        colorDarkMain: Colors.orange[700]!,
        colorDarkAccent: Colors.yellow[600]!,
      );
      case Org.zhr: return OrgColors(
        colorMain: Colors.lightGreen[700]!,
        colorAccent: Colors.teal[900]!,
        colorDarkMain: Colors.lightGreen,
        colorDarkAccent: Colors.teal[600]!,
      );
      case Org.zhrZuchChlop: return OrgColors(
        colorMain: Colors.red[900]!,
        colorAccent: Colors.orange[900]!,
        colorDarkMain: Colors.red,
        colorDarkAccent: Colors.orange,
      );
      case Org.zhrChlop: return OrgColors(
        colorMain: Colors.indigo[800]!,
        colorAccent: Colors.teal[400]!,
        colorDarkMain: Colors.indigo[500]!,
        colorDarkAccent: Colors.teal[300]!,
      );
      case Org.zhrZuchDziew: return OrgColors(
        colorMain: Colors.purple[900]!,
        colorAccent: Colors.pink[900]!,
        colorDarkMain: Colors.purple,
        colorDarkAccent: Colors.pink,
      );
      case Org.zhrDziew: return OrgColors(
        colorMain: Colors.purple[300]!,
        colorAccent: Colors.teal[400]!,
        colorDarkMain: Colors.purple[200]!,
        colorDarkAccent: Colors.teal[300]!,
      );
      case Org.fse: return OrgColors(
        colorMain: Colors.orange[800]!,
        colorAccent: Colors.yellow[800]!,
        colorDarkMain: Colors.orange,
        colorDarkAccent: Colors.yellow[600]!,
      );
      case Org.sh: return OrgColors(
        colorMain: Colors.blue,
        colorAccent: Colors.blue,
        colorDarkMain: Colors.blue,
        colorDarkAccent: Colors.blue,
      );
      case Org.zhpNL: return OrgColors(
        colorMain: Colors.teal,
        colorAccent: Colors.teal,
        colorDarkMain: Colors.teal,
        colorDarkAccent: Colors.teal,
      );
      case Org.hrp: return OrgColors(
        colorMain: Colors.red,
        colorAccent: Colors.red,
        colorDarkMain: Colors.red,
        colorDarkAccent: Colors.red,
      );
    }
  }

  String get asParam{
    switch(this){
      case Org.zhp: return 'ZHP';
      case Org.zhpZuch: return 'ZHPz';  // not used, only for ZHP zuch ranks.
      case Org.zhr: return 'ZHR';
      case Org.zhrZuchChlop: return 'ZHRzc'; // not used, only for ZHR zuch ranks.
      case Org.zhrChlop: return 'ZHRc';
      case Org.zhrZuchDziew: return 'ZHRzd'; // not used, only for ZHR zuch ranks.
      case Org.zhrDziew: return 'ZHR';
      case Org.fse: return 'FSE';
      case Org.sh: return 'SH';
      case Org.zhpNL: return 'ZHPnL';
      case Org.hrp: return 'HRP';
    }
  }

  static Org? fromParam(String param){
    switch(param){
      case 'ZHP': return Org.zhp;
      case 'ZHPz': return Org.zhpZuch;  // not used, only for ZHP zuch ranks.
      case 'ZHR': return Org.zhr;
      case 'ZHRzc': return Org.zhrZuchChlop; // not used, only for ZHR zuch ranks.
      case 'ZHRc': return Org.zhrChlop;
      case 'ZHRzd': return Org.zhrZuchDziew; // not used, only for ZHR zuch ranks.
      case 'ZHRd': return Org.zhrDziew;
      case 'FSE': return Org.fse;
      case 'SH': return Org.sh;
      case 'ZHPnL': return Org.zhpNL;
      case 'HRP': return Org.hrp;
      default: return null;
    }
  }

  int get asInt{
    switch(this){
      case Org.zhp: return 0;
      case Org.zhpZuch: return 1;  // not used, only for ZHP zuch ranks.
      case Org.zhr: return 2;
      case Org.zhrZuchChlop: return 3;  // not used, only for ZHR zuch ranks.
      case Org.zhrChlop: return 4;
      case Org.zhrZuchDziew: return 5; // not used, only for ZHR zuch ranks.
      case Org.zhrDziew: return 6;
      case Org.fse: return 7;
      case Org.sh: return 8;
      case Org.zhpNL: return 9;
      case Org.hrp: return 10;
    }
  }

  static Org? fromInt(int value){
    switch(value){
      case 0: return Org.zhp;
      case 1: return Org.zhpZuch;  // not used, only for ZHP zuch ranks.
      case 2: return Org.zhr;
      case 3: return Org.zhrZuchChlop; // not used, only for ZHR zuch ranks.
      case 4: return Org.zhrChlop;
      case 5: return Org.zhrZuchDziew; // not used, only for ZHR zuch ranks.
      case 6: return Org.zhrDziew;
      case 7: return Org.fse;
      case 8: return Org.sh;
      case 9: return Org.zhpNL;
      case 10: return Org.hrp;
      default: return null;
    }
  }

}

class OrgColors{

  static OrgColors zhpSim2003Regular = OrgColors(
    colorMain: Colors.grey[800]!,
    colorAccent: Colors.grey[600]!,
    colorDarkMain: Colors.grey[200]!,
    colorDarkAccent: Colors.grey[400]!,
  );

  static OrgColors zhpSim2003Water = OrgColors(
    colorMain: Colors.lightBlueAccent,
    colorAccent: Colors.blue[700]!,
    colorDarkMain: Colors.lightBlueAccent,
    colorDarkAccent: Colors.blue[700]!,
  );
  
  final Color colorMain;
  final Color colorAccent;
  final Color colorDarkMain;
  final Color colorDarkAccent;

  const OrgColors({
    required this.colorMain,
    required this.colorAccent,
    required this.colorDarkMain,
    required this.colorDarkAccent
  });

  Color avgColor(bool isDark){

    Color colorMain = main(isDark);
    Color colorAccent = accent(isDark);

    return Color.fromARGB(
      255,
      256*(colorMain.r + colorAccent.r)~/2,
      256*(colorMain.g + colorAccent.g)~/2,
      256*(colorMain.b + colorAccent.b)~/2
    );
  }

  Color main(bool isDark) => isDark?colorDarkMain:colorMain;
  Color accent(bool isDark) => isDark?colorDarkAccent:colorAccent;

  OrgColors copyWith({
    Color? colorMain,
    Color? colorAccent,
    Color? colorDarkMain,
    Color? colorDarkAccent
  }) => OrgColors(
    colorMain: colorMain??this.colorMain,
    colorAccent: colorAccent??this.colorAccent,
    colorDarkMain: colorDarkMain??this.colorDarkMain,
    colorDarkAccent: colorDarkAccent??this.colorDarkAccent
  );

}
