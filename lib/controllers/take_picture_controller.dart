import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/repo/api_keys.dart';
import 'package:shit_grabber/repo/camera_repo.dart';
import 'package:shit_grabber/repo/shared_pref_repo.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

class TakePictureController extends SubscriptionState<TakePictureController> {
  late CameraController cameraController;
  late List<CameraDescription> _cameras;
  late SharedPrefRepo _sharedPrefRepo;
  late CameraRepo _cameraRepo;

  @override
  void onInit() {
    super.onInit();
    _sharedPrefRepo = Get.find<SharedPrefRepo>();
    _cameraRepo = Get.find<CameraRepo>();
    getCameraList();
    initCameraController();
  }

  void getCameraList() => disposeLater(_cameraRepo.cameras.listen((list) {
        change(null, status: RxStatus.loading());
        _cameras = list;
      }));

  void initCameraController() {
    CameraController crtl = CameraController(
      _cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    cameraController = crtl;
    disposeLater(_cameraRepo.initCameraController(crtl).listen((_) {
      change(cameraController, status: RxStatus.success());
    }));
  }

  void snapPhoto() => disposeLater(
        _cameraRepo.takePicture(cameraController).listen((documentModel) {
          _sharedPrefRepo.addStringsToList(
            ApiKeys.documentList,
            [jsonEncode(documentModel)],
          );
        }),
      );
}
