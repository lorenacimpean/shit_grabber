import 'package:get/get.dart';
import 'package:shit_grabber/themes/app_strings.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;

  void selectNavigationItem(int index) {
    selectedIndex = index;
    update();
  }

  String get screenTitle {
    List<String> titles = [
      AppStrings.dashboard,
      AppStrings.loadDocuments,
      AppStrings.takePhoto,
      AppStrings.settings,
    ];
    return titles[selectedIndex];
  }
}
