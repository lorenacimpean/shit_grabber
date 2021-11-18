import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/models/document_model.dart';
import 'package:shit_grabber/repo/api_keys.dart';
import 'package:shit_grabber/repo/file_picker_repo.dart';
import 'package:shit_grabber/repo/firebase_repo.dart';
import 'package:shit_grabber/repo/firestore_repo.dart';
import 'package:shit_grabber/repo/shared_pref_repo.dart';
import 'package:shit_grabber/utils/list_extensions.dart';
import 'package:shit_grabber/utils/permission_handler.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

class DashboardController extends SubscriptionState<DashboardController>
    with PermissionHandler {
  late FilePickerRepo _filePickerRepo;
  late SharedPrefRepo _sharedPrefRepo;
  late AuthRepo _authRepo;
  late FireStoreRepo _fireStoreRepo;
  late RxList<DocumentModel> documents;
  late User? _user;

  @override
  void onInit() {
    documents = RxList<DocumentModel>();
    super.onInit();
    change(null, status: RxStatus.loading());
    _filePickerRepo = Get.find<FilePickerRepo>();
    _sharedPrefRepo = Get.find<SharedPrefRepo>();
    _authRepo = Get.find<AuthRepo>();
    _fireStoreRepo = Get.find<FireStoreRepo>();

    _loadDocuments();
  }

  void _loadDocuments() {
    change(null, status: RxStatus.loading());
    disposeLater(_authRepo.currentUser.listen((user) {
      _user = user;
      if (user != null) {
        _loadDocumentsFromCloud(user.email!);
      } else {
        _loadDocumentsFromStorage();
      }
    }));
  }

  void _loadDocumentsFromStorage() {
    change(null, status: RxStatus.loading());
    disposeLater(_sharedPrefRepo
        .getStringList(ApiKeys.documentList)
        .listen((stringList) {
      List<DocumentModel> fileList = stringList.map((fileString) {
        return DocumentModel.fromJson(jsonDecode(fileString));
      }).toList();
      documents.value = fileList;
      change(fileList, status: RxStatus.success());
    }));
  }

  void _loadDocumentsFromCloud(String email) {
    change(null, status: RxStatus.loading());
    disposeLater(
        _fireStoreRepo.getAllFromFirestore(email).listen((documentList) {
      documents.value = documentList;
      change(documentList, status: RxStatus.success());
    }));
  }

  void addDocuments() {
    disposeLater(
      //TODO: check this, it's annoying
      handleStoragePermission().listen((isGranted) {
        if (isGranted) {
          disposeLater(
            _filePickerRepo.pickFiles().listen((selectedFiles) {
              saveDocumentToSharedPref(selectedFiles);
            }),
          );
        }
      }),
    );
  }

  void saveDocumentToSharedPref(List<DocumentModel> selectedFiles) {
    change(null, status: RxStatus.loading());
    disposeLater(_sharedPrefRepo
        .addStringsToList(ApiKeys.documentList, getStringList(selectedFiles))
        .listen((event) {
      List<DocumentModel> newList = documents
        ..addAllUniqueDocuments(selectedFiles);
      documents.value = newList;
      change(newList, status: RxStatus.success());
      if (_user != null) {
        disposeLater(
            _fireStoreRepo.saveAllToFirestore(_user!.email!).listen((_) {}));
      }
    }));
  }

  void deleteDocument(String title) {
    change(null, status: RxStatus.loading());
    List<DocumentModel> newList = documents
      ..removeWhere((d) => d.name == title);
    disposeLater(_sharedPrefRepo
        .setStringList(ApiKeys.documentList, getStringList(newList))
        .listen((_) {
      documents.value = newList;
      change(newList, status: RxStatus.success());
    }));
  }

  List<String> getStringList(List<DocumentModel> docs) {
    return docs.map((e) => jsonEncode(e)).toList();
  }
}
