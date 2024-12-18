import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stipra/data/enums/win_point_category.dart';

import '../../../../data/enums/trade_point_category.dart';
import '../../../../data/models/offer_model.dart';
import '../../../../shared/app_theme.dart';

/// Create text for description for UI

class VideosWaitingCategoryList extends StatelessWidget {
  const VideosWaitingCategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15.w),
            height: ((AppTheme().largeParagraphBoldText.fontSize)?.h ?? 0),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'videos_waiting_title'.tr,
                            style: AppTheme().largeParagraphBoldText.copyWith(
                                  color: AppTheme().greyScale0,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 15.w, right: 15.w),
            height: 80.h,
            child: Text(
              'videos_waiting_subtitle'.tr,
              style: AppTheme().smallParagraphRegularText.copyWith(
                    color: AppTheme().greyScale0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
