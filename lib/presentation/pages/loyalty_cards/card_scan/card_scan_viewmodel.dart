import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:google_mlkit_barcode_scanning/barcode_scanner.dart';
import 'package:google_mlkit_commons/commons.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/services/validator_service.dart';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:stipra/presentation/pages/loyalty_cards/data/enums/card_brand_enum.dart';
import 'package:stipra/presentation/pages/loyalty_cards/data/models/custom_credit_card_model.dart';

import 'widgets/barcode_detector_painter.dart';

/// Barcode Scanner Controller for control flow of barcode to identify and save
/// videos
/// Also supports max barcode length and find barcode parameters
/// Max barcode length is for maximum barcode per scan
/// And findbarcode parameter is for specific barcode scan to find only scan the specific barcode that given
class LoyaltyCardScanViewModel extends BaseViewModel {
  String? findName;
  LoyaltyCardScanViewModel({
    this.findName,
  });

  /// Create parameters that will be used in this controller and UI
  CameraController? controller;
  int _cameraIndex = 0;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
  List<CameraDescription> cameras = [];

  TextRecognizer textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);
  CustomPaint? customPaint;
  late CustomCreditCardModel cardModel;
  late BuildContext _context;

  /// Init controller with default parameters and get cameras list
  /// Reuqest a permission for camera
  void init(BuildContext context) async {
    _context = context;
    cardModel = CustomCreditCardModel();
    cameras = await availableCameras();
    await requestPermissions();
  }

  /// Request permission for camera and storage
  /// Get the back camera first if exists if not get the any camera
  /// Start the countDownTimer for camera start
  requestPermissions() async {
    final camera = cameras[_cameraIndex];
    controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    if (await Permission.camera.request().isGranted) {}

    await controller?.initialize();
    controller?.setFlashMode(FlashMode.off);
    if (cameras.any(
      (element) =>
          element.lensDirection == CameraLensDirection.back &&
          element.sensorOrientation == 90,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) =>
            element.lensDirection == CameraLensDirection.back &&
            element.sensorOrientation == 90),
      );
    } else {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.back,
          orElse: () => cameras.first,
        ),
      );
    }

    startCapture();
    notifyListeners();
  }

  /// Start capture to scan barcodes and record
  Future startCapture() async {
    await controller?.startImageStream(_processCameraImage);
    notifyListeners();
  }

  /// Stop the video recording and barcode identify
  /// If pop is true show a dialog for 'Save Video' or 'Cancel'
  /// then if pop is false save the video
  /// Save the video to local storage with path and barcodes that identified
  Future<void> stopCapture(BuildContext context, {bool pop: false}) async {
    if (controller == null) return;
    await controller?.stopImageStream();
    await controller?.dispose();
    await textRecognizer.close();
    controller = null;
    Navigator.of(context).pop(
      cardModel,
    );
    return;
  }

  /// Process the image of camera and send it to identify for barcodes
  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.rotation0deg;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.nv21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    processImage(inputImage);
  }

  /// Identify the barcode if exists with barcode scanner plugin
  /// If barcode exists add it to list of barcodes and vibrate the device
  /// Show a dialog when found
  bool isBusy = false;
  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;

    isBusy = true;
    final recognizedText = await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    //dev.log('----------------');
    for (int block = 0; block < recognizedText.blocks.length; block++) {
      /*final Rect rect = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;*/
      TextBlock blockText = recognizedText.blocks[block];
      for (int index = 0; index < blockText.lines.length; index++) {
        checkCardInfo(blockText.lines[index], block);
      }
    }
    if (cardModel.cardHolderName?.isNotEmpty == true &&
        cardModel.cardIssuerName?.isNotEmpty == true &&
        cardModel.cardNumber?.isNotEmpty == true &&
        cardModel.expiryDate?.isNotEmpty == true) {
      Navigator.of(_context).pop(
        cardModel,
      );
    }

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = BarcodeDetectorPainter(
          recognizedText.blocks,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (!disposed) {
      notifyListeners();
    }
  }

  void checkCardInfo(TextLine line, int blockIndex) {
    if (isCardNumber(line.text)) {
      //dev.log('Card Number: ${line.text}');
      cardModel.cardNumber = line.text;
    } else if (isExpireDate(line.text)) {
      //dev.log('Expire Date: ${line.text}');
      cardModel.expiryDate = line.text;
    } else if (line.text.toLowerCase().contains('card') &&
        line.text.toLowerCase().contains('hol')) {
      //dev.log('line: ${line.text}');
    } else if (line.text.toLowerCase().contains('thru') &&
        line.text.toLowerCase().contains('val')) {
      //dev.log('line: ${line.text}');
    } else if (blockIndex < 2) {
      CardBrands.values.forEach((element) {
        if (line.text.toLowerCase() == element.lowerName) {
          //dev.log('Card issuer: ${line.text}');
          cardModel.cardIssuerName = line.text;
        }
      });
    } else {
      //dev.log('Name: ${line.text}');
      cardModel.cardHolderName = line.text;
    }
  }

  bool isCardNumber(String line) {
    //await Future.delayed(Duration(milliseconds: 250));

    String pattern = r'(^(?:[+0]9)?[0-9\ ]{8,30}$)';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(line)) {
      return false;
    }
    return true;
  }

  bool isExpireDate(String line) {
    //await Future.delayed(Duration(milliseconds: 250));

    String pattern = r'(^(?:[+0]9)?[0-9\ \/]{4,6}$)';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(line)) {
      return false;
    }
    return true;
  }

  bool isName(String line) {
    //await Future.delayed(Duration(milliseconds: 250));

    String pattern = r'(^(?:[+0]9)?[0-9\ \/]{4,6}$)';
    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(line)) {
      return false;
    }
    return true;
  }

  /// Dispose controller for prevent performance issue
  @override
  void dispose() {
    controller?.dispose();
    if (disposed) return;
    super.dispose();
  }
}
