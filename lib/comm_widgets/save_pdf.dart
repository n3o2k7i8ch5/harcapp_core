import 'dart:typed_data';

import 'package:printing/printing.dart';

/// Triggers the platform-native save/share flow for a PDF.
///
/// - iOS / Android: opens the system share sheet (Save to Files, share to apps, ...).
/// - Web: triggers a browser download to the user's Downloads folder.
Future<bool> savePdf({required Uint8List bytes, required String filename}) =>
    Printing.sharePdf(bytes: bytes, filename: filename);
