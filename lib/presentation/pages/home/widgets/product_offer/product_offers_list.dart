import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/presentation/pages/product_detail/product_detail_page.dart';
import 'package:stipra/presentation/widgets/image_box.dart';
import 'package:stipra/presentation/widgets/local_image_box.dart';

import '../../../../../data/models/product_model.dart';
import '../../../../../shared/app_theme.dart';

class ProductOffersList extends StatelessWidget {
  final List<ProductModel> products;
  const ProductOffersList({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.h,
          ),
          Container(
            margin: EdgeInsets.only(right: 15.w),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              physics: NeverScrollableScrollPhysics(),
              itemCount: products.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final product = products[index];
                return Material(
                  elevation: 0.25,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      AppNavigator.push(
                        context: context,
                        child: ProductDetailPage(productModel: product),
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme().greyScale5,
                      ),
                      width: 160.w,
                      height: 200.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                            'assets/images/image_box.svg',
                            width: 64.w,
                            height: 64.w,
                            semanticsLabel: 'Image box',
                          ),
                          /*LocalImageBox(
                                width: 64,
                                height: 64,
                                imgUrl: 'roblox.png',
                              ),*/
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: AppTheme()
                                      .smallParagraphSemiBoldText
                                      .copyWith(
                                        color: AppTheme().blackColor,
                                        fontSize: 16,
                                      ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  '${product.awardPoint.toString()} Points',
                                  style: AppTheme()
                                      .extraSmallParagraphRegularText
                                      .copyWith(
                                        fontSize: 13,
                                        color: AppTheme().greyScale0,
                                      ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  child: Text(
                                    product.desc!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: AppTheme()
                                        .extraSmallParagraphRegularText
                                        .copyWith(
                                          fontSize: 13,
                                          color: AppTheme().greyScale2,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
