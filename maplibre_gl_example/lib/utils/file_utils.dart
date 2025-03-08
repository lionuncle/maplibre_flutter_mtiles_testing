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

/// using the external storage
Future<void> copyAssetToExternalStorage() async {
  final directory = await getExternalStorageDirectory();
  final filePath = '${directory!.path}/synthetic.mbtiles';

  if (await File(filePath).exists()) {
    return;
  }

  final byteData = await rootBundle.load('assets/synthetic.mbtiles');
  final file = File(filePath);
  await file.writeAsBytes(byteData.buffer.asUint8List());

  print('////////////////-- File written successfully in external storage -- /////////////////');
}

Future<String> getExternalMBTilesPath() async {
  print('////////////////-- Getting File from external storage -- /////////////////');
  final directory = await getExternalStorageDirectory();
  return '${directory!.path}/synthetic.mbtiles';
}
