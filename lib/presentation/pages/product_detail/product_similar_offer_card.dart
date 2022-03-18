import 'package:flutter/material.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/core/utils/router/app_routes.dart';
import 'package:stipra/data/models/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/presentation/widgets/image_box.dart';
import 'package:stipra/shared/app_theme.dart';

class ProductSimilarOfferCard extends StatelessWidget {
  final ProductModel productModel;
  const ProductSimilarOfferCard({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.37.sw,
      margin: EdgeInsets.only(right: 20.w),
      child: IntrinsicWidth(
        child: InkWell(
          onTap: () {
            AppNavigator.pushNamed(
              context: context,
              routeName: AppRoutes.productDetail,
              arguments: productModel,
            );
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageBox(
                  width: 0.37.sw,
                  height: 100.w,
                  url: productModel.image ?? '',
                  borderRadius: BorderRadius.circular(5),
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  productModel.title ?? '',
                  style: AppTheme.smallParagraphSemiBoldText,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 4.h,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.star_border,
                        ),
                        alignment: PlaceholderAlignment.middle,
                      ),
                      TextSpan(
                        text: ' ${productModel.awardPoint} Points',
                        style: AppTheme.extraSmallParagraphRegularText.copyWith(
                          color: AppTheme.gray1Color,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
