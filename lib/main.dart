import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/bindings/base_binding.dart';
import 'package:shit_grabber/bindings/dashboard_binding.dart';
import 'package:shit_grabber/themes/app_theme.dart';
import 'package:shit_grabber/utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HomeBinding().dependencies();
  DashboardBinding().dependencies();
  runApp(const ShitGrabberApp());
}

class ShitGrabberApp extends StatelessWidget {
  const ShitGrabberApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Document grabber app',
      theme: AppTheme().appThemeDark(context),
      getPages: Routes.routes,
      initialRoute: '/home',
    );
  }
}
