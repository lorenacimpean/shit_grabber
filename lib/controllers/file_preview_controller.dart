import 'dart:io';

import 'package:get/get.dart';
import 'package:shit_grabber/models/document_model.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

enum FileTypes { pdf, img, none }

class FilePreviewController extends SubscriptionState<FilePreviewController> {
  static const List<String> _imageFormats = ['jpg', 'jpeg', 'png'];
  late String _path;
  late File _file;
  late Rx<FileTypes> fileType;

  @override
  void onInit() {
    super.onInit();
    DocumentModel documentModel = Get.arguments;
    _path = documentModel.path;
    _file = File(_path);
    fileType = Rx<FileTypes>(FileTypes.none);
    _checkFile();
  }

  void _checkFile() {
    change(null, status: RxStatus.loading());
    _file.exists().then((exists) {
      if (exists) {
        if (isImage) {
          fileType = FileTypes.img.obs;
          change(fileType, status: RxStatus.success());
        } else if (_fileTypeString == 'pdf') {
          fileType = FileTypes.pdf.obs;
          change(fileType, status: RxStatus.success());
        } else {
          fileType = FileTypes.none.obs;
          change(
            fileType,
            status: RxStatus.error(
              FileRelatedErrors.formatNotSupported,
            ),
          );
        }
      } else {
        fileType = FileTypes.none.obs;
        change(
          fileType,
          status: RxStatus.error(
            FileRelatedErrors.fileNotFound,
          ),
        );
      }
    });
  }

  bool get isImage => _imageFormats.contains(_fileTypeString);

  String get _fileTypeString {
    int i = _path.lastIndexOf('.');
    if (i <= -1) {
      return '';
    }
    return _path.substring(i + 1);
  }
}

class FileRelatedErrors {
  static const String fileNotFound = 'File not found';
  static const String formatNotSupported =
      'The app does not currently support opening this type of file';
}
