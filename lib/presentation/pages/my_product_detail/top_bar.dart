part of 'my_product_detail_page.dart';

class _TopBar extends StatelessWidget {
  final ProductConsumedModel productConsumed;
  const _TopBar({
    Key? key,
    required this.productConsumed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final correctDate = productConsumed.dateTaken?.replaceAll('  ', ' ');
    final newDate = Jiffy('$correctDate', 'EEE MMM dd hh:mm:ss yyyy').yMMMd;
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
                      productConsumed.label ?? '',
                      style: AppTheme().paragraphSemiBoldText.copyWith(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Container(
                      height: 5.h,
                    ),
                    Text(
                      '${productConsumed.points?.toString()} Points per product',
                      style: AppTheme().smallParagraphSemiBoldText.copyWith(
                            color: AppTheme().primaryColor,
                          ),
                    ),
                    Text(
                      'Consumed ${productConsumed.totalproduct?.toString()} ${productConsumed.totalproduct == '1' ? 'time' : 'times'}',
                      style:
                          AppTheme().extraSmallParagraphSemiBoldText.copyWith(),
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
                      'Consumed:',
                      style: AppTheme().smallParagraphSemiBoldText.copyWith(
                            fontSize: AppTheme()
                                    .smallParagraphSemiBoldText
                                    .fontSize! *
                                0.9,
                          ),
                    ),
                    Text(
                      '$newDate',
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
                    if (productConsumed.barcode?.isNotEmpty == true)
                      BarcodeWidget(
                        barcode: productConsumed.barcode?.length == 8
                            ? Barcode.ean8()
                            : Barcode.ean13(),
                        data: productConsumed.barcode ?? '',
                        drawText: false,
                        height: 20.w,
                        margin: EdgeInsets.only(left: 10.w),
                      ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10.w),
                      child: Text(
                        '${productConsumed.barcode?.toString() ?? ''}',
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
