import 'package:flutter/material.dart';

import '../../shared/app_theme.dart';
import 'classic_text.dart';

//* This custom component for error messages. We are showing a component which is coming from bottom of screen.

class SnackbarShow {
  static void showAndClear(BuildContext context, String error) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: ClassicText(
          text: error,
          style: AppTheme().smallParagraphRegularText.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
