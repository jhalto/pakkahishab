import 'package:flutter/services.dart';

class FileSaver {
  static const MethodChannel _channel = MethodChannel('com.example.filesaver');

  static Future<bool> saveToDownloads(String filename, Uint8List bytes, String mimeType) async {
    try {
      final bool result = await _channel.invokeMethod('saveFile', {
        'filename': filename,
        'bytes': bytes,
        'mimeType': mimeType,
      });
      return result;
    } catch (e) {
      print("❌ Failed to save file: $e");
      return false;
    }
  }
}