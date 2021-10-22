import 'package:camera/camera.dart';
import 'package:shit_grabber/models/document_model.dart';

class CameraRepo {
  Stream<List<CameraDescription>> get cameras => availableCameras().asStream();

  Stream<void> initCameraController(CameraController cameraController) =>
      cameraController.initialize().asStream();

  Stream<DocumentModel> takePicture(CameraController cameraController) =>
      cameraController.takePicture().asStream().map(
            (file) => DocumentModel(
              name: file.name,
              path: file.path,
              lastModified: DateTime.now(),
            ),
          );
}
