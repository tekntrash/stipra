part of '../card_list_page.dart';

class _CardListView extends ViewModelWidget<CardListViewModel> {
  @override
  Widget build(BuildContext context, CardListViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.getCardList().length,
      itemBuilder: (context, index) {
        final cardModel = viewModel.getCardList()[index];
        return GestureDetector(
          onTap: () {
            viewModel.routeToCardEdit(context, cardModel);
          },
          child: CustomCreditCardWidget(
            cardNumber: cardModel.cardNumber ?? '',
            expiryDate: cardModel.expiryDate ?? '',
            cardHolderName: cardModel.cardHolderName ?? '',
            cvvCode: '',
            showBackView: false,
            onCreditCardWidgetChange: (creditCardBrand) {
              //
            },
            customCardTypeIcons: [
              CustomCardTypeIcon(
                cardType: CardType.otherBrand,
                cardImage: cardModel.cardIssuerName.getIconFromIssuer,
              ),
            ],
            cardType: CardType.otherBrand,
            isSwipeGestureEnabled: false,
            isHolderNameVisible: true,
            cardBgColor: cardModel.cardIssuerName.getColorFromIssuer,
            isChipVisible: false,
            obscureCardNumber: false,
            numberTextStyle: AppTheme().smallParagraphRegularText.copyWith(
                  fontSize: 18,
                  color: AppTheme().whiteColor,
                ),
            textStyle: AppTheme().smallParagraphRegularText.copyWith(
                  color: AppTheme().whiteColor,
                ),
            titleTextStyle: AppTheme().extraSmallParagraphRegularText.copyWith(
                  color: AppTheme().whiteColor,
                  fontSize: 12,
                ),
            borderRadius: 15,
            bankName: cardModel.cardIssuerName?.toUpperCase(),
          ),
        );
      },
    );
  }
}
