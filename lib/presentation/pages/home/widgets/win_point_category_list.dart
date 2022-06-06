import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/data/enums/win_point_category.dart';

import '../../../../data/models/offer_model.dart';
import '../../../../shared/app_theme.dart';

//* Win point category list
//* Also names as 'products category list'
//* It is creating a list for products' categories

class WinPointCategoryList extends StatefulWidget {
  final Function(WinPointCategory) onCategorySelected;
  final Function(WinPointDirection) onDirectionSelected;
  final WinPointCategory selectedCategory;
  final WinPointDirection selectedDirection;
  final bool selectedExpire;
  final bool selectedOutside;
  final Function(bool) onShowExpiredChanged;
  final Function(bool) onShowOutsideChanged;
  const WinPointCategoryList({
    Key? key,
    required this.onCategorySelected,
    required this.onDirectionSelected,
    required this.selectedCategory,
    required this.selectedDirection,
    required this.onShowExpiredChanged,
    required this.selectedExpire,
    required this.selectedOutside,
    required this.onShowOutsideChanged,
  }) : super(key: key);

  @override
  State<WinPointCategoryList> createState() => _WinPointCategoryListState();
}

class _WinPointCategoryListState extends State<WinPointCategoryList> {
  final List<String> items = [
    'expired',
    'outside',
  ];

  late List<String> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItems = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15.w),
            height:
                ((AppTheme().largeParagraphBoldText.fontSize)?.h ?? 0) * 1.2,
            child: GestureDetector(
              onTap: () {
                widget.onDirectionSelected(
                    widget.selectedDirection == WinPointDirection.asc
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
                            'Earn', //'Products on ${selectedCategory.getCategoryName}',
                            style: AppTheme().largeParagraphBoldText.copyWith(
                                  color: AppTheme().greyScale0,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Icon(
                            widget.selectedDirection == WinPointDirection.asc
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: AppTheme().greyScale0,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownButton2<String>(
                    isExpanded: true,
                    hint: Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        'Select Items',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      log('dsa');
                      if (value == 'expired') {
                        widget.onShowExpiredChanged(!widget.selectedExpire);
                      } else if (value == 'outside') {
                        widget.onShowOutsideChanged(!widget.selectedOutside);
                      }
                    },
                    value: selectedItems.isEmpty ? null : selectedItems.last,
                    items: items.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        //disable default onTap to avoid closing menu when selecting an item
                        enabled: false,
                        child: StatefulBuilder(
                          builder: (context, menuSetState) {
                            final _isSelected = selectedItems.contains(item);
                            return InkWell(
                              onTap: () {
                                _isSelected
                                    ? selectedItems.remove(item)
                                    : selectedItems.add(item);
                                if (item == 'expired') {
                                  widget.onShowExpiredChanged(
                                      !widget.selectedExpire);
                                } else if (item == 'outside') {
                                  widget.onShowOutsideChanged(
                                      !widget.selectedOutside);
                                }
                                //This rebuilds the StatefulWidget to update the button's text
                                //setState(() {});
                                //This rebuilds the dropdownMenu Widget to update the check mark
                                menuSetState(() {});
                              },
                              child: Container(
                                height: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    _isSelected
                                        ? const Icon(Icons.check_box_outlined)
                                        : const Icon(
                                            Icons.check_box_outline_blank),
                                    const SizedBox(width: 16),
                                    Text(
                                      item == 'outside'
                                          ? 'Outside my area'
                                          : item == 'expired'
                                              ? 'Expired'
                                              : item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                    itemHeight: 40,
                    //buttonHeight: 40,
                    //buttonWidth: 140,
                    itemPadding: EdgeInsets.zero,
                    // itemPadding: const EdgeInsets.only(left: 14, right: 14),
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
                    selectedItemBuilder: (context) {
                      return items.map(
                        (item) {
                          return Container(
                            alignment: AlignmentDirectional.center,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              selectedItems.join(', '),
                              style: const TextStyle(
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          );
                        },
                      ).toList();
                    },
                    customButton: Container(
                      margin: EdgeInsets.only(right: 15.w),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.transparent,
                          border: Border.all(
                            color: AppTheme().greyScale4,
                          )),
                      height: 35.h,
                      child: Center(
                        child: Text(
                          'Show with',
                          style:
                              AppTheme().extraSmallParagraphMediumText.copyWith(
                                    color: AppTheme().greyScale2,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  /*GestureDetector(
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
                  ),*/
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
                final bool isFirst = index == widget.selectedCategory.index;
                return Container(
                  margin:
                      EdgeInsets.only(left: index == 0 ? 15.w : 0, right: 8.w),
                  child: GestureDetector(
                    onTap: () {
                      widget.onCategorySelected(WinPointCategory.values[index]);
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
