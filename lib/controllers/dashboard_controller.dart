import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shit_grabber/models/document_model.dart';
import 'package:shit_grabber/repo/file_picker_repo.dart';

class DashboardController extends GetxController {
  final FilePickerRepo _filePickerRepo = Get.find();
  late List<DocumentModel> documents;
  List<String> documentTitles = [
    "Title 1",
    "Title 2: djhsfgfghjkjhg",
    "Title 3 jhdsfgdjfgdsjhfgdjsfjshjkdfhsfjkdhgfkdsfgdskhgkdjhsgjdgfd",
    "Title 3 jhdsfgdjfgdsjhfgdjsfjshjkdfhsfjkdhgfkdsfgdskhgkdjhsgjdgfd",
    "Title 3 jhdsfgdjfgdsjhfgdjsfjshjkdfhsfjkdhgfkdsfgdskhgkdjhsgjdgfd",
    "Title 3 jhdsfgdjfgdsjhfgdjsfjshjkdfhsfjkdhgfkdsfgdskhgkdjhsgjdgfd",
    "Title 3 jhdsfgdjfgdsjhfgdjsfjshjkdfhsfjkdhgfkdsfgdskhgkdjhsgjdgfd",
    "Title 4"
  ].obs;

  // Future<List<DocumentModel>> addDocuments() async{
  //   await _filePickerRepo.getFilePickerResult().then((fileList) {
  //     return fileList.map((file) {
  //       return DocumentModel(name: file.name, path: file.path);
  //     }).toList();
  //   }).obs;
  // }
}
