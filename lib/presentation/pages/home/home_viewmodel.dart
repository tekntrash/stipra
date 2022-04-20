import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/enums/win_point_category.dart';
import 'package:stipra/data/models/win_item_model.dart';
import 'package:stipra/presentation/pages/home/widgets/win_point_category_list.dart';
import '../../../core/platform/network_info.dart';
import '../../../core/services/scanned_video_service.dart';
import '../../widgets/overlay/lock_overlay_dialog.dart';
import '../../widgets/overlay/snackbar_overlay.dart';
import '../../widgets/theme_button.dart';
import '../../../shared/app_theme.dart';

import '../../../data/models/offer_model.dart';
import '../../../data/models/product_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../injection_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewModel extends BaseViewModel {
  late bool isInited;
  late List<WinItemModel> winItems;
  late List<OfferModel> offers;
  late WinPointCategory selectedCategory;
  late WinPointDirection selectedDirection;
  late bool selectedExpire;
  late bool isLoading;
  init() async {
    offers = [];
    winItems = [];
    isInited = false;
    isLoading = true;
    selectedExpire = false;
    selectedCategory = WinPointCategory.All;
    selectedDirection = WinPointDirection.asc;
    await Future.wait([
      requestPermisisons(),
      getWinItems(),
      getOffers(),
      informAboutUploadedVideo(),
    ]);
    isInited = true;
    isLoading = false;
    notifyListeners();
  }

  Future<void> changeCategory(WinPointCategory category) async {
    selectedCategory = category;
    isLoading = true;
    notifyListeners();
    await getWinItems();
    isLoading = false;
    notifyListeners();
  }

  Future<void> changeDirection(WinPointDirection direction) async {
    selectedDirection = direction;
    isLoading = true;
    notifyListeners();
    await getWinItems();
    isLoading = false;
    notifyListeners();
  }

  Future<void> onShowExpiredChanged(bool status) async {
    selectedExpire = status;
    isLoading = true;
    notifyListeners();
    await getWinItems();
    isLoading = false;
    notifyListeners();
  }

  Future<void> requestPermisisons() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.location,
    ].request();
  }

  Future<void> informAboutUploadedVideo() async {
    locator<ScannedVideoService>().listenInternetForInformation();
    //await locator<ScannedVideoService>().informAboutUploadedVideo();
  }

  Future getWinItems() async {
    final data = await locator<DataRepository>()
        .getWinPoints(selectedCategory, selectedDirection, selectedExpire);
    if (data is Right) {
      winItems = (data as Right).value;
    } else {
      winItems = [];
    }
  }

  Future getOffers() async {
    final data = await locator<DataRepository>().getOffers();
    if (data is Right) {
      offers = (data as Right).value;
    }
  }
}
