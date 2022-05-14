import 'package:flutter/material.dart';

import '../../../shared/app_theme.dart';
import '../overlay/lock_overlay_dialog.dart';
import '../theme_button.dart';

//* A component for informing user and helping them to make actions.
//* We are showing user in the middle of screen and showing a message.
//* We are also showing a button for user to make actions.
//* This class providing a button to upload videos.

class UploadInformBox extends StatelessWidget {
  final Function() onTapUpload;
  const UploadInformBox({
    Key? key,
    required this.onTapUpload,
  }) : super(key: key);

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
                      'If you are not in using wifi this will use data from your mobile and the video may end up not being received. Do you want to upload them now?',
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
                      onTapUpload();
                      LockOverlayDialog().closeOverlay();
                    },
                    text: 'Upload now',
                  ),
                  ThemeButton(
                    height: 42,
                    color: Colors.white,
                    textColor: Colors.black,
                    isEnabled: false,
                    elevation: 0,
                    onTap: () {
                      LockOverlayDialog().closeOverlay();
                    },
                    text: 'Close',
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
