import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/data/models/search_dto_model.dart';
import 'package:stipra/data/models/trade_item_model.dart';
import 'package:stipra/presentation/pages/perk_detail/perk_detail_page.dart';
import 'package:stipra/presentation/widgets/html_converter.dart';
import '../../../../../core/utils/router/app_navigator.dart';

import '../../../../../shared/app_theme.dart';
import '../../../widgets/image_box.dart';
import '../../product_detail/win_item_detail_page.dart';

//* Creating a listview component for products

class FeaturedList extends StatefulWidget {
  final SearchDtoModel featuredItems;
  const FeaturedList({
    Key? key,
    required this.featuredItems,
  }) : super(key: key);

  @override
  State<FeaturedList> createState() => _FeaturedListState();
}

class _FeaturedListState extends State<FeaturedList> {
  late final CarouselController carouselController;
  late ValueNotifier<double?> dotPosition;
  @override
  void initState() {
    carouselController = CarouselController();
    dotPosition = ValueNotifier(0.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.featuredItems.tradeItems?.length == 0 &&
            widget.featuredItems.winItems?.length == 0)
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                'No offers available',
                style: AppTheme().paragraphSemiBoldText.copyWith(
                      color: AppTheme().greyScale0,
                    ),
              ),
            ),
          )
        : SliverToBoxAdapter(
            child: buildImageBox(),
          );
  }

  Widget buildImageBox() {
    final length = (widget.featuredItems.tradeItems?.length ?? 0) +
        (widget.featuredItems.winItems?.length ?? 0);
    return Container(
      height: 200.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: 180.h,
                  autoPlay: false,
                  initialPage: 0,
                  scrollPhysics: AlwaysScrollableScrollPhysics(),
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  onScrolled: (value) {
                    dotPosition.value = value;
                  },
                ),
                carouselController: carouselController,
                itemCount: length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  dynamic itemModel =
                      (widget.featuredItems.tradeItems?.length ?? 0) >
                              pageViewIndex
                          ? widget.featuredItems.tradeItems![pageViewIndex]
                          : widget.featuredItems.winItems![pageViewIndex -
                              (widget.featuredItems.tradeItems?.length ?? 0)];
                  return Hero(
                    tag: '${itemModel.name}1',
                    child: GestureDetector(
                      onTap: () {
                        if (itemModel is TradeItemModel) {
                          AppNavigator.push(
                            context: context,
                            child: PerkDetailPage(
                              tradeItem: itemModel,
                            ),
                          );
                        } else {
                          AppNavigator.push(
                            context: context,
                            child: WinItemDetailPage(
                              winItem: itemModel,
                              heroTag: '${itemModel.name}1',
                            ),
                          );
                        }
                      },
                      child: Material(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ImageBox(
                                width: 1.sw,
                                height: 130.h,
                                url: itemModel.images!.first,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            HTMLConverter.toRichText(
                              context,
                              itemModel.description!,
                              textAlign: TextAlign.center,
                              defaultTextStyle: AppTheme()
                                  .extraSmallParagraphRegularText
                                  .copyWith(
                                    fontSize: 13,
                                    color: AppTheme().greyScale2,
                                  ),
                              maxLines: 2,
                            ),
                            /*Text(
                              itemModel.description!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppTheme()
                                  .extraSmallParagraphRegularText
                                  .copyWith(
                                    fontSize: 13,
                                    color: AppTheme().greyScale2,
                                  ),
                              textAlign: TextAlign.center,
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Positioned(
            bottom: -10,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<double?>(
              valueListenable: dotPosition,
              builder: (context, dotpos, child) {
                return DotsIndicator(
                  dotsCount: length,
                  position: dotpos ?? 0,
                  decorator: DotsDecorator(
                    color: AppTheme().greyScale4, // Inactive color
                    activeColor: AppTheme().primaryColor,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
