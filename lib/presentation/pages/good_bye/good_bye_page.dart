import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/good_bye/good_bye_viewmodel.dart';
import 'package:stipra/presentation/widgets/theme_button.dart';
import 'package:stipra/shared/app_images.dart';
import 'package:stipra/shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodByePage extends StatelessWidget {
  const GoodByePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GoodByeViewModel>.nonReactive(
      viewModelBuilder: () => GoodByeViewModel(),
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Scaffold(
            body: Container(
              width: 1.sw,
              height: 1.sh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Good bye!',
                        style: AppTheme().smallParagraphRegularText,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          right: 0.125.sw,
                        ),
                        child: LottieBuilder.asset(
                          AppImages.goodBye.lottiePath,
                          width: 1.sw,
                          height: 256,
                          repeat: true,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: ThemeButton(
                      width: 0.75.sw,
                      height: 50.h,
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 30.h,
                      ),
                      color: AppTheme().primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        viewModel.goToHomePage(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Go to home',
                            style: AppTheme().paragraphSemiBoldText.copyWith(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
