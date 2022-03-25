import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/models/offer_model.dart';
import '../../../../../shared/app_theme.dart';

class TradingPointOffersList extends StatelessWidget {
  final List<OfferModel> offers;
  const TradingPointOffersList({
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
              'Deals on Fruits & Tea',
              style: AppTheme().largeParagraphBoldText.copyWith(
                    color: AppTheme().greyScale0,
                  ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 35.h,
            child: ListView.builder(
              itemCount: offers.length * 2,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final bool isFirst = index == 0;
                index = index % offers.length;
                return Container(
                  margin: EdgeInsets.only(left: isFirst ? 15.w : 0, right: 8.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: isFirst
                            ? AppTheme().darkPrimaryColor
                            : Colors.transparent,
                        border: Border.all(
                          color: isFirst
                              ? AppTheme().darkPrimaryColor
                              : AppTheme().greyScale4,
                        )),
                    height: 35.h,
                    child: Center(
                      child: Text(
                        offers[index].title!,
                        style:
                            AppTheme().extraSmallParagraphMediumText.copyWith(
                                  color: isFirst
                                      ? AppTheme().greyScale6
                                      : AppTheme().greyScale2,
                                ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
