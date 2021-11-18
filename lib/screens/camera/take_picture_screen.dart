import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/controllers/take_picture_controller.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/widgets/loading_widget.dart';

class TakePictureScreen extends GetView<TakePictureController> {
  TakePictureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) => _buildBody(),
        onLoading: LoadingWidget(),
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
          margin: EdgeInsets.only(bottom: AppDimensions.defaultPadding / 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.gradient,
          ),
          child: IconButton(
            onPressed: controller.snapPhoto,
            icon: Icon(Icons.camera_alt),
          ),
        ),
      )
    ]);
  }
}
