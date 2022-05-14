import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stipra/core/utils/extensions/app_string_extension.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/data/models/product_consumed_model.dart';
import 'package:stipra/presentation/pages/barcode_scan/barcode_scan_page.dart';
import 'package:stipra/presentation/widgets/local_image_box.dart';

import '../../../../../shared/app_theme.dart';
import '../../../widgets/theme_button.dart';
import '../../my_product_detail/my_product_detail_page.dart';

class MyProductsList extends StatelessWidget {
  final List<ProductConsumedModel> productsConsumed;
  const MyProductsList({
    Key? key,
    required this.productsConsumed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return productsConsumed.length == 0
        ? SliverToBoxAdapter(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'You don\'t have any products yet. Make videos of your household garbage as you dispose of the individual items and you will earn points',
                    style: AppTheme().smallParagraphMediumText.copyWith(
                          color: AppTheme().greyScale0,
                        ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ThemeButton(
                  width: 1.sw,
                  height: 50.h,
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  color: AppTheme().primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    AppNavigator.push(
                      context: context,
                      child: BarcodeScanPage(
                        maxBarcodeLength: double.maxFinite.toInt(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scan',
                        style: AppTheme().paragraphSemiBoldText.copyWith(),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      LocalImageBox(
                        width: 32,
                        height: 32,
                        imgUrl: 'barcode.png',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return buildItem(context, index);
              },
              childCount: productsConsumed.length,
            ),
          );
  }

  Widget buildItem(BuildContext context, int index) {
    final correctDate =
        productsConsumed[index].dateTaken?.replaceAll('  ', ' ');
    final newDate = Jiffy('${correctDate}', 'EEE MMM dd hh:mm:ss yyyy').yMMMMd;

    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
        ),
        child: GestureDetector(
          onTap: () {
            AppNavigator.push(
              context: context,
              child: MyProductsDetailPage(
                productConsumed: productsConsumed[index],
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      AppNavigator.push(
                        context: context,
                        child: MyProductsDetailPage(
                          productConsumed: productsConsumed[index],
                        ),
                      );
                    },
                    child: Container(
                      width: 128,
                      height: 160,
                      decoration: BoxDecoration(
                        color: AppTheme().greyScale5,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: productsConsumed[index].base64 != null
                            ? Container(
                                width: 96,
                                height: 96,
                                child: CachedNetworkImage(
                                  imageUrl: productsConsumed[index]
                                      .base64
                                      .convertBase64ToImageUrl(),
                                  errorWidget: (context, error, stackTrace) =>
                                      Center(
                                    child: SvgPicture.asset(
                                      'assets/images/image_box.svg',
                                      width: 64,
                                      height: 64,
                                      color: AppTheme().greyScale0,
                                    ),
                                  ),
                                ),
                              )
                            : SvgPicture.asset(
                                'assets/images/image_box.svg',
                                width: 64,
                                height: 64,
                                color: AppTheme().greyScale0,
                              ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${productsConsumed[index].label}',
                                style: AppTheme().paragraphBoldText.copyWith(
                                      color: AppTheme().greyScale0,
                                    ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                '${productsConsumed[index].points} Points per product',
                                style: AppTheme()
                                    .smallParagraphRegularText
                                    .copyWith(
                                      color: AppTheme().greyScale2,
                                      fontSize: AppTheme()
                                              .smallParagraphRegularText
                                              .fontSize! *
                                          0.95,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Consumed ${productsConsumed[index].totalproduct} ${productsConsumed[index].totalproduct == '1' ? 'time' : 'times'}',
                                style: AppTheme()
                                    .smallParagraphRegularText
                                    .copyWith(
                                      color: AppTheme().greyScale2,
                                      fontSize: AppTheme()
                                              .smallParagraphRegularText
                                              .fontSize! *
                                          0.95,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Consumed on:',
                                  style: AppTheme()
                                      .extraSmallParagraphSemiBoldText
                                      .copyWith(
                                        color: AppTheme().greyScale2,
                                      ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '$newDate',
                                  style: AppTheme()
                                      .extraSmallParagraphRegularText
                                      .copyWith(
                                        color: AppTheme().greyScale3,
                                      ),
                                  textAlign: TextAlign.left,
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
      ),
    );
  }
}
