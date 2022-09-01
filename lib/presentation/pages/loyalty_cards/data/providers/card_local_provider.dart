import 'dart:async';

import 'package:stipra/presentation/pages/loyalty_cards/data/models/custom_credit_card_model.dart';

class CardLocalProvider {
  final _cardLocalBoxName = 'cardsLocalBoxName';

  Future<void> init() async {}

  Future<List<CustomCreditCardModel>> getLastCampaigns() async {
    return List<CustomCreditCardModel>.empty();
  }

  Future<void> cacheLastCampaign(List<CustomCreditCardModel> campaigns) async {}
}
