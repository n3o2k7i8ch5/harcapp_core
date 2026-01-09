import 'dart:convert';

import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/harcthought/konspekts/data/utils.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

Future<Konspekt> get konspekt_kszt_czym_jest_zhp async => Konspekt.fromJsonMap(
    jsonDecode(
        (await readStringFromAssets(getKonspektJsonPath(category: KonspektCategory.ksztalcenie, konspektName: 'czym_jest_zhp')))!
    )
);