part of '../otp_verify_page.dart';

class ConfirmButton extends StatelessWidget {
  final OtpVerifyViewModel viewModel;
  const ConfirmButton({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: CustomButton(
        onPressed: () async {
          await viewModel.onConfirmed(context);
        },
        child: Center(
          child: viewModel.isCheckingPin
              ? Center(
                  child: Container(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  ),
                )
              : Text(
                  'Confirm',
                  style: AppTheme.buttonText.copyWith(color: Colors.white),
                ),
        ),
        options: CustomButtonOptions(
          width: 200,
          height: 60,
          color: AppTheme.primaryColor,
          textStyle: AppTheme.buttonText.apply(color: Colors.black),
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
