import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../errors/failure.dart';
import 'location_service.dart';
import '../../presentation/widgets/scanned_video/upload_inform_box.dart';

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
    final isConnectedForUpload =
        await locator<NetworkInfo>().isConnectedForUpload;
    if (isNeedUpload && isConnectedForUpload) {
      log('informAboutUploadedVideo: true');
      uploadScannedVideos(unUploadedScannedVideos);
      /*LockOverlayDialog().showCustomOverlay(
        child: UploadInformBox(
          onTapUpload: () {
            uploadScannedVideos(unUploadedScannedVideos);
          },
        ),
      );*/
    }
  }

  ///First index is latitude and second is longitude
  Future<List<double>?> getLocationWithPermRequest(
      {Function()? onRequestGranted, bool request: true}) async {
    double latitude, longitude;
    final isLocationAccessGranted =
        await locator<LocationService>().isAccessGranted;
    if (isLocationAccessGranted) {
      final position = await locator<LocationService>().getCurrentLocation();
      latitude = position.latitude;
      longitude = position.longitude;
      return [latitude, longitude];
    } else {
      if (request)
        await locator<LocationService>()
            .requestPermission(onRequestGranted: onRequestGranted);
      return null;
    }
  }

  Future<void> uploadScannedVideos(
      List<ScannedVideoModel> scannedVideos) async {
    final location = await getLocationWithPermRequest(onRequestGranted: () {
      uploadScannedVideos(scannedVideos);
    });
    if (location == null) {
      return;
    }
    final dataRepository = locator<DataRepository>();
    var futureList = List.from(scannedVideos)
        .map<Future<Either<Failure, bool>>>((scannedVideo) async {
      final barcodeTimeStamps =
          (scannedVideo as ScannedVideoModel).barcodeTimeStamps;
      final path = scannedVideo.videoPath;
      final isExists = await File(path).exists();
      if (isExists) {
        Future.wait(barcodeTimeStamps.map((barcodeTimeStamp) async {
          await locator<DataRepository>().sendBarcode(
            barcodeTimeStamp.barcode,
            path,
            location[0],
            location[1],
          );
        }));
        final data = await dataRepository.sendScannedVideo(
          path,
          location[0],
          location[1],
        );
        if (data is Right) {
          return Right(true);
        } else {
          return Left(data as Failure);
        }
      } else {
        return Left(DeletedFileFailure());
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
        if (either.isLeft()) {
          var failure = (either as Left).value;
          if (failure is ServerFailure) {
            log('ServerFailure');
          } else if (failure is DeletedFileFailure) {
            log('DeletedFileFailure path: ${scannedVideos[i].videoPath}');
            scannedVideos[i].delete();
          }
        }
        i++;
      });
    });
  }

  Future<List<ScannedVideoModel>> getVideosWaiting() async {
    final dataRepository = locator<LocalDataRepository>();
    List<ScannedVideoModel> _scannedVideos =
        await dataRepository.getScannedVideos();
    final unUploadedScannedVideos = _scannedVideos.where((scannedVideo) {
      return scannedVideo.isUploaded != true;
    }).toList();
    return unUploadedScannedVideos;
  }
}
