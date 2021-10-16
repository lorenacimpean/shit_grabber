import 'package:get/get.dart';
import 'package:shit_grabber/controllers/dashboard_controller.dart';
import 'package:shit_grabber/repo/file_picker_repo.dart';
import 'package:shit_grabber/repo/shared_pref_repo.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SharedPrefRepo());
    Get.put(FilePickerRepo());
    Get.put(DashboardController());
  }
}
