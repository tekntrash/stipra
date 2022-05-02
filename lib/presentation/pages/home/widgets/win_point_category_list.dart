import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/data/enums/win_point_category.dart';

import '../../../../data/models/offer_model.dart';
import '../../../../shared/app_theme.dart';

//* Win point category list
//* Also names as 'products category list'
//* It is creating a list for products' categories

class WinPointCategoryList extends StatelessWidget {
  final Function(WinPointCategory) onCategorySelected;
  final Function(WinPointDirection) onDirectionSelected;
  final WinPointCategory selectedCategory;
  final WinPointDirection selectedDirection;
  final bool selectedExpire;
  final Function(bool) onShowExpiredChanged;
  const WinPointCategoryList({
    Key? key,
    required this.onCategorySelected,
    required this.onDirectionSelected,
    required this.selectedCategory,
    required this.selectedDirection,
    required this.onShowExpiredChanged,
    required this.selectedExpire,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15.w),
            height: ((AppTheme().largeParagraphBoldText.fontSize)?.h ?? 0),
            child: GestureDetector(
              onTap: () {
                onDirectionSelected(selectedDirection == WinPointDirection.asc
                    ? WinPointDirection.desc
                    : WinPointDirection.asc);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Products', //'Products on ${selectedCategory.getCategoryName}',
                            style: AppTheme().largeParagraphBoldText.copyWith(
                                  color: AppTheme().greyScale0,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Icon(
                            selectedDirection == WinPointDirection.asc
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: AppTheme().greyScale0,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      onShowExpiredChanged(!selectedExpire);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15.w),
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: selectedExpire
                              ? AppTheme().darkPrimaryColor
                              : Colors.transparent,
                          border: Border.all(
                            color: selectedExpire
                                ? AppTheme().darkPrimaryColor
                                : AppTheme().greyScale4,
                          )),
                      height: 35.h,
                      child: Center(
                        child: Text(
                          'Include expired',
                          style:
                              AppTheme().extraSmallParagraphMediumText.copyWith(
                                    color: selectedExpire
                                        ? AppTheme().greyScale6
                                        : AppTheme().greyScale2,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 35.h,
            child: ListView.builder(
              itemCount: WinPointCategory.values.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final bool isFirst = index == selectedCategory.index;
                return Container(
                  margin:
                      EdgeInsets.only(left: index == 0 ? 15.w : 0, right: 8.w),
                  child: GestureDetector(
                    onTap: () {
                      onCategorySelected(WinPointCategory.values[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: isFirst
                              ? AppTheme().darkPrimaryColor
                              : Colors.transparent,
                          border: Border.all(
                            color: isFirst
                                ? AppTheme().darkPrimaryColor
                                : AppTheme().greyScale4,
                          )),
                      height: 35.h,
                      child: Center(
                        child: Text(
                          WinPointCategory.values[index].getCategoryName,
                          style:
                              AppTheme().extraSmallParagraphMediumText.copyWith(
                                    color: isFirst
                                        ? AppTheme().greyScale6
                                        : AppTheme().greyScale2,
                                  ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
