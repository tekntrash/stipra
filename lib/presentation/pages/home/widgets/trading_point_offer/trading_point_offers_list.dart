import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/models/offer_model.dart';
import '../../../../../shared/app_theme.dart';
import 'trading_point_offer_card.dart';

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
              'Trading Point Offers',
              style: AppTheme.largeParagraphBoldText,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 190.h,
            child: ListView.builder(
              itemCount: offers.length,
              //shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              //shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: index == 0 ? 15.w : 0),
                  child: TradingPointOfferCard(
                    offerModel: offers[index],
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
