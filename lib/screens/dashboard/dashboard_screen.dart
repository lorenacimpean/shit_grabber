import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
            itemCount: controller.documents.length,
            itemBuilder: (context, index) => DocumentCard(
              title: controller.documents[index].name,
              onDelete: () {
                controller.deleteDocument(controller.documents[index].name);
              },
              //TODO: check if can edit document name
              onEdit: () => print('Tapped edit'),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.opaqueGreen,
        child: Icon(
          CupertinoIcons.add_circled_solid,
          color: AppColors.opaqueBlack,
        ),
        onPressed: () {
          controller.addDocuments();
        },
      ),
    );
  }
}
