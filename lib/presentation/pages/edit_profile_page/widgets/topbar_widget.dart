part of '../edit_profile_page.dart';

/// A component for showing a title and description in edit profile page

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    'change_your_profile_title'.tr,
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
                    'Enter your new informations you want to change.',
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
