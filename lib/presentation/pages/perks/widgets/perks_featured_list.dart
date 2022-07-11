import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stipra/data/models/trade_item_model.dart';
import 'package:stipra/data/models/win_item_model.dart';
import '../../../../../../core/utils/router/app_navigator.dart';

import '../../../../../../shared/app_theme.dart';
import '../../../widgets/html_converter.dart';
import '../../../widgets/image_box.dart';
import '../../perk_detail/perk_detail_page.dart';

//* Creating a listview component for products
/*
class PerksFeaturedList extends StatefulWidget {
  final List<TradeItemModel> featuredItems;
  const PerksFeaturedList({
    Key? key,
    required this.featuredItems,
  }) : super(key: key);

  @override
  State<PerksFeaturedList> createState() => _PerskFeaturedListState();
}

class _PerskFeaturedListState extends State<PerksFeaturedList> {
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
    return widget.featuredItems.length == 0
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
              itemCount: widget.featuredItems.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Hero(
                tag: '${widget.featuredItems[itemIndex].name}1',
                child: GestureDetector(
                  onTap: () {
                    AppNavigator.push(
                      context: context,
                      child: PerkDetailPage(
                        tradeItem: widget.featuredItems[itemIndex],
                      ),
                    );
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
                            height: 200.h,
                            url: widget.featuredItems[itemIndex].images!.first,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //if (itemIndex == 1)
                        HTMLConverter.toRichText(
                          context,
                          widget.featuredItems[itemIndex].description!,
                          textAlign: TextAlign.center,
                          defaultTextStyle: AppTheme()
                              .extraSmallParagraphRegularText
                              .copyWith(
                                fontSize: 13,
                                color: AppTheme().greyScale2,
                              ),
                          maxLines: 2,
                        ),
                        /*Html(
                          data: widget.featuredItems[itemIndex].description!,
                          style: {
                            "*": Style(
                              fontFamily: AppTheme()
                                  .extraSmallParagraphRegularText
                                  .fontFamily!,
                              fontSize: FontSize(13),
                              color: AppTheme().greyScale2,
                              maxLines: 2,
                              display: Display.INLINE_BLOCK,
                              textOverflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          },
                        ),*/
                        /*if (itemIndex != 1)
                          Text(
                            widget.featuredItems[itemIndex].description!,
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
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<double?>(
              valueListenable: dotPosition,
              builder: (context, dotpos, child) {
                return DotsIndicator(
                  dotsCount: widget.featuredItems.length,
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
*/