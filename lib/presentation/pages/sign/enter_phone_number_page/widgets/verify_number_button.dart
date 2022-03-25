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
      margin: EdgeInsets.all(5.w),
      child: CustomButton(
        onPressed: () {
          viewModel.verifyNumber(context);
        },
        text: "Continue",
        options: CustomButtonOptions(
          width: 230.w,
          height: 50.h,
          color: AppTheme().darkPrimaryColor,
          textStyle: AppTheme().paragraphRegularText.apply(
                color: Colors.white,
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
