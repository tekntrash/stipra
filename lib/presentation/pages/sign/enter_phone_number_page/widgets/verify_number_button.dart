part of '../enter_phone_number_page.dart';

class VerifyNumberButton extends StatelessWidget {
  final EnterPhoneNumberViewModel viewModel;
  const VerifyNumberButton({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: CustomButton(
        onPressed: () {
          viewModel.verifyNumber(context);
        },
        text: "Continue",
        options: CustomButtonOptions(
          width: 200,
          height: 60,
          color: AppTheme.primaryColor,
          textStyle: AppTheme.paragraphRegularText.apply(
            color: Colors.black,
          ),
          elevation: 3,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: 8,
        ),
      ),
    );
  }
}
