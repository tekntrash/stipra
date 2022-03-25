import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../core/utils/router/app_navigator.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_theme.dart';
import '../../widgets/classic_text.dart';
import '../../widgets/local_image_box.dart';
import '../../widgets/theme_button.dart';
import '../sign/enter_phone_number_page/enter_phone_number_page.dart';

class BoardScreen extends StatefulWidget {
  BoardScreen({Key? key}) : super(key: key);

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late List<PageViewModel> pageViewModels;

  @override
  void initState() {
    pageViewModels = [
      PageViewModel(
        useScrollView: false,
        titleWidget: Container(),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/image_box.svg',
              width: 196.w,
              height: 196.w,
              semanticsLabel: 'Image box',
            ),
            SizedBox(
              height: 20,
            ),
            buildTitle(
              'Consume and earn',
            ),
            SizedBox(
              height: 20,
            ),
            buildSubTitle(
              'Let\'s win together with recycle the products we consumed!',
            ),
          ],
        ),
      ),
      PageViewModel(
        useScrollView: false,
        titleWidget: Container(),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/image_box.svg',
              width: 196.w,
              height: 196.w,
              semanticsLabel: 'Image box',
            ),
            SizedBox(
              height: 20,
            ),
            buildTitle(
              'Consume and earn',
            ),
            SizedBox(
              height: 20,
            ),
            buildSubTitle(
              'Let\'s win together with recycle the products we consumed!',
            ),
          ],
        ),
      ),
      PageViewModel(
        useScrollView: false,
        titleWidget: Container(),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/image_box.svg',
              width: 196.w,
              height: 196.w,
              semanticsLabel: 'Image box',
            ),
            SizedBox(
              height: 20,
            ),
            buildTitle(
              'Consume and earn',
            ),
            SizedBox(
              height: 20,
            ),
            buildSubTitle(
              'Let\'s win together with recycle the products we consumed!',
            ),
          ],
        ),
      ),
    ];

    super.initState();
  }

  Widget buildTitle(String text) {
    return ClassicText(
      text: text,
      style: AppTheme().paragraphSemiBoldText.copyWith(
            color: AppTheme().greyScale0,
          ),
    );
  }

  Widget buildSubTitle(String text) {
    return ClassicText(
      text: text,
      style: AppTheme().smallParagraphRegularText.copyWith(
            color: AppTheme().greyScale2,
          ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme().whiteColor,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Expanded(
                child: IntroductionScreen(
                  pages: pageViewModels,
                  onDone: () {},
                  controlsPadding: EdgeInsets.zero,
                  globalBackgroundColor:
                      AppTheme().greyScale2.withOpacity(0.01),
                  showSkipButton: false,
                  showDoneButton: false,
                  showNextButton: false,
                  dotsDecorator: DotsDecorator(
                      size: const Size.square(10.0),
                      activeSize: const Size(10.0, 10.0),
                      activeColor: AppTheme().primaryColor,
                      color: Colors.black26,
                      spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(500.0))),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              ThemeButton(
                  elevation: 5,
                  width: 230.w,
                  height: 45.h,
                  text: 'Login',
                  onTap: () {
                    AppNavigator.push(
                      context: context,
                      child: EnterPhoneNumberScreen(isSignIn: true),
                    );
                  }),
              SizedBox(
                height: 5.h,
              ),
              ThemeButton(
                  width: 230.w,
                  height: 45.h,
                  elevation: 5,
                  text: 'Register',
                  onTap: () {
                    AppNavigator.push(
                      context: context,
                      child: EnterPhoneNumberScreen(),
                    );
                  }),
              SizedBox(
                height: 20.h,
              ),
              buildBottomWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomWidget() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h),
      alignment: Alignment.bottomCenter,
      child: Text('Stipra all rights reserved'),
    );
  }
}
