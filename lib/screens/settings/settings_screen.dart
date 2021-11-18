import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/controllers/settings_controller.dart';
import 'package:shit_grabber/screens/settings/authentification_widget.dart';
import 'package:shit_grabber/screens/settings/option_card.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/widgets/app_error_widget.dart';
import 'package:shit_grabber/widgets/loading_widget.dart';

class SettingsScreen extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      decoration: BoxDecoration(
        gradient: AppColors.gradientWithOpacity,
      ),
      padding: EdgeInsets.all(AppDimensions.defaultPadding),
      child: controller.obx(
        (state) => controller.firebaseUser.value == null
            ? AuthWidget(
                fields: controller.fields.value,
                onTextObscureToggle: controller.toggleObscureText,
                onSubmit: controller.goToNext,
                isConfirmPasswordValid: !controller.isPasswordError.value,
              )
            : Center(
                child: SettingsOption(
                  title: "sign out",
                  onTap: controller.logout,
                ),
              ),
        onLoading: LoadingWidget(),
        onError: (e) => AppErrorWidget(
          error: e,
          onRetry: controller.onInit,
        ),
      ),
    );
  }
}
