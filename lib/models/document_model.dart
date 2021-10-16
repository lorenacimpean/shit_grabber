import 'package:file_picker/file_picker.dart';

class DocumentModel {
  final String name;
  final String? path;

  DocumentModel({
    required this.name,
    required this.path,
  });

  factory DocumentModel.fromPlatformFile(PlatformFile file) => DocumentModel(
        name: file.name,
        path: file.path,
      );
}
