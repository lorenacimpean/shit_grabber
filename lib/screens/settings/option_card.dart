import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/themes/app_icon_paths.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';
import 'package:shit_grabber/widgets/gradient_widget.dart';

class SettingsOption extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const SettingsOption({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: AppDimensions.largePadding,
            vertical: AppDimensions.smallPadding),
        color: AppColors.opaqueBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(AppDimensions.midPadding),
              child: Image(
                image: AssetImage(AppIconPaths.logo),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  right: AppDimensions.midPadding,
                  left: AppDimensions.midPadding,
                ),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextTheme.darkTextTheme.headline3
                      ?.copyWith(color: AppColors.grey),
                ),
              ),
            ),
            GradientMask(
              child: Padding(
                padding: EdgeInsets.only(
                  right: AppDimensions.midPadding,
                ),
                child: Icon(
                  CupertinoIcons.arrow_right_circle_fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
