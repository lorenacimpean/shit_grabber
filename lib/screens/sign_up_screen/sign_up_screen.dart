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
            (state) => ListView(children: [
              _buildInfo(),
              _buildFields(),
              controller.isPasswordError.value
                  ? ConfirmPasswordErrorWidget()
                  : Container(),
              _buildSubmitButton(),
            ]),
            onLoading: LoadingWidget(),
            onError: (e) => AppErrorWidget(
              errorMessage: e,
              onRetry: controller.onInit,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfo() => Padding(
        padding: EdgeInsets.only(bottom: AppDimensions.defaultPadding),
        child: Text(
          AppStrings.signUpInfo,
          style: AppTextTheme.darkTextTheme.headline2
              ?.copyWith(color: AppColors.appBlack),
          textAlign: TextAlign.justify,
        ),
      );

  Widget _buildFields() => ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.fields.length,
        itemBuilder: (ctx, i) => AppTextInput(
            formField: controller.fields[i],
            onTextObscureToggle: () =>
                controller.toggleObscureText(controller.fields[i])),
      );

  Widget _buildSubmitButton() => Padding(
        padding: EdgeInsets.only(top: AppDimensions.smallPadding),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              controller.goToNext();
            },
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.smallPadding),
              child: Text(
                AppStrings.submit,
                style: AppTextTheme.darkTextTheme.headline2
                    ?.copyWith(color: AppColors.appBlack),
              ),
            ),
          ),
        ),
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
