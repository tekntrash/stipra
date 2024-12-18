import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../core/utils/router/app_router.dart';

import 'classic_loading_overlay.dart';

bool haveOverlay = false;

//* This custom service is using for for showing a loading component.
//* This class uses applications's main overlay to show dialogs top of ui.
//* It can be used to show loading component at the middle of screen.
class LockOverlay {
  static LockOverlay? _instance;
  final ValueNotifier<OverlayEntry?> _overlayEntry = ValueNotifier(null);

  LockOverlay._internal() {
    _instance = this;
  }

  factory LockOverlay() => _instance ?? LockOverlay._internal();

  void showClassicLoadingOverlay({bool buildAfterRebuild: false}) {
    log('showClassicLoadingOverlay');
    if (haveOverlay) return;
    //final String myKey = _uniqueKey;
    if (buildAfterRebuild) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showClassicLoadingOverlay();
      });
      return;
    }
    OverlayState? overlayState =
        AppRouter().mainNavigatorKey!.currentState?.overlay;
    if (overlayState == null) return;

    final _myoverlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return ClassicLoadingOverlay(
          overlayEntry: _overlayEntry,
        );
      },
    );
    _overlayEntry.value = _myoverlayEntry;

    overlayState.insert(_overlayEntry.value!);
    haveOverlay = true;
  }

  closeOverlay() {
    if (_overlayEntry.value == null) return;
    haveOverlay = false;
    _overlayEntry.value!.remove();
    _overlayEntry.value = null;
  }
}
