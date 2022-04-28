import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stipra/data/models/trade_item_model.dart';
import 'package:stipra/data/models/user_model.dart';
import 'package:stipra/injection_container.dart';
import 'package:stipra/presentation/widgets/overlay/snackbar_overlay.dart';

import '../../../../shared/app_theme.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../widgets/theme_button.dart';

class TradeDialog extends StatefulWidget {
  final String button1Text, button2Text, descriptionText;
  final Function(int amount) onButton1Tap;
  final Function()? onButton2Tap, onResume, onClickOutside;
  final TradeItemModel tradeItem;
  const TradeDialog({
    Key? key,
    this.descriptionText = 'We need your location to verify your videos.',
    this.button1Text = '',
    this.button2Text = '',
    required this.onButton1Tap,
    this.onButton2Tap,
    this.onResume,
    this.onClickOutside,
    required this.tradeItem,
  }) : super(key: key);

  @override
  State<TradeDialog> createState() => _TradeDialogState();
}

class _TradeDialogState extends State<TradeDialog> {
  late int amount, maxAmount, minAmount, points, minPoints, maxPoints;
  @override
  void initState() {
    amount = 1;
    points = int.parse(widget.tradeItem.points ?? '1');
    maxPoints = int.parse(widget.tradeItem.maximumpoints ?? '1');
    minPoints = int.parse(widget.tradeItem.minimumpoints ?? '1');
    maxAmount = int.parse(widget.tradeItem.maximumpoints ?? '1') ~/ minPoints;
    minAmount = int.parse(widget.tradeItem.minimumpoints ?? '1') ~/ minPoints;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onClickOutside != null) widget.onClickOutside!();
        Navigator.of(context).pop();
      },
      child: Material(
        color: AppTheme().blackColor.withOpacity(0.55),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Trade for ${widget.tradeItem.name}',
                      style: AppTheme().paragraphSemiBoldText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*Row(
                    children: [
                      Expanded(
                        child: userPointText(),
                      ),
                    ],
                  ),*/
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'You can change the perk amount by tapping the number buttons.',
                      style: AppTheme().smallParagraphRegularText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  basketAmountButton(),
                  /*Text(
                    'Trading: ${amount * points} points',
                    style: AppTheme().paragraphRegularText,
                    textAlign: TextAlign.center,
                  ),*/
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        ThemeButton(
                          color: AppTheme().darkPrimaryColor,
                          height: 42,
                          onTap: () {
                            widget.onButton1Tap(amount * minPoints);
                            //LockOverlayDialog().closeOverlay();
                          },
                          text: 'Trade: ${amount * minPoints} Points',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ThemeButton(
                          height: 42,
                          color: Colors.transparent,
                          textColor: Colors.black,
                          isEnabled: false,
                          elevation: 0,
                          onTap: () {
                            if (widget.onButton2Tap != null)
                              widget.onButton2Tap!();
                            //LockOverlayDialog().closeOverlay();
                          },
                          text: widget.button2Text,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*Widget userPointText() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.centerLeft,
      child: StreamBuilder<UserModel>(
        stream: locator<LocalDataRepository>().userStream,
        initialData: locator<LocalDataRepository>().getUser(),
        builder: (context, snapshot) {
          log('Snapshot data: ${snapshot.data}');
          if (snapshot.hasData && snapshot.data?.userid != null) {
            return FutureBuilder(
              future: locator<DataRepository>().getPoints(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    'Your points: ${(snapshot.data as dynamic).value}',
                    style: AppTheme().smallParagraphRegularText.copyWith(
                          color: AppTheme().greyScale1,
                        ),
                    textAlign: TextAlign.left,
                  );
                } else {
                  return Text(
                    'Loading...',
                    style: AppTheme().smallParagraphRegularText.copyWith(
                          color: AppTheme().greyScale1,
                        ),
                    textAlign: TextAlign.left,
                  );
                }
              },
            );
          } else {
            return Text(
              'Login to see your points',
              style: AppTheme().smallParagraphRegularText.copyWith(
                    color: AppTheme().greyScale1,
                  ),
            );
          }
        },
      ),
    );
  }*/

  //create a basket amount increaser decreaser button with functionality to change amount variable
  Widget basketAmountButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ThemeButton(
            width: 65,
            height: 35,
            color: AppTheme().darkPrimaryColor,
            elevation: 5,
            onTap: () {
              if (amount <= minAmount) {
                SnackbarOverlay().show(
                  text:
                      'You can not trade less than ${minAmount * int.parse(widget.tradeItem.points ?? '1')} points',
                  buttonText: 'OK',
                  buttonTextColor: Colors.red,
                  addFrameCallback: true,
                  onTap: () {
                    SnackbarOverlay().closeCustomOverlay();
                  },
                  removeDuration: Duration(seconds: 10),
                  forceOverlay: true,
                );
                return;
              }
              amount--;
              setState(() {});
            },
            child: Icon(Icons.remove),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '${amount * points}',
            style: AppTheme().paragraphRegularText.copyWith(
                  fontSize: AppTheme().paragraphRegularText.fontSize! * 1.25,
                ),
          ),
          SizedBox(
            width: 10,
          ),
          ThemeButton(
            width: 65,
            height: 35,
            color: AppTheme().darkPrimaryColor,
            elevation: 5,
            onTap: () {
              if (amount >= maxAmount) {
                SnackbarOverlay().show(
                  text:
                      'You can not trade more than ${maxAmount * int.parse(widget.tradeItem.points ?? '1')} points',
                  buttonText: 'OK',
                  buttonTextColor: Colors.red,
                  addFrameCallback: true,
                  onTap: () {
                    SnackbarOverlay().closeCustomOverlay();
                  },
                  removeDuration: Duration(seconds: 10),
                  forceOverlay: true,
                );
                return;
              }
              amount++;
              setState(() {});
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
