import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/data/models/my_trade_model.dart';
import 'package:stipra/data/models/trade_item_model.dart';
import 'package:stipra/presentation/pages/perk_detail/perk_detail_page.dart';

import '../../../../../data/models/offer_model.dart';
import '../../../../../shared/app_theme.dart';

/// Create UI for my trades as list
/// And building them with the list given as parameter

class MyTradesList extends StatelessWidget {
  final List<MyTradeModel> myTrades;
  const MyTradesList({
    Key? key,
    required this.myTrades,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return myTrades.length == 0
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                'No perks available',
                style: AppTheme().paragraphSemiBoldText.copyWith(
                      color: AppTheme().greyScale0,
                    ),
              ),
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return buildItem(context, index);
              },
              childCount: myTrades.length,
            ),
          );
    ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: myTrades.length,
      itemBuilder: (context, index) {},
    );
  }

  Widget buildItem(BuildContext context, int index) {
    final newDate =
        Jiffy('${myTrades[index].date}', 'EEEE do \'of\' MMMM yyyy hh:mm:ss a')
            .yMMMMd;

    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
        ),
        child: GestureDetector(
          onTap: () {
            //
          },
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
                  InkWell(
                    onTap: () {
                      //
                    },
                    child: Container(
                      width: 128,
                      height: 160,
                      decoration: BoxDecoration(
                        color: AppTheme().greyScale5,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: myTrades[index].image != null
                            ? Container(
                                width: 96,
                                height: 96,
                                child: CachedNetworkImage(
                                  imageUrl: myTrades[index].image!,
                                  errorWidget: (context, url, error) =>
                                      SvgPicture.asset(
                                    'assets/images/image_box.svg',
                                    width: 64,
                                    height: 64,
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
                                '${myTrades[index].totalpointstraded} Points traded ',
                                style: AppTheme().paragraphBoldText.copyWith(
                                      color: AppTheme().greyScale0,
                                    ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                '${myTrades[index].description}',
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
                          /*RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Trade was made on: ',
                                  style: AppTheme()
                                      .extraSmallParagraphSemiBoldText
                                      .copyWith(
                                        color: AppTheme().greyScale2,
                                      ),
                                ),
                                TextSpan(
                                  text: newDate,
                                  style: AppTheme()
                                      .extraSmallParagraphRegularText
                                      .copyWith(
                                        color: AppTheme().greyScale3,
                                      ),
                                ),
                              ],
                            ),
                          ),*/
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Trade was made on:',
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
