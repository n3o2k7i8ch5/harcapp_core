enum RankHarc{
  dhc,
  dhd,

  zhpMlodzik, zhpOchotniczka,
  zhpWywiadowca, zhpTropicielka,
  zhpOdkrywca, zhpPionierka,
  zhpCwik, zhpSamarytanka,
  zhpHOc, zhpHOd,
  zhpHRc, zhpHRd,

  zhrMlodzik, zhrOchotniczka,
  zhrWywiadowca, zhrTropicielka,
  zhrCwik, zhrSamarytanka,
  zhrHOc, zhrWedrowniczka,
  zhrHRc, zhrHRd;

  String get shortName {
    switch(this){
      case RankHarc.dhc: return 'dh';
      case RankHarc.dhd: return 'dh.';
      case RankHarc.zhpMlodzik: return 'mł.';
      case RankHarc.zhpOchotniczka: return 'och.';
      case RankHarc.zhpWywiadowca: return 'wyw.';
      case RankHarc.zhpTropicielka: return 'trop.';
      case RankHarc.zhpOdkrywca: return 'odk.';
      case RankHarc.zhpPionierka: return 'pion.';
      case RankHarc.zhpCwik: return 'ćw.';
      case RankHarc.zhpSamarytanka: return 'sam.';
      case RankHarc.zhpHOd: return 'HO';
      case RankHarc.zhpHOc: return 'HO';
      case RankHarc.zhpHRd: return 'HR';
      case RankHarc.zhpHRc: return 'HR';

      case RankHarc.zhrMlodzik: return 'mł.';
      case RankHarc.zhrOchotniczka: return 'och.';
      case RankHarc.zhrWywiadowca: return 'wyw.';
      case RankHarc.zhrTropicielka: return 'trop.';
      case RankHarc.zhrCwik: return 'ćw.';
      case RankHarc.zhrSamarytanka: return 'sam.';
      case RankHarc.zhrHOc: return 'HO';
      case RankHarc.zhrWedrowniczka: return 'wędr.';
      case RankHarc.zhrHRc: return 'HR';
      case RankHarc.zhrHRd: return 'HR';
    }
  }

  String longName({bool withOrg = false}){
    switch(this){
      case RankHarc.dhc: return 'Druh' + (withOrg?' (ZHP)':'');
      case RankHarc.dhd: return 'Druhna' + (withOrg?' (ZHP)':'');
      case RankHarc.zhpMlodzik: return 'Młodzik' + (withOrg?' (ZHP)':'');
      case RankHarc.zhpOchotniczka: return 'Ochotniczka' + (withOrg?' (ZHP)':'');
      case RankHarc.zhpWywiadowca: return 'Wywiadowca' + (withOrg?' (ZHP)':'');
      case RankHarc.zhpTropicielka: return 'Tropicielka' + (withOrg?' (ZHP)':'');
      case RankHarc.zhpOdkrywca: return 'Odkrywca' + (withOrg?' (ZHP)':'');
      case RankHarc.zhpPionierka: return 'Pionierka' + (withOrg?' (ZHP)':'');
      case RankHarc.zhpCwik: return 'Ćwik' + (withOrg?' (ZHP)':'');
      case RankHarc.zhpSamarytanka: return 'Samarytanka' + (withOrg?' (ZHP)':'');
      case RankHarc.zhpHOd: return 'Harcerka Orla' + (withOrg?' (ZHP)':'');
      case RankHarc.zhpHOc: return 'Harcerz Orli' + (withOrg?' (ZHP)':'');
      case RankHarc.zhpHRd: return 'Harcerka Rzeczypospolitej' + (withOrg?' (ZHP)':'');
      case RankHarc.zhpHRc: return 'Harcerz Rzeczypospolitej' + (withOrg?' (ZHP)':'');

      case RankHarc.zhrMlodzik: return 'Młodzik' + (withOrg?' (ZHR)':'');
      case RankHarc.zhrOchotniczka: return 'Ochotniczka' + (withOrg?' (ZHR)':'');
      case RankHarc.zhrWywiadowca: return 'Wywiadowca' + (withOrg?' (ZHR)':'');
      case RankHarc.zhrTropicielka: return 'Tropicielka' + (withOrg?' (ZHR)':'');
      case RankHarc.zhrCwik: return 'Ćwik' + (withOrg?' (ZHR)':'');
      case RankHarc.zhrSamarytanka: return 'Samarytanka' + (withOrg?' (ZHR)':'');
      case RankHarc.zhrHOc: return 'Harcerz Orli' + (withOrg?' (ZHR)':'');
      case RankHarc.zhrWedrowniczka: return 'Wędrowniczka' + (withOrg?' (ZHR)':'');
      case RankHarc.zhrHRc: return 'Harcerz Rzeczypospolitej' + (withOrg?' (ZHR)':'');
      case RankHarc.zhrHRd: return 'Harcerka Rzeczypospolitej' + (withOrg?' (ZHR)':'');
    }
  }

  String get apiParam{
    switch(this){
      case RankHarc.dhd: return 'Dhd';
      case RankHarc.dhc: return 'Dhc';
      case RankHarc.zhpMlodzik: return 'ZhpMlodzik';
      case RankHarc.zhpOchotniczka: return 'ZhpOchotniczka';
      case RankHarc.zhpWywiadowca: return 'ZhpWywiadowca';
      case RankHarc.zhpTropicielka: return 'ZhpTropicielka';
      case RankHarc.zhpOdkrywca: return 'ZhpOdkrywca';
      case RankHarc.zhpPionierka: return 'ZhpPionierka';

      case RankHarc.zhpCwik: return 'ZhpCwik';
      case RankHarc.zhpSamarytanka: return 'ZhpSamarytanka';
      case RankHarc.zhpHOc: return 'ZhpHOc';
      case RankHarc.zhpHOd: return 'ZhpHOd';
      case RankHarc.zhpHRc: return 'ZhpHRc';
      case RankHarc.zhpHRd: return 'ZhpHRd';

      case RankHarc.zhrMlodzik: return 'ZhrMlodzik';
      case RankHarc.zhrOchotniczka: return 'ZhrOchotniczka';
      case RankHarc.zhrWywiadowca: return 'ZhrWywiadowca';
      case RankHarc.zhrTropicielka: return 'ZhrTropicielka';
      case RankHarc.zhrCwik: return 'ZhrCwik';
      case RankHarc.zhrSamarytanka: return 'ZhrSamarytanka';
      case RankHarc.zhrHOc: return 'ZhrHOc';
      case RankHarc.zhrWedrowniczka: return 'ZhrWedrowniczka';
      case RankHarc.zhrHRc: return 'ZhrHRc';
      case RankHarc.zhrHRd: return 'ZhrHRd';
    }
  }

  static RankHarc? fromApiParam(String param) {
    switch (param) {
      case 'Dhd':
        return RankHarc.dhd;
      case 'Dhc':
        return RankHarc.dhc;
      case 'ZhpMlodzik':
        return RankHarc.zhpMlodzik;
      case 'ZhpOchotniczka':
        return RankHarc.zhpOchotniczka;
      case 'ZhpWywiadowca':
        return RankHarc.zhpWywiadowca;
      case 'ZhpTropicielka':
        return RankHarc.zhpTropicielka;
      case 'ZhpOdkrywca':
        return RankHarc.zhpOdkrywca;
      case 'ZhpPionierka':
        return RankHarc.zhpPionierka;
      case 'ZhpCwik':
        return RankHarc.zhpCwik;
      case 'ZhpSamarytanka':
        return RankHarc.zhpSamarytanka;
      case 'ZhpHOc':
        return RankHarc.zhpHOc;
      case 'ZhpHOd':
        return RankHarc.zhpHOd;
      case 'ZhpHRc':
        return RankHarc.zhpHRc;
      case 'ZhpHRd':
        return RankHarc.zhpHRd;
      case 'ZhrMlodzik':
        return RankHarc.zhrMlodzik;
      case 'ZhrOchotniczka':
        return RankHarc.zhrOchotniczka;
      case 'ZhrWywiadowca':
        return RankHarc.zhrWywiadowca;
      case 'ZhrTropicielka':
        return RankHarc.zhrTropicielka;
      case 'ZhrCwik':
        return RankHarc.zhrCwik;
      case 'ZhrSamarytanka':
        return RankHarc.zhrSamarytanka;
      case 'ZhrHOc':
        return RankHarc.zhrHOc;
      case 'ZhrWedrowniczka':
        return RankHarc.zhrWedrowniczka;
      case 'ZhrHRc':
        return RankHarc.zhrHRc;
      case 'ZhrHRd':
        return RankHarc.zhrHRd;
      default:
        return null;
    }
  }

}

