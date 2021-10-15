import 'package:flutter/material.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/themes/app_icon_paths.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';

class DocumentCard extends StatelessWidget {
  final String title;

  const DocumentCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.largePadding,
          vertical: AppDimensions.midPadding),
      color: AppColors.appBlack.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(AppDimensions.smallPadding),
            child: Image(
              image: AssetImage(AppIconPaths.logo),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(AppDimensions.midPadding),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextTheme.darkTextTheme.headline3,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: AppDimensions.smallPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => print("tapped edit"),
                        child: Text(
                          "Edit",
                          style: AppTextTheme.darkTextTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary),
                        ),
                      ),
                      TextButton(
                        onPressed: () => print("tapped delete"),
                        child: Text(
                          "Delete",
                          style: AppTextTheme.darkTextTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
