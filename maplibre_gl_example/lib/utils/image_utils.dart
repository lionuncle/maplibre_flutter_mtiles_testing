import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

/// Adds an asset image to the currently displayed style
Future<void> addImageFromAsset(
    MapLibreMapController controller, String name, String assetName) async {
  try {
    final bytes = await rootBundle.load(assetName);
    final list = bytes.buffer.asUint8List();
    await controller.addImage(name, list);
  } catch (e) {
    print('Failed to add image from asset: $e');
    rethrow;
  }
}