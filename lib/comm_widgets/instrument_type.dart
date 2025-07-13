enum InstrumentType{
  GUITAR,
  UKULELE,
  MANDOLIN;

  String get name{
    switch(this){
      case InstrumentType.GUITAR: return 'Gitara';
      case InstrumentType.UKULELE: return 'Ukulele';
      case InstrumentType.MANDOLIN: return 'Mandolina';
    }
  }

  String get nameDopelniacz{
    switch(this){
      case InstrumentType.GUITAR: return 'Gitary';
      case InstrumentType.UKULELE: return 'Ukulele';
      case InstrumentType.MANDOLIN: return 'Mandoliny';
    }
  }

  InstrumentType get next{
    switch(this){
      case InstrumentType.GUITAR: return InstrumentType.UKULELE;
      case InstrumentType.UKULELE: return InstrumentType.MANDOLIN;
      case InstrumentType.MANDOLIN: return InstrumentType.GUITAR;
    }
  }

}

int instrumentTypeToInt(InstrumentType type){
  if(type == InstrumentType.GUITAR) return 0;
  else if(type == InstrumentType.UKULELE) return 1;
  else if(type == InstrumentType.MANDOLIN) return 2;
  return -1;
}

InstrumentType intToTstrumentType(int value){
  if(value == 0) return InstrumentType.GUITAR;
  else if(value == 1) return InstrumentType.UKULELE;
  else if(value == 2) return InstrumentType.MANDOLIN;
  return InstrumentType.GUITAR;
}