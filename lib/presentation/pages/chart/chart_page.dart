import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/models/food_fact_model.dart';
import 'package:stipra/presentation/pages/chart/chart_viewmodel.dart';
import 'package:stipra/presentation/widgets/custom_load_indicator.dart';
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
  const RadarChartSample1({
    Key? key,
    required this.productBarcode,
  }) : super(key: key);

  @override
  _RadarChartSample1State createState() => _RadarChartSample1State();
}

class _RadarChartSample1State extends State<RadarChartSample1> {
  int selectedDataSetIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChartViewModel>.reactive(
      viewModelBuilder: () => ChartViewModel(widget.productBarcode ?? ''),
      onModelReady: (model) => model.init(),
      builder: (context, viewModel, child) {
        if (!viewModel.isInited)
          return Container(
            color: AppTheme().greyScale5,
            child: CustomLoadIndicator(),
          );
        if (!viewModel.isFoodExists) {
          return Scaffold(
            backgroundColor: AppTheme().greyScale5,
            body: Container(
              color: AppTheme().greyScale5,
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
          );
        }
        return Scaffold(
          backgroundColor: AppTheme().greyScale5,
          body: GestureDetector(
            onTap: () {
              setState(() {
                selectedDataSetIndex = -1;
              });
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppTheme().blackColor.withOpacity(0.33),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                'Categories'.toUpperCase(),
                                style: TextStyle(
                                  color: AppTheme().whiteColor,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ...rawDataSets(viewModel.foodFact)
                                  .asMap()
                                  .map((index, value) {
                                    final isSelected =
                                        index == selectedDataSetIndex;
                                    return MapEntry(
                                      index,
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedDataSetIndex = index;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          height: 26,
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? AppTheme()
                                                    .greyScale1
                                                    .withOpacity(0.5)
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(46),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 6),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 400),
                                                curve: Curves.easeInToLinear,
                                                padding: EdgeInsets.all(
                                                    isSelected ? 8 : 6),
                                                decoration: BoxDecoration(
                                                  color: value.color,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              AnimatedDefaultTextStyle(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeInToLinear,
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? value.color
                                                      : AppTheme().greyScale5,
                                                ),
                                                child: Text(value.title),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  .values
                                  .toList()
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: RadarChart(
                            RadarChartData(
                              radarTouchData: RadarTouchData(touchCallback:
                                  (FlTouchEvent event, response) {
                                if (!event.isInterestedForInteractions) {
                                  setState(() {
                                    selectedDataSetIndex = -1;
                                  });
                                  return;
                                }
                                setState(() {
                                  selectedDataSetIndex = response
                                          ?.touchedSpot?.touchedDataSetIndex ??
                                      -1;
                                });
                              }),
                              dataSets: showingDataSets(viewModel.foodFact),
                              radarBackgroundColor: Colors.transparent,
                              borderData: FlBorderData(show: false),
                              radarBorderData:
                                  BorderSide(color: Colors.transparent),
                              titlePositionPercentageOffset: 0.2,
                              titleTextStyle: TextStyle(
                                  color: AppTheme().blackColor, fontSize: 14),
                              getTitle: (index) {
                                switch (index) {
                                  case 0:
                                    return 'Carbonhydrates';
                                  case 2:
                                    return 'Fat';
                                  case 1:
                                    return 'Protein';
                                  case 3:
                                    return 'Sugar';
                                  default:
                                    return '';
                                }
                              },
                              tickCount: 1,
                              ticksTextStyle: const TextStyle(
                                  color: Colors.transparent, fontSize: 64),
                              tickBorderData:
                                  BorderSide(color: Colors.transparent),
                              gridBorderData: BorderSide(
                                  color: AppTheme().greyScale1, width: 2),
                            ),
                            swapAnimationDuration:
                                const Duration(milliseconds: 400),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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
