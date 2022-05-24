part of '../chart_page.dart';

class _NutrientsList extends StatelessWidget {
  final ChartViewModel viewModel;
  const _NutrientsList({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30.h,
        ),
        Text(
          'Nutrients',
          style: AppTheme().paragraphSemiBoldText.copyWith(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Container(
          height: 8.h,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: viewModel.nutritionCategories.length,
          itemBuilder: (context, index) {
            final nutrient = viewModel.nutritionCategories[index];
            return buildItem(
              nutrient: nutrient,
            );
          },
        ),
        Container(
          height: 100.h,
        ),
      ],
    );
  }

  Widget buildItem({required nutrient}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme().greyScale2,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Energy',
                style: AppTheme().smallParagraphMediumText.copyWith(
                      fontSize: 14,
                      color: AppTheme().greyScale1,
                    ),
              ),
              Text(
                '341 (kcal) per 100g',
                style: AppTheme().extraSmallParagraphRegularText.copyWith(
                      fontSize: 14,
                      color: AppTheme().greyScale2,
                    ),
              ),
            ],
          ),
          Center(
            child: Container(
              width: 50.w,
              height: 50.w,
              margin: EdgeInsets.only(
                right: 40.w,
                top: 25.w,
              ),
              child: Center(
                child: _NutrientGaugeBar(
                  viewModel: viewModel,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
