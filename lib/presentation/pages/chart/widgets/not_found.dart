part of '../chart_page.dart';

class _NotFound extends StatelessWidget {
  const _NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              child: locator<LottieCache>().load(
                AppImages.searchNotFound.lottiePath,
                height: 200,
                reverse: true,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'We could not find this product.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme().greyScale1,
              ),
            ),
            SizedBox(
              height: 48,
            ),
          ],
        ),
      ),
    );
  }
}
