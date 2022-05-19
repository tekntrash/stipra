import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import '../../presentation/widgets/overlay/lock_overlay_dialog.dart';
import '../../presentation/widgets/overlay/widgets/location_permission_dialog.dart';

abstract class LocationService {
  Future<bool> get isAccessGranted;

  Future<void> requestPermission(
      {LocationPermission? overridePermission, Function()? onRequestGranted});

  Future<Position> getCurrentLocation();

  Future<String> getCurrentLocationAsString();

  void showLocationPermissionDialog({Function()? onRequestGranted});
}

class LocationServiceImpl extends LocationService {
  @override
  Future<bool> get isAccessGranted async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<void> requestPermission(
      {LocationPermission? overridePermission,
      Function()? onRequestGranted,
      bool alreadyRequested: false}) async {
    LocationPermission permission;
    if (overridePermission != null) {
      permission = overridePermission;
    } else {
      permission = await Geolocator.checkPermission();
    }
    log('Permission is: $permission');
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      if (onRequestGranted != null) onRequestGranted();
      log('Permission granted');
    } else if (permission == LocationPermission.deniedForever ||
        alreadyRequested) {
      //final isOpened = await Geolocator.openAppSettings();
      //if (isOpened) {
      //  log('App settings opened');
      //} else {
      log('Open app settings');
      showLocationPermissionDialog(onRequestGranted: onRequestGranted);
      //}
    } else {
      log('Permission requesting');
      final requestResult = await Geolocator.requestPermission();
      if (requestResult == LocationPermission.whileInUse ||
          requestResult == LocationPermission.always) {
        if (onRequestGranted != null) onRequestGranted();
      } else {
        requestPermission(
            overridePermission: requestResult, alreadyRequested: true);
      }
    }
  }

  @override
  showLocationPermissionDialog({Function()? onRequestGranted}) {
    LockOverlayDialog().showCustomOverlay(
      child: LocationPermissionDialog(
        descriptionText:
            'Stipra is using your location for provides products to you which can disposable on that location. Stipra using your location to verify your disposed products.',
        button1Text: 'Open Settings',
        button2Text: 'Cancel',
        onButton1Tap: () async {
          await Geolocator.openAppSettings();
          //requestPermission(onRequestGranted: onRequestGranted);
          //LockOverlayDialog().closeOverlay();
        },
        onButton2Tap: () {
          LockOverlayDialog().closeOverlay();
        },
        onResume: () async {
          await requestPermission(onRequestGranted: () {
            if (onRequestGranted != null) onRequestGranted();
            LockOverlayDialog().closeOverlay();
            //LockOverlayDialog().closeOverlay();
          });
        },
      ),
    );
  }

  @override
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    log('Current location: ${position.latitude}, ${position.longitude}');
    return position;
  }

  @override
  Future<String> getCurrentLocationAsString() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return '${position.latitude},${position.longitude}';
  }
}
