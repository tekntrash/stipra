import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/home/home_page.dart';
import 'package:stipra/presentation/pages/home/widgets/featured_list.dart';
import 'package:stipra/presentation/pages/perks/widgets/perks_category_list.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../widgets/custom_load_indicator.dart';
import '../barcode_scan/barcode_scan_page.dart';
import '../home/widgets/bottom_bar.dart';
import '../home/widgets/top_bar.dart';
import 'widgets/perks_featured_list.dart';
import 'widgets/perks_list.dart';
import '../../widgets/local_image_box.dart';

import '../../../shared/app_theme.dart';
import '../../widgets/curved_container.dart';
import 'perks_viewmodel.dart';

/// Perks page UI for showing perks list and categories
/// Using PerksViewModel to handle logic

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
                              if (!viewModel.isFeaturedClosed)
                                SliverToBoxAdapter(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 15.w, right: 15.w, top: 25.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Featured',
                                          style: AppTheme()
                                              .largeParagraphBoldText
                                              .copyWith(
                                                color: AppTheme().greyScale0,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            child: IconButton(
                                              onPressed: () {
                                                viewModel.closeFeatured();
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                size: AppTheme()
                                                        .largeParagraphBoldText
                                                        .fontSize! *
                                                    1.2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              !viewModel.isInited
                                  ? SliverToBoxAdapter(
                                      child: CustomLoadIndicator())
                                  : (!viewModel.isFeaturedClosed)
                                      ? SliverPadding(
                                          padding: EdgeInsets.only(
                                            top: 25.h,
                                            // bottom: 12.5.h,
                                            left: 15.w,
                                            right: 15.w,
                                          ),
                                          sliver: FeaturedList(
                                            featuredItems:
                                                viewModel.featuredItems,
                                            suffix: 'perkspage',
                                          ),
                                        )
                                      : SliverToBoxAdapter(
                                          child: Container(),
                                        ),
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
                                        PerksCategoryList(
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
