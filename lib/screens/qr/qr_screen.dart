import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shit_grabber/controllers/qr_code_controller.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';

class QrScreen extends GetView<QrCodeController> {
  const QrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.gradientWithOpacity,
      ),
      child: Center(
        child: QrImage(
          data: controller.downloadUrl,
          padding: EdgeInsets.all(
            AppDimensions.largePadding * 2,
          ),
          foregroundColor: AppColors.appBlack,
        ),
      ),
    );
  }
}
