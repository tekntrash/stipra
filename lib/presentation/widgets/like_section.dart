import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stipra/shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikeSection extends StatelessWidget {
  const LikeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildIcon(
          Icons.thumb_up_alt_outlined,
          '4,6k',
        ),
        buildIcon(
          Icons.thumb_down_alt_outlined,
          '245',
        ),
        buildIcon(
          FontAwesomeIcons.commentDots,
          '456',
        ),
        buildIcon(
          Icons.ios_share_rounded,
          'Share',
        ),
      ],
    );
  }

  Widget buildIcon(
    IconData icon,
    String belowText,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24.sp,
        ),
        SizedBox(
          height: 3.h,
        ),
        Text(
          belowText,
          style: AppTheme.extraSmallParagraphRegularText,
        ),
      ],
    );
  }
}
