enum SprawBookSlug {
  zhpZuchSim2022,
  zhpHarcSim2022,
  zhrHarcCSim2023,
  zhrHarcSim2023;

  String get name{
    switch(this){
      case SprawBookSlug.zhpZuchSim2022:
        return 'zhp_zuch_sim_2022';
      case SprawBookSlug.zhpHarcSim2022:
        return 'zhp_harc_sim_2022';
      case SprawBookSlug.zhrHarcCSim2023:
        return 'zhr_harc_c_sim_2023';
      case SprawBookSlug.zhrHarcSim2023:
        return 'zhr_harc_d_sim_2023';
    }
  }
}