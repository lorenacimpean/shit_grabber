import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/controllers/home_controller.dart';
import 'package:shit_grabber/screens/camera/take_picture_screen.dart';
import 'package:shit_grabber/screens/dashboard/dashboard_screen.dart';
import 'package:shit_grabber/screens/qr/qr_screen.dart';
import 'package:shit_grabber/screens/settings/settings_screen.dart';
import 'package:shit_grabber/widgets/custom_app_bar.dart';

import 'app_bottom_nav_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: CustomAppBar(
          title: controller.screenTitle,
        ),
        body: Container(
          child: _bodyByIndex,
        ),
        bottomNavigationBar: AppBottomNavigationWidget(
          selectedIndex: controller.selectedIndex,
          onTabSelected: (tabIndex) {
            controller.selectNavigationItem(tabIndex);
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
        return TakePictureScreen();
      case 2:
        return QrScreen();
      case 3:
        return SettingsScreen();
      default:
        return DashboardScreen();
    }
  }
}
