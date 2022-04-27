part of 'perk_detail_page.dart';

class _TopBar extends StatelessWidget {
  final TradeItemModel tradeItem;
  const _TopBar({
    Key? key,
    required this.tradeItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tradeItem.name ?? '',
                      style: AppTheme().paragraphSemiBoldText.copyWith(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      '${tradeItem.minimumpoints?.toString()} Points',
                      style: AppTheme().smallParagraphSemiBoldText.copyWith(
                            color: AppTheme().primaryColor,
                          ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Level: ',
                            style:
                                AppTheme().smallParagraphSemiBoldText.copyWith(
                                      color: Colors.black,
                                      fontSize: AppTheme()
                                              .smallParagraphSemiBoldText
                                              .fontSize! *
                                          0.95,
                                    ),
                          ),
                          TextSpan(
                            text: ' ${tradeItem.level?.toString() ?? ''}',
                            style:
                                AppTheme().smallParagraphRegularText.copyWith(
                                      color: AppTheme().greyScale2,
                                      fontSize: AppTheme()
                                              .smallParagraphSemiBoldText
                                              .fontSize! *
                                          0.85,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Valid until',
                      style: AppTheme().smallParagraphSemiBoldText.copyWith(),
                    ),
                    Text(
                      '${tradeItem.enddate?.toString() ?? ''}',
                      style: AppTheme().smallParagraphRegularText.copyWith(
                            color: AppTheme().greyScale2,
                            fontSize: AppTheme()
                                    .smallParagraphSemiBoldText
                                    .fontSize! *
                                0.8,
                          ),
                    ),
                    /*Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 36,
                          color: Color.fromARGB(255, 255, 235, 96),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '4.5',
                          style:
                              AppTheme().smallParagraphSemiBoldText.copyWith(),
                        ),
                      ],
                    ),
                    IntrinsicWidth(
                      child: Text(
                        '(230 reviews)',
                        style:
                            AppTheme().extraSmallParagraphRegularText.copyWith(
                                  color: AppTheme().greyScale2,
                                  fontSize: 10,
                                ),
                      ),
                    ),*/
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: 2.h,
        ),
      ],
    );
  }
}
