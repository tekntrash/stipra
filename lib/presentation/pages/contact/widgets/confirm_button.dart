part of '../contact_page.dart';

/// Button for use in contact page

class _SendButton extends StatelessWidget {
  final ContactViewModel viewModel;
  const _SendButton({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.w),
      child: CustomButton(
        onPressed: () async {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          FocusScope.of(context).unfocus();
          await viewModel.sendMail(context);
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
                  'Send',
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
