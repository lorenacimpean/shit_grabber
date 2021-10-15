import 'package:flutter/cupertino.dart';
import 'package:shit_grabber/themes/app_colors.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.gradient,
      ),
    );
  }
}
