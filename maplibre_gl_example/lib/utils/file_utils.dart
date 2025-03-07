import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Copies the `synthetic.mbtiles` file from assets to local storage
Future<void> copyAssetToLocalStorage() async {
  try{
    // Get the local storage directory
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/synthetic.mbtiles';

    // Check if the file already exists
    if (await File(filePath).exists()) {
      return;
    }

    // Load the file from assets
    final byteData = await rootBundle.load('assets/synthetic.mbtiles');

    // Write the file to local storage
    final file = File(filePath);
    await file.writeAsBytes(byteData.buffer.asUint8List());
  }catch (e) {
    print('Failed to copy asset to local storage: $e');
    rethrow;
  }
}

/// Retrieves the file path of the `synthetic.mbtiles` file in local storage
Future<String> getMBTilesFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/synthetic.mbtiles';
}