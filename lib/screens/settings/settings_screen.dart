import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/controllers/settings_controller.dart';
import 'package:shit_grabber/screens/settings/authentification_widget.dart';
import 'package:shit_grabber/screens/settings/option_card.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/themes/app_strings.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';
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
            : _buildSyncInfo(),
        onLoading: LoadingWidget(),
        onError: (e) => AppErrorWidget(
          error: e,
          onRetry: controller.onInit,
        ),
      ),
    );
  }

  Widget _buildSyncInfo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _syncInfoText(),
          Padding(
            padding: const EdgeInsets.only(top: AppDimensions.largePadding),
            child: SettingsOption(
              title: AppStrings.logout,
              onTap: controller.logout,
            ),
          ),
        ],
      ),
    );
  }

  Widget _syncInfoText() {
    return Text(
      AppStrings.syncOptions,
      style: AppTextTheme.darkTextTheme.headline2
          ?.copyWith(color: AppColors.appWhite),
    );
  }
}
