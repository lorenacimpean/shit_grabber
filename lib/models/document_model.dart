import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:shit_grabber/models/serializable_model.dart';
import 'package:shit_grabber/repo/api_keys.dart';

class DocumentModel extends SerializableModel {
  final String name;
  final String path;
  final DateTime lastModified;
  final String encodedString;

  DocumentModel({
    required this.name,
    required this.path,
    required this.lastModified,
    required this.encodedString,
  });

  factory DocumentModel.fromPlatformFile(PlatformFile file) => DocumentModel(
        name: file.name,
        path: file.path ?? '',
        lastModified: DateTime.now(),
        encodedString: encodeBytes(file.bytes),
      );

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      name: json[ApiKeys.name],
      path: json[ApiKeys.path],
      lastModified:
          DateTime.tryParse(json[ApiKeys.lastModified]) ?? DateTime.now(),
      encodedString: json[ApiKeys.encodedString],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ApiKeys.name: name,
      ApiKeys.path: path,
      ApiKeys.lastModified: lastModified.toString(),
      ApiKeys.encodedString: encodeFile(path),
    };
  }

  static String encodeBytes(Uint8List? bytes) {
    String base64String = base64Encode(bytes ?? []);
    return base64String;
  }

  static String encodeFile(String filePath) {
    File file = File(filePath);
    List<int> bytes = file.readAsBytesSync();
    String base64String = base64Encode(bytes);
    return base64String;
  }

  File fileFromEncodedString() {
    Uint8List bytes = base64.decode(encodedString);
    File file = File(path);
    file.writeAsBytesSync(bytes);
    return file;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          path == other.path &&
          lastModified == other.lastModified &&
          encodedString == other.encodedString;

  @override
  int get hashCode =>
      name.hashCode ^
      path.hashCode ^
      lastModified.hashCode ^
      encodedString.hashCode;
}


