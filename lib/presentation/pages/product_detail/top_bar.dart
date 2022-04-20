part of 'win_item_detail_page.dart';

class _TopBar extends StatelessWidget {
  final WinItemModel winItem;
  const _TopBar({
    Key? key,
    required this.winItem,
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
                      winItem.name ?? '',
                      style: AppTheme().paragraphSemiBoldText.copyWith(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Container(
                      height: 5.h,
                    ),
                    Text(
                      '${winItem.points?.toString()} Points',
                      style: AppTheme().smallParagraphSemiBoldText.copyWith(
                            color: AppTheme().primaryColor,
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
                      '${winItem.enddate?.toString() ?? ''}',
                      style: AppTheme().smallParagraphRegularText.copyWith(
                            color: AppTheme().greyScale2,
                            fontSize: AppTheme()
                                    .smallParagraphSemiBoldText
                                    .fontSize! *
                                0.8,
                          ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BarcodeWidget(
                      barcode: Barcode.ean13(),
                      data: winItem.barcode ?? '',
                      drawText: false,
                      height: 20.w,
                      margin: EdgeInsets.only(left: 10.w),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10.w),
                      child: Text(
                        '${winItem.barcode?.toString() ?? ''}',
                        style: AppTheme().smallParagraphRegularText.copyWith(
                              color: AppTheme().greyScale2,
                              fontSize: AppTheme()
                                      .smallParagraphSemiBoldText
                                      .fontSize! *
                                  0.55,
                            ),
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
