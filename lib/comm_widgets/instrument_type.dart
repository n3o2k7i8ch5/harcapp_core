enum InstrumentType{
  GUITAR,
  UKULELE,
  MANDOLIN
}

const Map<InstrumentType, String> _instrumentTypeName = {
  InstrumentType.GUITAR: 'Gitara',
  InstrumentType.UKULELE: 'Ukulele',
  InstrumentType.MANDOLIN: 'Mandolina'
};


String instrumentTypeName(InstrumentType type) => _instrumentTypeName[type]??'Nie ma takiego';

InstrumentType nextInstrumentType(InstrumentType type){
  if(type == InstrumentType.GUITAR) return InstrumentType.UKULELE;
  else if(type == InstrumentType.UKULELE) return InstrumentType.MANDOLIN;
  else if(type == InstrumentType.MANDOLIN) return InstrumentType.GUITAR;
  
  return InstrumentType.GUITAR;

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