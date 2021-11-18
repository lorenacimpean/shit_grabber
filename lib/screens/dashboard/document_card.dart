import 'package:flutter/material.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/themes/app_icon_paths.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';

class DocumentCard extends StatelessWidget {
  final String title;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const DocumentCard({
    Key? key,
    required this.title,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

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
                    margin: const EdgeInsets.only(
                      top: AppDimensions.midPadding,
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
                  Padding(
                    padding: EdgeInsets.only(
                      right: AppDimensions.smallPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: onDelete,
                          child: Text(
                            'Delete',
                            style:
                                AppTextTheme.darkTextTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
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
      ),
    );
  }
}
