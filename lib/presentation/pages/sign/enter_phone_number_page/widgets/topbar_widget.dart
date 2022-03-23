part of '../enter_phone_number_page.dart';

class TopBarWidget extends StatelessWidget {
  final bool? isSignIn;
  const TopBarWidget({
    Key? key,
    required this.isSignIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15.w, 20.h, 10.w, 10.h),
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppTheme.blackColor,
              size: 24,
            ),
          ),
        ),
        IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Welcome to Stipra!',
                    style: AppTheme.smallParagraphMediumText.copyWith(
                      fontSize: 26,
                      color: AppTheme.blackColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    isSignIn != true
                        ? 'Please enter your phone number below to get started with the registration process'
                        : 'Please enter your phone number below to get started to use app',
                    style: AppTheme.smallParagraphMediumText.copyWith(
                      color: AppTheme.blackColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
