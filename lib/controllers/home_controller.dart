import 'package:get/get.dart';
import 'package:shit_grabber/themes/app_strings.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
  }

  void selectNavigationItem(int index) {
    selectedIndex = index;
    refresh();
    update();
  }

  String get screenTitle {
    List<String> titles = [
      AppStrings.dashboard,
      AppStrings.takePhoto,
      AppStrings.shareApp,
      AppStrings.settings,
    ];
    return titles[selectedIndex];
  }
}
