enum SprawBookSlug {
  zhpZuchSim2022,
  zhpHarcSim2022,
  zhrHarcCSim2023,
  zhrHarcDSim2023;

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
      default:
        return null;
    }
  }
}