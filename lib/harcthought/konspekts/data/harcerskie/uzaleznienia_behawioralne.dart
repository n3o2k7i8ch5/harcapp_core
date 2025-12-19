import 'dart:convert';

import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

Future<Konspekt> get uzaleznienia_behawioralne async => Konspekt.fromJsonMap(
    jsonDecode(
        (await readStringFromAssets('assets/konspekty/harcerskie/uzaleznienia_behawioralne/konspekt.json'))!
    )
);
