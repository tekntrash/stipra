import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/home/home_page.dart';
import 'package:stipra/presentation/pages/my_trades/widgets/my_trades_category_list.dart';
import 'package:stipra/presentation/pages/perks/widgets/perks_category_list.dart';
import 'package:stipra/presentation/pages/videos_waiting/videos_waiting_viewmodel.dart';
import 'package:stipra/presentation/pages/videos_waiting/widgets/videos_waiting_category_list.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../widgets/custom_load_indicator.dart';
import '../barcode_scan/barcode_scan_page.dart';
import '../home/widgets/bottom_bar.dart';
import '../home/widgets/top_bar.dart';
import 'widgets/videos_waiting_list.dart';
import '../../widgets/local_image_box.dart';

import '../../../shared/app_theme.dart';
import '../../widgets/curved_container.dart';

class VideosWaitingPage extends StatefulWidget {
  const VideosWaitingPage({Key? key}) : super(key: key);

  @override
  State<VideosWaitingPage> createState() => _VideosWaitingPageState();
}

class _VideosWaitingPageState extends State<VideosWaitingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<VideosWaitingViewModel>.reactive(
      viewModelBuilder: () => VideosWaitingViewModel(),
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
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              TopBar(
                                hideSearchBar: true,
                                replaceSideBarWithBack: true,
                              ),
                            ],
                          ),
                        ),
                        expandedHeight: 80,
                      ),
                    ),
                  ];
                },
                body: CurvedContainer(
                  radius: 30,
                  child: Container(
                    color: AppTheme().whiteColor,
                    child: (!viewModel.isInited)
                        ? Center(
                            child: Container(
                              width: 64.w,
                              height: 64.w,
                              child: CircularProgressIndicator.adaptive(),
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
                                        VideosWaitingCategoryList(),
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
                                          vertical: 0, horizontal: 15.w),
                                      sliver: VideosWaitingList(
                                        scannedVideos: viewModel.scannedVideos,
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
      25.h +
      12.5.h +
      80.h;

  @override
  double get minExtent =>
      ((AppTheme().largeParagraphBoldText.fontSize?.h) ?? 0) +
      10.h +
      25.h +
      12.5.h +
      80.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
