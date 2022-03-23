import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/presentation/widgets/custom_button.dart';

import '../../shared/app_theme.dart';

class ThemeButton extends StatelessWidget {
  final String? text;
  final Function() onTap;
  final BorderRadius? borderRadius;
  final Color? color;
  final double? elevation;
  final EdgeInsets margin;
  final Widget? child;
  final bool isEnabled;
  const ThemeButton({
    Key? key,
    this.text,
    this.child,
    required this.onTap,
    this.margin = const EdgeInsets.all(5),
    this.borderRadius,
    this.color,
    this.elevation: 3,
    this.isEnabled: true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: CustomButton(
        onPressed: onTap,
        text: text,
        child: child,
        options: CustomButtonOptions(
          width: 200,
          height: 50,
          color: color ?? AppTheme.primaryColor,
          textStyle: AppTheme.paragraphRegularText.apply(
            color: Colors.white,
          ),
          elevation: elevation,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: 8,
          borderRadiusCustom: borderRadius,
          highlightColor: isEnabled ? null : Colors.transparent,
          splashColor: isEnabled ? null : Colors.transparent,
        ),
      ),
    );
  }
}
