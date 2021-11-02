import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/controllers/sign_up_controller.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/themes/app_strings.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';
import 'package:shit_grabber/widgets/app_error_widget.dart';
import 'package:shit_grabber/widgets/app_text_input.dart';
import 'package:shit_grabber/widgets/custom_app_bar.dart';
import 'package:shit_grabber/widgets/loading_widget.dart';

class SignUpScreen extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.signUp,
      ),
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
          gradient: AppColors.gradientWithOpacity,
        ),
        padding: EdgeInsets.all(AppDimensions.defaultPadding),
        child: Form(
          child: controller.obx(
              (state) => ListView(
                    children: [
                      Container(height: 200),
                      ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.fields.length,
                        itemBuilder: (ctx, i) => AppTextInput(
                            formField: controller.fields[i],
                            onTextObscureToggle: () => controller
                                .toggleObscureText(controller.fields[i])),
                      ),
                      controller.isPasswordError.value
                          ? ConfirmPasswordErrorWidget()
                          : Container(),
                      _buildSubmitButton(),
                    ],
                  ),
              onLoading: LoadingWidget(),
              onError: (e) => AppErrorWidget(
                    errorMessage: e,
                    onRetry: controller.onInit,
                  )),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() => TextButton(
        onPressed: controller.validateConfirmPassword,
        child: Text(AppStrings.submit),
      );
}

class ConfirmPasswordErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.opaqueBlack,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.defaultRadius)),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.smallPadding),
        child: Text(
          AppStrings.confirmPasswordError,
          style: AppTextTheme.darkTextTheme.headline3
              ?.copyWith(color: AppColors.error),
        ),
      ),
    );
  }
}
