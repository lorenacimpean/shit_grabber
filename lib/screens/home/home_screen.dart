import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/controllers/home_controller.dart';
import 'package:shit_grabber/screens/camera/take_picture_screen.dart';
import 'package:shit_grabber/screens/dashboard/dashboard_screen.dart';
import 'package:shit_grabber/screens/settings/settings_screen.dart';
import 'package:shit_grabber/screens/upload/upload_screen.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';
import 'package:shit_grabber/widgets/gradient_widget.dart';

import 'app_bottom_nav_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: _buildAppBar,
        body: _bodyByIndex,
        bottomNavigationBar: AppBottomNavigationWidget(
          selectedIndex: controller.selectedIndex,
          onTabSelected: (tabIndex) {
            controller.selectNavigationItem(tabIndex);
            // Get.reset();
          },
        ),
      ),
    );
  }

  Widget get _bodyByIndex {
    switch (controller.selectedIndex) {
      case 0:
        return DashboardScreen();
      case 1:
        return UploadScreen();
      case 2:
        return TakePictureScreen();
      case 3:
        return SettingsScreen();
      default:
        return DashboardScreen();
    }
  }

  AppBar get _buildAppBar => AppBar(
        title: GradientMask(
            child: Text(
          controller.screenTitle,
          style: AppTextTheme.darkTextTheme.headline2
              ?.copyWith(letterSpacing: 2.5),
        )),
        elevation: 0.0,
        backgroundColor: AppColors.appBlack,
        centerTitle: true,
      );
}
