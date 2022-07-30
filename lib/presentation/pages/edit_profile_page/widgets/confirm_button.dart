part of '../edit_profile_page.dart';

/// A component for showing a button for apply changes in edit profile page

class ConfirmButton extends StatelessWidget {
  final EditProfileViewModel viewModel;
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
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          FocusScope.of(context).unfocus();
          await viewModel.sendChangeEmail(context);
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
                  'change_your_profile_confirm'.tr,
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
