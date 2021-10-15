import 'package:flutter/cupertino.dart';
import 'package:shit_grabber/themes/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.gradient,
      ),
    );
  }
}
