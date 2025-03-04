import 'package:flutter/material.dart';
import 'package:harcapp_core/color_pack_app.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/open_image_dialog.dart';
import 'package:harcapp_core/comm_widgets/open_svg_image_dialog.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/values/people.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:open_filex/open_filex.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart' as pdf;


enum KonspektCategory{
  harcerskie, ksztalcenie;

  String get displayName{
    switch(this){
      case harcerskie: return 'Harcerskie';
      case ksztalcenie: return 'Kształceniowe';
    }
  }

  String get path{
    switch(this){
      case harcerskie: return 'harcerskie';
      case ksztalcenie: return 'ksztalcenie';
    }
  }
  
}

enum KonspektType{
  zwyczaj, zajecia, projekt, wspolzawoIndywidualne, wspolzawoGrupowe;

  String get displayName{
    switch(this){
      case zwyczaj: return 'Zwyczaj';
      case zajecia: return 'Zajęcia';
      case projekt: return 'Projekt';
      case wspolzawoIndywidualne: return 'Współzawodnictwo indywidualne';
      case wspolzawoGrupowe: return 'Współzawodnictwo grupowe';
    }
  }

  Color color(BuildContext context){
    switch(this){
      case zwyczaj: return isDark(context)?Colors.brown[400]!:Colors.amber[100]!;
      case zajecia: return isDark(context)?Colors.brown[800]!:Colors.brown[200]!;
      case projekt: return isDark(context)?Colors.purple[900]!:Colors.deepPurple[200]!;
      case wspolzawoIndywidualne: return isDark(context)?Colors.deepOrange[900]!:Colors.deepOrange[200]!;
      case wspolzawoGrupowe: return isDark(context)?Colors.orange[900]!:Colors.orange[200]!;
    }
  }

}

enum KonspektSphere{
  cialo, umysl, duch, emocje, relacje;

  String get displayName{
    switch(this){
      case cialo: return 'Ciało';
      case umysl: return 'Umysł';
      case duch: return 'Duch';
      case emocje: return 'Emocje';
      case relacje: return 'Relacje';
    }
  }

  IconData get displayIcon{
    switch(this){
      case cialo: return MdiIcons.armFlexOutline;
      case umysl: return MdiIcons.brain;
      case duch: return MdiIcons.flare;
      case emocje: return MdiIcons.dramaMasks;
      case relacje: return MdiIcons.handshake;
    }
  }

}

class KonspektSphereDetails{

  final Map<KonspektSphereLevel, Map<String, Set<KonspektSphereFactor>?>>? levels;

  const KonspektSphereDetails({
    required this.levels,
  });
}

enum KonspektSphereLevel{
  duchAksjomaty,
  duchWartosci,
  duchPostawy,

  duchHartDucha,
  duchZdolnoscRefleksyjna,

  other;

  String get displayName{
    switch(this){
      case duchAksjomaty: return 'Aksjomaty';
      case duchWartosci: return 'Wartości';
      case duchPostawy: return 'Postawy';

      case duchHartDucha: return 'Hart Ducha';
      case duchZdolnoscRefleksyjna: return 'Zdolność Refleksyjna';

      case other: return 'Inne';

    }
  }

  Color get color{
    switch(this){
      case duchAksjomaty: return Colors.blue;
      case duchWartosci: return Colors.orange;
      case duchPostawy: return Colors.deepPurpleAccent;

      case duchHartDucha: return Colors.red;
      case duchZdolnoscRefleksyjna: return Colors.teal;

      case other: return Colors.black;
    }
  }

  pdf.PdfColor get pdfColor{
    switch(this){
      case duchAksjomaty: return pdf.PdfColors.blue;
      case duchWartosci: return pdf.PdfColors.orange;
      case duchPostawy: return pdf.PdfColors.deepPurpleAccent;

      case duchHartDucha: return pdf.PdfColors.red;
      case duchZdolnoscRefleksyjna: return pdf.PdfColors.teal;

      case other: return pdf.PdfColors.black;
    }
  }

  Widget get textWidget => Text(
    displayName,
    style: AppTextStyle(color: color, fontWeight: weight.bold),
  );

  pdf.Widget pdfWidget(pdf.Font fontBold, double fontSize) => pdf.Text(
    displayName,
    style: pdf.TextStyle(
      font: fontBold,
      fontSize: fontSize,
      color: pdfColor,
    ),
  );

}

enum KonspektSphereFactor{
  duchBiologia,
  duchBezposrednieDoswiadczenie,
  duchNormalizacja,
  duchOczekiwaniaAutorytetu,
  duchOpowiescPrzewodnia,
  duchPrzestrzenSemantyczna,
  duchPrzykladWlasnyAutorytetow,
  duchWartosciWtorne,
  duchWlasnaRefleksja,
  duchWzajemnoscOddzialywan;

