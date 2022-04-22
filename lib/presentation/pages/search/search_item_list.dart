import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stipra/data/models/trade_item_model.dart';
import 'package:stipra/data/models/win_item_model.dart';
import '../../../../../core/utils/router/app_navigator.dart';

import '../../../../../shared/app_theme.dart';
import '../product_detail/win_item_detail_page.dart';

class SearchItemList extends StatelessWidget {
  final List<WinItemModel> winItems;
  final List<TradeItemModel> tradeItems;
  final bool isSearched;
  const SearchItemList({
    Key? key,
    required this.winItems,
    required this.tradeItems,
    required this.isSearched,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*Container(
      margin: EdgeInsets.only(left: 15.w),
      child: Container(
        margin: EdgeInsets.only(right: 15.w),
        child: */
        winItems.length == 0 && tradeItems.length == 0
            ? isSearched
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'We couldn\'t find any results.',
                        style: AppTheme().smallParagraphSemiBoldText.copyWith(
                              color: AppTheme().greyScale0,
                            ),
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'Start searching to find deals and perks.',
                        style: AppTheme().smallParagraphSemiBoldText.copyWith(
                              color: AppTheme().greyScale0,
                            ),
                      ),
                    ),
                  )
            : winItems.length == 0
                ? SliverToBoxAdapter()
                : SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return buildItem(context, index);
                      },
                      childCount: winItems.length,
                    ),
                    /*),
      ),*/
                  );
  }

  Widget buildItem(BuildContext context, int index) {
    final winItem = winItems[index];
    return Material(
      elevation: 0.25,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          AppNavigator.push(
            context: context,
            child: WinItemDetailPage(winItem: winItem),
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
              (winItem.images != null && winItem.images!.length > 0)
                  ? Container(
                      width: 64.w,
                      height: 64.w,
                      child: Center(
                        child: Image.network(winItem.images!.first),
                      ),
                    )
                  : SvgPicture.asset(
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
                      winItem.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTheme().smallParagraphSemiBoldText.copyWith(
                            color: AppTheme().blackColor,
                            fontSize: 16,
                          ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      '${winItem.points.toString()} Points',
                      style: AppTheme().extraSmallParagraphRegularText.copyWith(
                            fontSize: 13,
                            color: AppTheme().greyScale0,
                          ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      child: Text(
                        winItem.description!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style:
                            AppTheme().extraSmallParagraphRegularText.copyWith(
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
  }
}
