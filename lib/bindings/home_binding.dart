import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:shit_grabber/controllers/home_controller.dart';
import 'package:shit_grabber/controllers/qr_code_controller.dart';
import 'package:shit_grabber/controllers/take_picture_controller.dart';
import 'package:shit_grabber/repo/camera_repo.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut(() => CameraRepo());
    Get.lazyPut(() => TakePictureController());
    Get.lazyPut(() => QrCodeController());
  }
}
