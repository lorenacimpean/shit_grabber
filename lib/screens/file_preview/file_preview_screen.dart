import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/controllers/file_preview_controller.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/widgets/app_error_widget.dart';
import 'package:shit_grabber/widgets/gradient_widget.dart';
import 'package:shit_grabber/widgets/loading_widget.dart';

class FilePreviewScreen extends GetView<FilePreviewController> {
  final path = Get.arguments as String;

  FilePreviewScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.appBlack,
        appBar: _buildAppBar(),
        body: SafeArea(
          child: controller.obx(
            (state) => _buildBodyByFileType(),
            onLoading: LoadingWidget(),
            onError: (error) => AppErrorWidget(
              errorMessage: error,
            ),
          ),
        ),
      );

  PreferredSizeWidget _buildAppBar() => AppBar(
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: GradientWidget(
            child: Icon(CupertinoIcons.back),
          ),
        ),
      );

  Widget _buildBodyByFileType() {
    Widget body;
    switch (controller.fileType.value) {
      case FileTypes.pdf:
        body = _buildPdfWidget();
        break;
      case FileTypes.img:
        body = _buildImagePreview();
        break;
      case FileTypes.none:
        body = GradientWidget(child: Container());
        break;
    }
    return Container(
      child: body,
      color: AppColors.appBlack,
    );
  }

  Widget _buildImagePreview() {
    return Center(
      child: Image.file(File(path)),
    );
  }

  Widget _buildPdfWidget() => PDFView(
        filePath: path,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: true,
        pageSnap: true,
        fitPolicy: FitPolicy.BOTH,
        preventLinkNavigation:
            false, // if set to true the link is handled in flutter
      );
}
