part of '../card_add_page.dart';

class _CardView extends ViewModelWidget<LoyaltyCardAddViewModel> {
  @override
  Widget build(BuildContext context, LoyaltyCardAddViewModel viewModel) {
    log('sr: ${viewModel.cardIssuer}');
    return CustomCreditCardWidget(
      cardNumber: viewModel.cardNumber,
      expiryDate: viewModel.expiryDate,
      cardHolderName: viewModel.cardHolderName,
      cvvCode: '',
      showBackView: false,
      onCreditCardWidgetChange: (creditCardBrand) {
        //
      },
      customCardTypeIcons: [
        CustomCardTypeIcon(
          cardType: CardType.otherBrand,
          cardImage: viewModel.cardIssuer.getIconFromIssuer,
        ),
      ],
      cardType: CardType.otherBrand,
      isSwipeGestureEnabled: false,
      isHolderNameVisible: true,
      cardBgColor: viewModel.cardIssuer.getColorFromIssuer,
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
      bankName: viewModel.cardIssuer.toUpperCase(),
    );
  }
}
