import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/themes/app_strings.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';

class AppErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetry;
  final String? retryText;

  const AppErrorWidget({
    Key? key,
    required this.errorMessage,
    this.onRetry,
    this.retryText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.defaultRadius)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTextCard(),
            if (onRetry != null) _buildRetryButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextCard() => Container(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.defaultPadding),
          child: Text(
            errorMessage ?? AppStrings.genericError,
            style: AppTextTheme.darkTextTheme.headline2
                ?.copyWith(color: AppColors.error),
          ),
        ),
      );

  Widget _buildRetryButton() => Padding(
        padding: EdgeInsets.all(AppDimensions.largePadding),
        child: ElevatedButton(
          onPressed: onRetry,
          child: Text(
            retryText ?? AppStrings.retry,
            style: AppTextTheme.darkTextTheme.headline2,
          ),
        ),
      );
}
