import 'package:flutter/cupertino.dart';
import 'package:shit_grabber/themes/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
//todo: add sync files with firestore
  //check how to save images from cache
//todo: add firebase login
//todo: drop a message to creator
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.gradientWithOpacity,
      ),
    );
  }

}
