import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/utils/router/app_navigator.dart';
import '../../../../injection_container.dart';
import '../card_add/card_add_page.dart';
import '../data/providers/card_provider.dart';
import '../data/services/card_service.dart';
import '../data/models/custom_credit_card_model.dart';

class CardListViewModel extends ReactiveViewModel {
  final CardService _cardService = locator<CardService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_cardService];

  late bool isInited;

  Future<void> init() async {
    log('hi!');
    isInited = false;
    await updateCardList();
    isInited = true;
  }

  Future<void> updateCardList() async {
    log('hi 2!');
    final cardList = await locator<CardProvider>().getCardList();
    log('hi 3!');
    if (cardList is Right) {
      _cardService.savedCardList = (cardList as Right).value;
    } else {
      _cardService.savedCardList = [];
    }
  }

  List<CustomCreditCardModel> getCardList() {
    return _cardService.savedCardList;
  }

  routeToCardAdd(context) {
    AppNavigator.push(
      context: context,
      child: LoyaltyCardAddPage(),
    );
  }

  routeToCardEdit(context, CustomCreditCardModel cardModel) {
    AppNavigator.push(
      context: context,
      child: LoyaltyCardAddPage(oldCardModel: cardModel),
    );
  }
}
