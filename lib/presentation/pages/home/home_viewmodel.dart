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

/// This class controlling home page
/// Can get products from backend
/// Can change category, directiong and can select expired products

class HomeViewModel extends BaseViewModel {
  late bool isInited;
  late List<WinItemModel> winItems;
  late WinPointCategory selectedCategory;
  late WinPointDirection selectedDirection;
  late bool selectedExpire;
  late bool isLoading;

  /// Init this controller and set default parameters for this controller
  /// Also request permissions if not granted
  init() async {
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

  /// Change category of products then re-request products
  Future<void> changeCategory(WinPointCategory category) async {
    selectedCategory = category;
    isLoading = true;
    notifyListeners();
    await getWinItems();
    isLoading = false;
    notifyListeners();
  }

  /// Change direction of products then re-request products
  Future<void> changeDirection(WinPointDirection direction) async {
    selectedDirection = direction;
    isLoading = true;
    notifyListeners();
    await getWinItems();
    isLoading = false;
    notifyListeners();
  }

  /// Change expired parameter of products then re-request products
  Future<void> onShowExpiredChanged(bool status) async {
    selectedExpire = status;
    isLoading = true;
    notifyListeners();
    await getWinItems();
    isLoading = false;
    notifyListeners();
  }

  /// Request permissions for camera and storage & location
  Future<void> requestPermisisons() async {
    askForCameraPermission();
  }

  /// Wait for camera permission response then ask for storage permission if not granted and if it is not ios show error to open settings
  Future<void> askForCameraPermission() async {
    await locator<PermissionService>().requestPermission(
      Permission.camera,
      description:
          'Stipra requires camera to make videos of disposed products in order to award points and does not share those with anyone.',
      onRequestGranted: () {
        LockOverlayDialog().closeOverlay();

        askForStoragePermission();
      },
      onDenied: () {
        LockOverlayDialog().closeOverlay();
        askForStoragePermission();
      },
      dontAskIfFirstTime: true,
    );
  }

  /// Wait for storage permission response then if granted ask for location permission if not granted and if it is not ios show error to open settings
  Future<void> askForStoragePermission() async {
    await locator<PermissionService>().requestPermission(
      Permission.storage,
      description:
          'Stipra requires storage to store the videos before sending them for analysis and does not share those with anyone.',
      onRequestGranted: () {
        askForLocationPermission();
      },
      onDenied: () {
        askForLocationPermission();
      },
      dontAskIfFirstTime: true,
    );
  }

  /// Wait for location permission response then if granted get products, if not granted and if it is not ios show error to open settings
  Future<void> askForLocationPermission() async {
    await locator<PermissionService>().requestPermission(
      Permission.locationWhenInUse,
      description:
          'Stipra requires geolocation to show relevant products only and does not share this information with anyone.',
      onDenied: () async {
        //if (Platform.isIOS) {
        await Future.wait([
          getWinItems(request: false),
          informAboutUploadedVideo(),
        ]);
        isInited = true;
        isLoading = false;
        notifyListeners();
        /*} else {
          askForLocationPermission();
        }*/
      },
      onRequestGranted: () async {
        await Future.wait([
          getWinItems(request: false),
          informAboutUploadedVideo(),
        ]);
        isInited = true;
        isLoading = false;
        notifyListeners();
      },
      dontAskIfFirstTime: true,
    );
  }

  /// Control the local storage if there are any videos waiting for upload
  Future<void> informAboutUploadedVideo() async {
    locator<ScannedVideoService>().listenInternetForInformation();
    //await locator<ScannedVideoService>().informAboutUploadedVideo();
  }

  /// Get products from backend with location and with the help of singleton and data repository
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
}
