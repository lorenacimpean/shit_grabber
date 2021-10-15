import 'package:flutter/cupertino.dart';
import 'package:shit_grabber/themes/app_colors.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.gradient,
      ),
    );
  }
}
