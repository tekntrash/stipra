import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stipra/data/models/trade_item_model.dart';

import '../../../../../data/models/offer_model.dart';
import '../../../../../shared/app_theme.dart';

class PerksList extends StatelessWidget {
  final List<TradeItemModel> tradeItems;
  const PerksList({
    Key? key,
    required this.tradeItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tradeItems.length == 0
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
              childCount: tradeItems.length,
            ),
          );
    ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tradeItems.length,
      itemBuilder: (context, index) {},
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
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
                    child: tradeItems[index].image != null
                        ? Container(
                            width: 96,
                            height: 96,
                            child: Image.network(
                              tradeItems[index].image!,
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
                              '${tradeItems[index].name}',
                              style: AppTheme().paragraphBoldText.copyWith(
                                    color: AppTheme().greyScale0,
                                  ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              '${tradeItems[index].description}',
                              style:
                                  AppTheme().smallParagraphRegularText.copyWith(
                                        color: AppTheme().greyScale2,
                                      ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              'Level ${tradeItems[index].level}',
                              style: AppTheme()
                                  .extraSmallParagraphSemiBoldText
                                  .copyWith(
                                    color: AppTheme().primaryBlueColor,
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
  }
}
