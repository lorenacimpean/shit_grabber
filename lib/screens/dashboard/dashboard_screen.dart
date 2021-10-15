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
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.gradient,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.documentTitles.length,
        itemBuilder: (context, index) => DocumentCard(
          title: controller.documentTitles[index],
        ),
      ),
    );
  }
}
