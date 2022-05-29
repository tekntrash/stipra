import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart' show Right;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/data/models/scanned_video_model.dart';
import 'package:stipra/domain/repositories/data_repository.dart';
import 'package:stipra/presentation/widgets/custom_load_indicator.dart';
import 'package:stipra/presentation/widgets/overlay/lock_overlay.dart';
import 'package:stipra/presentation/widgets/overlay/lock_overlay_dialog.dart';
import 'package:stipra/presentation/widgets/overlay/widgets/location_permission_dialog.dart';

import '../../../core/services/scanned_video_service.dart';
import '../../../injection_container.dart';
import 'package:video_player/video_player.dart';

part 'widgets/video_widget.dart';

/// VideoViewModel uses for get video results from [ScannedVideoService]

class VideosWaitingViewModel extends BaseViewModel {
  late bool isInited;
  late List<ScannedVideoModel> scannedVideos;
  late bool isLoading;
  init() async {
    scannedVideos = [];
    isInited = false;
    isLoading = true;
    await Future.wait([
      getVideosWaiting(),
    ]);
    isInited = true;
    isLoading = false;
    notifyListeners();
  }

  Future getVideosWaiting() async {
    final data = await locator<ScannedVideoService>().getVideosWaiting();
    scannedVideos = data;
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
    log('Scanned videos waiting: $scannedVideos');
  }

  Future<void> showUploadVideosDialog() async {
    locator<ScannedVideoService>().informAboutUploadedVideoWithDialog();
  }

  Future<void> deleteScannedVideo(
      ScannedVideoModel scannedVideo, bool fromMemory) async {
    if (fromMemory)
      await locator<ScannedVideoService>().deleteScannedVideo(scannedVideo);
    scannedVideos.remove(scannedVideo);
    notifyListeners();
  }

  Future routeToVideoPage(
      BuildContext context, ScannedVideoModel scannedVideo) async {
    AppNavigator.pushWithOutAnim(
      context: context,
      child: VideoWidget(
        fileLink: File(scannedVideo.videoPath),
        scannedVideoModel: scannedVideo,
        deleteScannedVideo: deleteScannedVideo,
      ),
    );
  }
}
