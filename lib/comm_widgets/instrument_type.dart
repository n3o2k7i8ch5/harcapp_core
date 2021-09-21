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