import 'package:file_picker/file_picker.dart';
import 'package:shit_grabber/models/serializable_model.dart';
import 'package:shit_grabber/repo/api_keys.dart';

class DocumentModel extends SerializableModel {
  final String name;
  final String path;

  DocumentModel({
    required this.name,
    required this.path,
  });

  factory DocumentModel.fromPlatformFile(PlatformFile file) => DocumentModel(
        name: file.name,
        path: file.path ?? '',
      );

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      name: json[ApiKeys.name],
      path: json[ApiKeys.path],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ApiKeys.name: name,
      ApiKeys.path: path,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentModel && name == other.name && path == other.path;

  @override
  int get hashCode => name.hashCode ^ path.hashCode;
}
