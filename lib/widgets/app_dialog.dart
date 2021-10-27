import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/themes/app_strings.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';
import 'package:shit_grabber/widgets/gradient_widget.dart';

class AppDialog {
  final String title;
  final String contentText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  AppDialog({
    required this.title,
    required this.contentText,
    required this.onConfirm,
    required this.onCancel,
  });

  Future<dynamic> showDialog() {
    return Get.defaultDialog(
        title: title,
        titleStyle: AppTextTheme.darkTextTheme.headline2!
            .copyWith(color: AppColors.primary),
        titlePadding: EdgeInsets.all(AppDimensions.defaultPadding),
        content: Padding(
          padding: EdgeInsets.all(AppDimensions.smallPadding),
          child: GradientMask(
            child: Text(
              contentText,
              style: AppTextTheme.darkTextTheme.headline2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        textConfirm: AppStrings.ok,
        textCancel: AppStrings.cancel,
        confirm: TextButton(
            onPressed: onConfirm,
            child: Text(AppStrings.ok,
                style: AppTextTheme.darkTextTheme.headline2!
                    .copyWith(color: AppColors.tertiary))),
        cancel: TextButton(
            onPressed: onCancel,
            child: Text(AppStrings.cancel,
                style: AppTextTheme.darkTextTheme.headline2!
                    .copyWith(color: AppColors.primary))),
        onConfirm: onConfirm,
        onCancel: onCancel,
        backgroundColor: AppColors.appBlack);
  }
}
