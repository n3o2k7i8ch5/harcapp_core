import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_navigator.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/dialog/dialog.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

Future<String?> scanQrCode(BuildContext context) async {
  String? scannedQrCode;
  await openDialog(
      context: context,
      builder: (context) => QRCodeScannerWidget(
        onCapture: (qrCode){
          scannedQrCode = qrCode;
          popPage(context);
        },
      )
  );

  return scannedQrCode;
}

class QRCodeScannerWidget extends StatelessWidget{

  final void Function(String) onCapture;

  const QRCodeScannerWidget({required this.onCapture, super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(Dimen.sideMarg),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppCard.bigRadius),
        child: Stack(
          children: [
            QRCodeDartScanView(
              typeScan: TypeScan.live, // if TypeScan.takePicture will try decode when click to take a picture (default TypeScan.live)
              // takePictureButtonBuilder: (context,controller,isLoading){ // if typeScan == TypeScan.takePicture you can customize the button.
              //    if(loading) return CircularProgressIndicator();
              //    return ElevatedButton(
              //       onPressed:controller.takePictureAndDecode,
              //       child:Text('Take a picture'),
              //    );
              // }
              // resolutionPreset: = QrCodeDartScanResolutionPreset.high,
              formats: const [ // You can restrict specific formats.
                BarcodeFormat.qrCode
              ],
              onCapture: (Result result) {
                onCapture.call(result.text);
              },
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBarX(
                backgroundColor: Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );

}