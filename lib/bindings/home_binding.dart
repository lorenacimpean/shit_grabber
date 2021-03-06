import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:shit_grabber/controllers/dashboard_controller.dart';
import 'package:shit_grabber/controllers/home_controller.dart';
import 'package:shit_grabber/controllers/take_picture_controller.dart';
import 'package:shit_grabber/repo/camera_repo.dart';
import 'package:shit_grabber/repo/file_picker_repo.dart';
import 'package:shit_grabber/repo/shared_pref_repo.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SharedPrefRepo());

    Get.put(HomeController());
    Get.put(FilePickerRepo());
    Get.put(DashboardController());
    Get.lazyPut(() => CameraRepo());
    Get.lazyPut(() => TakePictureController());
  }
}
