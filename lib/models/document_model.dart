import 'package:file_picker/file_picker.dart';
import 'package:shit_grabber/models/serializable_model.dart';
import 'package:shit_grabber/repo/api_keys.dart';

class DocumentModel extends SerializableModel {
  final String name;
  final String path;
  final DateTime lastModified;

  DocumentModel({
    required this.name,
    required this.path,
    required this.lastModified,
  });

  factory DocumentModel.fromPlatformFile(PlatformFile file) => DocumentModel(
        name: file.name,
        path: file.path ?? '',
        lastModified: DateTime.now(),
      );

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      name: json[ApiKeys.name],
      path: json[ApiKeys.path],
      lastModified:
          DateTime.tryParse(json[ApiKeys.lastModified]) ?? DateTime.now(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ApiKeys.name: name,
      ApiKeys.path: path,
      ApiKeys.lastModified: lastModified.toString(),
    };
  }

  void addAllUnique(){

  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentModel && name == other.name && path == other.path;

  @override
  int get hashCode => name.hashCode ^ path.hashCode;
}
