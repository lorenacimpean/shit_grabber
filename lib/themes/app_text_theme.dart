import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = const TextTheme(
    bodyText1: TextStyle(
      fontFamily: 'Roboto',
      fontSize: AppDimensions.bodyTextSize,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      color: AppColors.appBlack,
    ),
    headline1: TextStyle(
      fontFamily: 'Roboto',
      fontSize: AppDimensions.headline1Size,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      color: AppColors.appBlack,
    ),
    headline2: TextStyle(
      fontFamily: 'Roboto',
      fontSize: AppDimensions.headline2Size,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      color: AppColors.appBlack,
    ),
    headline3: TextStyle(
      fontFamily: 'Roboto',
      fontSize: AppDimensions.headline3Size,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: AppColors.appBlack,
    ),
    headline4: TextStyle(
      fontFamily: 'Roboto',
      fontSize: AppDimensions.headline4Size,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      color: AppColors.appBlack,
    ),
  );

  static TextTheme darkTextTheme = const TextTheme(
    bodyText1: TextStyle(
      fontFamily: 'Roboto',
      fontSize: AppDimensions.bodyTextSize,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      color: AppColors.appWhite,
    ),
    headline1: TextStyle(
      fontFamily: 'Roboto',
      fontSize: AppDimensions.headline1Size,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      color: AppColors.appWhite,
    ),
    headline2: TextStyle(
      fontFamily: 'Roboto',
      fontSize: AppDimensions.headline2Size,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      color: AppColors.appWhite,
    ),
    headline3: TextStyle(
      fontFamily: 'Roboto',
      fontSize: AppDimensions.headline3Size,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: AppColors.appWhite,
    ),
    headline4: TextStyle(
      fontFamily: 'Roboto',
      fontSize: AppDimensions.headline4Size,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      color: AppColors.appWhite,
    ),
  );
}
