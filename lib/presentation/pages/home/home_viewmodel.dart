import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/platform/network_info.dart';
import 'package:stipra/core/services/scanned_video_service.dart';
import 'package:stipra/presentation/widgets/overlay/lock_overlay_dialog.dart';
import 'package:stipra/presentation/widgets/overlay/snackbar_overlay.dart';
import 'package:stipra/presentation/widgets/theme_button.dart';
import 'package:stipra/shared/app_theme.dart';

import '../../../data/models/offer_model.dart';
import '../../../data/models/product_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../injection_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewModel extends BaseViewModel {
  late bool isInited;
  late List<ProductModel> products;
  late List<OfferModel> offers;
  init() async {
    offers = [];
    products = [];
    isInited = false;
    await Future.wait([
      requestPermisisons(),
      getProducts(),
      getOffers(),
      informAboutUploadedVideo(),
    ]);
    isInited = true;
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

  Future getProducts() async {
    final data = await locator<DataRepository>().getProducts();
    if (data is Right) {
      products = (data as Right).value;
    }
  }

  Future getOffers() async {
    final data = await locator<DataRepository>().getOffers();
    if (data is Right) {
      offers = (data as Right).value;
    }
  }
}
