import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/presentation/pages/loyalty_cards/data/models/custom_credit_card_model.dart';

import '../../../../injection_container.dart';
import '../card_scan/card_scan_page.dart';
import '../data/services/card_service.dart';

class LoyaltyCardAddViewModel extends ReactiveViewModel {
  final CardService _cardService = locator<CardService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_cardService];

  late CustomCreditCardModel creditCardModel;
  late CustomCreditCardModel oldCreditCardModel;
  GlobalKey<FormState> formKey = GlobalKey();
  late bool isEditMode;

  void init(CustomCreditCardModel? oldCardModel) {
    if (oldCardModel != null) {
      isEditMode = true;
      oldCreditCardModel = oldCardModel;
      creditCardModel = oldCardModel;
    } else {
      isEditMode = false;
      creditCardModel = CustomCreditCardModel();
    }
  }

  Future<void> scanCard(BuildContext context) async {
    log('Routed');
    final cardInformation = await AppNavigator.push<CustomCreditCardModel?>(
      context: context,
      child: LoyaltyCardScanPage(),
    );
    if (cardInformation != null) {
      log('Card Information: ${cardInformation.toJson()}');
      creditCardModel = cardInformation;

      notifyListeners();
    } else {
      //
    }
  }

  Future<void> saveCard(BuildContext context) async {
    final isAllFilled = isCardInformationCorrect();
    if (isAllFilled) {
      if (isEditMode) {
        _cardService.updateSavedCard(oldCreditCardModel, creditCardModel);
      } else {
        _cardService.addSavedCard(creditCardModel);
      }
      Navigator.of(context).pop();
    } else {
      return;
    }
  }

  bool isCardInformationCorrect() {
    if (formKey.currentState?.validate() == true) {
      return true;
    }
    return false;
  }
}
