import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stipra/core/platform/app_info.dart';
import 'package:stipra/presentation/widgets/overlay/snackbar_overlay.dart';
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
  ValueNotifier<Map<String, UploadingVideo>> uploadingVideosNotifier =
      ValueNotifier({});

  listenInternetForInformation() {
    locator<NetworkInfo>().onInternetChange(
      onConnect: () async {
        log('Internet is connected');
        if (_waitForConnection) {
          _waitForConnection = false;
          informAboutUploadedVideo();
        }
        final errors = await locator<LocalDataRepository>().getLogs();
        if (errors.length > 0) {
          String error = '********************* \n Start of error';
          error += 'Mobile info: ${AppInfo.mobileInfo}\n';
          for (var i = 0; i < errors.length; i++) {
            error += '----------------------';
            error += errors[i].toJson().toString();
            error += '----------------------\n';
          }
          error += '********************* \n End of error';
          final result = locator<DataRepository>().sendMail(
            '${locator<LocalDataRepository>().getUser().name} & ${locator<LocalDataRepository>().getUser().userid}',
            locator<LocalDataRepository>().getUser().alogin ?? 'Not logged',
            error,
          );
          if (result is Right) {
            for (var i = 0; i < errors.length; i++) {
              errors[i].delete();
            }
          }
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

    for (ScannedVideoModel scannedVideo in scannedVideos) {
      final dateFormat = DateFormat('dd-MM-yy')
          .format(DateTime.fromMillisecondsSinceEpoch(scannedVideo.timeStamp));
      log('Date format: $dateFormat');
      final result = await locator<DataRepository>()
          .isVideoAlreadyUploaded(scannedVideo.videoPath, dateFormat);
      if (result is Right) {
        if ((result as Right).value == true) {
          scannedVideo.isUploaded = true;
          await scannedVideo.save();
        }
      }
    }

    final unUploadedScannedVideos = scannedVideos.where((scannedVideo) {
      return scannedVideo.isUploaded != true;
    }).toList();
    final isConnectedForUpload =
        await locator<NetworkInfo>().isConnectedForUpload;
    if (isNeedUpload && isConnectedForUpload) {
      log('informAboutUploadedVideo: true');
      uploadScannedVideos(unUploadedScannedVideos);
    }
  }

  Future<void> informAboutUploadedVideoWithDialog() async {
    final dataRepository = locator<LocalDataRepository>();
    bool isNeedUpload = false;
    log('Helo!');
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
      LockOverlayDialog().showCustomOverlay(
        child: UploadInformBox(
          onTapUpload: () {
            uploadScannedVideos(unUploadedScannedVideos);
          },
        ),
      );
    } else if (!isConnected) {
      SnackbarOverlay().show(
        addFrameCallback: true,
        onTap: () {
          SnackbarOverlay().closeCustomOverlay();
        },
        text:
            'There is no connectivity right now: please connect to your mobile operator or wifi.',
        buttonText: 'OK',
      );
      Future.delayed(Duration(seconds: 6), () {
        SnackbarOverlay().closeCustomOverlay();
      });
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
    final dataRepository = locator<DataRepository>();

    for (ScannedVideoModel scannedVideo in scannedVideos) {
      if (uploadingVideosNotifier.value[scannedVideo.videoPath] != null) {
        uploadingVideosNotifier.value[scannedVideo.videoPath]!.cancelToken
            .cancel();
        uploadingVideosNotifier.value.remove(scannedVideo);
      }
      final barcodeTimeStamps = scannedVideo.barcodeTimeStamps;
      final path = scannedVideo.videoPath;
      final isExists = await File(path).exists();
      if (isExists) {
        Future.wait(barcodeTimeStamps.map((barcodeTimeStamp) async {
          log('Barcode timestamp: ${barcodeTimeStamp.timeStamp}');
          await locator<DataRepository>().sendBarcode(
            barcodeTimeStamp.barcode,
            barcodeTimeStamp.timeStamp,
            path,
            scannedVideo.location?[0] ?? 0,
            scannedVideo.location?[1] ?? 0,
          );
        }));
        final cancelToken = CancelToken();
        final progressNotifier = ValueNotifier<double>(0.0);
        uploadingVideosNotifier.value[path] = UploadingVideo(
          progressNotifier: progressNotifier,
          cancelToken: cancelToken,
          scannedVideo: scannedVideo,
        );
        uploadingVideosNotifier.notifyListeners();

        log('Scanned video timestamp: ${scannedVideo.timeStamp}');
        final dateFormat = DateFormat('dd-MM-yy').format(
            DateTime.fromMillisecondsSinceEpoch(scannedVideo.timeStamp));
        log('Date format date: $dateFormat');

        final data = await dataRepository.sendScannedVideo(
          path,
          dateFormat,
          scannedVideo.location?[0] ?? 0,
          scannedVideo.location?[1] ?? 0,
          cancelToken: cancelToken,
          progressNotifier: progressNotifier,
        );
        if (data is Right) {
          uploadingVideosNotifier.value.remove(path);
          uploadingVideosNotifier.notifyListeners();

          final deleteFile = File(path);
          try {
            await deleteFile.delete();
            scannedVideo.isUploaded = true;
            await scannedVideo.save();
          } catch (e) {
            SnackbarOverlay().show(
              addFrameCallback: true,
              onTap: () {
                SnackbarOverlay().closeCustomOverlay();
              },
              removeDuration: Duration(seconds: 5),
              text: isDebugMode
                  ? 'Delete error: $e'
                  : 'Something went wrong, please try again later.',
              buttonText: 'OK',
              buttonTextColor: Colors.red,
            );
          }
        } else {
          uploadingVideosNotifier.value.remove(path);
          uploadingVideosNotifier.notifyListeners();

          if (!cancelToken.isCancelled) {
            SnackbarOverlay().show(
              addFrameCallback: true,
              onTap: () {
                SnackbarOverlay().closeCustomOverlay();
              },
              removeDuration: Duration(seconds: 5),
              text: isDebugMode
                  ? 'Type: ${(data as Left)} Value: ${(data as Left).value}'
                  : 'Something went wrong, please try again later.',
              buttonText: 'OK',
              buttonTextColor: Colors.red,
            );
          }
        }
      } else {
        await scannedVideo.delete();
      }
    }
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

  Future<void> deleteScannedVideo(ScannedVideoModel scannedVideo) async {
    final dataRepository = locator<LocalDataRepository>();
    await dataRepository.deleteScannedVideo(scannedVideo);
    File videoFile = File(scannedVideo.videoPath);
    if (videoFile.existsSync()) {
      await videoFile.delete();
    }
  }
}

class UploadingVideo {
  UploadingVideo({
    required this.cancelToken,
    required this.scannedVideo,
    required this.progressNotifier,
  });
  final ValueNotifier<double> progressNotifier;
  final CancelToken cancelToken;
  final ScannedVideoModel scannedVideo;
}
