import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../shared/app_theme.dart';
import 'classic_text.dart';

//* A component for date selector.
//* This component providing a date selector functionality and showing a selected date with initial date.

class DateField extends StatelessWidget {
  final String title;
  final Function(DateTime?) onDateChange;
  final DateTime? initialDate;
  final bool showErrorOnlyIfTrue;
  final ValueNotifier<String?>? notifier;
  final int? minAge;
  const DateField({
    Key? key,
    required this.title,
    this.initialDate,
    this.showErrorOnlyIfTrue: false,
    this.notifier,
    required this.onDateChange,
    this.minAge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Container(
              padding: EdgeInsets.only(bottom: 5.h, left: 5.w),
              child: ClassicText(
                text: title,
                style: AppTheme().smallParagraphRegularText.copyWith(),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: _CupertinoDateTextBox(
                    textColor: Colors.black,
                    pickerBackgroundColor: Colors.white,
                    initialValue: initialDate,
                    onDateChange: onDateChange,
                    hintText: 'Select Date',
                    fontSize: AppTheme().smallParagraphMediumText.fontSize!,
                  ),
                ),
              ),
              if (notifier != null)
                ValueListenableBuilder(
                  valueListenable: notifier!,
                  builder: (context, String? error, child) {
                    if (showErrorOnlyIfTrue && error == null)
                      return Container();
                    return TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 200),
                      builder:
                          (BuildContext context, double size, Widget? child) {
                        return Opacity(
                          opacity: size,
                          child: Transform.translate(
                            offset: Offset(
                              0,
                              (1.0 - size) * -2.0,
                            ),
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom: 5, left: 11.w, top: 5),
                              child: ClassicText(
                                text: error ?? '',
                                style: AppTheme()
                                    .smallParagraphRegularText
                                    .copyWith(
                                      color: Colors.red[400],
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CupertinoDateTextBox extends StatefulWidget {
  /// A text box widget which displays a cupertino picker to select a date if clicked
  _CupertinoDateTextBox({
    required this.initialValue,
    required this.onDateChange,
    required this.hintText,
    this.textColor,
    this.hintColor = CupertinoColors.black,
    this.pickerBackgroundColor = CupertinoColors.systemBackground,
    this.fontSize = 17.0,
    this.textfieldPadding = const EdgeInsets.fromLTRB(12, 16, 12, 16),
    this.enabled = true,
    this.labelText,
    this.helperText,
    this.style,
  });

  final TextStyle? style;

  /// The initial value which shall be displayed in the text box
  final DateTime? initialValue;

  /// The function to be called if the selected date changes
  final Function onDateChange;

  /// The text to be displayed if no initial value is given
  final String hintText;

  /// The color of the text within the text box
  final Color? textColor;

  /// The color of the hint text within the text box
  final Color hintColor;

  /// The background color of the cupertino picker
  final Color pickerBackgroundColor;

  /// The size of the font within the text box
  final double fontSize;

  /// The inner padding within the text box
  final EdgeInsets textfieldPadding;

  /// Specifies if the text box can be modified
  final bool enabled;

  final String? labelText, helperText;

  @override
  _CupertinoDateTextBoxState createState() => new _CupertinoDateTextBoxState();
}

class _CupertinoDateTextBoxState extends State<_CupertinoDateTextBox> {
  final double _kPickerSheetHeight = 250.0;

  DateTime? _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant _CupertinoDateTextBox oldWidget) {
    if (widget.initialValue != oldWidget.initialValue)
      _currentDate = widget.initialValue;
    super.didUpdateWidget(oldWidget);
  }

  void callCallback() {
    widget.onDateChange(_currentDate);
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: TextStyle(
          color: widget.textColor,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  void onSelectedDate(DateTime date) {
    setState(() {
      _currentDate = date;
    });
  }

  Widget _buildTextField(String hintText, Function onSelectedFunction) {
    String fieldText;
    Color textColor;
    if (_currentDate != null) {
      final formatter = new DateFormat.yMd();
      fieldText = formatter.format(_currentDate!);
      textColor = widget.textColor ?? Colors.black;
    } else {
      fieldText = hintText;
      textColor = widget.hintColor;
    }

    return new Flexible(
      child: new GestureDetector(
        onTap: !widget.enabled
            ? null
            : () async {
                if (_currentDate == null) {
                  setState(() {
                    _currentDate = DateTime.now();
                  });
                }
                await showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildBottomPicker(CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        backgroundColor: widget.pickerBackgroundColor,
                        initialDateTime: _currentDate,
                        onDateTimeChanged: (DateTime newDateTime) {
                          onSelectedFunction(newDateTime);
                          // call callback
                          callCallback();
                        }));
                  },
                );

                // call callback
                callCallback();
              },
        child: new InputDecorator(
          decoration: InputDecoration(
            helperText: widget.helperText,
            labelText: widget.labelText,
            labelStyle: AppTheme().smallParagraphRegularText.copyWith(),
            helperStyle: AppTheme().smallParagraphRegularText.copyWith(
                  color: Colors.transparent,
                ),
            errorStyle: AppTheme().smallParagraphRegularText.copyWith(
                  color: Colors.red[400],
                ),
            hintText: widget.hintText,
            hintStyle: AppTheme().smallParagraphRegularText.apply(
                  color: widget.hintColor,
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
            border: OutlineInputBorder(
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
            //isDense: true,
            /*hintText: hintText,
            hintStyle: TextStyle(
                color: CupertinoColors.inactiveGray, fontSize: widget.fontSize),*/
            contentPadding: widget.textfieldPadding,
            /*enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: const BorderSide(
                    color: CupertinoColors.inactiveGray, width: 0.0)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: const BorderSide(
                    color: CupertinoColors.inactiveGray, width: 0.0)),*/
          ),
          child: new Text(fieldText,
              style: widget.style ??
                  AppTheme()
                      .smallParagraphRegularText
                      .copyWith(color: textColor)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      _buildTextField(widget.hintText, onSelectedDate),
    ]);
  }
}
