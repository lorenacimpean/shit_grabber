import 'package:flutter/cupertino.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_strings.dart';
import 'package:shit_grabber/widgets/app_base_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      screenTitle: AppStrings.dashboard,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.gradient,
        ),
      ),
    );
  }
}
