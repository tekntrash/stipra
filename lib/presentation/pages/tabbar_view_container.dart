import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../core/utils/router/app_navigator.dart';
import '../../core/utils/router/app_router.dart';
import '../../shared/app_theme.dart';
import '../widgets/local_image_box.dart';
import '../widgets/tab_bar/tab_bar_view_without_animation.dart';
import 'barcode_scan/barcode_scan_page.dart';
import 'home/home_page.dart';
import 'home/widgets/bottom_bar.dart';
import 'info/info_page.dart';
import 'perks/perks_page.dart';
import 'profile/profile_page.dart';

/// This the bottom bar and home page creator.
/// It is used to create the bottom bar and the home page.
/// Helping to navigate between pages with tabbarview.

class TabBarViewContainer extends StatefulWidget {
  const TabBarViewContainer({Key? key}) : super(key: key);

  @override
  State<TabBarViewContainer> createState() => _TabBarViewContainerState();
}

class _TabBarViewContainerState extends State<TabBarViewContainer>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    AppRouter().tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          if (isKeyboardVisible)
            return Container(
              height: 0,
            );
          return FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {
              AppNavigator.push(
                context: context,
                child: BarcodeScanPage(
                  maxBarcodeLength: double.maxFinite.toInt(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme().darkPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: LocalImageBox(
                      width: 32,
                      height: 32,
                      imgUrl: 'barcode.png',
                    ),
                  ),
                ),
                /*Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: 6,
                        left: -6,
                        right: -6,
                        child: Container(
                          color: Colors.transparent,
                          child: Text(
                            'Make video',
                            style: AppTheme()
                                .extraSmallParagraphRegularText
                                .copyWith(
                                  color: AppTheme().darkPrimaryColor,
                                  letterSpacing: 0.25,
                                  fontSize: 12,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
      bottomSheet: Container(height: 0),
      //resizeToAvoidBottomInset: false,
      body: TabBarViewWithoutAnimation(
        physics: NeverScrollableScrollPhysics(),
        controller: AppRouter().tabController,
        children: [
          HomePage(),
          PerksPage(),
          ProfilePage(),
          InfoPage(),
        ],
      ),
    );
  }
}
