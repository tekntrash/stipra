import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/core/utils/router/app_router.dart';
import 'package:stipra/core/utils/router/app_routes.dart';
import 'package:stipra/core/utils/time_converter/time_converter.dart';

import '../../../../../data/models/product_model.dart';
import '../../../../../shared/app_theme.dart';
import '../../../../widgets/image_box.dart';

class ProductOfferCard extends StatelessWidget {
  final ProductModel product;
  const ProductOfferCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.37.sw,
      margin: EdgeInsets.only(right: 20.w),
      child: IntrinsicWidth(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              AppNavigator.pushNamed(
                context: context,
                routeName: AppRoutes.productDetail,
                arguments: product,
              );
            },
            child: Container(
              padding: EdgeInsets.only(
                top: 12.5.h,
                bottom: 12.5.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ImageBox(
                        width: 80.w,
                        height: 80.w,
                        url: product.image ?? '',
                        borderRadius: BorderRadius.circular(15),
                        fit: BoxFit.fitHeight,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title ?? '',
                              style: AppTheme.smallParagraphSemiBoldText,
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              '${product.awardPoint} Points',
                              style: AppTheme.extraSmallParagraphRegularText
                                  .copyWith(
                                color: AppTheme.gray2Color,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              formatDateyMd(
                                timeAgo: DateFormat('dd/MM/yyyy')
                                    .parse(product.endDate ?? '')
                                    .millisecondsSinceEpoch,
                                addHM: false,
                                isMilliSeconds: true,
                              ),
                              style: AppTheme.extraSmallParagraphRegularText
                                  .copyWith(
                                color: AppTheme.gray2Color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.desc ?? '',
                          style: AppTheme.smallParagraphRegularText.copyWith(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
