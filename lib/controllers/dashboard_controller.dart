import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/models/document_model.dart';
import 'package:shit_grabber/repo/api_keys.dart';
import 'package:shit_grabber/repo/file_picker_repo.dart';
import 'package:shit_grabber/repo/shared_pref_repo.dart';
import 'package:shit_grabber/utils/list_extensions.dart';
import 'package:shit_grabber/utils/permission_handler.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

class DashboardController extends SubscriptionState<DashboardController>
    with PermissionHandler {
  late FilePickerRepo _filePickerRepo;
  late SharedPrefRepo _sharedPrefRepo;
  late RxList<DocumentModel> documents;

  @override
  void onInit() {
    documents = RxList<DocumentModel>();
    super.onInit();
    _filePickerRepo = Get.find<FilePickerRepo>();
    _sharedPrefRepo = Get.find<SharedPrefRepo>();
    disposeLater(_sharedPrefRepo
        .getStringList(ApiKeys.documentList)
        .listen((stringList) {
      change(null, status: RxStatus.loading());
      List<DocumentModel> fileList = stringList.map((fileString) {
        return DocumentModel.fromJson(jsonDecode(fileString));
      }).toList();
      documents.value = fileList;
      change(fileList, status: RxStatus.success());
    }));
  }

  void addDocuments() {
    disposeLater(
      handleStoragePermission().listen((isGranted) {
        if (isGranted) {
          disposeLater(
            _filePickerRepo.pickFiles().listen((selectedFiles) {
              change(null, status: RxStatus.loading());
              selectedFiles.map((file) {
                if (documents.contains(file)) {
                  debugPrint('Element Already present in the dashboard');
                }
                return _sharedPrefRepo.addStringsToList(
                  ApiKeys.documentList,
                  getStringList(selectedFiles),
                );
              });
              List<DocumentModel> newList = documents
                ..addAllUnique(selectedFiles);
              change(newList, status: RxStatus.success());
            })
              ..onError(
                  (error) => change(error, status: RxStatus.error(error))),
          );
        }
      }),
    );
  }

  void deleteDocument(String title) {
    change(null, status: RxStatus.loading());
    List<DocumentModel> updatedList = documents
      ..removeWhere((d) => d.name == title);
    disposeLater(_sharedPrefRepo
        .setStringList(ApiKeys.documentList, getStringList(updatedList))
        .listen((_) {
      change(updatedList, status: RxStatus.success());
    }));
  }

  List<String> getStringList(List<DocumentModel> docs) {
    return docs.map((e) => jsonEncode(e)).toList();
  }
}
