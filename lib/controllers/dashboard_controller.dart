import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/models/document_model.dart';
import 'package:shit_grabber/repo/api_keys.dart';
import 'package:shit_grabber/repo/file_picker_repo.dart';
import 'package:shit_grabber/repo/shared_pref_repo.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

class DashboardController extends SubscriptionState<DashboardController> {
  final FilePickerRepo _filePickerRepo = Get.find<FilePickerRepo>();
  final SharedPrefRepo _sharedPrefRepo = Get.find<SharedPrefRepo>();
  late RxList<DocumentModel> documents;

  @override
  void onInit() {
    documents = RxList<DocumentModel>();
    super.onInit();
    disposeLater(_sharedPrefRepo
        .getStringList(ApiKeys.documentList)
        .listen((stringList) {
      List<DocumentModel> fileList = stringList.map((fileString) {
        return DocumentModel.fromJson(jsonDecode(fileString));
      }).toList();
      documents.assignAll(fileList.obs);
    }));
  }

  void addDocuments() {
    disposeLater(_filePickerRepo.pickFiles().listen((selectedFiles) {
      selectedFiles.map((file) {
        if (documents.contains(file)) {
          //TODO: check how to handle this (toast, loading state, error handling state)
          // also check RxState management stuff
          debugPrint('Element Already present in the dashboard');
        }
        return _sharedPrefRepo.addStringsToList(
          ApiKeys.documentList,
          getStringList(selectedFiles),
        );
      });
      List<DocumentModel> newList = documents..addAll(selectedFiles);
      documents.assignAll(newList.obs.toSet().toList());
    }));
  }

  void deleteDocument(String title) {
    List<DocumentModel> updatedList = documents
      ..removeWhere((d) => d.name == title);
    disposeLater(_sharedPrefRepo
        .setStringList(ApiKeys.documentList, getStringList(updatedList))
        .listen((_) {
      documents.assignAll(updatedList.obs);
    }));
  }

  List<String> getStringList(List<DocumentModel> docs) {
    return docs.map((e) => jsonEncode(e)).toList();
  }

  //TODO: check if I really need this
  @override
  void onDetached() {
    print('onDetached');
  }

  @override
  void onInactive() {
    print('onInactive');
  }

  @override
  void onPaused() {
    print('onPaused');
  }

  @override
  void onResumed() {
    print('onResumed');
  }
}
