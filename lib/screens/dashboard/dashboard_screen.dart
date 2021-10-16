import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/controllers/dashboard_controller.dart';
import 'package:shit_grabber/screens/dashboard/document_card.dart';
import 'package:shit_grabber/themes/app_colors.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.gradientWithOpacity,
        ),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.documentTitles.value.length,
            itemBuilder: (context, index) => DocumentCard(
              title: controller.documentTitles.value[index],
              onDelete: () => print('Tapped delete'),
              onEdit: () => print('Tapped edit'),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.tertiary,
        child: Icon(
          CupertinoIcons.add_circled_solid,
          color: AppColors.opaqueBlack,
        ),
        onPressed: () {},
      ),
    );
  }
}
