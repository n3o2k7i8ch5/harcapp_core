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

  final Map<KonspektSphereLevel, Map<String, Set<KonspektSphereFactor>>?>? levels;

  // final List<KonspektSphereLevel> level;
  // final List<KonspektSphereMechanism> mechanism;

  const KonspektSphereDetails({
    required this.levels,
  });
}

enum KonspektSphereLevel{
  duchAksjomaty,
  duchWartosci,
  duchPostawy,
  duchHartDucha,

  cialoZdolnoscMarszu,

  umyslDyskusja,
  umyslKoncentracja,
  umyslLogiczneMyslenie,

  emoOdczytywanieWlasnychEmocji,
  emoPanowanieNadEmocjami;

  String get displayName{
    switch(this){
      case duchAksjomaty: return 'Aksjomaty';
      case duchWartosci: return 'Wartości';
      case duchPostawy: return 'Postawy';
      case duchHartDucha: return 'Hart Ducha';

      case cialoZdolnoscMarszu: return 'Zdolność marszu';

      case umyslDyskusja: return 'Umiejętność dyskusji';
      case umyslKoncentracja: return 'Zdolność koncentracji';
      case umyslLogiczneMyslenie: return 'Zdolność logicznego myślenia';

      case emoOdczytywanieWlasnychEmocji: return 'Zdolność odczytywania własnych emocji';
      case emoPanowanieNadEmocjami: return 'Zdolność panowania nad emocjami';
    }
  }

  Color get color{
    switch(this){
      case duchAksjomaty: return Colors.blue;
      case duchWartosci: return Colors.orange;
      case duchPostawy: return Colors.deepPurpleAccent;
      case duchHartDucha: return Colors.red;

      case cialoZdolnoscMarszu: return Colors.black;

      case umyslDyskusja: return Colors.black;
      case umyslKoncentracja: return Colors.black;
      case umyslLogiczneMyslenie: return Colors.black;

      case emoOdczytywanieWlasnychEmocji: return Colors.black;
      case emoPanowanieNadEmocjami: return Colors.black;
    }
  }

  Widget get textWidget => Text(
    displayName,
    style: AppTextStyle(color: color, fontWeight: weight.bold),
  );

}

enum KonspektSphereFactor{
  duchBiologia,
  duchBezposrednieDoswiadczenie,
  duchNormalizacja,
  duchOczekiwaniaAutorytetu,
  duchOpowiescPrzewodnia,
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
      case duchPrzykladWlasnyAutorytetow: return 'Przykład Własny Autorytetów';
      case duchWartosciWtorne: return 'Wartości Wtórne';
      case duchWlasnaRefleksja: return 'Własna Refleksja';
      case duchWzajemnoscOddzialywan: return 'Wzajemność Oddziaływań';
    }

  }

  Widget get textWidget => Text(
    displayName,
    style: const AppTextStyle(fontWeight: weight.halfBold),
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

  String get coverPath => 'packages/harcapp_core/assets/konspekty/${category.path}/$name/cover.webp';

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
    this.author,
    this.customDuration,  // if null, `duration` will be calculated from the steps' duration.
    required this.aims,
    this.materials,
    this.summary,
    this.intro,
    this.description,
    this.howToFail,
    this.steps,

    this.attachments,
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