import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/models/search_dto_model.dart';
import 'package:stipra/presentation/pages/search/search_item_list.dart';
import 'package:stipra/presentation/pages/search/search_viewmodel.dart';
import '../../../data/models/trade_item_model.dart';
import '../../widgets/custom_load_indicator.dart';
import '../home/widgets/top_bar.dart';
import '../../widgets/curved_container.dart';
import '../../widgets/local_image_box.dart';
import '../../../shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'trade_items_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final FloatingSearchBarController floatingSearchBarController;

  @override
  void initState() {
    floatingSearchBarController = FloatingSearchBarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.nonReactive(
      viewModelBuilder: () => SearchViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppTheme().whiteColor,
          body: Container(
            decoration: BoxDecoration(
              gradient: AppTheme().gradientPrimary,
            ),
            child: SafeArea(
              bottom: false,
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
                              TopBar(
                                  hideBack: true,
                                  replaceSideBarWithBack: true,
                                  hideSearchBar: true),
                              Expanded(
                                child: FloatingSearchBar(
                                  controller: floatingSearchBarController,
                                  hint: 'Search',
                                  scrollPadding:
                                      EdgeInsets.only(top: 18.h, bottom: 56),
                                  transitionDuration:
                                      const Duration(milliseconds: 350),
                                  transitionCurve: Curves.easeInOut,
                                  queryStyle:
                                      AppTheme().extraSmallParagraphRegularText,
                                  hintStyle: AppTheme()
                                      .extraSmallParagraphRegularText
                                      .copyWith(
                                        color: AppTheme().greyScale2,
                                      ),
                                  physics: const BouncingScrollPhysics(),
                                  automaticallyImplyBackButton: false,
                                  leadingActions: [
                                    FloatingSearchBarAction.icon(
                                      icon: Icons.search_sharp,
                                      onTap: () {
                                        //
                                      },
                                      showIfOpened: false,
                                      showIfClosed: true,
                                    ),
                                    FloatingSearchBarAction.back(
                                      showIfClosed: false,
                                    ),
                                  ],
                                  automaticallyImplyDrawerHamburger: false,
                                  backgroundColor: AppTheme().greyScale5,
                                  backdropColor: Colors.transparent,
                                  axisAlignment: 0.0,
                                  openAxisAlignment: 0.0,
                                  width: 1.sw,
                                  height: 50,
                                  debounceDelay:
                                      const Duration(milliseconds: 500),
                                  onQueryChanged: (query) {
                                    print('Searched: $query');
                                    viewModel.search(query);
                                  },
                                  clearQueryOnClose: true,
                                  closeOnBackdropTap: true,
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(25),
                                  margins: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 0),
                                  transition:
                                      SlideFadeFloatingSearchBarTransition(),
                                  actions: [
                                    FloatingSearchBarAction.icon(
                                      icon: Icons.close,
                                      onTap: () {
                                        floatingSearchBarController.clear();
                                        floatingSearchBarController.close();
                                      },
                                      showIfOpened: true,
                                      showIfClosed: false,
                                    ),
                                  ],
                                  builder: (context, transition) {
                                    return Container();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        expandedHeight: 150,
                      ),
                    ),
                  ];
                },
                body: searchBody(viewModel),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget searchBody(SearchViewModel viewModel) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      builder: (context, viewModel, child) {
        return Container(
          margin: EdgeInsets.only(),
          child: CurvedContainer(
            radius: 30,
            child: ValueListenableBuilder<SearchDtoModel>(
              valueListenable: viewModel.searchDtoModel,
              builder: (context, searchDtoModel, child) {
                print('searchDtoModel: $searchDtoModel');
                return Container(
                  color: AppTheme().whiteColor,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          height: 25.h,
                        ),
                      ),
                      viewModel.isLoading
                          ? SliverToBoxAdapter(child: CustomLoadIndicator())
                          : SliverStickyHeader(
                              header: (viewModel.isSearched &&
                                      viewModel.isLoading == false &&
                                      (viewModel.searchDtoModel.value.winItems
                                                  ?.length ??
                                              0) >
                                          0)
                                  ? Container(
                                      color: Colors.white,
                                      margin: EdgeInsets.only(left: 15.w),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Text(
                                        'Deals',
                                        style: AppTheme()
                                            .largeParagraphBoldText
                                            .copyWith(
                                              color: AppTheme().greyScale0,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  : Container(),
                              sliver: SliverPadding(
                                padding: ((viewModel.searchDtoModel.value
                                                .winItems?.length ??
                                            0) >
                                        0)
                                    ? EdgeInsets.symmetric(
                                        vertical: 12.5.h, horizontal: 15.w)
                                    : EdgeInsets.zero,
                                sliver: SearchItemList(
                                  winItems: searchDtoModel.winItems!,
                                  tradeItems: searchDtoModel.tradeItems!,
                                  isSearched: viewModel.isSearched,
                                ),
                              ),
                            ),
                      SliverToBoxAdapter(
                        child:
                            (viewModel.searchDtoModel.value.winItems?.length ??
                                        0) >
                                    0
                                ? Container(
                                    height: 10.h,
                                  )
                                : Container(),
                      ),
                      SliverStickyHeader(
                        header: (viewModel.isSearched &&
                                viewModel.isLoading == false &&
                                (viewModel.searchDtoModel.value.tradeItems
                                            ?.length ??
                                        0) >
                                    0)
                            ? Container(
                                color: Colors.white,
                                margin: EdgeInsets.only(left: 15.w),
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Text(
                                  'Perks',
                                  style: AppTheme()
                                      .largeParagraphBoldText
                                      .copyWith(
                                        color: AppTheme().greyScale0,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : Container(),
                        sliver: (viewModel.isSearched &&
                                viewModel.isLoading == false)
                            ? SliverPadding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.5.h, horizontal: 15.w),
                                sliver: _TradeItemsList(
                                  tradeItems: searchDtoModel.tradeItems!,
                                  isSearched: viewModel.isSearched,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
