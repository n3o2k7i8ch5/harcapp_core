import 'package:flutter/material.dart';
import 'package:harcapp_core/color_pack_app.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/comm_classes/missing_decode_param_error.dart';
import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/open_image_dialog.dart';
import 'package:harcapp_core/comm_widgets/open_svg_image_dialog.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/values/people.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:open_filex/open_filex.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart' as pdf;

import 'common.dart';


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

  String get apiParam{
    switch(this){
      case harcerskie: return 'harcerskie';
      case ksztalcenie: return 'ksztalcenie';
    }
  }

  static KonspektCategory? fromApiParam(String name){
    switch(name){
      case 'harcerskie': return KonspektCategory.harcerskie;
      case 'ksztalcenie': return KonspektCategory.ksztalcenie;
      default: return null;
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

  static KonspektSphere? fromName(String name){
    switch(name.toLowerCase()){
      case 'cialo': return KonspektSphere.cialo;
      case 'umysl': return KonspektSphere.umysl;
      case 'duch': return KonspektSphere.duch;
      case 'emocje': return KonspektSphere.emocje;
      case 'relacje': return KonspektSphere.relacje;
      default: return null;
    }
  }

  String get displayName{
    switch(this){
      case cialo: return 'Ciało';
      case umysl: return 'Umysł';
      case duch: return 'Duch';
      case emocje: return 'Emocje';
      case relacje: return 'Relacje';
    }
  }

  String get displayNameDopelniacz{
    switch(this){
      case cialo: return 'Ciała';
      case umysl: return 'Umysłu';
      case duch: return 'Ducha';
      case emocje: return 'Emocji';
      case relacje: return 'Relacji';
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

  final Map<KonspektSphereLevel, KonspektSphereFields> levels;

  const KonspektSphereDetails({
    required this.levels,
  });

  Map toJsonMap(){
    Map result = {};
    for (KonspektSphereLevel level in levels.keys)
      result[level.name] = levels[level]!.fields.map(
              (key, value) => MapEntry(key, value?.map((e) => e.name).toList())
      );

    return result;
  }

  KonspektSphereDetails copy() => KonspektSphereDetails(
    levels: Map.fromEntries(
      levels.entries.map((e) => MapEntry(
        e.key,
        e.value.copy()
      ))
    )
  );

}

enum KonspektSphereLevel{
  duchAksjomaty,
  duchWartosci,
  duchPostawy,

  duchSilaCharakteru,
  duchZdolnoscRefleksyjna,

  other;

  String get displayName{
    switch(this){
      case duchAksjomaty: return 'Aksjomaty';
      case duchWartosci: return 'Wartości';
      case duchPostawy: return 'Postawy';

      case duchSilaCharakteru: return 'Siła Charakteru';
      case duchZdolnoscRefleksyjna: return 'Zdolność Refleksyjna';

      case other: return 'Inne';

    }
  }

  Color get color{
    switch(this){
      case duchAksjomaty: return Colors.blue;
      case duchWartosci: return Colors.orange;
      case duchPostawy: return Colors.deepPurpleAccent;

      case duchSilaCharakteru: return Colors.red;
      case duchZdolnoscRefleksyjna: return Colors.teal;

      case other: return Colors.black;
    }
  }

  pdf.PdfColor get pdfColor{
    switch(this){
      case duchAksjomaty: return pdf.PdfColors.blue;
      case duchWartosci: return pdf.PdfColors.orange;
      case duchPostawy: return pdf.PdfColors.deepPurpleAccent;

      case duchSilaCharakteru: return pdf.PdfColors.red;
      case duchZdolnoscRefleksyjna: return pdf.PdfColors.teal;

      case other: return pdf.PdfColors.black;
    }
  }

  Widget get textWidget => Text(
    displayName,
    style: AppTextStyle(color: color, fontWeight: weightBold),
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

class KonspektSphereFields{

  final Map<String, Set<KonspektSphereFactor>?> fields;

  const KonspektSphereFields({
    required this.fields,
  });

  KonspektSphereFields copy() => KonspektSphereFields(
    fields: Map.fromEntries(
      fields.entries.map((e) => MapEntry(
        e.key,
        e.value == null ? null : Set.from(e.value!))
      )
    )
  );

}

enum KonspektSphereFactor{
  duchBiologia,
  duchBezposrednieDoswiadczenie,
  duchPerspektywa_Normalizacja,
  duchOczekiwaniaAutorytetu,
  duchMetanarracja,
  duchPerspektwa_PrzestrzenSemantyczna,
  duchPrzykladWlasnyAutorytetow,
  duchWartosciWtorne,
  duchWlasnaRefleksja,
  duchWspolnota_WzajemnoscOddzialywan;

  String get displayName{
    switch(this){
      case duchBiologia: return 'Biologia';
      case duchBezposrednieDoswiadczenie: return 'Bezpośrednie Doświadczenie';
      case duchPerspektywa_Normalizacja: return 'Perspektywa (Normalizacja)';
      case duchOczekiwaniaAutorytetu: return 'Oczekiwania Uznanego Autorytetu';
      case duchMetanarracja: return 'Metanarracja';
      case duchPerspektwa_PrzestrzenSemantyczna: return 'Perspektywa (Przestrzeń Semantyczna)';
      case duchPrzykladWlasnyAutorytetow: return 'Przykład Własny Autorytetów';
      case duchWartosciWtorne: return 'Wartości Wtórne';
      case duchWlasnaRefleksja: return 'Własna Refleksja';
      case duchWspolnota_WzajemnoscOddzialywan: return 'Wspólnota (Wzajemność Oddziaływań)';
    }

  }

  Widget get textWidget => Text(
    displayName,
    style: const AppTextStyle(
      fontWeight: weightNormal,
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

  static KonspektAttachmentPrintColor? fromName(String name){
    switch(name.toLowerCase()){
      case 'monochrome': return KonspektAttachmentPrintColor.monochrome;
      case 'color': return KonspektAttachmentPrintColor.color;
      case 'any': return KonspektAttachmentPrintColor.any;
      default: return null;
    }
  }

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

  static KonspektAttachmentPrintSide? fromName(String name){
    switch(name.toLowerCase()){
      case 'single': return KonspektAttachmentPrintSide.single;
      case 'double': return KonspektAttachmentPrintSide.double;
      case 'any': return KonspektAttachmentPrintSide.any;
      default: return null;
    }
  }

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

  Map toJsonMap() => {
    'color': color.name,
    'side': side.name,
  };

  static KonspektAttachmentPrint? fromJsonMap(Map<String, dynamic> map) => KonspektAttachmentPrint(
    color: KonspektAttachmentPrintColor.fromName(map['color'] as String)??(throw MissingDecodeParamError('color')),
    side: KonspektAttachmentPrintSide.fromName(map['side'] as String)??(throw MissingDecodeParamError('side')),
  );

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

    Map toJsonMap() => {
      'name': name,
      'title': title,
      'assets': assets.map((key, value) => MapEntry(key.name, value)),
      'print': print?.toJsonMap()
    };

    static KonspektAttachment fromJsonMap(Map<String, dynamic> map) => KonspektAttachment(
      name: map['name'] as String,
      title: map['title'] as String,
      assets: (map['assets'] as Map<String, dynamic>).map((key, value) => MapEntry(FileFormat.fromName(key)??(throw MissingDecodeParamError('assets.$key')), value as String)),
      print: map['print'] == null ? null : KonspektAttachmentPrint.fromJsonMap(map['print'] as Map<String, dynamic>),
    );

}

class KonspektMaterial{

  final int? amount;
  final int? amountAttendantFactor;
  final String name;
  final String? comment;
  final String? attachmentName;
  final String? additionalPreparation;
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

  KonspektMaterial copyWith({
    int? amount,
    int? amountAttendantFactor,
    String? name,
    String? comment,
    String? additionalPreparation,
    String? attachmentName,
    void Function(BuildContext)? onTap,
    Widget Function(BuildContext)? bottomBuilder,
  }) => KonspektMaterial(
    amount: amount??this.amount,
    amountAttendantFactor: amountAttendantFactor??this.amountAttendantFactor,
    name: name??this.name,
    comment: comment??this.comment,
    additionalPreparation: additionalPreparation??this.additionalPreparation,
    attachmentName: attachmentName??this.attachmentName,
    onTap: onTap??this.onTap,
    bottomBuilder: bottomBuilder??this.bottomBuilder,
  );

  Map toJsonMap() => {
    'amount': amount,
    'amountAttendantFactor': amountAttendantFactor,
    'name': name,
    'comment': comment,
    'attachmentName': attachmentName,
    'additionalPreparation': additionalPreparation,
  };

  static KonspektMaterial fromJsonMap(Map<String, dynamic> map) => KonspektMaterial(
    amount: map['amount'] as int?,
    amountAttendantFactor: map['amountAttendantFactor'] as int?,
    name: map['name'] as String,
    comment: map['comment'] as String?,
    additionalPreparation: map['additionalPreparation'] as String?,
    attachmentName: map['attachmentName'] as String?,
  );

}

mixin KonspektDurationElementMixin{

  Duration get duration;

}

enum KonspektStepActiveForm{
  active,
  static;

  String get displayName{
    switch(this){
      case active: return 'Forma aktywna';
      case static: return 'Forma statyczna';
    }
  }

  Color get color{
    switch(this){
      case active: return Colors.green;
      case static: return Colors.deepOrange;
    }
  }
}

class KonspektStep with KonspektDurationElementMixin{

  final String title;
  final Duration duration;
  final KonspektStepActiveForm activeForm;
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
    KonspektStepActiveForm? activeForm,
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

  Map toJsonMap() => {
    'title': title,
    'duration': duration.inSeconds,
    'activeForm': activeForm.name,
    'required': required,
    'content': content,
    'aims': aims,
    'materials': materials?.map((e) => e.toJsonMap()).toList(),
  };

  static KonspektStep fromJsonMap(Map<String, dynamic> map) => KonspektStep(
    title: map['title'] as String,
    duration: Duration(seconds: map['duration'] as int),
    activeForm: KonspektStepActiveForm.values.firstWhere((e) => e.name == (map['activeForm'] as String), orElse: () => throw MissingDecodeParamError('activeForm')),
    required: map['required'] as bool? ?? true,
    content: map['content'] as String?,
    aims: (map['aims'] as List<dynamic>?)?.map((e) => e as String).toList(),
    materials: (map['materials'] as List<dynamic>?)?.map((e) => KonspektMaterial.fromJsonMap(e as Map<String, dynamic>)).toList(),
  );

}

mixin KonspektStepsContainerMixin{

  List<KonspektStep> get steps;

}

class KonspektStepGroup with KonspektDurationElementMixin, KonspektStepsContainerMixin{

  final String? title;
  final List<KonspektStep> steps;

  Duration get duration{
    Duration resultDuration = Duration.zero;

    for(KonspektStep step in steps)
      resultDuration += step.duration;

    return resultDuration;
  }

  Duration get requiredDuration{
    Duration resultDuration = Duration.zero;

    for(KonspektStep step in steps)
      if(step.required)
        resultDuration += step.duration;

    return resultDuration;
  }

  const KonspektStepGroup({
    this.title,
    required this.steps
  });
}

abstract class BaseKonspekt with KonspektDurationElementMixin, KonspektStepsContainerMixin{

  String get name;
  String get title;
  List<String> get additionalSearchPhrases;
  KonspektCategory get category;
  KonspektType get type;
  Map<KonspektSphere, KonspektSphereDetails?> get spheres;

  List<Meto> get metos;
  String get coverAuthor;
  Person? get author;
  Duration? get customDuration;
  List<String> get aims;
  List<KonspektMaterial>? get materials;
  String get summary;
  String? get intro;
  String? get description;
  List<String>? get howToFail;

  List<KonspektStep> get steps;

  Map toJsonMap() => {
    'name': name,
    'title': title,
    'additionalSearchPhrases': additionalSearchPhrases,
    'category': category.name,
    'type': type.name,
    'spheres': spheres.map((key, value) => MapEntry(key.name, value?.toJsonMap())),
    'metos': metos.map((e) => e.name).toList(),
    'coverAuthor': coverAuthor,
    'author': author?.toApiJsonMap(),
    'customDuration': customDuration?.inSeconds,
    'aims': aims,
    'materials': materials?.map((e) => e.toJsonMap()).toList(),
    'summary': summary,
    'intro': intro,
    'description': description,
    'howToFail': howToFail,
    'steps': steps.map((e) => e.toJsonMap()).toList(),
  };

}

class Konspekt with KonspektStepsContainerMixin{

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
  final String summary;
  final String? intro;
  final String? description;
  final List<String>? howToFail;
  // If stepGroups is not null, steps will be ignored.
  final List<KonspektStepGroup>? stepGroups;
  final List<KonspektStep> steps;

  final List<KonspektAttachment>? attachments;
  final Konspekt? partOf;
  final bool upToDate;

  List<KonspektStep> get allSteps{
    if(stepGroups != null)
      return stepGroups!.expand((group) => group.steps).toList();
    else
      return steps;
  }

  List<TimeOfDay> stepsTimeTable(TimeOfDay startTime, {bool expandStepGroups = false}){
    List<KonspektDurationElementMixin> _steps;
    if(stepGroups != null){
      if(expandStepGroups) _steps = allSteps;
      else _steps = stepGroups!;
    } else
      _steps = steps;

    return buildTimeTable(_steps, startTime);
  }

  bool get anySteps => stepGroups != null || steps.isNotEmpty;

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

    if(stepGroups != null){
      if(stepGroups!.isEmpty) return null;

      Duration resultDuration = Duration.zero;

      for(KonspektStepGroup stepGroup in stepGroups!)
        resultDuration += stepGroup.duration;

      return resultDuration;
    }

    if(steps.isEmpty)
      return null;

    Duration resultDuration = Duration.zero;

    for(KonspektStep step in steps)
      resultDuration += step.duration;

    return resultDuration;

  }

  Duration? get requiredDuration{
    if(customDuration != null) return customDuration;

    if(stepGroups != null){
      if(stepGroups!.isEmpty) return null;

      Duration resultDuration = Duration.zero;

      for(KonspektStepGroup stepGroup in stepGroups!)
        resultDuration += stepGroup.requiredDuration;

      return resultDuration;
    }

    if(steps.isEmpty)
      return null;

    Duration resultDuration = Duration.zero;

    for(KonspektStep step in steps)
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
    this.stepGroups,
    this.steps = const [],

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

  Konspekt fromJsonMap(Map data){

    return Konspekt(
      name: data['name'] as String,
      title: data['title'] as String,
      additionalSearchPhrases: (data['additionalSearchPhrases'] as List?)?.map((e) => e as String).toList()??[],
      category: KonspektCategory.fromApiParam(data['category'] as String)??(throw MissingDecodeParamError('category')),
      type: KonspektType.values.firstWhere((e) => e.name == (data['type'] as String), orElse: () => throw MissingDecodeParamError('type')),
      spheres: (data['spheres'] as Map<String, dynamic>).map((key, value) => MapEntry(
        KonspektSphere.fromName(key)??(throw MissingDecodeParamError('spheres.$key')),
        value == null ? null : KonspektSphereDetails(
          levels: (value as Map<String, dynamic>).map((levelKey, levelValue) => MapEntry(
            KonspektSphereLevel.values.firstWhere((e) => e.name == levelKey, orElse: () => throw MissingDecodeParamError('spheres.$key.$levelKey')),
            KonspektSphereFields(
              fields: (levelValue as Map<String, dynamic>).map((fieldKey, fieldValue) => MapEntry(
                fieldKey,
                fieldValue == null ? null : Set.from((fieldValue as List).map((e) => KonspektSphereFactor.values.firstWhere((f) => f.name == e, orElse: () => throw MissingDecodeParamError('spheres.$key.$levelKey.$fieldKey'))))
              ))
            )
          ))
        )
      )),
      metos: (data['metos'] as List).map((e) => Meto.fromName(e as String)??(throw MissingDecodeParamError('metos'))).toList(),
      coverAuthor: data['coverAuthor'] as String,
      customCoverDirName: data['customCoverDirName'] as String?,
      author: data['author']==null?null:Person.fromApiJsonMap(data['author'] as Map<String, dynamic>),
      customDuration: data['customDuration'] == null ? null : Duration(seconds: data['customDuration'] as int),
      aims: (data['aims'] as List?)?.map((e) => e as String).toList()??[],
      materials: (data['materials'] as List?)?.map((e) => KonspektMaterial.fromJsonMap(e as Map<String, dynamic>)).toList(),
      summary: data['summary'] as String,
      intro: data['intro'] as String?,
      description: data['description'] as String?,
      howToFail: (data['howToFail'] as List?)?.map((e) => e as String).toList(),
      steps: (data['steps'] as List?)?.map((e) => KonspektStep.fromJsonMap(e as Map<String, dynamic>)).toList()??[],
    );

  }

}