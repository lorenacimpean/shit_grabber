import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';

import 'gradient_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GradientMask(
          child: Text(
        title,
        style:
            AppTextTheme.darkTextTheme.headline2?.copyWith(letterSpacing: 2.5),
      )),
      elevation: 0.0,
      backgroundColor: AppColors.appBlack,
      centerTitle: true,
      leading: _buildBackButton(),
    );
  }

  Widget _buildBackButton() => GradientMask(child: Icon(CupertinoIcons.back));

  @override
  Size get preferredSize => Size.fromHeight(AppDimensions.largePadding * 2);
}
