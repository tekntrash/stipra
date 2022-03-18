part of 'product_detail_page.dart';

class _TopBar extends StatelessWidget {
  final ProductModel productModel;
  const _TopBar({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productModel.title ?? '',
          style: AppTheme.headingText.copyWith(
            color: AppTheme.accentFirstColor,
          ),
          overflow: TextOverflow.fade,
          maxLines: 2,
        ),
        Container(
          height: 5.h,
        ),
        Text(
          formatDateyMd(
            monthDayYear: true,
            timeAgo: DateFormat('dd/MM/yyyy')
                .parse(productModel.endDate ?? '')
                .millisecondsSinceEpoch,
            addHM: false,
            isMilliSeconds: true,
          ),
          style: AppTheme.smallParagraphRegularText.copyWith(
            color: AppTheme.gray1Color,
          ),
        ),
        Container(
          height: 2.h,
        ),
        Text(
          '${productModel.awardPoint} Points',
          style: AppTheme.extraSmallParagraphRegularText.copyWith(
            color: AppTheme.gray2Color,
          ),
        ),
      ],
    );
  }
}
