import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:rest_api_package/requests/rest_api_request.dart';
import 'package:rest_api_package/rest_api_package.dart';
import 'package:stipra/presentation/pages/loyalty_cards/data/providers/card_local_provider.dart';

import '../../../../../core/services/_data_service.dart';
import '../../../../../injection_container.dart';
import '../models/custom_credit_card_model.dart';
import '../requests/get_campaigns_request.dart';

@LazySingleton()
class CardProvider extends DataService {
  Future<DataModel<List<CustomCreditCardModel>>> getCardList() async {
    return getDataList<CustomCreditCardModel>(
      parseModel: CustomCreditCardModel.new,
      request: GetCardsRequest(),
      mockUrl: 'test/fixtures/card_lists.json',
      getCache: locator<CardLocalProvider>().getLastCampaigns,
      saveCache: locator<CardLocalProvider>().cacheLastCampaign,
    );
  }

  Future<void> updateCard() async {
    final result = await locator<RestApiHttpService>().request(
      RestApiRequest(),
    );
    log('Data: ${result.data}');
  }
}
