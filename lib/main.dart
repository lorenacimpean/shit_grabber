import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/bindings/base_binding.dart';
import 'package:shit_grabber/bindings/dashboard_binding.dart';
import 'package:shit_grabber/screens/dashboard/dashboard_screen.dart';
import 'package:shit_grabber/screens/home/home_screen.dart';
import 'package:shit_grabber/themes/app_theme.dart';

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
      getPages: [
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/dashboard',
          page: () => const DashboardScreen(),
          binding: DashboardBinding(),
        ),
      ],
      initialRoute: '/home',
    );
  }
}