String rankHarcToStr(RankHarc rankHarc){
  switch(rankHarc){
    case RankHarc.dhd: return 'dhd';
    case RankHarc.dhc: return 'dhc';
    case RankHarc.zhpMlodzik: return 'zhpMlodzik';
    case RankHarc.zhpOchotniczka: return 'zhpOchotniczka';
    case RankHarc.zhpWywiadowca: return 'zhpWywiadowca';
    case RankHarc.zhpTropicielka: return 'zhpTropicielka';
    case RankHarc.zhpOdkrywca: return 'zhpOdkrywca';
    case RankHarc.zhpPionierka: return 'zhpPionierka';
    
    case RankHarc.zhpCwik: return 'zhpCwik';
    case RankHarc.zhpSamarytanka: return 'zhpSamarytanka';
    case RankHarc.zhpHOc: return 'zhpHOc';
    case RankHarc.zhpHOd: return 'zhpHOd';
    case RankHarc.zhpHRc: return 'zhpHRc';
    case RankHarc.zhpHRd: return 'zhpHRd';
    
    case RankHarc.zhrMlodzik: return 'zhrMlodzik';
    case RankHarc.zhrOchotniczka: return 'zhrOchotniczka';
    case RankHarc.zhrWywiadowca: return 'zhrWywiadowca';
    case RankHarc.zhrTropicielka: return 'zhrTropicielka';
    case RankHarc.zhrCwik: return 'zhrCwik';
    case RankHarc.zhrSamarytanka: return 'zhrSamarytanka';
    case RankHarc.zhrHOc: return 'zhrHOc';
    case RankHarc.zhrWedrowniczka: return 'zhrWedrowniczka';
    case RankHarc.zhrHRc: return 'zhrHRc';
    case RankHarc.zhrHRd: return 'zhrHRd';
  }
}

