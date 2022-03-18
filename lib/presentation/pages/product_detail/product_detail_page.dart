import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/core/utils/time_converter/time_converter.dart';
import 'package:stipra/data/models/product_model.dart';
import 'package:stipra/presentation/pages/product_detail/product_detail_viewmodel.dart';
import 'package:stipra/presentation/pages/product_detail/product_similar_offer_card.dart';
import 'package:stipra/presentation/widgets/curved_container.dart';
import 'package:stipra/presentation/widgets/image_box.dart';
import 'package:stipra/presentation/widgets/like_section.dart';
import 'package:stipra/shared/app_theme.dart';

part 'top_bar.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailPage({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      viewModelBuilder: () => ProductDetailViewModel(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        if (!viewModel.isInited) {
          return Center(
            child: Container(
              width: 64.w,
              height: 64.w,
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        return Scaffold(
          backgroundColor: AppTheme.whiteColor,
          body: Container(
            child: SafeArea(
              child: ListView(
                children: [
                  Container(
                    height: 250.h,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 0,
                          child: ImageFiltered(
                            imageFilter:
                                new ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
                            child: ImageBox(
                              width: 1.sw,
                              height: 275.h,
                              url: productModel.image ?? '',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: ImageFiltered(
                            imageFilter:
                                new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              width: 1.sw,
                              height: 275.h,
                              color: Colors.black.withOpacity(0.08),
                            ),
                          ),
                        ),
                        /*ImageBox(
                          width: 1.sw,
                          height: 250.h,
                          url: productModel.image ?? '',
                          fit: BoxFit.fitHeight,
                        ),*/
                      ],
                    ),
                  ),
                  CurvedContainer(
                    radius: 20,
                    child: Container(
                      color: AppTheme.whiteColor,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 25.h,
                            ),
                            _TopBar(
                              productModel: productModel,
                            ),
                            Container(
                              height: 16.h,
                            ),
                            LikeSection(),
                            Container(
                              height: 8.h,
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Container(
                              height: 8.h,
                            ),
                            Text(
                              'Description',
                              style: AppTheme.paragraphBoldText,
                            ),
                            Container(
                              height: 8.h,
                            ),
                            Text(
                              productModel.desc ?? '',
                              style: AppTheme.smallParagraphRegularText,
                            ),
                            Container(
                              height: 45.h,
                            ),
                            Text(
                              'Similar Offers',
                              style: AppTheme.paragraphBoldText,
                            ),
                            Container(
                              height: 8.h,
                            ),
                            Container(
                              height: 200.h,
                              child: ListView.builder(
                                itemCount: 3,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ProductSimilarOfferCard(
                                    productModel: productModel,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
