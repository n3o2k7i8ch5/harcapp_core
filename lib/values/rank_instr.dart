enum RankInstr{
  pwd, phm, hm;

  String get shortName {
    switch(this){
      case RankInstr.pwd: return 'pwd';
      case RankInstr.phm: return 'phm';
      case RankInstr.hm: return 'hm';
    }
  }

  static RankInstr? fromShortName(String shortName) {
    switch(shortName){
      case 'pwd': return RankInstr.pwd;
      case 'phm': return RankInstr.phm;
      case 'hm': return RankInstr.hm;
      default: return null;
    }
  }

  String get longName{
    switch(this){
      case RankInstr.pwd: return 'Przewodnik';
      case RankInstr.phm: return 'Podharcmistrz';
      case RankInstr.hm: return 'Harcmistrz';
    }
  }

  String get apiParam {
    switch(this){
      case RankInstr.pwd: return 'Pwd';
      case RankInstr.phm: return 'Phm';
      case RankInstr.hm: return 'Hm';
    }
  }

  static RankInstr? fromApiParam(String apiParam) {
    switch(apiParam){
      case 'Pwd': return RankInstr.pwd;
      case 'Phm': return RankInstr.phm;
      case 'Hm': return RankInstr.hm;
      default: return null;
    }
  }

}
