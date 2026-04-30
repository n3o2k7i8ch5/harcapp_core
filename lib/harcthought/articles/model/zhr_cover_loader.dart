import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:harcapp_core/comm_classes/dio.dart';
import 'package:image/image.dart' as img;

import 'zhr_utils.dart';

Future<(img.Image?, img.Image?)> downloadZhrCover(String link) =>
    compute(_zhrCoverFromHtmlLink, link);

Future<(img.Image?, img.Image?)> _zhrCoverFromHtmlLink(String link) async {
  try {
    String imageLink = await ZHRUtils.coverLinkFromHtmlLink(link);
    Response response = await defDio.get(
      webCorsProxy(imageLink),
      options: Options(responseType: ResponseType.bytes),
    );
    img.Image image = img.decodeImage(response.data)!;
    img.Image bigImage = img.copyResize(
      image,
      width: 1000,
      interpolation: img.Interpolation.cubic,
    );
    img.Image smallImage = img.copyResize(image, width: 480);
    return (bigImage, smallImage);
  } catch (_) {
    return (null, null);
  }
}
