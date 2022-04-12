import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/app_theme.dart';
import '../classic_text.dart';
import 'listenable_error_text.dart';

class DropdownSelectorButton extends StatefulWidget {
  final List items;
  final String title, unSelectedTitle;
  final Function(String selected) onChanged;
  final ValueNotifier<String?>? errorNotifier;
  final String? selected;
  final Function? onTap;
  DropdownSelectorButton({
    Key? key,
    required this.title,
    required this.unSelectedTitle,
    required this.items,
    required this.onChanged,
    this.selected,
    this.errorNotifier,
    this.onTap,
  }) : super(key: key);

  @override
  _DropdownSelectorButtonState createState() => _DropdownSelectorButtonState();
}

class _DropdownSelectorButtonState extends State<DropdownSelectorButton> {
  String? selected;
  @override
  void initState() {
    if (widget.selected != null && widget.selected!.isNotEmpty)
      selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Container(
              padding: EdgeInsets.only(bottom: 5, left: 5),
              child: ClassicText(
                text: widget.title,
                style: AppTheme().smallParagraphMediumText.copyWith(
                      fontSize: AppTheme().paragraphSemiBoldText.fontSize,
                    ),
              ),
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              customButton: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: buildWithInputDecorator(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    ClassicText(
                                      text: selected != null
                                          ? selected!
                                          : widget.unSelectedTitle,
                                      style:
                                          AppTheme().smallParagraphRegularText,
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.chevron_right,
                                          size: 24,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              items: widget.items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: AppTheme().smallParagraphRegularText.copyWith(
                                color: Colors.black,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              value: selected,
              onChanged: (value) {
                selected = value as String;

                widget.onChanged(selected!);
                setState(() {});
              },
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              style: AppTheme().smallParagraphRegularText.copyWith(
                    color: Colors.black,
                  ),
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
            ),
          ),
          if (widget.errorNotifier != null)
            ListenableErrorText(
              notifier: widget.errorNotifier!,
              showErrorOnlyIfTrue: true,
            ),
        ],
      ),
    );
  }

  Widget buildWithInputDecorator(Widget child) {
    return new InputDecorator(
      decoration: InputDecoration(
        helperText: null,
        labelText: null,
        labelStyle: AppTheme().smallParagraphRegularText,
        helperStyle: AppTheme().smallParagraphRegularText.copyWith(
              color: Colors.transparent,
            ),
        errorStyle: AppTheme().smallParagraphRegularText.copyWith(
              color: Colors.red[400],
            ),
        hintText: widget.title,
        hintStyle: AppTheme().smallParagraphRegularText.apply(
              color: Colors.grey,
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
      ),
      child: child,
    );
  }
}
