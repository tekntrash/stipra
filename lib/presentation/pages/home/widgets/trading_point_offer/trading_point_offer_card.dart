import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/core/utils/router/app_routes.dart';

import '../../../../../data/models/offer_model.dart';
import '../../../../../shared/app_theme.dart';
import '../../../../widgets/image_box.dart';

class TradingPointOfferCard extends StatelessWidget {
  final OfferModel offerModel;
  const TradingPointOfferCard({
    Key? key,
    required this.offerModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.37.sw,
      margin: EdgeInsets.only(right: 20.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            AppNavigator.pushNamed(
              context: context,
              routeName: AppRoutes.tradingOfferDetail,
              arguments: offerModel,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageBox(
                width: 128.w,
                height: 128.h,
                url: offerModel.image ?? '',
                borderRadius: BorderRadius.circular(15),
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                offerModel.title ?? '',
                style: AppTheme.smallParagraphSemiBoldText,
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                offerModel.desc ?? '',
                style: AppTheme.extraSmallParagraphRegularText.copyWith(
                  color: AppTheme.gray2Color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