  String get displayName{
    switch(this){
      case duchBiologia: return 'Biologia';
      case duchBezposrednieDoswiadczenie: return 'Bezpośrednie Doświadczenie';
      case duchNormalizacja: return 'Normalizacja';
      case duchOczekiwaniaAutorytetu: return 'Oczekiwania Uznanego Autorytetu';
      case duchOpowiescPrzewodnia: return 'Opowieść Przewodnia';
      case duchPrzestrzenSemantyczna: return 'Przestrzeń Semantyczna';
      case duchPrzykladWlasnyAutorytetow: return 'Przykład Własny Autorytetów';
      case duchWartosciWtorne: return 'Wartości Wtórne';
      case duchWlasnaRefleksja: return 'Własna Refleksja';
      case duchWzajemnoscOddzialywan: return 'Wzajemność Oddziaływań';
    }

  }

  Widget get textWidget => Text(
    displayName,
    style: const AppTextStyle(
      fontWeight: weight.normal,
      decoration: TextDecoration.underline
    ),
  );

  pdf.Widget pdfWidget(pdf.Font font, double fontSize) => pdf.Text(
    displayName,
    style: pdf.TextStyle(
      font: font,
      fontSize: fontSize,
      fontWeight: pdf.FontWeight.normal,
      decoration: pdf.TextDecoration.underline
    ),
  );

}

enum KonspektAttachmentPrintColor{
  monochrome, color, any;

  String get displayName{
    switch(this){
      case monochrome: return 'Czarno-biało';
      case color: return 'W kolorze';
      case any: return 'W kolorze lub czarno-biało';
    }
  }

}

enum KonspektAttachmentPrintSide{
  single, double, any;

  String get displayName{
    switch(this){
      case single: return 'Jednostronnie';
      case double: return 'Dwustronnie';
      case any: return 'Jedno- lub dwustronnie';
    }
  }

}

class KonspektAttachmentPrint{

  KonspektAttachmentPrintColor color;
  KonspektAttachmentPrintSide side;

  KonspektAttachmentPrint({
    required this.color,
    required this.side,
  });
  
}

class KonspektAttachment{

    final String name;
    final String title;
    final Map<FileFormat, String> assets;
    final KonspektAttachmentPrint? print;

    const KonspektAttachment({
      required this.name,
      required this.title,
      required this.assets,
      this.print
    });

    Future<bool> open(
        BuildContext context,
        String konspektName,
        FileFormat format,
        KonspektCategory konspektCategory,
        {double? maxDialogWidth}
    ) async {
      String? assetPath = assets[format];
      if(assetPath == null) return false;

      switch(format){
        case FileFormat.url:
          launchURL(assetPath);
          return true;
        case FileFormat.urlPdf:
          launchURL(assetPath);
          return true;
        case FileFormat.urlDocx:
          launchURL(assetPath);
          return true;
        case FileFormat.urlPng:
        case FileFormat.urlWebp:
          openImageDialog(context, title, assetPath, web: true, maxWidth: maxDialogWidth);
          return true;
        case FileFormat.urlSvg:
          openSvgImageDialog(context, title, assetPath, web: true, maxWidth: maxDialogWidth);
          return true;
        case FileFormat.pdf:
        case FileFormat.docx:
          OpenResult? result;
          if(assetPath.contains('/'))
            result = await openAsset('packages/harcapp_core/assets/konspekty/$assetPath', webOpenInNewTab: true);
          else
            result = await openAsset('packages/harcapp_core/assets/konspekty/${konspektCategory.path}/${konspektName}/${assetPath}', webOpenInNewTab: true);

          return result?.type == ResultType.done;
        case FileFormat.png:
        case FileFormat.webp:
          if(assetPath.contains('/'))
            await openImageDialog(context, title, 'packages/harcapp_core/assets/konspekty/$assetPath', web: false, maxWidth: maxDialogWidth);
          else
            await openImageDialog(context, title, 'packages/harcapp_core/assets/konspekty/${konspektCategory.path}/${konspektName}/${assetPath}', web: false, maxWidth: maxDialogWidth);

          return true;
        case FileFormat.svg:
          if(assetPath.contains('/'))
            await openSvgImageDialog(context, title, 'packages/harcapp_core/assets/konspekty/$assetPath', web: false, maxWidth: maxDialogWidth);
          else
            await openSvgImageDialog(context,  title, 'packages/harcapp_core/assets/konspekty/${konspektCategory.path}/${konspektName}/${assetPath}', web: false, maxWidth: maxDialogWidth);

          return true;
      }

    }

    Future<bool> openOrShowMessage(
        BuildContext context,
        String konspektName,
        FileFormat format,
        KonspektCategory konspektCategory,
        {double? maxDialogWidth}
    ) async {
      bool result = await open(
        context,
        konspektName,
        format,
        konspektCategory,
        maxDialogWidth: maxDialogWidth
      );
      if(!result) showAppToast(context, text: 'Nie udało się otworzyć pliku');
      return result;
    }

}

class KonspektMaterial{

  final int? amount;
  final int? amountAttendantFactor;
  final String name;
  final String? comment;
  final String? additionalPreparation;
  final String? attachmentName;
  final void Function(BuildContext)? onTap;
  final Widget Function(BuildContext)? bottomBuilder;

  bool get hasAmount => (amount != null && amount! > 0) || (amountAttendantFactor != null && amountAttendantFactor! > 0);

