import 'package:get/get.dart';

class BaseController extends GetxController {
  int selectedIndex = 0;

  void selectNavigationItem(int index) {
    selectedIndex = index;
    update();
  }
}
