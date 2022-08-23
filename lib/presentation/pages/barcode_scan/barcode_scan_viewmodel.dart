import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:google_mlkit_barcode_scanning/barcode_scanner.dart';
import 'package:google_mlkit_commons/commons.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import '../../../core/platform/network_info.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../core/utils/router/app_router.dart';
import '../../../data/datasources/hive_data_source.dart';
import 'widgets/barcode_detector_painter.dart';
import '../sign/enter_phone_number_page/enter_phone_number_page.dart';
import '../../widgets/overlay/lock_overlay_dialog.dart';
import '../../widgets/overlay/snackbar_overlay.dart';
import '../../widgets/overlay/widgets/save_video_dialog.dart';
import '../../../shared/app_theme.dart';

import '../../../core/services/scanned_video_service.dart';
import '../../../data/models/barcode_timestamp_model.dart';
import '../../../data/models/scanned_video_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../domain/repositories/remote_data_repository.dart';
import '../../../injection_container.dart';
import '../../widgets/overlay/lock_overlay.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

/// Barcode Scanner Controller for control flow of barcode to identify and save
/// videos
/// Also supports max barcode length and find barcode parameters
/// Max barcode length is for maximum barcode per scan
/// And findbarcode parameter is for specific barcode scan to find only scan the specific barcode that given
class BarcodeScanViewModel extends BaseViewModel {
  int? maxBarcodeLength;
  String? findBarcode;
  BarcodeScanViewModel({
    this.maxBarcodeLength,
    this.findBarcode,
  });

  /// Create parameters that will be used in this controller and UI
  CameraController? controller;
  int _cameraIndex = 0;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
  List<CameraDescription> cameras = [];
  late bool isStopped;

  BarcodeScanner barcodeScanner = BarcodeScanner();
  CustomPaint? customPaint;

  final int _maxRecordTime = 60;
  final int _countDownTime = 3;
  late BuildContext _context;
  bool? isStarted;
  late List<BarcodeTimeStampModel> barcodeTimeStamps;
  late ValueNotifier<int> timeDuration;
  late ValueNotifier<int> countDownDuration;

  /// Init controller with default parameters and get cameras list
  /// Reuqest a permission for camera
  void init(BuildContext context) async {
    _context = context;
    isStopped = false;
    timeDuration = ValueNotifier<int>(_maxRecordTime);
    countDownDuration = ValueNotifier<int>(_countDownTime);
    barcodeTimeStamps = [];

    cameras = await availableCameras();
    await requestPermissions();
  }

  /// Countdown when the screen opens and start the camera after
  void countDownTimer() async {
    if (countDownDuration.value > 0) {
      await Future.delayed(Duration(seconds: 1));
      countDownDuration.value--;
      countDownTimer();
    } else {
      if (disposed || isStopped) return;
      await startCapture();
      notifyListeners();
    }
  }

  /// Listen the duration of the video if reaches 0 then stop the video
  timerListener() async {
    if (isStarted != true || isStopped) {
      return;
    }
    await Future.delayed(Duration(seconds: 1));
    timeDuration.value -= 1;
    if (timeDuration.value == 0) {
      stopCapture(_context);
    } else {
      timerListener();
    }
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

    if (await Permission.storage.request().isGranted) {}
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

    notifyListeners();
    countDownTimer();
  }

  /// Start capture to scan barcodes and record
  Future startCapture() async {
    if (disposed) {
      return;
    }
    isStopped = false;
    isStarted = true;
    timeDuration.value = _maxRecordTime;
    /*controller?.getMinZoomLevel().then((value) {
      zoomLevel = value;
      minZoomLevel = value;
    });
    controller?.getMaxZoomLevel().then((value) {
      maxZoomLevel = value;
    });*/
    await controller?.startImageStream(_processCameraImage);
    await controller?.startVideoRecording();
    timerListener();
    notifyListeners();
  }

  /// Get the date timestamp for current time
  String get timeStamp => DateTime.now().millisecondsSinceEpoch.toString();

  /// Stop the video recording and barcode identify
  /// If pop is true show a dialog for 'Save Video' or 'Cancel'
  /// then if pop is false save the video
  /// Save the video to local storage with path and barcodes that identified
  Future<void> stopCapture(BuildContext context, {bool pop: false}) async {
    if (disposed || isStopped) {
      return;
    }
    isStopped = true;
    log('Is stopped: $isStopped and is started: $isStarted');
    if (isStarted != true) {
      Navigator.of(context).pop();
      return;
    }
    LockOverlay().showClassicLoadingOverlay(buildAfterRebuild: true);
    if (controller == null || (controller?.value.isRecordingVideo != true))
      return;

    await controller?.stopImageStream();
    await Future.delayed(Duration(milliseconds: 100));
    showSnackbarForInformation(context);
    XFile? originalFileVideo = await controller?.stopVideoRecording();

    var isExit = false;
    if (pop) {
      LockOverlay().closeOverlay();
      isExit = await showExitOrSaveDialog();
    }
    if (!isExit) {
      saveScannedVideosAndTryUpload(originalFileVideo, context);
    }

    await controller?.dispose();
    controller = null;
    LockOverlay().closeOverlay();
    Navigator.of(context).pop();

    return;
  }

