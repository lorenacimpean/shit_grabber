import 'package:get/get.dart';
import 'package:shit_grabber/controllers/file_preview_controller.dart';

class FilePreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FilePreviewController());
  }
}
