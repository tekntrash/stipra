part of '../otp_verify_page.dart';

class BottomInfoWidget extends StatelessWidget {
  const BottomInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(bottom: 25),
        alignment: Alignment.bottomCenter,
        child: Text('Stipra all rights reserved'),
      ),
    );
  }
}
