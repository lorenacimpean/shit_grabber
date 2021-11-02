import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class ImageEncodingRepo {
  Stream<String> encodeImage(File image) =>
      image.readAsBytes().asStream().map((bytes) => base64.encode(bytes));

  Stream<File> decodeImage(String source) {
    return getApplicationDocumentsDirectory().asStream().flatMap((dir) {
      File file = File(dir.path);
      Uint8List bytes = base64.decode(source);
      return file.writeAsBytes(bytes).asStream();
    });
  }
}
