import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

Future<void> initHybridComposition() async {
  if (!kIsWeb && Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkVersion = androidInfo.version.sdkInt;
    if (sdkVersion >= 29) {
      MapLibreMap.useHybridComposition = true;
    } else {
      MapLibreMap.useHybridComposition = false;
    }
  }
}