Map<String, RankHarc> strToRankHarc = {
  'dhd': RankHarc.dhd,
  'dhc': RankHarc.dhc,
  'zhpMlodzik': RankHarc.zhpMlodzik,
  'zhpOchotniczka': RankHarc.zhpOchotniczka,
  'zhpWywiadowca': RankHarc.zhpWywiadowca,
  'zhpTropicielka': RankHarc.zhpTropicielka,
  'zhpOdkrywca': RankHarc.zhpOdkrywca,
  'zhpPionierka': RankHarc.zhpPionierka,

  'zhpCwik': RankHarc.zhpCwik,
  'zhpSamarytanka': RankHarc.zhpSamarytanka,
  'zhpHOc': RankHarc.zhpHOc,
  'zhpHOd': RankHarc.zhpHOd,
  'zhpHRc': RankHarc.zhpHRc,
  'zhpHRd': RankHarc.zhpHRd,

  'zhrMlodzik': RankHarc.zhrMlodzik,
  'zhrOchotniczka': RankHarc.zhrOchotniczka,
  'zhrWywiadowca': RankHarc.zhrWywiadowca,
  'zhrTropicielka': RankHarc.zhrTropicielka,
  'zhrCwik': RankHarc.zhrCwik,
  'zhrSamarytanka': RankHarc.zhrSamarytanka,
  'zhrHOc': RankHarc.zhrHOc,
  'zhrWedrowniczka': RankHarc.zhrWedrowniczka,
  'zhrHRc': RankHarc.zhrHRc,
  'zhrHRd': RankHarc.zhrHRd,
};
