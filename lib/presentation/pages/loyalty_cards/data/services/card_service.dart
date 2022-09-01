import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/loyalty_cards/data/models/custom_credit_card_model.dart';

@lazySingleton
class CardService with ReactiveServiceMixin {
  CardService() {
    listenToReactiveValues([_selectedCreditCard, _savedCardList]);
  }

  ReactiveValue<CustomCreditCardModel?> _selectedCreditCard =
      ReactiveValue<CustomCreditCardModel?>(null);

  CustomCreditCardModel? get selectedCreditCard => _selectedCreditCard.value;

  void selectCreditCard(CustomCreditCardModel cardModel) {
    _selectedCreditCard.value = cardModel;
  }

  void unSelectCreditCard() {
    _selectedCreditCard.value = null;
  }

  ReactiveValue<List<CustomCreditCardModel>> _savedCardList =
      ReactiveValue<List<CustomCreditCardModel>>([]);

  List<CustomCreditCardModel> get savedCardList => _savedCardList.value;

  set savedCardList(List<CustomCreditCardModel> cardList) {
    _savedCardList.value = cardList;
  }

  void addSavedCard(CustomCreditCardModel cardModel) {
    _savedCardList.value.add(cardModel);
    notifyListeners();
  }

  void updateSavedCard(
      CustomCreditCardModel oldCardModel, CustomCreditCardModel newCardModel) {
    final index = _savedCardList.value.indexOf(oldCardModel);
    _savedCardList.value[index] = newCardModel;
    notifyListeners();
  }

  void removeSavedCard(CustomCreditCardModel cardModel) {
    _savedCardList.value.remove(cardModel);
    notifyListeners();
  }
}
