import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_strings.dart';
import 'package:shit_grabber/widgets/gradient_widget.dart';

class AppBottomNavigationWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTabSelected;

  const AppBottomNavigationWidget({
    Key? key,
    required this.selectedIndex,
    this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTabSelected,
      selectedItemColor: AppColors.primary,
      showSelectedLabels: false,
      enableFeedback: true,
      type: BottomNavigationBarType.shifting,
      items: _navigationItems,
      elevation: 0.0,
    );
  }

  List<BottomNavigationBarItem> get _navigationItems {
    List<IconData> icons = [
      CupertinoIcons.square_list_fill,
      CupertinoIcons.camera_circle_fill,
      CupertinoIcons.upload_circle_fill,
      CupertinoIcons.settings
    ];
    List<String> labels = [
      AppStrings.dashboard,
      AppStrings.takePhoto,
      AppStrings.shareApp,
      AppStrings.settings
    ];

    return icons.map((icon) {
      return BottomNavigationBarItem(
        backgroundColor: AppColors.appBlack,
        icon: icon == icons[selectedIndex]
            ? Icon(icon)
            : GradientMask(
                child: Icon(icon),
              ),
        label: labels[selectedIndex],
      );
    }).toList();
  }
}