  const KonspektMaterial({
    this.amount,
    this.amountAttendantFactor,
    required this.name,
    this.comment,
    this.attachmentName,
    this.additionalPreparation,
    this.onTap,
    this.bottomBuilder,
  });



}

class KonspektStep{

  final String title;
  final Duration duration;
  final bool activeForm;
  final bool required;
  final String? content;
  final List<String>? aims;
  final List<KonspektMaterial>? materials;
  final String Function({required bool isDark})? contentBuilder;

  const KonspektStep({
    required this.title,
    required this.duration,
    required this.activeForm,
    this.required = true,
    this.content,
    this.aims,
    this.materials,
    this.contentBuilder
  }):
    assert (content != null || contentBuilder != null);

  KonspektStep copyWith({
    String? title,
    Duration? duration,
    bool? activeForm,
    bool? required,
    String? content,
    List<String>? aims,
    List<KonspektMaterial>? materials,
    String Function({required bool isDark})? contentBuilder,
  }) => KonspektStep(
    title: title??this.title,
    duration: duration??this.duration,
    activeForm: activeForm??this.activeForm,
    required: required??this.required,
    content: content??this.content,
    aims: aims??this.aims,
    materials: materials??this.materials,
    contentBuilder: contentBuilder??this.contentBuilder
  );

  KonspektStep copyWithNamePrefix(String prefix) => copyWith(
    title: prefix + title[0].toLowerCase() + title.substring(1)
  );

}

class Konspekt{

  final String name;
  final String title;
  final List<String> additionalSearchPhrases;
  final KonspektCategory category;
  final KonspektType type;
  final Map<KonspektSphere, KonspektSphereDetails?> spheres;

  final List<Meto> metos;
  final String coverAuthor;
  final String? customCoverDirName;
  final Person? author;
  final Duration? customDuration;
  final List<String> aims;
  final List<KonspektMaterial>? materials;
  final String? summary;
  final String? intro;
  final String? description;
  final List<String>? howToFail;
  final List<KonspektStep>? steps;

  final List<KonspektAttachment>? attachments;
  final Konspekt? partOf;
  final bool upToDate;

  static Konspekt oldFrom(
    Konspekt upToDateKonspekt, {
      List<KonspektMaterial> materials = const [],
      List<KonspektAttachment> attachments = const [],
      List<KonspektStep> steps = const [],
  }) => Konspekt(
      name: upToDateKonspekt.name + "_old",
      title: upToDateKonspekt.title + " (stare elementy)",
      category: upToDateKonspekt.category,
      type: upToDateKonspekt.type,
      spheres: upToDateKonspekt.spheres,
      metos: upToDateKonspekt.metos,
      coverAuthor: upToDateKonspekt.coverAuthor,
      customCoverDirName: upToDateKonspekt.name,
      aims: [
        'Miejsce, w którym można znaleźć nieuzywane elementy konspektu "${upToDateKonspekt.title}", które z niego wyleciały.',
      ],
      materials: materials,
      attachments: attachments,
      summary: 'Stare elementy konspektu "${upToDateKonspekt.title}", które z niego wyleciały.',
      steps: steps,
      upToDate: false
  );

  String get coverPath => 'packages/harcapp_core/assets/konspekty/${category.path}/${customCoverDirName??name}/cover.webp';

  Duration? get duration{
    if(customDuration != null) return customDuration;

    if(steps == null)
      return null;

    Duration resultDuration = Duration.zero;

    for(KonspektStep step in steps!)
      resultDuration += step.duration;

    return resultDuration;

  }

  Duration? get requiredDuration{
    if(customDuration != null) return customDuration;

    if(steps == null)
      return null;

    Duration resultDuration = Duration.zero;

    for(KonspektStep step in steps!)
      if(step.required)
        resultDuration += step.duration;

    return resultDuration;

  }

  const Konspekt({
    required this.name,
    required this.title,
    this.additionalSearchPhrases = const [],
    required this.category,
    required this.type,
    required this.spheres,

    required this.metos,
    required this.coverAuthor,
    this.customCoverDirName,
    this.author,
    this.customDuration,  // if null, `duration` will be calculated from the steps' duration.
    required this.aims,
    this.materials,
    required this.summary,
    this.intro,
    this.description,
    this.howToFail,
    this.steps,

    this.attachments,
    this.partOf,
    this.upToDate = true,
  });

  bool matchesAdditionalPhrase(String searchPhrase){

    searchPhrase = remSpecChars(remPolChars(searchPhrase));

    for (String addSearchPhrase in additionalSearchPhrases)
      if(remSpecChars(remPolChars(addSearchPhrase)).contains(searchPhrase))
        return true;

    return false;
  }

  bool containsMetos(Iterable<Meto> metos){
    if(this.metos.isEmpty && metos.isNotEmpty) return false;

    for(Meto meto in metos)
      if(!this.metos.contains(meto))
        return false;

    return true;
  }
  
  bool containsSpheres(Iterable<KonspektSphere> spheres){
    if(this.spheres.isEmpty && spheres.isNotEmpty) return false;

    for(KonspektSphere sphere in spheres)
      if(!this.spheres.keys.contains(sphere))
        return false;

    return true;
  }

}