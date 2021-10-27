import 'package:camera/camera.dart';
import 'package:shit_grabber/models/document_model.dart';

class CameraRepo {
  static final Duration _tapDelay = Duration(milliseconds: 200);

  Stream<List<CameraDescription>> get cameras => availableCameras().asStream();

  Stream<void> initCameraController(CameraController cameraController) {
    print('$cameraController');
    return cameraController.initialize().asStream();
  }

  Stream<void> disableFlash(CameraController cameraController) {
    return cameraController.setFlashMode(FlashMode.off).asStream();
  }

  Stream<DocumentModel> takePicture(CameraController cameraController) {
    return Stream.fromFuture(cameraController.takePicture()).map(
      (file) => DocumentModel(
        name: file.name,
        path: file.path,
        lastModified: DateTime.now(),
      ),
    );
  }
}
