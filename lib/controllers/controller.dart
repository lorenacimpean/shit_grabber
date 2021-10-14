import 'package:get/get.dart';

class Controller extends GetxController {
  RxInt count = 0.obs;

  void increment() => count++;

  void reset() {
    count.value = 0;
    update();
  }
}
