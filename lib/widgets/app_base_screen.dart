import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/controllers/base_controlles.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';
import 'package:shit_grabber/widgets/app_bottom_nav_widget.dart';
import 'package:shit_grabber/widgets/gradient_widget.dart';

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
        bottomNavigationBar: AppBottomNavigationWidget(
          selectedIndex: controller.selectedIndex,
          onTabSelected: controller.selectNavigationItem,
        ),
      ),
    );
  }

  AppBar get _buildAppBar => AppBar(
        title: GradientWidget(Text(
          screenTitle,
          style: AppTextTheme.darkTextTheme.headline2
              ?.copyWith(letterSpacing: 2.0),
        )),
        elevation: 0.0,
        backgroundColor: AppColors.appBlack,
      );

  Widget get _body => SafeArea(child: body);
}
