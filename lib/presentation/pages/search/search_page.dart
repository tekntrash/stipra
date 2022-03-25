import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stipra/presentation/pages/home/widgets/top_bar.dart';
import 'package:stipra/presentation/widgets/curved_container.dart';
import 'package:stipra/presentation/widgets/local_image_box.dart';
import 'package:stipra/shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Scaffold(
      backgroundColor: AppTheme().whiteColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme().gradientPrimary,
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              TopBar(replaceSideBarWithBack: true, hideSearchBar: true),
              Expanded(
                child: FloatingSearchBar(
                  controller: floatingSearchBarController,
                  hint: 'Search deal',
                  scrollPadding: EdgeInsets.only(top: 18.h, bottom: 56),
                  transitionDuration: const Duration(milliseconds: 350),
                  transitionCurve: Curves.easeInOut,
                  queryStyle: AppTheme().extraSmallParagraphRegularText,
                  hintStyle: AppTheme().extraSmallParagraphRegularText.copyWith(
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
                  debounceDelay: const Duration(milliseconds: 500),
                  onQueryChanged: (query) {
                    // Call your model, bloc, controller here.
                  },
                  clearQueryOnClose: true,
                  closeOnBackdropTap: true,
                  elevation: 5,
                  borderRadius: BorderRadius.circular(25),
                  margins: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  transition: SlideFadeFloatingSearchBarTransition(),
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
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Material(
                        color: AppTheme().greyScale5,
                        elevation: 4.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [1, 2, 3, 4, 5].map((color) {
                            return InkWell(
                              onTap: () {
                                floatingSearchBarController.close();
                              },
                              child: Ink(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                color: AppTheme().greyScale5,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/image_box.svg',
                                      width: 32,
                                      height: 32,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Center(
                                      child: Text(
                                        'Vegetable Paste $color',
                                        style: AppTheme()
                                            .extraSmallParagraphRegularText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  body: Container(
                    margin: EdgeInsets.only(
                      top: 50 + 15.h,
                    ),
                    child: CurvedContainer(
                      radius: 30,
                      child: Container(
                        color: AppTheme().whiteColor,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 25.h,
                            ),
                            Text('Search screen'),
                            Container(
                              height: 25.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
