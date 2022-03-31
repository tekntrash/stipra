import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../shared/app_theme.dart';
import '../../theme_button.dart';
import '../lock_overlay_dialog.dart';

class LocationPermissionDialog extends StatefulWidget {
  final String button1Text, button2Text, descriptionText;
  final Function()? onButton1Tap, onButton2Tap, onResume;
  const LocationPermissionDialog({
    Key? key,
    this.descriptionText = 'We need your location to verify your videos.',
    this.button1Text = '',
    this.button2Text = '',
    this.onButton1Tap,
    this.onButton2Tap,
    this.onResume,
  }) : super(key: key);

  @override
  State<LocationPermissionDialog> createState() =>
      _LocationPermissionDialogState();
}

class _LocationPermissionDialogState extends State<LocationPermissionDialog>
    with WidgetsBindingObserver {
  late bool _isResumed;
  @override
  void initState() {
    _isResumed = true;
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('App state changed to $state');
    if (state == AppLifecycleState.resumed) {
      log('On resume to app');
      if (_isResumed == false && widget.onResume != null) widget.onResume!();
      _isResumed = true;
    } else if (state == AppLifecycleState.paused) {
      log('On pause to app');
      _isResumed = false;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        LockOverlayDialog().closeOverlay();
      },
      child: Material(
        color: AppTheme().blackColor.withOpacity(0.55),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Information',
                      style: AppTheme().paragraphSemiBoldText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      widget.descriptionText,
                      style: AppTheme().smallParagraphRegularText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ThemeButton(
                    height: 42,
                    onTap: () {
                      if (widget.onButton1Tap != null) widget.onButton1Tap!();
                      //LockOverlayDialog().closeOverlay();
                    },
                    text: widget.button1Text,
                  ),
                  ThemeButton(
                    height: 42,
                    color: Colors.white,
                    textColor: Colors.black,
                    isEnabled: false,
                    elevation: 0,
                    onTap: () {
                      if (widget.onButton2Tap != null) widget.onButton2Tap!();
                      //LockOverlayDialog().closeOverlay();
                    },
                    text: widget.button2Text,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
