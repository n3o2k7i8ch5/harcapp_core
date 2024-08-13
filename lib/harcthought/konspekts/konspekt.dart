import 'package:flutter/material.dart';
import 'package:harcapp_core/color_pack_app.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
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
  zwyczaj, zajecia, projekt;

  String get displayName{
    switch(this){
      case zwyczaj: return 'Zwyczaj';
      case zajecia: return 'Zajęcia';
      case projekt: return 'Projekt';
    }
  }

  Color color(BuildContext context){
    switch(this){
      case zwyczaj: return isDark(context)?Colors.brown[400]!:Colors.amber[100]!;
      case zajecia: return isDark(context)?Colors.brown[800]!:Colors.brown[400]!;
      case projekt: return isDark(context)?Colors.purple[900]!:Colors.deepPurple[300]!;
    }
  }

}

enum KonspektAttachmentFormat{
  pdf, docx, url, urlPdf, urlDocx
}

enum KonspektSphere{
  cialo, umysl, duch, relacje, emocje;

  String get displayName{
    switch(this){
      case cialo: return 'Ciało';
      case umysl: return 'Umysł';
      case duch: return 'Duch';
      case relacje: return 'Relacje';
      case emocje: return 'Emocje';
    }
  }

  IconData get displayIcon{
    switch(this){
      case cialo: return MdiIcons.armFlexOutline;
      case umysl: return MdiIcons.brain;
      case duch: return MdiIcons.flare;
      case relacje: return MdiIcons.handshake;
      case emocje: return MdiIcons.dramaMasks;
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

Color konspektAttachmentFormatToColor(KonspektAttachmentFormat format){
  switch(format){
    case KonspektAttachmentFormat.pdf: return Colors.red;
    case KonspektAttachmentFormat.docx: return Colors.blue;
    case KonspektAttachmentFormat.url: return Colors.grey;
    case KonspektAttachmentFormat.urlPdf: return Colors.red;
    case KonspektAttachmentFormat.urlDocx: return Colors.blue;
  }
}

String konspektAttachmentFormatToName(KonspektAttachmentFormat format){
  switch(format){
    case KonspektAttachmentFormat.pdf: return 'PDF';
    case KonspektAttachmentFormat.docx: return 'DOC';
    case KonspektAttachmentFormat.url: return 'URL';
    case KonspektAttachmentFormat.urlPdf: return 'PDF';
    case KonspektAttachmentFormat.urlDocx: return 'DOC';
  }
}

IconData? konspektAttachmentFormatToSubIcon(KonspektAttachmentFormat format){
  switch(format){
    case KonspektAttachmentFormat.pdf:
    case KonspektAttachmentFormat.docx:
    case KonspektAttachmentFormat.url: return null;
    case KonspektAttachmentFormat.urlPdf: return MdiIcons.abacus;
    case KonspektAttachmentFormat.urlDocx: return MdiIcons.link;
  }
}

class KonspektAttachment{

    final String name;
    final String title;
    final Map<KonspektAttachmentFormat, String> assets;

    const KonspektAttachment({
      required this.name,
      required this.title,
      required this.assets,
    });

    Future<bool> open(String konspektName, KonspektAttachmentFormat format, KonspektCategory konspektCategory) async {
      String? assetPath = assets[format];
      if(assetPath == null) return false;

      switch(format){
        case KonspektAttachmentFormat.url:
          launchURL(assetPath);
          return true;
        case KonspektAttachmentFormat.urlPdf:
        case KonspektAttachmentFormat.urlDocx:
          launchURL(assetPath);
          return true;
        case KonspektAttachmentFormat.pdf:
        case KonspektAttachmentFormat.docx:
          OpenResult result;
          if(assetPath.contains('/'))
            result = await openAsset('packages/harcapp_core/assets/konspekty/$assetPath', webOpenInNewTab: true);
          else
            result = await openAsset('packages/harcapp_core/assets/konspekty/${konspektCategory.path}/${konspektName}/${assetPath}', webOpenInNewTab: true);

          return result.type == ResultType.done;
      }

    }

    Future<bool> openOrShowMessage(BuildContext context, String konspektName, KonspektAttachmentFormat format, KonspektCategory konspektCategory) async {
      bool result = await open(konspektName, format, konspektCategory);
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