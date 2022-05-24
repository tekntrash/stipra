import 'dart:developer';
import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:d_chart/d_chart.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/core/utils/lottie/lottie_cache.dart';
import 'package:stipra/data/enums/win_point_category.dart';
import 'package:stipra/injection_container.dart';
import 'package:stipra/presentation/pages/chart/chart_page.dart';
import 'package:stipra/presentation/pages/chart/chart_viewmodel.dart';
import 'package:stipra/presentation/widgets/custom_load_indicator.dart';
import 'package:stipra/presentation/widgets/radial_gauge/custom_radial_gauge.dart';
import 'package:stipra/shared/app_images.dart';
import '../../../data/models/win_item_model.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../core/utils/time_converter/time_converter.dart';
import '../../../data/models/product_model.dart';
import '../barcode_scan/barcode_scan_page.dart';
import '../map/map_controller.dart';
import '../../widgets/curved_container.dart';
import '../../widgets/image_box.dart';
import '../../widgets/local_image_box.dart';
import '../../widgets/theme_button.dart';
import '../../../shared/app_theme.dart';

part 'widgets/not_found.dart';
part 'widgets/nutrients_list.dart';
part 'widgets/product_image.dart';
part 'widgets/nutrient_gauge_bar.dart';

class ChartPage extends StatefulWidget {
  final WinItemModel winItem;
  const ChartPage({
    Key? key,
    required this.winItem,
  }) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
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
    return ViewModelBuilder<ChartViewModel>.reactive(
      viewModelBuilder: () => ChartViewModel(widget.winItem.barcode ?? ''),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
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
              child: ListView(
                children: [
                  _ProductImage(
                    winItem: widget.winItem,
                    dotPosition: dotPosition,
                    carouselController: carouselController,
                  ),
                  CurvedContainer(
                    radius: 20,
                    child: Container(
                      color: AppTheme().whiteColor,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: !viewModel.isInited
                            ? Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 30.h),
                                  child: CustomLoadIndicator(),
                                ),
                              )
                            : (!viewModel.isFoodExists)
                                ? _NotFound()
                                : _NutrientsList(
                                    viewModel: viewModel,
                                  ),
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
}
