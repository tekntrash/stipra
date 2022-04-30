import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/services/permission_service.dart';
import 'package:stipra/data/enums/win_point_category.dart';
import 'package:stipra/data/models/win_item_model.dart';
import '../../../core/services/scanned_video_service.dart';

import '../../../data/models/offer_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';
import '../../widgets/overlay/lock_overlay_dialog.dart';

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
    ]);
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
    /*Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.location,
    ].request();*/
    askForCameraPermission();
    //if camera is not granted
  }

  Future<void> askForCameraPermission() async {
    await locator<PermissionService>().requestPermission(
      Permission.camera,
      description:
          'We need to access your camera to identify barcodes of products you will scan.',
      onRequestGranted: () {
        LockOverlayDialog().closeOverlay();

        askForStoragePermission();
      },
      onDenied: () {
        if (Platform.isIOS) {
          LockOverlayDialog().closeOverlay();
          askForStoragePermission();
        } else {
          askForCameraPermission();
        }
      },
    );
  }

  Future<void> askForStoragePermission() async {
    await locator<PermissionService>().requestPermission(
      Permission.storage,
      description: 'We need to access your storage to save your videos.',
      onRequestGranted: () {
        askForLocationPermission();
      },
      onDenied: () {
        if (Platform.isIOS) {
          askForLocationPermission();
        } else {
          askForStoragePermission();
        }
      },
    );
  }

  Future<void> askForLocationPermission() async {
    await locator<PermissionService>().requestPermission(
        Permission.locationWhenInUse,
        description:
            'We need your location to find available disposable products around you.',
        onDenied: () async {
      if (Platform.isIOS) {
        await Future.wait([
          getWinItems(request: false),
          getOffers(),
          informAboutUploadedVideo(),
        ]);
        isInited = true;
        isLoading = false;
        notifyListeners();
      } else {
        askForLocationPermission();
      }
    }, onRequestGranted: () async {
      await Future.wait([
        getWinItems(request: false),
        getOffers(),
        informAboutUploadedVideo(),
      ]);
      isInited = true;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> informAboutUploadedVideo() async {
    locator<ScannedVideoService>().listenInternetForInformation();
    //await locator<ScannedVideoService>().informAboutUploadedVideo();
  }

  Future getWinItems({bool request: true}) async {
    final location = await locator<ScannedVideoService>()
        .getLocationWithPermRequest(request: request);
    final data = await locator<DataRepository>().getWinPoints(
      selectedCategory,
      selectedDirection,
      selectedExpire,
      location ?? [0, 0],
    );
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
