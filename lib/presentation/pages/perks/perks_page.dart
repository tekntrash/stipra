import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/home/home_page.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../barcode_scan/barcode_scan_page.dart';
import '../home/widgets/bottom_bar.dart';
import '../home/widgets/top_bar.dart';
import 'widgets/perks_list.dart';
import '../../widgets/local_image_box.dart';

import '../../../shared/app_theme.dart';
import '../../widgets/curved_container.dart';
import 'perks_viewmodel.dart';

class PerksPage extends StatefulWidget {
  const PerksPage({Key? key}) : super(key: key);

  @override
  State<PerksPage> createState() => _PerksPageState();
}

class _PerksPageState extends State<PerksPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<PerksViewModel>.reactive(
      viewModelBuilder: () => PerksViewModel(),
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
                        backgroundColor: Colors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              TopBar(),
                              SizedBox(
                                height: 15.h,
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
                                delegate: PersistentHeader(
                                  widget: Container(
                                    color: AppTheme().bgColor,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 30.w),
                                          child: Text(
                                            'Perks',
                                            style: AppTheme()
                                                .largeParagraphBoldText
                                                .copyWith(
                                                  color: AppTheme().greyScale0,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SliverPadding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 15.w),
                                sliver: PerksList(
                                  tradeItems: viewModel.tradeItems,
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
      (AppTheme().largeParagraphBoldText.fontSize! * 1.2) + 25.h;

  @override
  double get minExtent =>
      (AppTheme().largeParagraphBoldText.fontSize! * 1.2) + 25.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
