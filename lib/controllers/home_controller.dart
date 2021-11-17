import 'package:get/get.dart';
import 'package:shit_grabber/repo/api_keys.dart';
import 'package:shit_grabber/repo/firebase_repo.dart';
import 'package:shit_grabber/repo/shared_pref_repo.dart';
import 'package:shit_grabber/themes/app_strings.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

class HomeController extends SubscriptionState<HomeController> {
  int selectedIndex = 0;
  late AuthRepo _authRepo;
  late SharedPrefRepo _sharedPrefRepo;

  @override
  void onInit() {
    _authRepo = Get.find<AuthRepo>();
    _sharedPrefRepo = Get.find<SharedPrefRepo>();
    super.onInit();
    checkLoginState();
  }

  void checkLoginState() {
    disposeLater(_authRepo.currentUser.listen((user) {
      updateSessionPreferences(user != null);
    }));
  }

  void updateSessionPreferences(bool isLoggedIn) {
    disposeLater(
        _sharedPrefRepo.setBool(ApiKeys.isLoggedIn, isLoggedIn).listen((_) {}));
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
