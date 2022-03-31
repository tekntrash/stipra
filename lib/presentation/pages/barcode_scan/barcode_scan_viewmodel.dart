import 'package:flutter/material.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/platform/network_info.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';

import '../../../core/services/scanned_video_service.dart';
import '../../../data/models/barcode_timestamp_model.dart';
import '../../../data/models/scanned_video_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../domain/repositories/remote_data_repository.dart';
import '../../../injection_container.dart';
import '../../widgets/overlay/lock_overlay.dart';
import 'widgets/video_box.dart';

class BarcodeScanViewModel extends BaseViewModel {
  final int _maxRecordTime = 60;
  final int _countDownTime = 3;
  MobileScannerController? cameraController;
  late BuildContext _context;
  bool? isStarted;
  String? videoName;
  late List<BarcodeTimeStampModel> barcodeTimeStamps;
  late ValueNotifier<int> timeDuration;
  late ValueNotifier<int> countDownDuration;

  void init(BuildContext context) async {
    _context = context;
    timeDuration = ValueNotifier<int>(_maxRecordTime);
    countDownDuration = ValueNotifier<int>(_countDownTime);
    barcodeTimeStamps = [];

    await requestPermissions();
  }

  void countDownTimer() async {
    if (countDownDuration.value > 0) {
      await Future.delayed(Duration(seconds: 1));
      countDownDuration.value--;
      countDownTimer();
    } else {
      if (disposed) return;
      videoName = 'scanned_$timeStamp';
      isStarted = await FlutterScreenRecording.startRecordScreen(
        videoName!,
      );
      if (isStarted == true) {
        timerListener();
      }
      notifyListeners();
    }
  }

  timerListener() async {
    if (isStarted != true) {
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

  requestPermissions() async {
    if (await Permission.camera.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }
    cameraController = MobileScannerController();

    if (await Permission.storage.request().isGranted) {
      //
      print('Record started $isStarted');
    }
    if (await Permission.manageExternalStorage.request().isGranted) {
      //
      print('Record started $isStarted');
    }
    notifyListeners();
    countDownTimer();
  }

  Future<void> startCapture() async {
    if (isStarted == true) {
      return;
    }
    if (await Permission.camera.request().isGranted) {
      timeDuration.value = _maxRecordTime;
      videoName = 'scanned_$timeStamp';
      isStarted = await FlutterScreenRecording.startRecordScreen(
        videoName!,
      );
      if (isStarted == true) {
        timerListener();
      }
      notifyListeners();
    } else {
      //Handle permission denied for camera, ask user to enable it from settings?
    }
  }

  String get timeStamp => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> stopCapture(BuildContext context, {bool pop: false}) async {
    final _lastStart = isStarted;
    isStarted = false;
    if (_lastStart == true) {
      LockOverlay().showClassicLoadingOverlay(buildAfterRebuild: true);
      final path = await FlutterScreenRecording.stopRecordScreen;
      locator<LocalDataRepository>().saveScannedVideo(
        ScannedVideoModel(
          timeStamp: int.parse(timeStamp),
          videoPath: path,
          isUploaded: false,
          barcodeTimeStamps: barcodeTimeStamps,
        ),
      );
      final isConnected = await locator<NetworkInfo>().isConnected;
      if (isConnected) {
        await _sendVideoAndBarcodes(path);
      }
      LockOverlay().closeOverlay();
      Navigator.of(context).pop();
    } else {
      if (pop) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> _sendVideoAndBarcodes(String path) async {
    final location = await locator<ScannedVideoService>()
        .getLocationWithPermRequest(onRequestGranted: () {
      _sendVideoAndBarcodes(path);
    });
    if (location == null) {
      return;
    }
    barcodeTimeStamps.forEach((element) {
      locator<DataRepository>().sendBarcode(
        element.barcode,
        element.videoName,
        location[0],
        location[1],
      );
    });

    final bool? isUploaded =
        await locator<RemoteDataRepository>().sendScannedVideo(
      path,
    );
    if (isUploaded == true) {
      locator<LocalDataRepository>().updateIsUploaded(path, true);
    }
  }

  Future<void> onDetect(Barcode barcode, MobileScannerArguments? args) async {
    if (isStarted != true) {
      return;
    }
    final String? code = barcode.rawValue;
    if (code != null) {
      if (barcodeTimeStamps.any((element) => element.barcode == code)) {
        return;
      }
      barcodeTimeStamps.add(
        BarcodeTimeStampModel(
            timeStamp: timeStamp, barcode: code, videoName: videoName!),
      );
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
        content: Text('Product found! Show next one please'),
        duration: Duration(seconds: 3),
      ));
      debugPrint('Barcode found! $code sent');
    }
    await Future.delayed(Duration(seconds: 1));
  }
}
