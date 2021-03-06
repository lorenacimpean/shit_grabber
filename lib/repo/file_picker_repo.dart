import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shit_grabber/models/document_model.dart';
import 'package:shit_grabber/repo/api_keys.dart';
import 'package:shit_grabber/repo/shared_pref_repo.dart';

class FilePickerRepo {
  final SharedPrefRepo _sharedPrefRepo = Get.find<SharedPrefRepo>();

  Stream<List<PlatformFile>> get _selectedFiles {
    return FilePicker.platform
        .pickFiles(allowMultiple: true)
        .asStream()
        .map((result) => result != null ? result.files : []);
  }

  Stream<List<DocumentModel>> pickFiles() => _selectedFiles.flatMap((list) {
        List<DocumentModel> fileList =
            list.map((file) => DocumentModel.fromPlatformFile(file)).toList();
        List<String> filesStringList =
            fileList.map((doc) => jsonEncode(doc)).toList();
        return _sharedPrefRepo
            .addStringsToList(ApiKeys.documentList, filesStringList)
            .map((_) => fileList);
      });

}
