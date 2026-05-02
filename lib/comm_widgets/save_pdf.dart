import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

/// Triggers the platform-native save/open flow for a PDF.
///
/// - iOS / Android: writes the file to a temporary directory and opens it via
///   the system "Open with" picker (default PDF viewer or app chooser).
///   The viewer / picker exposes options to save the file locally or share it.
/// - Web: triggers a browser download to the user's Downloads folder.
Future<bool> savePdf({required Uint8List bytes, required String filename}) async {
  if(kIsWeb)
    return Printing.sharePdf(bytes: bytes, filename: filename);

  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/$filename');
  await file.writeAsBytes(bytes);
  final result = await OpenFilex.open(file.path);
  return result.type == ResultType.done;
}
