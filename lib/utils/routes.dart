import 'package:get/get.dart';
import 'package:shit_grabber/bindings/base_binding.dart';
import 'package:shit_grabber/bindings/dashboard_binding.dart';
import 'package:shit_grabber/bindings/file_preview_binding.dart';
import 'package:shit_grabber/screens/dashboard/dashboard_screen.dart';
import 'package:shit_grabber/screens/file_preview/file_preview_screen.dart';
import 'package:shit_grabber/screens/home/home_screen.dart';

class Routes {
  static const String homeRoute = '/home';
  static const String dashboardRoute = '/dashboard';
  static const String filePreviewRoute = '/filePreview';

  static final routes = [
    GetPage(
      name: homeRoute,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: dashboardRoute,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: '$filePreviewRoute/:documentModel',
      page: () => FilePreviewScreen(),
      binding: FilePreviewBinding(),
    ),
  ];
}
