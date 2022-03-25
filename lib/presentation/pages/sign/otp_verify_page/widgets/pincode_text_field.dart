part of '../otp_verify_page.dart';

class PinCodeWidget extends StatelessWidget {
  final OtpVerifyViewModel viewModel;
  const PinCodeWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: TextStyle(
        color: Colors.green.shade600,
        fontWeight: FontWeight.bold,
      ),
      textStyle: TextStyle(
        color: Colors.black,
      ),
      showCursor: true,
      length: 4,
      obscureText: false,
      obscuringCharacter: '*',
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      validator: (v) {
        return null;
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(15),
        fieldHeight: 52,
        fieldWidth: 44,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveColor: Colors.grey[400],
        selectedColor: Colors.grey[700],
        activeColor: Colors.green[200],
      ),
      cursorColor: Colors.black,
      animationDuration: Duration(milliseconds: 10),
      enableActiveFill: true,
      errorAnimationController: viewModel.errorController,
      errorAnimationDuration: 400,
      animationCurve: Curves.linear,
      controller: viewModel.textEditingController,
      keyboardType: TextInputType.number,
      boxShadows: [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.black12,
          blurRadius: 10,
        )
      ],
      onCompleted: (v) async {
        await viewModel.onConfirmed(context);
        print("Completed");
      },
      // onTap: () {
      //   print("Pressed");
      // },
      onChanged: (value) {
        print(value);
        viewModel.currentPin = value;
        viewModel.notifyListeners();
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        return true;
      },
    );
  }
}
