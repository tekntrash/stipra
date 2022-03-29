import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:stipra/core/errors/failure.dart';
import 'package:stipra/presentation/widgets/scanned_video/upload_inform_box.dart';

import '../../data/models/scanned_video_model.dart';
import '../../domain/repositories/data_repository.dart';
import '../../domain/repositories/local_data_repository.dart';
import '../../injection_container.dart';
import '../../presentation/widgets/overlay/lock_overlay_dialog.dart';
import '../platform/network_info.dart';

class ScannedVideoService {
  bool _waitForConnection = true;

  listenInternetForInformation() {
    locator<NetworkInfo>().onInternetChange(
      onConnect: () {
        log('Internet is connected');
        if (_waitForConnection) {
          _waitForConnection = false;
          informAboutUploadedVideo();
        }
      },
      onDisconnect: () {
        log('Internet is disconnected');
        _waitForConnection = true;
      },
    );
  }

  Future<void> informAboutUploadedVideo() async {
    final dataRepository = locator<LocalDataRepository>();
    bool isNeedUpload = false;
    List<ScannedVideoModel> scannedVideos =
        await dataRepository.getScannedVideos().then((scannedVideos) {
      scannedVideos.forEach((scannedVideo) {
        if (scannedVideo.isUploaded != true) {
          isNeedUpload = true;
          log('video is not uploaded path: ${scannedVideo.videoPath}');
        }
      });
      return scannedVideos;
    });
    final unUploadedScannedVideos = scannedVideos.where((scannedVideo) {
      return scannedVideo.isUploaded != true;
    }).toList();
    final isConnected = await locator<NetworkInfo>().isConnected;
    if (isNeedUpload && isConnected) {
      log('informAboutUploadedVideo: true');
      LockOverlayDialog().showCustomOverlay(
        child: UploadInformBox(
          onTapUpload: () {
            uploadScannedVideos(unUploadedScannedVideos);
          },
        ),
      );
    }
  }

  Future<void> uploadScannedVideos(
      List<ScannedVideoModel> scannedVideos) async {
    final dataRepository = locator<DataRepository>();
    var futureList = List.from(scannedVideos)
        .map<Future<Either<Failure, bool>>>((scannedVideo) async {
      final barcodeTimeStamps =
          (scannedVideo as ScannedVideoModel).barcodeTimeStamps;
      final path = (scannedVideo as ScannedVideoModel).videoPath;
      final isExists = await File(path).exists();
      if (isExists) {
        Future.wait(barcodeTimeStamps.map((barcodeTimeStamp) async {
          await locator<DataRepository>().sendBarcode(barcodeTimeStamp.barcode);
        }));
        final data = await dataRepository.sendScannedVideo(path);
        if (data is Right) {
          return Right(true);
        } else {
          return Left(data as Failure);
        }
      } else {
        return Left(ServerFailure());
      }
    }).toList();
    await Future.wait(futureList).then((list) {
      int i = 0;
      list.forEach((either) {
        if (either.isRight()) {
          final path = scannedVideos[i].videoPath;
          log('Uploaded video path: $path');

          scannedVideos[i].delete();
          File(path).delete().then((value) {
            log('Deleted video path: $path');
          });
        }
        i++;
      });
    });
  }
}
