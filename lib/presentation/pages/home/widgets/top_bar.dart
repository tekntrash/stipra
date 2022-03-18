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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*ImageBox(
              width: 32,
              height: 32,
              url: 'https://www.stipra.com/favicon.ico',
            ),
            SizedBox(
              width: 10.w,
            ),*/
            Text(
              'Stipra',
              style: AppTheme.headingText.copyWith(
                color: AppTheme.gray4Color,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning',
                    style: AppTheme.smallParagraphRegularText.copyWith(
                      color: AppTheme.gray4Color,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Endy Gerard',
                    style: AppTheme.headingText.copyWith(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ],
              ),
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_640.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
