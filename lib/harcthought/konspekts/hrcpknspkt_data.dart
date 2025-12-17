import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:harcapp_core/comm_classes/missing_decode_param_error.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:path/path.dart';

class AttachmentData {
  final String name;
  final String title;

  final Map<FileFormat, Uint8List> assets;

  final Map<FileFormat, String> urlAssets;

  final bool printInfoEnabled;
  final KonspektAttachmentPrintSide printSide;
  final KonspektAttachmentPrintColor printColor;

  const AttachmentData({
    required this.name,
    required this.title,
    required this.assets,
    required this.urlAssets,
    this.printInfoEnabled = false,
    this.printSide = KonspektAttachmentPrintSide.single,
    this.printColor = KonspektAttachmentPrintColor.monochrome,
  });

  Map<String, dynamic> toJson() {
    final Map filesJson = {};
    assets.forEach((k, v) => filesJson[k.name] = base64Encode(v));

    final Map urlsJson = {};
    urlAssets.forEach((k, v) => urlsJson[k.name] = v);

    return {
      'name': name,
      'title': title,
      'formats': {...assets.keys, ...urlAssets.keys}.map((e) => e.apiParam).toList(),
      'files': filesJson,
      'urls': urlsJson,
      'printInfoEnabled': printInfoEnabled,
      'printSide': printSide.name,
      'printColor': printColor.name,
    };
  }

  ({Map<String, dynamic> json, List<ArchiveFile> files}) toTarData() {
    final archiveFiles = <ArchiveFile>[];
    for (final entry in assets.entries)
      archiveFiles.add(ArchiveFile(
        '$name.${entry.key.extension}',
        entry.value.length,
        entry.value,
      ));

    final Map<String, String> assetsJson = {};
    for (final fmt in assets.keys)
      assetsJson[fmt.apiParam] = '$name.${fmt.extension}';
    for (final entry in urlAssets.entries)
      assetsJson[entry.key.apiParam] = entry.value;

    return (
      json: {
        'name': name,
        'title': title,
        'assets': assetsJson,
        'printInfoEnabled': printInfoEnabled,
        'printSide': printSide.name,
        'printColor': printColor.name,
      },
      files: archiveFiles,
    );
  }

  static AttachmentData fromJson(Map<String, dynamic> json) {
    final formats = <FileFormat>{};
    for (final formatStr in (json['formats'] as List).cast<String>())
      formats.add(FileFormat.fromApiParam(formatStr)??(throw InvalidDecodeParamError('format', formatStr)));

    final assets = <FileFormat, Uint8List>{};
    final filesJson = (json['files'] as Map?)?.cast<String, String>() ?? {};
    filesJson.forEach((formatStr, value) {
      final format = FileFormat.fromApiParam(formatStr)??(throw InvalidDecodeParamError('format', formatStr));
      assets[format] = base64Decode(value);
    });

    final urlAssets = <FileFormat, String>{};
    final urlsJson = (json['urls'] as Map?)?.cast<String, String>() ?? {};
    urlsJson.forEach((formatStr, value) {
      final format = FileFormat.fromApiParam(formatStr)??(throw InvalidDecodeParamError('format', formatStr));
      urlAssets[format] = value;
    });

    return AttachmentData(
      name: json['name'] as String,
      title: json['title'] as String,
      assets: assets,
      urlAssets: urlAssets,
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
  final Map<String, Uint8List> attachmentFiles;  // Name -> File
  final Konspekt konspektCore;

  const HrcpknspktData({
    required this.coverImage,
    required this.attachmentFiles,
    required this.konspektCore,
  });

  Uint8List toTarBytes() {
    final archive = Archive();

    for (final entry in attachmentFiles.entries)
      archive.addFile(ArchiveFile(posix.join("attachments", entry.key), entry.value.length, entry.value));

    final Uint8List jsonBytes = utf8.encode(jsonEncode(konspektCore.toJsonMap()));
    archive.addFile(ArchiveFile('konspekt.json', jsonBytes.length, jsonBytes));

    if (coverImage != null)
      archive.addFile(ArchiveFile('cover.webp', coverImage!.length, coverImage!));

    return Uint8List.fromList(TarEncoder().encode(archive));
  }

  static HrcpknspktData fromTarBytes(Uint8List bytes){
    final archive = TarDecoder().decodeBytes(bytes);

    final konspektCore = Konspekt.fromJsonMap(
        jsonDecode(
            utf8.decode(
                Uint8List.fromList(archive.files.firstWhere((e) => e.name == 'konspekt.json').content)
            )
        )
    );

    final coverFile = archive.files.where((e) => e.name == 'cover.webp').firstOrNull;
    final Uint8List? coverImage = coverFile == null ? null : Uint8List.fromList(coverFile.content);

    final Map<String, Uint8List> attachmentFiles = {
      for (final file in archive.files.where((e) => e.name.startsWith('attachments/')))
        posix.basename(file.name): Uint8List.fromList(file.content)
    };

    return HrcpknspktData(
      coverImage: coverImage,
      attachmentFiles: attachmentFiles,
      konspektCore: konspektCore,
    );

  }
}