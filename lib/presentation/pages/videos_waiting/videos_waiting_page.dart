import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../../../shared/app_theme.dart';
import '../../widgets/curved_container.dart';
import '../../widgets/custom_load_indicator.dart';
import '../home/widgets/top_bar.dart';
import 'videos_waiting_viewmodel.dart';
import 'widgets/videos_waiting_category_list.dart';
import 'widgets/videos_waiting_list.dart';

/// Show videos waiting page UI
/// Using [VideosWaitingViewModel] to handle logic
/// Using [VideosWaitingCategoryList] to show category list
/// Using [VideosWaitingList] to show videos list
/// Using [CurvedContainer] to show curved container
/// Using [CustomLoadIndicator] to show loading indicator
/// Using [TopBar] to show top bar

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

/// PersistentHeader class to change height of sliver's height
/// For Category list
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
