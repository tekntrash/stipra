import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/enums/trade_point_category.dart';
import 'package:stipra/data/models/my_trade_model.dart';
import 'package:stipra/data/models/scanned_video_model.dart';
import 'package:stipra/data/models/trade_item_model.dart';

import '../../../core/services/scanned_video_service.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';

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
    log('Scanned videos waiting: $scannedVideos');
  }
}
