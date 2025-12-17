import 'dart:convert';
import 'dart:typed_data';

import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

class AttachmentData {
  final String name;
  final String title;

  final Map<FileFormat, Uint8List> fileData;

  final Map<FileFormat, String> urlData;

  final bool printInfoEnabled;
  final KonspektAttachmentPrintSide printSide;
  final KonspektAttachmentPrintColor printColor;

  const AttachmentData({
    required this.name,
    required this.title,
    required this.fileData,
    required this.urlData,
    this.printInfoEnabled = false,
    this.printSide = KonspektAttachmentPrintSide.single,
    this.printColor = KonspektAttachmentPrintColor.monochrome,
  });

  Map<String, dynamic> toJson() {
    final Map filesJson = {};
    fileData.forEach((k, v) => filesJson[k.name] = base64Encode(v));

    final Map urlsJson = {};
    urlData.forEach((k, v) => urlsJson[k.name] = v);

    return {
      'name': name,
      'title': title,
      'formats': {...fileData.keys, ...urlData.keys}.map((e) => e.name).toList(),
      'files': filesJson,
      'urls': urlsJson,
      'printInfoEnabled': printInfoEnabled,
      'printSide': printSide.name,
      'printColor': printColor.name,
    };
  }

  static AttachmentData fromJson(Map<String, dynamic> json) {
    final formats = <FileFormat>{};
    for (final fName in (json['formats'] as List).cast<String>())
      formats.add(FileFormat.values.firstWhere((e) => e.name == fName));

    final fileData = <FileFormat, Uint8List>{};
    final filesJson = (json['files'] as Map?)?.cast<String, String>() ?? {};
    filesJson.forEach((k, v) {
      final fmt = FileFormat.values.firstWhere((e) => e.name == k);
      fileData[fmt] = base64Decode(v);
    });

    final urlData = <FileFormat, String>{};
    final urlsJson = (json['urls'] as Map?)?.cast<String, String>() ?? {};
    urlsJson.forEach((k, v) {
      final fmt = FileFormat.values.firstWhere((e) => e.name == k);
      urlData[fmt] = v;
    });

    return AttachmentData(
      name: json['name'] as String,
      title: json['title'] as String,
      fileData: fileData,
      urlData: urlData,
      printInfoEnabled: json['printInfoEnabled'] ?? false,
      printSide: KonspektAttachmentPrintSide.values
          .firstWhere((e) => e.name == (json['printSide'] ?? KonspektAttachmentPrintSide.single.name)),
      printColor: KonspektAttachmentPrintColor.values
          .firstWhere((e) => e.name == (json['printColor'] ?? KonspektAttachmentPrintColor.monochrome.name)),
    );
  }

  // static Future<AttachmentData> fromKonspektAttachment(KonspektAttachment attachment) async{
  //
  //   Map<FileFormat, Uint8List> fileData = {};
  //   Map<FileFormat, String> urlData = {};
  //
  //   for(MapEntry<FileFormat, String> entry in attachment.assets.entries)
  //     if(entry.key.isUrl)
  //       urlData[entry.key] = entry.value;
  //     else
  //       fileData[entry.key] = (await readByteDataFromAssets(entry.value))!.buffer.asUint8List();
  //
  //   return AttachmentData(
  //     name: attachment.name,
  //     title: attachment.title,
  //     fileData: fileData,
  //     urlData: urlData,
  //     printInfoEnabled: attachment.print != null,
  //     printSide: attachment.print?.side??KonspektAttachmentPrintSide.single,
  //     printColor: attachment.print?.color??KonspektAttachmentPrintColor.monochrome,
  //   );
  // }

}

class HrcpknspktData {
  final Uint8List? coverImage;
  final List<AttachmentData> attachments;
  final String konspektCoreData;

  const HrcpknspktData({
    required this.coverImage,
    this.attachments = const [],
    required this.konspektCoreData,
  });

  Map<String, dynamic> toJson() => {
    'coverImage': coverImage==null?null:base64Encode(coverImage!),
    'attachments': attachments.map((a) => a.toJson()).toList(),
    'konspektCoreData': konspektCoreData,
  };

  static HrcpknspktData fromJson(Map<String, dynamic> json) => HrcpknspktData(
    coverImage: json['coverImage']==null?null:base64Decode(json['coverImage'] as String),
    attachments: (json['attachments'] as List<dynamic>)
        .map((e) => AttachmentData.fromJson(e as Map<String, dynamic>))
        .toList(growable: false),
    konspektCoreData: json['konspektCoreData'] as String,
  );

  Uint8List toBytes() => Uint8List.fromList(utf8.encode(jsonEncode(toJson())));

  static HrcpknspktData fromBytes(Uint8List bytes) =>
      fromJson(jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>);

}