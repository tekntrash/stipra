import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/models/food_fact_model.dart';
import 'package:stipra/data/models/win_item_model.dart';
import 'package:stipra/presentation/pages/chart/chart_viewmodel.dart';
import 'package:stipra/presentation/widgets/curved_container.dart';
import 'package:stipra/presentation/widgets/custom_load_indicator.dart';
import 'package:stipra/presentation/widgets/image_box.dart';
import 'package:stipra/shared/app_images.dart';
import 'package:stipra/shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const fashionColor = Color.fromARGB(255, 231, 30, 50);
const artColor = Color.fromARGB(255, 60, 233, 230);
const boxingColor = Color(0xff83dea7);
const entertainmentColor = Color(0xFFFFF59D);
const offRoadColor = Color.fromARGB(179, 45, 236, 93);

class RadarChartSample1 extends StatefulWidget {
  final String? productBarcode;
  final WinItemModel winItem;
  const RadarChartSample1({
    Key? key,
    required this.productBarcode,
    required this.winItem,
  }) : super(key: key);

  @override
  _RadarChartSample1State createState() => _RadarChartSample1State();
}

class _RadarChartSample1State extends State<RadarChartSample1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
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
      ),*/
      backgroundColor: AppTheme().whiteColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 256.h,
                floating: false,
                pinned: true,
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                /*title: AppBar(
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
                ),*/
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    margin: EdgeInsets.only(top: kToolbarHeight),
                    child: buildImageBox(),
                  ),
                  titlePadding: EdgeInsets.zero,
                  expandedTitleScale: 1,
                  centerTitle: true,
                  title: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: kToolbarHeight,
                      child: AppBar(
                        flexibleSpace: Container(
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
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
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ViewModelBuilder<ChartViewModel>.reactive(
            viewModelBuilder: () => ChartViewModel(widget.productBarcode ?? ''),
            onModelReady: (model) => model.init(),
            builder: (context, viewModel, child) {
              if (!viewModel.isInited)
                return Stack(
                  children: [
                    Positioned(
                      top: -450.h,
                      child: IgnorePointer(
                        ignoring: true,
                        child: ImageFiltered(
                          imageFilter:
                              new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            width: 1.sw,
                            height: 450.h,
                            color: Colors.black.withOpacity(0.10),
                          ),
                        ),
                      ),
                    ),
                    CurvedContainer(
                      radius: 20,
                      child: Container(
                        color: Color.fromARGB(255, 253, 253, 253),
                        child: Container(
                          color: AppTheme().greyScale5,
                          child: CustomLoadIndicator(),
                        ),
                      ),
                    ),
                  ],
                );
              if (!viewModel.isFoodExists) {
                return Container(
                  width: 1.sw,
                  color: AppTheme().greyScale5,
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Positioned(
                          top: -450.h,
                          child: IgnorePointer(
                            ignoring: true,
                            child: ImageFiltered(
                              imageFilter: new ImageFilter.blur(
                                  sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                width: 1.sw,
                                height: 450.h,
                                color: Colors.black.withOpacity(0.10),
                              ),
                            ),
                          ),
                        ),
                        CurvedContainer(
                          radius: 20,
                          child: Container(
                            color: Color.fromARGB(255, 253, 253, 253),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    color: Colors.transparent,
                                    child: LottieBuilder.asset(
                                      AppImages.searchNotFound.lottiePath,
                                      width: 256,
                                      reverse: true,
                                      //repeat: false,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    'We could not find this product.',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme().greyScale1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 48,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -450,
                          child: IgnorePointer(
                            ignoring: true,
                            child: ImageFiltered(
                              imageFilter: new ImageFilter.blur(
                                  sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                width: 1.sw,
                                height: 450.h,
                                color: Colors.black.withOpacity(0.10),
                              ),
                            ),
                          ),
                        ),
                        CurvedContainer(
                          radius: 20,
                          child: Container(
                            color: Color.fromARGB(255, 253, 253, 253),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 7.5.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 25.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.local_activity_rounded,
                                        size: 32,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'Nutrition',
                                        style: AppTheme()
                                            .paragraphRegularText
                                            .copyWith(
                                              fontSize: AppTheme()
                                                      .paragraphRegularText
                                                      .fontSize! *
                                                  1.1,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 8.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      //crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      mainAxisExtent: 100,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final nutritionCategory =
                            viewModel.nutritionCategories[index];
                        return Container(
                          margin: EdgeInsets.only(left: 7.5, right: 7.5),
                          child: Card(
                            elevation: 3.75,
                            borderOnForeground: true,
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: AutoSizeText(
                                      '${nutritionCategory.name}',
                                      style: AppTheme()
                                          .extraSmallParagraphRegularText,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    '${nutritionCategory.value}',
                                    style: AppTheme().paragraphSemiBoldText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: viewModel.nutritionCategories.length,
                    ),
                  ),
                  if (viewModel.foodFact.product?.ingredientsTextEn != null)
                    SliverToBoxAdapter(
                      child: CurvedContainer(
                        radius: 20,
                        child: Container(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 7.5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 25.h,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.donut_small_rounded,
                                      size: 32,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Ingredients',
                                      style: AppTheme()
                                          .paragraphRegularText
                                          .copyWith(
                                            fontSize: AppTheme()
                                                    .paragraphRegularText
                                                    .fontSize! *
                                                1.1,
                                          ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 8.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (viewModel.foodFact.product?.ingredientsTextEn != null)
                    SliverPadding(
                        padding: EdgeInsets.only(
                          bottom: 25.h,
                          left: 10,
                          right: 10,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            '${viewModel.foodFact.product?.ingredientsTextEn}',
                            style: AppTheme()
                                .extraSmallParagraphRegularText
                                .copyWith(
                                  fontSize: 16,
                                  color: AppTheme().greyScale2,
                                ),
                          ),
                        )),
                  /*SliverToBoxAdapter(
                    child: CurvedContainer(
                      radius: 20,
                      child: Container(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 7.5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 25.h,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.rule,
                                    size: 32,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'Allergens',
                                    style: AppTheme()
                                        .paragraphRegularText
                                        .copyWith(
                                          fontSize: AppTheme()
                                                  .paragraphRegularText
                                                  .fontSize! *
                                              1.1,
                                        ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 8.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                      padding: EdgeInsets.only(
                        bottom: 25.h,
                        left: 10,
                        right: 10,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          '${viewModel.foodFact.product?.allergensFromIngredients}',
                          style: AppTheme()
                              .extraSmallParagraphRegularText
                              .copyWith(
                                fontSize: 16,
                                color: AppTheme().greyScale2,
                              ),
                        ),
                      )),*/
                  /*SliverToBoxAdapter(
                    child: Column(
                      children: [],
                    ),
                  )*/
                ],
              );
            },
          ),
        ),
      ),
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
              child: ImageBox(
                width: 1.sw,
                height: 300.h,
                url: widget.winItem.images![0],
                fit: BoxFit.scaleDown,
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
        ],
      ),
    );
  }
}

/*
  List<RadarDataSet> showingDataSets(FoodFactModel foodFact) {
    return [
      RadarDataSet(
        fillColor: Colors.blueGrey.withOpacity(0.35),
        borderColor: Colors.blueGrey,
        entryRadius: 5,
        dataEntries: [
          RadarEntry(
              value:
                  foodFact.product?.nutriments?.carbohydrates100G?.toDouble() ??
                      1),
          RadarEntry(
              value:
                  foodFact.product?.nutriments?.proteins100G?.toDouble() ?? 1),
          RadarEntry(
              value: foodFact.product?.nutriments?.fat100G?.toDouble() ?? 1),
          RadarEntry(
              value: foodFact.product?.nutriments?.sugars100G?.toDouble() ?? 1),
        ],
        borderWidth: 2,
      ),
      ...rawDataSets(foodFact).asMap().entries.map((entry) {
        var index = entry.key;
        var rawDataSet = entry.value;

        final isSelected = index == selectedDataSetIndex
            ? true
            : selectedDataSetIndex == -1
                ? true
                : false;

        return RadarDataSet(
          fillColor: isSelected
              ? rawDataSet.color.withOpacity(0.2)
              : rawDataSet.color.withOpacity(0.05),
          borderColor: isSelected
              ? rawDataSet.color
              : rawDataSet.color.withOpacity(0.25),
          entryRadius: isSelected ? 3 : 2,
          dataEntries: [
            ...rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
          ],
          borderWidth: isSelected ? 2.3 : 2,
        );
      }).toList()
    ];
  }

  List<RawDataSet> rawDataSets(FoodFactModel foodFact) {
    return [
      RawDataSet(
        title: 'Carbonhydrates',
        color: fashionColor,
        values: [
          foodFact.product?.nutriments?.carbohydrates100G?.toDouble() ?? 1,
          0,
          0,
          0,
        ],
      ),
      RawDataSet(
        title: 'Protein',
        color: offRoadColor,
        values: [
          0,
          foodFact.product?.nutriments?.proteins100G?.toDouble() ?? 1,
          0,
          0,
        ],
      ),
      RawDataSet(
        title: 'Fat',
        color: artColor,
        values: [
          0,
          0,
          foodFact.product?.nutriments?.fat100G?.toDouble() ?? 1,
          0,
        ],
      ),
      RawDataSet(
        title: 'Sugar',
        color: entertainmentColor,
        values: [
          0,
          0,
          0,
          foodFact.product?.nutriments?.sugars100G?.toDouble() ?? 1,
        ],
      ),
    ];
  }
}

class RawDataSet {
  final String title;
  final Color color;
  final List<double> values;

  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });
}
*/
