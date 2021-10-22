import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:shit_grabber/controllers/take_picture_controller.dart';
import 'package:shit_grabber/repo/camera_repo.dart';

class TakePictureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CameraRepo());
    Get.lazyPut(() => TakePictureController());
  }
}
