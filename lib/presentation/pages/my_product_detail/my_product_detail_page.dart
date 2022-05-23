import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/data/models/product_consumed_model.dart';
import 'package:stipra/presentation/pages/chart/chart_page.dart';
import '../../../data/models/win_item_model.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../core/utils/time_converter/time_converter.dart';
import '../../../data/models/product_model.dart';
import '../barcode_scan/barcode_scan_page.dart';
import '../map/map_controller.dart';
import 'my_product_detail_viewmodel.dart';
import '../../widgets/curved_container.dart';
import '../../widgets/image_box.dart';
import '../../widgets/local_image_box.dart';
import '../../widgets/theme_button.dart';
import '../../../shared/app_theme.dart';
import 'package:jiffy/jiffy.dart';

import '../../../core/utils/extensions/app_string_extension.dart';

part 'top_bar.dart';

class MyProductsDetailPage extends StatefulWidget {
  final ProductConsumedModel productConsumed;
  const MyProductsDetailPage({
    Key? key,
    required this.productConsumed,
  }) : super(key: key);

  @override
  State<MyProductsDetailPage> createState() => _MyProductsDetailPageState();
}

class _MyProductsDetailPageState extends State<MyProductsDetailPage> {
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
    return ViewModelBuilder<MyProductsDetailViewModel>.reactive(
      viewModelBuilder: () => MyProductsDetailViewModel(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        if (!viewModel.isInited) {
          return Center(
            child: Container(
              width: 64.w,
              height: 64.w,
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                //color: AppTheme().darkPrimaryColor,
                gradient: AppTheme().gradientPrimary,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text('Detail'),
            centerTitle: true,
            actions: [],
          ),
          backgroundColor: AppTheme().whiteColor,
          body: Container(
            child: SafeArea(
              child: Stack(
                children: [
                  ListView(
                    children: [
                      buildImageBox(),
                      CurvedContainer(
                        radius: 20,
                        child: Container(
                          color: AppTheme().whiteColor,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 25.h,
                                ),
                                _TopBar(
                                  productConsumed: widget.productConsumed,
                                ),
                                Container(
                                  height: 16.h,
                                ),
                                /*Text(
                                  'Description',
                                  style: AppTheme()
                                      .smallParagraphMediumText
                                      .copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                                Container(
                                  height: 8.h,
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    //bottom: 15 + 50.h + 15,
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: ThemeButton(
                      width: 1.sw,
                      height: 50.h,
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      color: AppTheme().primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        AppNavigator.push(
                          context: context,
                          child: MapControllerPage(
                            name: widget.productConsumed.label ?? '',
                            productLocation:
                                '${widget.productConsumed.latitude}, ${widget.productConsumed.longitude}',
                            productImage: widget.productConsumed.base64
                                .convertBase64ToImageUrl(),
                            binColor:
                                widget.productConsumed.bincolor.getBinColor(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.public,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'See Locations',
                            style: AppTheme().paragraphSemiBoldText.copyWith(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*Positioned(
                    bottom: 15,
                    left: 0,
                    right: 0,
                    child: ThemeButton(
                      width: 1.sw,
                      height: 50.h,
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      color: AppTheme().primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        /*AppNavigator.push(
                          context: context,
                          child: RadarChartSample1(
                              productBarcode: widget.productConsumed.barcode),
                        );*/
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.leaderboard,
                            color: Colors.white,
                            size: 26,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'See nutrition stats',
                            style: AppTheme().paragraphSemiBoldText.copyWith(),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildImageBox() {
    int imgLength = 1;

    return Container(
      height: 300.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: new ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: 300.h,
                  autoPlay: false,
                  initialPage: 0,
                  scrollPhysics: AlwaysScrollableScrollPhysics(),
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  onScrolled: (value) {
                    dotPosition.value = value;
                  },
                ),
                carouselController: carouselController,
                itemCount: imgLength,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        ImageBox(
                  width: 1.sw,
                  height: 250.h,
                  url: widget.productConsumed.base64.convertBase64ToImageUrl(),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: IgnorePointer(
              ignoring: true,
              child: ImageFiltered(
                imageFilter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: 1.sw,
                  height: 350.h,
                  color: Colors.black.withOpacity(0.10),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<double?>(
              valueListenable: dotPosition,
              builder: (context, dotpos, child) {
                return imgLength == 1
                    ? Container()
                    : DotsIndicator(
                        dotsCount: imgLength,
                        position: dotpos ?? 0,
                        decorator: DotsDecorator(
                          color: AppTheme().greyScale5, // Inactive color
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
