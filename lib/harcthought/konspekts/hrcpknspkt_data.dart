import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:path/path.dart';

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