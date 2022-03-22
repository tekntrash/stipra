part of '../enter_phone_number_page.dart';

class PhoneNumberField extends StatelessWidget {
  final EnterPhoneNumberViewModel viewModel;
  const PhoneNumberField({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: PhoneNumberInputField(
        phonevalidator: viewModel.phonevalidator,
        autoValidateMode: AutovalidateMode.disabled,
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          showFlags: true,
          trailingSpace: false,
          useEmoji: true,
          setSelectorButtonAsPrefixIcon: false,
        ),
        onInputChanged: (PhoneNumber number) {
          print(number.phoneNumber);
          viewModel.phoneNumber = number.phoneNumber;
        },
        onInputValidated: (bool value) {
          //print(value);
        },
        textStyle: AppTheme.smallParagraphMediumText.copyWith(
          fontSize: 16,
          color: AppTheme.blackColor,
        ),
        selectorTextStyle: AppTheme.smallParagraphMediumText.copyWith(
          fontSize: 16,
          color: AppTheme.blackColor,
        ),
      ),
    );
  }
}
