part of '../delete_account_page.dart';

class _ConfirmButton extends StatelessWidget {
  final DeleteAccountViewModel viewModel;
  const _ConfirmButton({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: CustomButton(
        onPressed: () async {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          FocusScope.of(context).unfocus();
          await viewModel.sendForgotPassword(context);
        },
        child: Center(
          child: viewModel.isSending
              ? Center(
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  ),
                )
              : Text(
                  'remove_profile_confirm_button_text'.tr,
                  style: AppTheme().buttonText.copyWith(color: Colors.white),
                ),
        ),
        options: CustomButtonOptions(
          width: 230.w,
          height: 50.h,
          color: AppTheme().darkPrimaryColor,
          textStyle: AppTheme().buttonText.apply(color: Colors.black),
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