  void saveScannedVideosAndTryUpload(
      XFile? originalFileVideo, BuildContext context) async {
    final location = await locator<ScannedVideoService>()
        .getLocationWithPermRequest(onRequestGranted: () {
      saveScannedVideosAndTryUpload(originalFileVideo, context);
    });
    if (location == null) {
      SnackbarOverlay().show(
        text: 'To upload these videos please enable location.',
        buttonText: 'OK',
        removeDuration: Duration(seconds: 5),
      );
      return;
    }

    final _timeStamp = timeStamp;

    final fileVideo = changeFileNameOnlySync(
      File(originalFileVideo!.path),
      '$_timeStamp${locator<LocalDataRepository>().getUser().alogin}.mp4',
    );

    locator<LocalDataRepository>().saveScannedVideo(
      ScannedVideoModel(
        timeStamp: int.parse(_timeStamp),
        videoPath: fileVideo.path,
        isUploaded: false,
        barcodeTimeStamps: barcodeTimeStamps,
        location: location,
      ),
    );
    final isConnectedForUpload =
        await locator<NetworkInfo>().isConnectedForUpload;
    log('isConnectedForUpload $isConnectedForUpload');
    if (isConnectedForUpload) {
      _sendVideoAndBarcodes(
        fileVideo.path,
        _timeStamp,
        location,
      );
    }
    log('Video saved to ${fileVideo.path}');
  }

  /// When user click exit button shows this dialog for 'Save Video' or 'Cancel'
  Future<bool> showExitOrSaveDialog() async {
    return await showDialog(
      context: _context,
      builder: (contextdialog) {
        return SaveVideoDialog(
          button1Text: 'Save',
          onButton1Tap: () {
            Navigator.of(contextdialog).pop(false);
          },
          button2Text: 'Exit',
          onButton2Tap: () {
            Navigator.of(contextdialog).pop(true);
          },
        );
      },
    );
  }

  /// Change file name with pattern for video names we use
  File changeFileNameOnlySync(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.renameSync(newPath);
  }

  /// Show a dialog component after video recorded
  /// If logged shows will be analyzed
  /// If not logged shows you need to log in
  void showSnackbarForInformation(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (locator<LocalDataRepository>().getUser().alogin != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppTheme().blackColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'Thank you! Video will be sent and analyzed and you will receive an email with your points.',
            style: AppTheme().extraSmallParagraphRegularText,
          ),
        ),
      );
    } else {
      SnackbarOverlay().show(
        addFrameCallback: true,
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppNavigator.push(
              context: AppRouter().mainNavigatorKey!.currentState!.context,
              child: EnterPhoneNumberScreen(isSignIn: true),
            );
          });
          SnackbarOverlay().closeCustomOverlay();
        },
        text: 'Thank you for receive points, you need to log in.',
        buttonText: 'LOGIN',
      );
      Future.delayed(Duration(seconds: 8))
          .then((value) => SnackbarOverlay().closeCustomOverlay());
    }
    /*SnackbarOverlayTop().show(
      addFrameCallback: true,
      onTap: () {
        SnackbarOverlayTop().closeCustomOverlay();
      },
      text:
          'New featured offers available, do you want to see them? Check it out.',
      alignment: Alignment.topCenter,
      removeDuration: Duration(seconds: 10),
    );*/
  }

  /// Send the video and barcodes to server with location
  Future<void> _sendVideoAndBarcodes(
      String path, String _timestamp, List<double> location) async {
    barcodeTimeStamps.forEach((element) {
      locator<DataRepository>().sendBarcode(
        element.barcode,
        element.timeStamp,
        path,
        location[0],
        location[1],
      );
    });

    final dateFormat = DateFormat('dd-MM-yy')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(_timestamp)));

    final bool? isUploaded =
        await locator<RemoteDataRepository>().sendScannedVideo(
      path,
      dateFormat,
      location[0],
      location[1],
    );
    if (isUploaded == true) {
      locator<LocalDataRepository>().updateIsUploaded(path, true);
    }
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
    if (isBusy || isStopped) return;
    if ((maxBarcodeLength ?? 0) <= barcodeTimeStamps.length) return;
    isBusy = true;
    final barcodes = await barcodeScanner.processImage(inputImage);
    log('Found ${barcodes.length} barcodes');

    if (isStarted != true) {
      return;
    }
    for (final barcode in barcodes) {
      final String? code = barcode.value.rawValue;
      if (code != null) {
        final isSearchingBarcodeFound = (code == findBarcode);
        final isSearchingBarcode = findBarcode != null;
        if (barcodeTimeStamps.any((element) => element.barcode == code) ||
            (isSearchingBarcode && !isSearchingBarcodeFound)) {
          isBusy = false;
          if (!disposed) {
            notifyListeners();
          }
          return;
        }
        barcodeTimeStamps.add(
          BarcodeTimeStampModel(
            timeStamp: timeStamp,
            barcode: code,
          ),
        );
        Vibrate.feedback(FeedbackType.light);
        ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
          content: Text('Product found! Show next one please'),
          duration: Duration(seconds: 3),
        ));
        if ((maxBarcodeLength ?? 0) <= barcodeTimeStamps.length) {
          stopCapture(_context);
        }
        log('Barcode found! $code sent');
      }
    }

    /*if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = BarcodeDetectorPainter(
          barcodes,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }*/
    isBusy = false;
    if (!disposed) {
      notifyListeners();
    }
  }

  /// Dispose controller for prevent performance issue
  @override
  void dispose() {
    controller?.dispose();
    if (disposed) return;
    super.dispose();
  }
}
