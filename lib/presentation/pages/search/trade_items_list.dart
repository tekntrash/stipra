part of 'search_page.dart';

class _TradeItemsList extends StatelessWidget {
  final List<TradeItemModel> tradeItems;
  final bool isSearched;
  const _TradeItemsList({
    Key? key,
    required this.tradeItems,
    required this.isSearched,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return buildTradeItem(context, index);
        },
        childCount: tradeItems.length,
      ),
    );
  }

  Widget buildTradeItem(BuildContext context, int index) {
    final tradeItem = tradeItems[index];
    return Material(
      elevation: 0.25,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          //
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
              (tradeItem.image != null)
                  ? Container(
                      width: 64.w,
                      height: 64.w,
                      child: Center(
                        child: Image.network(tradeItem.image!),
                      ),
                    )
                  : SvgPicture.asset(
                      'assets/images/image_box.svg',
                      width: 64.w,
                      height: 64.w,
                      semanticsLabel: 'Image box',
                    ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tradeItem.name!,
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
                      'Level ${tradeItem.level.toString()}',
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
                        tradeItem.description!,
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
