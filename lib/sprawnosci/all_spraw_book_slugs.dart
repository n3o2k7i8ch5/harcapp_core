import 'package:harcapp_core/values/org.dart';

import 'models.dart';

enum SprawBookSlug {
  zhpZuchSim2022,
  zhpHarcSim2022,
  zhrHarcCSim2023,
  zhrHarcDSim2023,
  zhrHarcDSim2006,
  zhpHarcSim2003,
  zhpHarcSim2003Wodne;

  String get name{
    switch(this){
      case SprawBookSlug.zhpZuchSim2022:
        return 'zhp_zuch_sim_2022';
      case SprawBookSlug.zhpHarcSim2022:
        return 'zhp_harc_sim_2022';
      case SprawBookSlug.zhrHarcCSim2023:
        return 'zhr_harc_c_sim_2023';
      case SprawBookSlug.zhrHarcDSim2023:
        return 'zhr_harc_d_sim_2023';
      case zhrHarcDSim2006:
        return 'zhr_harc_d_sim_2006';
      case zhpHarcSim2003:
        return 'zhr_harc_d_sim_2003';
      case zhpHarcSim2003Wodne:
        return 'zhp_harc_sim_2003_wodne';
    }
  }

  static SprawBookSlug? fromName(String name){
    switch(name){
      case 'zhp_zuch_sim_2022':
        return SprawBookSlug.zhpZuchSim2022;
      case 'zhp_harc_sim_2022':
        return SprawBookSlug.zhpHarcSim2022;
      case 'zhr_harc_c_sim_2023':
        return SprawBookSlug.zhrHarcCSim2023;
      case 'zhr_harc_d_sim_2023':
        return SprawBookSlug.zhrHarcDSim2023;
      case 'zhr_harc_d_sim_2006':
        return SprawBookSlug.zhrHarcDSim2006;
      case 'zhp_harc_sim_2003':
        return SprawBookSlug.zhpHarcSim2003;
      case 'zhp_harc_sim_2003_wodne':
        return SprawBookSlug.zhpHarcSim2003Wodne;
      default:
        return null;
    }
  }

  OrgColors get colors{
    switch(this){
      case SprawBookSlug.zhpHarcSim2003:
        return OrgColors.outOfDate;
      case SprawBookSlug.zhpHarcSim2003Wodne:
        return OrgColors.outOfDate;
      case SprawBookSlug.zhrHarcDSim2006:
        return OrgColors.outOfDate;
      case SprawBookSlug.zhpZuchSim2022:
        return Org.zhpZuch.colors;
      case SprawBookSlug.zhpHarcSim2022:
        return Org.zhp.colors;
      case SprawBookSlug.zhrHarcCSim2023:
        return Org.zhrChlop.colors;
      case SprawBookSlug.zhrHarcDSim2023:
        return Org.zhrDziew.colors;
    }
  }
}