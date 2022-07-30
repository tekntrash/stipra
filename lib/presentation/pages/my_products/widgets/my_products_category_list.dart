import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stipra/data/enums/my_product_category.dart';
import 'package:stipra/presentation/widgets/selector_buttons/dropdown_selector_button.dart';

import '../../../../shared/app_theme.dart';

class MyProductsCategoryList extends StatelessWidget {
  final Function(MyProductOrder) onOrderSelected;
  final Function(MyProductDirection) onDirectionSelected;
  final MyProductOrder selectedOrder;
  final MyProductDirection selectedDirection;

  const MyProductsCategoryList({
    Key? key,
    required this.onOrderSelected,
    required this.onDirectionSelected,
    required this.selectedOrder,
    required this.selectedDirection,
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
                onDirectionSelected(selectedDirection == MyProductDirection.asc
                    ? MyProductDirection.desc
                    : MyProductDirection.asc);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'my_earnings_title'.tr,
                            style: AppTheme().largeParagraphBoldText.copyWith(
                                  color: AppTheme().greyScale0,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Icon(
                            selectedDirection == MyProductDirection.asc
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: AppTheme().greyScale0,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownButton2<MyProductOrder>(
                    onChanged: (value) {
                      onOrderSelected(value!);
                    },
                    value: selectedOrder,
                    items: MyProductOrder.values
                        .map<DropdownMenuItem<MyProductOrder>>((e) =>
                            DropdownMenuItem<MyProductOrder>(
                                value: e, child: Text('${e.getOrderName}')))
                        .toList(),
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    style: AppTheme().smallParagraphRegularText.copyWith(
                          color: Colors.black,
                        ),
                    enableFeedback: true,
                    underline: Container(),
                    selectedItemHighlightColor:
                        AppTheme().primaryColor.withOpacity(0.65),
                    dropdownMaxHeight: 200,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    customButton: Container(
                      margin: EdgeInsets.only(right: 15.w),
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.transparent,
                          border: Border.all(
                            color: AppTheme().greyScale4,
                          )),
                      height: 35.h,
                      child: Center(
                        child: Text(
                          'my_earnings_order_by_text'
                              .trParams({'type': selectedOrder.getOrderName}),
                          style:
                              AppTheme().extraSmallParagraphMediumText.copyWith(
                                    color: AppTheme().greyScale2,
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
        ],
      ),
    );
  }
}
