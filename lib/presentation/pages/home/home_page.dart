import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/home/widgets/bottom_bar.dart';
import 'package:stipra/presentation/pages/home/widgets/top_bar.dart';

import '../../../shared/app_theme.dart';
import '../../widgets/curved_container.dart';
import 'home_viewmodel.dart';
import 'widgets/product_offer/product_offers_list.dart';
import 'widgets/trading_point_offer/trading_point_offers_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
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
          bottomNavigationBar: BottomBar(
            tabController: tabController,
          ),
          backgroundColor: AppTheme.primaryColor,
          body: Container(
            child: SafeArea(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  TopBar(),
                  SizedBox(
                    height: 40.h,
                  ),
                  CurvedContainer(
                    child: Container(
                      color: AppTheme.whiteColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 25.h,
                          ),
                          TradingPointOffersList(
                            offers: viewModel.offers,
                          ),
                          Container(
                            height: 25.h,
                          ),
                          ProductOffersList(
                            products: viewModel.products,
                          ),
                          Container(
                            height: 25.h,
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
}
