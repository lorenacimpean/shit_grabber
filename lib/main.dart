import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/bindings/home_binding.dart';
import 'package:shit_grabber/themes/app_theme.dart';
import 'package:shit_grabber/utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HomeBinding().dependencies();
  runApp(ShitGrabberApp());
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
      initialRoute: Routes.homeRoute,
      initialBinding: HomeBinding(),
      transitionDuration: Duration(milliseconds: 200),
      defaultTransition: Transition.cupertino,
      enableLog: true,
    );
  }
}
