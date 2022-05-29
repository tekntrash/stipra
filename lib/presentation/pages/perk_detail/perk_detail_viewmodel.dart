import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/errors/failure.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/data/models/trade_item_model.dart';
import 'package:stipra/injection_container.dart';
import 'package:stipra/presentation/pages/trade/trade_dialog.dart';
import 'package:stipra/presentation/widgets/overlay/lock_overlay.dart';
import 'package:stipra/presentation/widgets/overlay/lock_overlay_dialog.dart';
import 'package:stipra/presentation/widgets/overlay/snackbar_overlay.dart';
import 'package:stipra/presentation/widgets/overlay/widgets/location_permission_dialog.dart';

import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';

/// Controlling the perk detail page
/// Handling buttons from here
/// Trade dialog opens from here and trade functionality
/// happening in this controller.

class PerkDetailViewModel extends BaseViewModel {
  late bool isInited;

  Future<void> init() async {
    isInited = false;

    isInited = true;
    notifyListeners();
  }

  /// Show user the trade dialog
  /// If not logged prevent and show a dialog for log in.
  Future<dynamic> showTrade(
    BuildContext context,
    TradeItemModel tradeItem,
  ) async {
    final user = locator<LocalDataRepository>().getUser();
    if (user.alogin == null) {
      SnackbarOverlay().show(
        text: 'Login first to trade your points.',
        buttonText: 'OK',
        buttonTextColor: Colors.red,
        addFrameCallback: true,
        onTap: () {
          SnackbarOverlay().closeCustomOverlay();
        },
        removeDuration: Duration(seconds: 10),
        forceOverlay: true,
      );
      notifyListeners();
      return;
    }
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) => TradeDialog(
        tradeItem: tradeItem,
        button1Text: 'Trade',
        button2Text: 'Cancel',
        descriptionText: 'You can trade your points for this perk.',
        onClickOutside: () {},
        onButton1Tap: (int amount) {
          trade(tradeItem, amount);
          Navigator.of(context).pop();
        },
        onButton2Tap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  /// When click trade button from dialog, this method will be called
  /// And will trade the item with amount as given by user
  /// Then will request for points from backend and update the UI
  /// If success will show a dialog about 'success' with gif
  /// If not will show a ui with error message
  Future<void> trade(TradeItemModel tradeItem, int amount) async {
    LockOverlay().showClassicLoadingOverlay(buildAfterRebuild: true);
    final result = await locator<DataRepository>().tradePoints(
      int.parse(tradeItem.id!),
      amount,
    );
    await locator<DataRepository>().getPoints();
    LockOverlay().closeOverlay();
    if (result is Right) {
      LockOverlayDialog().showCustomOverlay(
        child: LocationPermissionDialog(
          titleText: 'Trade success!',
          descriptionText: '${(result as Right).value}',
          button1Text: 'Done',
          button2Text: 'Cancel',
          image: 'giphy.gif',
          onButton1Tap: () {
            LockOverlayDialog().closeOverlay();
          },
          disableCancelButton: true,
        ),
      );
    } else {
      if ((result as Left).value is ServerFailure) {
        SnackbarOverlay().show(
          text: '${((result as Left).value as ServerFailure).errorMessage}',
          buttonText: 'OK',
          buttonTextColor: Colors.red,
          addFrameCallback: true,
          onTap: () {
            SnackbarOverlay().closeCustomOverlay();
          },
          removeDuration: Duration(seconds: 10),
          forceOverlay: true,
        );
      } else {
        SnackbarOverlay().show(
          text: '${(result as Left).value.toString()}',
          buttonText: 'OK',
          buttonTextColor: Colors.red,
          addFrameCallback: true,
          onTap: () {
            SnackbarOverlay().closeCustomOverlay();
          },
          removeDuration: Duration(seconds: 10),
          forceOverlay: true,
        );
      }
    }
    notifyListeners();
  }
}
