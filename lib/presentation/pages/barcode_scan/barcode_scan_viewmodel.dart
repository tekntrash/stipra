import 'package:flutter/material.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/platform/network_info.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';

import '../../../data/models/barcode_timestamp_model.dart';
import '../../../data/models/scanned_video_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../domain/repositories/remote_data_repository.dart';
import '../../../injection_container.dart';
import '../../widgets/overlay/lock_overlay.dart';
import 'widgets/video_box.dart';

class BarcodeScanViewModel extends BaseViewModel {
  late MobileScannerController cameraController;
  late bool? isStarted;
  late List<BarcodeTimeStampModel> barcodeTimeStamps;

  void init() {
    isStarted = false;
    barcodeTimeStamps = [];
    cameraController = MobileScannerController();

    requestPermissions();
  }

  requestPermissions() async {
    if (await Permission.camera.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }

    if (await Permission.storage.request().isGranted) {
      //
      print('Record started $isStarted');
    }
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 3));
      if (disposed) return;
      isStarted = await FlutterScreenRecording.startRecordScreen(
        'scanned_$timeStamp',
      );
    });
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
        barcodeTimeStamps.forEach((element) {
          locator<DataRepository>().sendBarcode(element.timeStamp);
        });

        final bool? isUploaded =
            await locator<RemoteDataRepository>().sendScannedVideo(
          path,
        );
        if (isUploaded == true) {
          locator<LocalDataRepository>().updateIsUploaded(path, true);
        }
      }
      LockOverlay().closeOverlay();
      AppNavigator.pushReplacement(
        context: context,
        child: VideoBox(path, barcodeTimeStamps),
      );
    } else {
      if (pop) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> onDetect(Barcode barcode, MobileScannerArguments? args) async {
    if (isStarted != true) {
      return;
    }
    final String? code = barcode.rawValue;
    if (code != null) {
      barcodeTimeStamps.add(
        BarcodeTimeStampModel(
          timeStamp: timeStamp,
          barcode: code,
        ),
      );
      debugPrint('Barcode found! $code sent');
    }
    await Future.delayed(Duration(seconds: 1));
  }
}
