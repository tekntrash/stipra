import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/win_item_model.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../core/utils/time_converter/time_converter.dart';
import '../../../data/models/product_model.dart';
import '../barcode_scan/barcode_scan_page.dart';
import '../map/map_controller.dart';
import 'product_detail_viewmodel.dart';
import '../../widgets/curved_container.dart';
import '../../widgets/image_box.dart';
import '../../widgets/like_section.dart';
import '../../widgets/local_image_box.dart';
import '../../widgets/theme_button.dart';
import '../../../shared/app_theme.dart';

part 'top_bar.dart';

class WinItemDetailPage extends StatefulWidget {
  final WinItemModel winItem;
  const WinItemDetailPage({
    Key? key,
    required this.winItem,
  }) : super(key: key);

  @override
  State<WinItemDetailPage> createState() => _WinItemDetailPageState();
}

class _WinItemDetailPageState extends State<WinItemDetailPage> {
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
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      viewModelBuilder: () => ProductDetailViewModel(),
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
            actions: [
              Container(
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: IconButton(
                  icon: Icon(
                    Icons.public,
                    color: Colors.white,
                    size: 26,
                  ),
                  onPressed: () {
                    print(
                        'Bin color: ${widget.winItem.getBinColor()} and color: ${widget.winItem.bincolor}');
                    AppNavigator.push(
                      context: context,
                      child: MapControllerPage(
                        name: widget.winItem.name ?? '',
                        geoPoint: widget.winItem.geo ?? '',
                        binColor: widget.winItem.getBinColor(),
                      ),
                    );
                    //Navigator.of(context).pop();
                  },
                ),
              ),
            ],
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
                                  winItem: widget.winItem,
                                ),
                                Container(
                                  height: 16.h,
                                ),
                                Text(
                                  'Description',
                                  style: AppTheme()
                                      .smallParagraphMediumText
                                      .copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                                Container(
                                  height: 8.h,
                                ),
                                Text(
                                  widget.winItem.description ?? '',
                                  style: AppTheme()
                                      .extraSmallParagraphRegularText
                                      .copyWith(
                                        fontSize: 14,
                                        color: AppTheme().greyScale2,
                                      ),
                                ),
                                Container(
                                  height: 100.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
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
                          child: BarcodeScanPage(
                            maxBarcodeLength: 1,
                            findBarcode: widget.winItem.barcode,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Scan',
                            style: AppTheme().paragraphSemiBoldText.copyWith(),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          LocalImageBox(
                            width: 32,
                            height: 32,
                            imgUrl: 'barcode.png',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildImageBox() {
    int imgLength =
        widget.winItem.images?.where((e) => e.isNotEmpty).length ?? 0;

    return Container(
      height: 350.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: new ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: 250.h,
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
                  height: 300.h,
                  url: widget.winItem.images![itemIndex],
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
                  height: 450.h,
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
