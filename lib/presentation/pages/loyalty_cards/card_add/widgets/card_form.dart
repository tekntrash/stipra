part of '../card_add_page.dart';

class _CardForm extends ViewModelWidget<LoyaltyCardAddViewModel> {
  _CardForm() : super();
  @override
  Widget build(BuildContext context, LoyaltyCardAddViewModel viewModel) {
    log('Card info from form: ${viewModel.creditCardModel.toJson()}');
    return CustomCreditCardForm(
      cardNumber: viewModel.creditCardModel.cardNumber ?? '',
      cvvCode: '',
      expiryDate: viewModel.creditCardModel.expiryDate ?? '',
      cardHolderName: viewModel.creditCardModel.cardHolderName ?? '',
      cardIssuerName: viewModel.creditCardModel.cardIssuerName ?? '',
      formKey: viewModel.formKey,
      onCreditCardModelChange: (data) {
        viewModel.creditCardModel = data;
        viewModel.notifyListeners();
      },
      themeColor: Colors.red,
      cursorColor: Colors.black,
      cardNumberDecoration: decorationCreator(
        'Number',
        'XXXX XXXX XXXX XXXX',
      ),
      expiryDateDecoration: decorationCreator(
        'Expired Date',
        'XX/XX',
      ),
      cvvCodeDecoration: decorationCreator(
        'CVV',
        'XXX',
      ),
      cardHolderDecoration: decorationCreator(
        'Card Holder',
        'Your Name',
      ),
      cardIssuerDecoration: decorationCreator(
        'Card Issuer',
        '',
      ),
    );
  }

  InputDecoration decorationCreator(String label, String hint) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppTheme().smallParagraphRegularText.copyWith(
            color: AppTheme().blackColor,
          ),
      helperStyle: AppTheme().smallParagraphRegularText.copyWith(
            color: Colors.transparent,
          ),
      errorStyle: AppTheme().smallParagraphRegularText.copyWith(
            color: Colors.red[400],
          ),
      hintText: hint,
      hintStyle: AppTheme().smallParagraphRegularText.apply(
            color: AppTheme().greyScale2,
          ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 0,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 0,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 0,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 0,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 0,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
    );
  }
}
