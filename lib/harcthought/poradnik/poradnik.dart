enum PoradnikFormat{
  pdf,
  docx;

  String get title{
    switch(this){
      case PoradnikFormat.pdf: return 'PDF';
      case PoradnikFormat.docx: return 'DOCX';
    }
  }

  String get extension{
    switch(this){
      case PoradnikFormat.pdf: return 'pdf';
      case PoradnikFormat.docx: return 'docx';
    }
  }
}

class Poradnik{

  final String name;
  final String title;
  final List<PoradnikFormat> formats;
  
  const Poradnik({
    required this.name,
    required this.title,
    required this.formats
  });

  String getDownloadUrl(PoradnikFormat format) => "https://gitlab.com/n3o2k7i8ch5/harcapp_data/raw/master/poradniki/$name/$name.${format.extension}";

}