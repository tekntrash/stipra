import 'package:flutter/material.dart';
import 'package:stipra/presentation/widgets/image_box.dart';
import 'package:stipra/shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.gray3Color,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppTheme.accentFirstColor,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.search_sharp,
                color: AppTheme.gray1Color,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Search deal',
                style: AppTheme.extraSmallParagraphRegularText.copyWith(
                  color: AppTheme.gray1Color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
