import 'package:flutter/material.dart';
import 'package:harcapp_core/color_pack_app.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/open_image_dialog.dart';
import 'package:harcapp_core/comm_widgets/open_svg_image_dialog.dart';
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

enum KonspektAttachmentFormat{
  pdf, docx, png, webp, svg, url, urlPdf, urlDocx, urlPng, urlWebp, urlSvg;
  
  Color get color{
    switch(this){
      case pdf: return Colors.red;
      case docx: return Colors.blue;
      case png: return Colors.yellow[600]!;
      case webp: return Colors.orange;
      case svg: return Colors.deepPurpleAccent;
      case url: return Colors.grey;
      case urlPdf: return Colors.red;
      case urlDocx: return Colors.blue;
      case urlPng: return Colors.yellow[600]!;
      case urlWebp: return Colors.orange;
      case urlSvg: return Colors.deepPurpleAccent;
    }
  }

  String get displayName{
    switch(this){
      case pdf: return 'PDF';
      case docx: return 'DOC';
      case png: return 'PNG';
      case webp: return 'WEBP';
      case svg: return 'SVG';
      case url: return 'URL';
      case urlPdf: return 'PDF';
      case urlDocx: return 'DOC';
      case urlPng: return 'PNG';
      case urlWebp: return 'WEBP';
      case urlSvg: return 'SVG';
    }
  }

  IconData? get subIcon{
    switch(this){
      case pdf:
      case docx:
      case png:
      case webp:
      case svg:
      case url: return null;
      case urlPdf:
      case urlDocx:
      case urlPng:
      case urlWebp:
      case urlSvg: return MdiIcons.web;
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

  final List<KonspektSphereLevel> level;
  final List<KonspektSphereMechanism> mechanism;

  const KonspektSphereDetails({
    required this.level,
    required this.mechanism
  });
}

enum KonspektSphereLevel{
  duchAksjomaty,
  duchWartosci,
  duchPostawy;

  String get displayName{
    switch(this){
      case duchAksjomaty: return 'Aksjomaty';
      case duchWartosci: return 'Wartości';
      case duchPostawy: return 'Postawy';
    }
  }

  Color get color{
    switch(this){
      case duchAksjomaty: return Colors.blue;
      case duchWartosci: return Colors.orange;
      case duchPostawy: return Colors.deepPurpleAccent;
    }
  }

  Widget get textWidget => Text(
    displayName,
    style: AppTextStyle(color: color, fontWeight: weight.bold),
  );

}

enum KonspektSphereMechanism{
  duchBezposrednia,
  duchNormalizacja,
  duchHartDucha,
  duchKsztaltowanieUwaznosci,
  duchOtwartoscNaLudzi,
  duchWartoscWtorna,
  duchSumiennosc;


  String get displayName{
    switch(this){
      case duchBezposrednia: return 'Forma Bezpośrednia';
      case duchNormalizacja: return 'Normalizacja';
      case duchHartDucha: return 'Hart Ducha';
      case duchKsztaltowanieUwaznosci: return 'Kształtowanie Uważności';
      case duchOtwartoscNaLudzi: return 'Otwartość Na Ludzi';
      case duchWartoscWtorna: return 'Wartość Wtórna';
      case duchSumiennosc: return 'Sumienność';
    }
  }

  Widget get textWidget => Text(
    displayName,
    style: const AppTextStyle(fontWeight: weight.bold),
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
    final Map<KonspektAttachmentFormat, String> assets;
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
        KonspektAttachmentFormat format,
        KonspektCategory konspektCategory,
        {double? maxDialogWidth}
    ) async {
      String? assetPath = assets[format];
      if(assetPath == null) return false;

      switch(format){
        case KonspektAttachmentFormat.url:
          launchURL(assetPath);
          return true;
        case KonspektAttachmentFormat.urlPdf:
          launchURL(assetPath);
          return true;
        case KonspektAttachmentFormat.urlDocx:
          launchURL(assetPath);
          return true;
        case KonspektAttachmentFormat.urlPng:
        case KonspektAttachmentFormat.urlWebp:
          openImageDialog(context, title, assetPath, web: true, maxWidth: maxDialogWidth);
          return true;
        case KonspektAttachmentFormat.urlSvg:
          openSvgImageDialog(context, title, assetPath, web: true, maxWidth: maxDialogWidth);
          return true;
        case KonspektAttachmentFormat.pdf:
        case KonspektAttachmentFormat.docx:
          OpenResult result;
          if(assetPath.contains('/'))
            result = await openAsset('packages/harcapp_core/assets/konspekty/$assetPath', webOpenInNewTab: true);
          else
            result = await openAsset('packages/harcapp_core/assets/konspekty/${konspektCategory.path}/${konspektName}/${assetPath}', webOpenInNewTab: true);

          return result.type == ResultType.done;
        case KonspektAttachmentFormat.png:
        case KonspektAttachmentFormat.webp:
          if(assetPath.contains('/'))
            await openImageDialog(context, title, 'packages/harcapp_core/assets/konspekty/$assetPath', web: false, maxWidth: maxDialogWidth);
          else
            await openImageDialog(context, title, 'packages/harcapp_core/assets/konspekty/${konspektCategory.path}/${konspektName}/${assetPath}', web: false, maxWidth: maxDialogWidth);

          return true;
        case KonspektAttachmentFormat.svg:
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
        KonspektAttachmentFormat format,
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

  final int amount;
  final int? amountAttendantFactor;
  final String name;
  final String? comment;
  final String? additionalPreparation;
  final String? attachmentName;
  final void Function(BuildContext)? onTap;
  final Widget Function(BuildContext)? bottomBuilder;

  const KonspektMaterial({
    this.amount = 1,
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