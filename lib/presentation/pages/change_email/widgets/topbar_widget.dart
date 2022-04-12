part of '../change_email_page.dart';

class TopBarWidget extends StatelessWidget {
  final bool hideBackButton;
  const TopBarWidget({
    Key? key,
    this.hideBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!hideBackButton)
          Container(
            padding: EdgeInsets.fromLTRB(15.w, 15.h, 10.w, 15.h),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppTheme().blackColor,
                size: 24,
              ),
            ),
          ),
        IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.fromLTRB(25.w, 15.h, 20.w, 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Change your email',
                    style: AppTheme().smallParagraphMediumText.copyWith(
                          fontSize: 26,
                          color: AppTheme().blackColor,
                        ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Enter your new email address to change then we will send verify code.',
                    style: AppTheme().smallParagraphMediumText.copyWith(
                          color: AppTheme().blackColor,
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
