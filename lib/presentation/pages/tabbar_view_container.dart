import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../core/utils/router/app_navigator.dart';
import '../../core/utils/router/app_router.dart';
import '../../data/models/user_model.dart';
import '../../domain/repositories/local_data_repository.dart';
import '../../injection_container.dart';
import 'barcode_scan/barcode_scan_page.dart';
import 'home/home_page.dart';
import 'home/widgets/bottom_bar.dart';
import 'perks/perks_page.dart';
import 'profile/profile_page.dart';
import 'sign/enter_phone_number_page/enter_phone_number_page.dart';
import '../widgets/local_image_box.dart';
import '../widgets/tab_bar/tab_bar_view_without_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/app_theme.dart';

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
      length: 3,
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
                child: BarcodeScanPage(),
              );
            },
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppTheme().darkPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: LocalImageBox(
                  width: 32.w,
                  height: 32.w,
                  imgUrl: 'barcode.png',
                ),
              ),
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
        ],
      ),
    );
  }
}
