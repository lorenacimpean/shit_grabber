import 'package:flutter/material.dart';
import 'package:shit_grabber/themes/app_colors.dart';

class AppTheme {
  ThemeData appThemeLight(BuildContext context) => ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme(
          primary: AppColors.primary,
          primaryVariant: AppColors.primary,
          onPrimary: AppColors.appWhite,
          secondary: AppColors.secondary,
          secondaryVariant: AppColors.secondary,
          onSecondary: AppColors.appWhite,
          surface: AppColors.appWhite,
          onSurface: AppColors.appBlack,
          brightness: Brightness.light,
          error: AppColors.error,
          onError: AppColors.appWhite,
          background: AppColors.appBlack,
          onBackground: AppColors.appWhite,
        ),
        errorColor: AppColors.error,
        cardColor: AppColors.appWhite,
        dividerColor: AppColors.grey,
        hintColor: AppColors.tertiary,
        disabledColor: AppColors.lightGrey,
        selectedRowColor: AppColors.primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'SpaceMono',
      );

  ThemeData appThemeDark(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        primary: AppColors.primary,
        primaryVariant: AppColors.primary,
        onPrimary: AppColors.appBlack,
        secondary: AppColors.secondary,
        secondaryVariant: AppColors.secondary,
        onSecondary: AppColors.appBlack,
        surface: AppColors.appBlack,
        onSurface: AppColors.appWhite,
        brightness: Brightness.dark,
        error: AppColors.error,
        onError: AppColors.appBlack,
        background: AppColors.appWhite,
        onBackground: AppColors.appBlack,
      ),
      errorColor: AppColors.error,
      cardColor: AppColors.appBlack,
      dividerColor: AppColors.grey,
      hintColor: AppColors.tertiary,
      disabledColor: AppColors.lightGrey,
      selectedRowColor: AppColors.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'SpaceMono',
      scaffoldBackgroundColor: AppColors.appBlack,
  );
}
