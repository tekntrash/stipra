part of '../enter_phone_number_page.dart';

class KeepSignedButton extends StatelessWidget {
  final Function() onTap;
  const KeepSignedButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        locator<LocalDataRepository>().getUser().stayLoggedIn =
            !(locator<LocalDataRepository>().getUser().stayLoggedIn ?? true);
        await locator<LocalDataRepository>().getUser().save();
        onTap();
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: SquareCheckbox(
                value: locator<LocalDataRepository>().getUser().stayLoggedIn ??
                    true,
                onChange: (val) async {
                  locator<LocalDataRepository>().getUser().stayLoggedIn = val;
                  await locator<LocalDataRepository>().getUser().save();
                  onTap();
                },
                color: AppTheme().primaryColor,
                glowColor: AppTheme().darkPrimaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
              child: ClassicText(
                text: 'Keep signed',
                style: AppTheme()
                    .smallParagraphMediumText
                    .copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
