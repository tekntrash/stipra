import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/app_theme.dart';

class CustomLoadIndicator extends StatelessWidget {
  const CustomLoadIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.w,
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(
          AppTheme().darkPrimaryColor,
        ),
        strokeWidth: 3,
      ),
    );
  }
}
