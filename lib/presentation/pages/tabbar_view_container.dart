import 'package:flutter/material.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/core/utils/router/app_router.dart';
import 'package:stipra/presentation/pages/barcode_scan/barcode_scan_page.dart';
import 'package:stipra/presentation/pages/home/home_page.dart';
import 'package:stipra/presentation/pages/home/widgets/bottom_bar.dart';
import 'package:stipra/presentation/pages/perks/perks_page.dart';
import 'package:stipra/presentation/widgets/local_image_box.dart';
import 'package:stipra/presentation/widgets/tab_bar/tab_bar_view_without_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/shared/app_theme.dart';

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
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
      body: TabBarViewWithoutAnimation(
        physics: NeverScrollableScrollPhysics(),
        controller: AppRouter().tabController,
        children: [
          HomePage(),
          PerksPage(),
        ],
      ),
    );
  }
}
