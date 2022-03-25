part of 'trading_offer_detail_page.dart';

class _TopBar extends StatelessWidget {
  final OfferModel offerModel;
  const _TopBar({
    Key? key,
    required this.offerModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          offerModel.title ?? '',
          style: AppTheme().largeParagraphBoldText.copyWith(
                color: AppTheme().blackColor,
              ),
          overflow: TextOverflow.fade,
          maxLines: 2,
        ),
        Container(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.access_time,
                      color: AppTheme().greyScale0,
                      size: 22,
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  TextSpan(
                    text: ' ${offerModel.endDate}',
                    style: AppTheme().extraSmallParagraphRegularText.copyWith(
                          color: AppTheme().greyScale0,
                        ),
                  ),
                ],
              ),
            ),
            Text(
              'Level: ALL',
              style: AppTheme().extraSmallParagraphRegularText.copyWith(
                    color: AppTheme().greyScale0,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
