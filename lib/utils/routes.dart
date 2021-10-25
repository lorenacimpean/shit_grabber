import 'package:get/get.dart';
import 'package:shit_grabber/bindings/dashboard_binding.dart';
import 'package:shit_grabber/bindings/file_preview_binding.dart';
import 'package:shit_grabber/bindings/home_binding.dart';
import 'package:shit_grabber/bindings/qr_code_binding.dart';
import 'package:shit_grabber/bindings/take_picture_binding.dart';
import 'package:shit_grabber/screens/camera/take_picture_screen.dart';
import 'package:shit_grabber/screens/dashboard/dashboard_screen.dart';
import 'package:shit_grabber/screens/file_preview/file_preview_screen.dart';
import 'package:shit_grabber/screens/home/home_screen.dart';
import 'package:shit_grabber/screens/qr/qr_screen.dart';


class Routes {
  static const String homeRoute = '/home';
  static const String dashboardRoute = '/dashboard';
  static const String filePreviewRoute = '/filePreview';
  static const String cameraRoute = '/camera';
  static const String qrCode = '/qrCode';

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
      name: cameraRoute,
      page: () => TakePictureScreen(),
      binding: TakePictureBinding(),
    ),
    GetPage(
      name: '$filePreviewRoute/:documentModel',
      page: () => FilePreviewScreen(),
      binding: FilePreviewBinding(),
    ),
    GetPage(
      name: qrCode,
      page: () => QrScreen(),
      binding: QrCodeBinding(),
    ),
  ];
}
