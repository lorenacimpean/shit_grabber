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


  //TODO: check hot to dispose camera and acheck what happens at resume
  // might need to use lifecycle mixin to handle this
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading());
    _sharedPrefRepo = Get.find<SharedPrefRepo>();
    _cameraRepo = Get.find<CameraRepo>();

    disposeLater(
      _cameraRepo.cameras.listen((list) {
        cameraController = Rx(CameraController(
          list.first,
          ResolutionPreset.medium,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
        ));
        initCameraController();
      })
        ..onError((error) => change(RxStatus.error(error))),
    );
  }

  void initCameraController() {
    disposeLater(
      _cameraRepo.initCameraController(cameraController.value).listen((_) {
        change(cameraController, status: RxStatus.success());
      })
        ..onError((error) => change(RxStatus.error(error))),
    );
  }

  void snapPhoto() => disposeLater(
        _cameraRepo.takePicture(cameraController.value).listen((documentModel) {
          saveToSharedPref(documentModel);
        }),
      );

  void saveToSharedPref(DocumentModel documentModel) {
    disposeLater(_sharedPrefRepo.addStringsToList(
      ApiKeys.documentList,
      [jsonEncode(documentModel)],
    ).listen((_) {}));
  }
}
