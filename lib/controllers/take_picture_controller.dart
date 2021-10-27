import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/models/document_model.dart';
import 'package:shit_grabber/repo/api_keys.dart';
import 'package:shit_grabber/repo/camera_repo.dart';
import 'package:shit_grabber/repo/shared_pref_repo.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

class TakePictureController extends SubscriptionState<TakePictureController> {
  late Rx<CameraController> cameraController;
  late SharedPrefRepo _sharedPrefRepo;
  late CameraRepo _cameraRepo;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading());
    _sharedPrefRepo = Get.find<SharedPrefRepo>();
    _cameraRepo = Get.find<CameraRepo>();
    disposeLater(
      _cameraRepo.cameras.listen((list) {
        cameraController = Rx(
          CameraController(
            list.first,
            ResolutionPreset.medium,
            enableAudio: false,
            imageFormatGroup: ImageFormatGroup.jpeg,
          ),
        );
        initCameraController();
      })
        ..onError(
            (error) => change(error, status: RxStatus.error(error.toString()))),
    );
  }

  void initCameraController() {
    disposeLater(
      _cameraRepo.initCameraController(cameraController.value).listen((_) {
        disposeLater(
            _cameraRepo.disableFlash(cameraController.value).listen((_) {}));
        change(cameraController.value, status: RxStatus.success());
      })
        ..onError((error) {
          if (error is CameraException) {
            change(error, status: RxStatus.error(error.description));
          } else {
            change(error, status: RxStatus.error(error.toString()));
          }
        }),
    );
  }

  void snapPhoto() {
    change(null, status: RxStatus.loading());
    disposeLater(
      _cameraRepo.takePicture(cameraController.value).listen((documentModel) {
        saveToSharedPref(documentModel);
      })
        ..onError((error) {
          change(error, status: RxStatus.error(error.toString()));
        }),
    );
    change(cameraController.value, status: RxStatus.success());
  }

  void saveToSharedPref(DocumentModel documentModel) {
    disposeLater(_sharedPrefRepo.addStringsToList(
      ApiKeys.documentList,
      [jsonEncode(documentModel)],
    ).listen((_) {})
      ..onError(
          (error) => change(error, status: RxStatus.error(error.toString()))));
  }

  @override
  void onClose() {
    super.onClose();
    cameraController.value.dispose();
  }
}
