import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../data/models/offer_model.dart';
import '../../../../../shared/app_theme.dart';

class PerksList extends StatelessWidget {
  final List<OfferModel> offers;
  const PerksList({
    Key? key,
    required this.offers,
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
            child: Text(
              'Perks',
              style: AppTheme().largeParagraphBoldText.copyWith(
                    color: AppTheme().greyScale0,
                  ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: offers.length * 2,
            itemBuilder: (context, index) {
              final bool isFirst = index == 0;
              index = index % offers.length;
              return Container(
                margin: EdgeInsets.only(bottom: 8.w),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                        //color: AppTheme().blackColor,
                        ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(
                            width: 128,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 220, 131),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/image_box.svg',
                                width: 64,
                                height: 64,
                                color: AppTheme().greyScale0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        offers[index].title!,
                                        style: AppTheme()
                                            .paragraphBoldText
                                            .copyWith(
                                              color: AppTheme().greyScale0,
                                            ),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        'Trade ${offers[index].desc!}',
                                        style: AppTheme()
                                            .smallParagraphRegularText
                                            .copyWith(
                                              color: AppTheme().greyScale2,
                                            ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Starting from',
                                        style: AppTheme()
                                            .extraSmallParagraphRegularText
                                            .copyWith(
                                              color: AppTheme().greyScale3,
                                            ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        'Level 0',
                                        style: AppTheme()
                                            .extraSmallParagraphSemiBoldText
                                            .copyWith(
                                              color:
                                                  AppTheme().primaryBlueColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
