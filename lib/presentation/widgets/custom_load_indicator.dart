import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/app_theme.dart';

//* A loading component for custom and easy use in app.

class CustomLoadIndicator extends StatelessWidget {
  const CustomLoadIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 48.w,
        height: 48.w,
        margin: EdgeInsets.only(top: 24.w),
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(
            AppTheme().darkPrimaryColor,
          ),
          strokeWidth: 3,
        ),
      ),
    );
  }
}
