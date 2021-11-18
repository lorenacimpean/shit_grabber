import 'dart:convert';

import 'package:get/get.dart';
import 'package:shit_grabber/models/document_model.dart';
import 'package:shit_grabber/repo/api_keys.dart';
import 'package:shit_grabber/repo/file_picker_repo.dart';
import 'package:shit_grabber/repo/shared_pref_repo.dart';
import 'package:shit_grabber/utils/list_extensions.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

class DashboardController extends SubscriptionState<DashboardController> {
  late FilePickerRepo _filePickerRepo;
  late SharedPrefRepo _sharedPrefRepo;
  late RxList<DocumentModel> documents;

  @override
  void onInit() {
    documents = RxList<DocumentModel>();
    super.onInit();
    change(null, status: RxStatus.loading());
    _filePickerRepo = Get.find<FilePickerRepo>();
    _sharedPrefRepo = Get.find<SharedPrefRepo>();
    _loadDocumentsFromStorage();
  }

  void _loadDocumentsFromStorage() {
    change(null, status: RxStatus.loading());
    disposeLater(_sharedPrefRepo
        .getStringList(ApiKeys.documentList)
        .listen((stringList) {
      List<DocumentModel> fileList = stringList.map((fileString) {
        return DocumentModel.fromJson(jsonDecode(fileString));
      }).toList();
      documents = fileList.obs;
      change(fileList, status: RxStatus.success());
    }));
  }

  void addDocuments() {
    disposeLater(
      _filePickerRepo.pickFiles().listen((selectedFiles) {
        saveDocumentToSharedPref(selectedFiles);
      }),
    );
  }

  void saveDocumentToSharedPref(List<DocumentModel> selectedFiles) {
    change(null, status: RxStatus.loading());
    disposeLater(_sharedPrefRepo
        .addStringsToList(ApiKeys.documentList, getStringList(selectedFiles))
        .listen((event) {
      List<DocumentModel> newList = documents..addAllUnique(selectedFiles);
      documents = newList.obs;
      change(newList, status: RxStatus.success());
    }));
  }

  void deleteDocument(String title) {
    change(null, status: RxStatus.loading());
    List<DocumentModel> newList = documents
      ..removeWhere((d) => d.name == title);
    disposeLater(_sharedPrefRepo
        .setStringList(ApiKeys.documentList, getStringList(newList))
        .listen((_) {
      documents = newList.obs;
      change(newList, status: RxStatus.success());
    }));
  }

  List<String> getStringList(List<DocumentModel> docs) {
    return docs.map((e) => jsonEncode(e)).toList();
  }
}
