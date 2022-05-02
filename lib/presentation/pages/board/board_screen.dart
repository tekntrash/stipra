import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:stipra/presentation/pages/tabbar_view_container.dart';
import '../../../core/platform/app_info.dart';

import '../../../core/utils/router/app_navigator.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_theme.dart';
import '../../widgets/classic_text.dart';
import '../../widgets/local_image_box.dart';
import '../../widgets/theme_button.dart';
import '../sign/enter_phone_number_page/enter_phone_number_page.dart';

/// Create a UI for board screen
/// Also named as 'Intro screen'
/// It is showing only first time when the app is opened

class BoardScreen extends StatefulWidget {
  BoardScreen({Key? key}) : super(key: key);

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late List<PageViewModel> pageViewModels;
  late List<BoardModel> boardModels;
  late ValueNotifier<double?> dotPosition;
  late final CarouselController carouselController;

  /// Init all the pages
  @override
  void initState() {
    carouselController = CarouselController();
    dotPosition = ValueNotifier(0.0);
    boardModels = [
      BoardModel(
        image: '1.png',
        title: 'Care about the environment',
        subTitle:
            'Show you care about the environment and be actually rewarded for it! Make videos of your household products before you dispose of them, receive points you can trade, trade those points for many perks, and help companies be more environmentally conscious',
      ),
      BoardModel(
        image: '2.png',
        title: 'AI based recognition',
        subTitle:
            'Our impressive AI system identified in the videous you made. Check how many points you made for each video you made. You can use the trash cans you use regularly: the system geolocates them automatically.',
      ),
      BoardModel(
          image: '4.png',
          title: 'Recycle properly and earn',
          subTitle:
              'Trade your points for perks, deals, and even donate them to charities. Yes: Stipra is the only service which actually rewards you for proper recycling. So, not only you are helping the nature, but also being rewared for it!'),
      /*BoardModel(
        image: '5.png',
        title: 'Neigborhood',
        subTitle:
            'You can also make videos of your neighbours trash and also get rewards for it. For that, register them and, after we\'ve received confirmation that they are ok with it, all you have to do is pick up their trash whenever they want and choose them at the moment of making video.',
      ),*/
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
            fontSize: AppTheme().smallParagraphRegularText.fontSize! * 0.90,
            color: AppTheme().greyScale2,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget buildDots() {
    return ValueListenableBuilder<double?>(
      valueListenable: dotPosition,
      builder: (context, dotpos, child) {
        return boardModels.length == 1
            ? Container()
            : DotsIndicator(
                dotsCount: boardModels.length,
                position: dotpos ?? 0,
                decorator: DotsDecorator(
                  color: AppTheme().greyScale4,
                  activeColor: AppTheme().primaryColor,
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().whiteColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned.fill(
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlay: false,
                    initialPage: 0,
                    scrollPhysics: AlwaysScrollableScrollPhysics(),
                    enableInfiniteScroll: false,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                    height: 1.sh,
                    onScrolled: (value) {
                      dotPosition.value = value;
                    },
                  ),
                  carouselController: carouselController,
                  itemCount: boardModels.length,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      buildBoardPage(boardModels[itemIndex]),
                ),
              ),
              Positioned.fill(
                top: 0.475.sh,
                child: buildDots(),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ThemeButton(
                        elevation: 5,
                        width: 230.w,
                        height: 45.h,
                        text: 'Sign in',
                        onTap: () {
                          AppNavigator.push(
                            context: context,
                            child: EnterPhoneNumberScreen(
                              isSignIn: true,
                              onLogged: () {
                                AppNavigator.pushAndRemoveUntil(
                                  context: context,
                                  child: TabBarViewContainer(),
                                );
                              },
                              onVerified: () {
                                AppNavigator.pushAndRemoveUntil(
                                  context: context,
                                  child: TabBarViewContainer(),
                                );
                              },
                            ),
                          );
                        }),
                    SizedBox(
                      height: 5.h,
                    ),
                    ThemeButton(
                        width: 230.w,
                        height: 45.h,
                        elevation: 5,
                        text: 'Skip',
                        onTap: () {
                          AppNavigator.pushAndRemoveUntil(
                            context: context,
                            child: TabBarViewContainer(),
                          );
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBoardPage(BoardModel boardModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        LocalImageBox(
          imgUrl: 'board/' + boardModel.image,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 40,
        ),
        buildTitle(
          boardModel.title,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: buildSubTitle(
            boardModel.subTitle,
          ),
        ),
      ],
    );
  }
}

class BoardModel {
  final String title;
  final String subTitle;
  final String image;

  BoardModel({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}
