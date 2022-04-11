import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/services/image_service.dart';
import 'package:stipra/core/utils/time_converter/time_converter.dart';

class TakePictureViewModel extends BaseViewModel {
  IconData getCameraLensIcon(CameraLensDirection direction) {
    return Icons.flip_camera_ios;
  }

  String? imagePath;
  FlashMode flashMode = FlashMode.off;
  double prevZoom = 1;
  List<CameraDescription> cameraDescriptionList = [];
  CameraController? customCameraController;
  bool isbackCamera = true;
  double startPointOfVideoRecord = 0;

  void onTakePictureButtonPressed(BuildContext context) {
    takePicture().then((String? filePath) {
      if (!disposed) {
        imagePath = filePath ?? '';

        if (filePath != null) {
          Navigator.pop(context, File(imagePath!));
        }
      }
    });
  }

  Future<String?> takePicture() async {
    if (!(customCameraController?.value.isInitialized == true)) {
      return null;
    }

    if ((customCameraController?.value.isTakingPicture == true)) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final xfile = await customCameraController?.takePicture();

      var image = await ImageService.fixExifRotation(File(xfile!.path),
          deleteOriginal: true);

      return image.path;
    } catch (e) {
      return null;
    }
  }

  Future<File> changeFileNameOnly(File file, String newFileName) async {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }

  void flipCamera() {
    if (isbackCamera) {
      isbackCamera = false;
      onNewCameraSelected(cameraDescriptionList[1]);
    } else {
      isbackCamera = true;
      onNewCameraSelected(cameraDescriptionList[0]);
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (customCameraController != null) {
      await customCameraController?.dispose();
    }

    customCameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    customCameraController?.addListener(() {
      if (!disposed) notifyListeners();
    });

    try {
      await customCameraController?.initialize();
    } catch (e) {}

    if (!disposed) notifyListeners();
  }

  Future<void> changeFlashMode() async {
    if (flashMode == FlashMode.off || flashMode == FlashMode.torch) {
      flashMode = FlashMode.always;
    } else if (flashMode == FlashMode.always) {
      flashMode = FlashMode.auto;
    } else {
      flashMode = FlashMode.off;
    }
    await customCameraController?.setFlashMode(flashMode);

    notifyListeners();
  }
}