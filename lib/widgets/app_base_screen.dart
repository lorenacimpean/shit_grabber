import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/controllers/base_controlles.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/themes/app_icon_paths.dart';
import 'package:shit_grabber/themes/app_strings.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';
import 'package:shit_grabber/widgets/gradient_text_widget.dart';

class AppBaseScreen extends GetView<BaseController> {
  final String screenTitle;
  final Widget body;

  const AppBaseScreen({
    required this.screenTitle,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseController>(
      builder: (controller) => Scaffold(
        appBar: _buildAppBar,
        body: _body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          onTap: controller.selectNavigationItem,
          unselectedItemColor: AppColors.secondary,
          showSelectedLabels: false,
          enableFeedback: true,
          type: BottomNavigationBarType.shifting,
          items: _navigationItems(),
        ),
      ),
    );
  }

  AppBar get _buildAppBar => AppBar(
        title: GradientText(
          screenTitle,
          style: AppTextTheme.darkTextTheme.headline2
              ?.copyWith(letterSpacing: 2.0),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.appBlack,
      );

  Widget get _body => SafeArea(child: body);

  List<BottomNavigationBarItem> _navigationItems() => [
        const BottomNavigationBarItem(
          icon: Image(
            image: AssetImage(AppIconPaths.home),
            height: AppDimensions.defaultPadding,
          ),
          label: AppStrings.dashboard,
        ),
        const BottomNavigationBarItem(
          icon: Image(
            image: AssetImage(AppIconPaths.link),
            height: AppDimensions.defaultPadding,
          ),
          label: AppStrings.loadDocuments,
        ),
        const BottomNavigationBarItem(
          icon: Image(
            image: AssetImage(AppIconPaths.phoneLink),
            height: AppDimensions.defaultPadding,
          ),
          label: AppStrings.takePhoto,
        ),
        const BottomNavigationBarItem(
          icon: Image(
            image: AssetImage(AppIconPaths.settings),
            height: AppDimensions.defaultPadding,
          ),
          label: AppStrings.settings,
        ),
      ];
}
