import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/domain/repositories/local_data_repository.dart';
import 'package:stipra/injection_container.dart';
import 'package:stipra/presentation/pages/barcode_scan/barcode_scan_page.dart';
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

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: AppTheme().gradientPrimary,
            ),
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
                      color: AppTheme().whiteColor,
                      child: (!viewModel.isInited)
                          ? Container(
                              height: 0.75.sh,
                              child: Center(
                                child: Container(
                                  width: 48.w,
                                  height: 48.w,
                                  child: CircularProgressIndicator.adaptive(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppTheme().darkPrimaryColor,
                                    ),
                                    strokeWidth: 3,
                                  ),
                                ),
                              ),
                            )
                          : Column(
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

  @override
  bool get wantKeepAlive => true;
}
