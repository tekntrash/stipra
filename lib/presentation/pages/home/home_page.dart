import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../../../shared/app_theme.dart';
import '../../widgets/curved_container.dart';
import '../../widgets/custom_load_indicator.dart';
import 'home_viewmodel.dart';
import 'widgets/product_offer/product_offers_list.dart';
import 'widgets/top_bar.dart';
import 'widgets/win_point_category_list.dart';

//* Home also named as 'products page'
//* It has topbar & products list

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: AppTheme().gradientPrimary,
            ),
            child: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    SliverOverlapAbsorber(
                      // This widget takes the overlapping behavior of the SliverAppBar,
                      // and redirects it to the SliverOverlapInjector below. If it is
                      // missing, then it is possible for the nested "inner" scroll view
                      // below to end up under the SliverAppBar even when the inner
                      // scroll view thinks it has not been scrolled.
                      // This is not necessary if the "headerSliverBuilder" only builds
                      // widgets that do not overlap the next sliver.
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        backgroundColor: Colors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              TopBar(),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                        expandedHeight: 150,
                      ),
                    ),
                  ];
                },
                body: CurvedContainer(
                  radius: 30,
                  child: Container(
                    color: AppTheme().whiteColor,
                    child: (!viewModel.isInited)
                        ? Container(
                            height: 0.75.sh,
                            child: Center(
                              child: Container(
                                width: 48.w,
                                height: 48.w,
                                child: CircularProgressIndicator.adaptive(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppTheme().darkPrimaryColor,
                                  ),
                                  strokeWidth: 3,
                                ),
                              ),
                            ),
                          )
                        : CustomScrollView(
                            //mainAxisSize: MainAxisSize.min,
                            physics: AlwaysScrollableScrollPhysics(),
                            slivers: [
                              SliverPersistentHeader(
                                pinned: true,
                                floating: true,
                                delegate: PersistentHeader(
                                  widget: Container(
                                    color: AppTheme().bgColor,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                        WinPointCategoryList(
                                          selectedCategory:
                                              viewModel.selectedCategory,
                                          selectedDirection:
                                              viewModel.selectedDirection,
                                          selectedExpire:
                                              viewModel.selectedExpire,
                                          onCategorySelected: (category) {
                                            viewModel.changeCategory(category);
                                          },
                                          onDirectionSelected: (direction) {
                                            viewModel
                                                .changeDirection(direction);
                                          },
                                          onShowExpiredChanged: (bool value) {
                                            viewModel
                                                .onShowExpiredChanged(value);
                                          },
                                        ),
                                        SizedBox(
                                          height: 12.5.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              viewModel.isLoading
                                  ? SliverToBoxAdapter(
                                      child: CustomLoadIndicator())
                                  : SliverPadding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.5.h, horizontal: 15.w),
                                      sliver: WinItemsList(
                                        winItems: viewModel.winItems,
                                      ),
                                    ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// A custom component to set custom properties for scrollable sliver
// With this we can control the height of the sliver
class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeader({required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  double get maxExtent =>
      ((AppTheme().largeParagraphBoldText.fontSize?.h) ?? 0) +
      10.h +
      35.h +
      25.h +
      12.5.h;

  @override
  double get minExtent =>
      ((AppTheme().largeParagraphBoldText.fontSize?.h) ?? 0) +
      10.h +
      35.h +
      25.h +
      12.5.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
