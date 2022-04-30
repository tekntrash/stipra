import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../presentation/widgets/overlay/lock_overlay_dialog.dart';
import '../../presentation/widgets/overlay/widgets/location_permission_dialog.dart';

abstract class PermissionService {
  Future<void> requestPermission(
    Permission requestedPermission, {
    PermissionStatus? overridePermission,
    Function()? onRequestGranted,
    Function()? onDenied,
    required String description,
  });

  void showLocationPermissionDialog(Permission requestedPermission,
      {required String description,
      Function()? onRequestGranted,
      Function()? onDenied});
}

class PermissionServiceImpl extends PermissionService {
  @override
  Future<void> requestPermission(
    Permission requestedPermission, {
    PermissionStatus? overridePermission,
    Function()? onRequestGranted,
    Function()? onDenied,
    bool alreadyRequested: false,
    required String description,
  }) async {
    PermissionStatus permission;
    if (overridePermission != null) {
      permission = overridePermission;
    } else {
      log('Requesting permission: $requestedPermission');
      permission = await requestedPermission.request();
    }
    log('Permission is: $permission');
    if (permission == PermissionStatus.granted) {
      if (onRequestGranted != null) onRequestGranted();
      log('Permission granted');
    } else if (permission == PermissionStatus.permanentlyDenied ||
        alreadyRequested) {
      //final isOpened = await Geolocator.openAppSettings();
      //if (isOpened) {
      //  log('App settings opened');
      //} else {
      log('Open app settings');
      showLocationPermissionDialog(
        requestedPermission,
        onRequestGranted: onRequestGranted,
        description: description,
        onDenied: onDenied,
      );
      //}
    } else {
      log('Permission requesting');
      final requestResult = await requestedPermission.request();
      if (requestResult == PermissionStatus.granted) {
        if (onRequestGranted != null) onRequestGranted();
      } else {
        requestPermission(
          requestedPermission,
          overridePermission: requestResult,
          alreadyRequested: true,
          description: description,
          onRequestGranted: onRequestGranted,
          onDenied: onDenied,
        );
      }
    }
  }

  @override
  showLocationPermissionDialog(Permission requestedPermission,
      {required String description,
      Function()? onRequestGranted,
      Function()? onDenied}) {
    LockOverlayDialog().showCustomOverlay(
      child: LocationPermissionDialog(
        descriptionText: description,
        button1Text: 'Open Settings',
        button2Text: 'Cancel',
        onButton1Tap: () async {
          //await Geolocator.openAppSettings();
          AppSettings.openAppSettings();
          //requestPermission(onRequestGranted: onRequestGranted);
          //LockOverlayDialog().closeOverlay();
        },
        onButton2Tap: () {
          LockOverlayDialog().closeOverlay();
          if (onDenied != null) onDenied();
        },
        onClickOutside: onDenied,
        onResume: () async {
          await requestPermission(
            requestedPermission,
            onRequestGranted: () {
              if (onRequestGranted != null) onRequestGranted();
              LockOverlayDialog().closeOverlay();
            },
            description: description,
          );
        },
      ),
    );
  }
}
