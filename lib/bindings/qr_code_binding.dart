import 'package:get/get.dart';
import 'package:shit_grabber/controllers/qr_code_controller.dart';

class QrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(QrCodeController());
  }
}
