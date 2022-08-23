import 'package:stacked/stacked.dart';

import '../../../../core/utils/router/app_navigator.dart';
import '../card_add/card_add_page.dart';

class CardListViewModel extends BaseViewModel {
  //
  routeToCardAdd(context) {
    AppNavigator.push(
      context: context,
      child: LoyaltyCardAddPage(),
    );
  }
}
