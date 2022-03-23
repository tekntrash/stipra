import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/home/widgets/bottom_bar.dart';
import 'package:stipra/presentation/pages/home/widgets/top_bar.dart';
import 'package:stipra/presentation/widgets/local_image_box.dart';

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
          floatingActionButton: Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: LocalImageBox(
                width: 32.w,
                height: 32.w,
                imgUrl: 'barcode.png',
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomBar(
            tabController: tabController,
          ),
          //backgroundColor: Color.fromRGBO(255, 189, 55, 1),
          body: Container(
            color: Color.fromRGBO(255, 189, 55, 1),
            child: SafeArea(
              child: ListView(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  TopBar(),
                  SizedBox(
                    height: 15.h,
                  ),
                  CurvedContainer(
                    radius: 30,
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
