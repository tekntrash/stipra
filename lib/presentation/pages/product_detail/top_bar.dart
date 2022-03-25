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
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.title ?? '',
                      style: AppTheme().paragraphSemiBoldText.copyWith(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Container(
                      height: 5.h,
                    ),
                    Text(
                      '200 Points',
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
                    Row(
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
                    ),
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
