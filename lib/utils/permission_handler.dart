import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shit_grabber/themes/app_strings.dart';
import 'package:shit_grabber/widgets/app_dialog.dart';

mixin PermissionHandler {
  Stream<PermissionStatus> hasPermission(Permission permission) {
    return permission.status.asStream();
  }

  Stream<PermissionStatus> requestPermission(Permission permission) {
    return permission.request().asStream();
  }

  Stream<bool> handleStoragePermission() {
    return hasPermission(Permission.storage).flatMap((permissionStatus) {
      if (permissionGrantedList.contains(permissionStatus)) {
        return Stream.value(true);
      } else {
        AppDialog(
          title: AppStrings.storagePermission,
          contentText: AppStrings.goToSettings,
          onCancel: () {
            Navigator.of(Get.overlayContext!).pop();
          },
          onConfirm: openAppSettings,
        ).showDialog();
        return Stream.value(false);
      }
    });
  }

  List<PermissionStatus> permissionGrantedList = [
    PermissionStatus.granted,
    PermissionStatus.limited,
  ];
}
