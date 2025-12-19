import 'dart:convert';

import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

import '../utils.dart';

Future<Konspekt> get uzaleznienia_behawioralne async => Konspekt.fromJsonMap(
    jsonDecode(
        (await readStringFromAssets(getKonspektJsonPath(category: KonspektCategory.harcerskie, konspektName: 'uzaleznienia_behawioralne')))!
    )
);
