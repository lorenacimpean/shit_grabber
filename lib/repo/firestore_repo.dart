import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shit_grabber/models/document_model.dart';
import 'package:shit_grabber/repo/api_keys.dart';
import 'package:shit_grabber/repo/shared_pref_repo.dart';

class FireStoreRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SharedPrefRepo _sharedPrefRepo = Get.find<SharedPrefRepo>();

  //  document id is user email, pass it from controller
  Stream<void> saveAllToFirestore(String documentId) {
    // get files from shared prefs
    return _sharedPrefRepo
        .getStringList(ApiKeys.documentList)
        .flatMap((filesEncodedToJson) {
      return _firestore.collection(ApiKeys.documentList).doc(documentId).set(
        {ApiKeys.documents: filesEncodedToJson},
      ).asStream();
    });
    // encode
    // save to collection
  }

  // get collection
  // decode
  // check if file in cache
  // save to cache
  // add to dashboards
  // PdfDocument pdf = PdfDocument.fromBase64String(base64String);
  Stream<List<DocumentModel>> getAllFromFirestore(String documentId) {
    return _firestore
        .collection(ApiKeys.documentList)
        .doc(documentId)
        .get()
        .asStream()
        .map((snapshot) {
      List<dynamic> fml = snapshot.data()?[ApiKeys.documents];
      return fml.map((encodedString) {
        Map<String, dynamic> json = jsonDecode(encodedString);
        return DocumentModel.fromJson(json);
      }).toList();
    });
  }
}
