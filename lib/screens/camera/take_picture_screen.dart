import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shit_grabber/controllers/take_picture_controller.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/themes/app_strings.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';
import 'package:shit_grabber/widgets/gradient_widget.dart';
import 'package:shit_grabber/widgets/loading_widget.dart';

class TakePictureScreen extends GetView<TakePictureController> {
  TakePictureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      body: controller.obx(
        (state) => _buildBody(),
        onLoading: LoadingWidget(),
        onError: (error) => CameraPermissionError(
          text: error.toString(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(children: [
      Listener(
        child: CameraPreview(
          controller.cameraController.value,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
            );
          }),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.gradient,
          ),
          child: IconButton(
            onPressed: () => controller.snapPhoto(),
            icon: Icon(Icons.camera_alt),
          ),
        ),
      )
    ]);
  }
}

class CameraPermissionError extends StatelessWidget {
  final String text;

  const CameraPermissionError({Key? key, this.text = AppStrings.genericError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(AppDimensions.smallPadding),
            child: GradientMask(
              child: Text(
                text,
                style: AppTextTheme.darkTextTheme.headline2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppDimensions.smallPadding),
            child: GradientMask(
              child: Text(
                AppStrings.goToSettings,
                style: AppTextTheme.darkTextTheme.headline2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppDimensions.smallPadding),
            child: ElevatedButton(
              child: Text(
                'Open settings',
                style: AppTextTheme.darkTextTheme.headline2!
                    .copyWith(color: AppColors.appBlack),
              ),
              onPressed: openAppSettings,
            ),
          ),
        ],
      ),
    );
  }
}
