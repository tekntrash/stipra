import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../core/utils/time_converter/time_converter.dart';
import '../../../data/models/offer_model.dart';
import '../../../shared/app_theme.dart';
import '../../widgets/curved_container.dart';
import '../../widgets/image_box.dart';
import '../../widgets/like_section.dart';
import 'trading_offer_detail_viewmodel.dart';

part 'top_bar.dart';

class TradingOfferDetailPage extends StatelessWidget {
  final OfferModel offerModel;
  const TradingOfferDetailPage({
    Key? key,
    required this.offerModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TradingOfferDetailViewModel>.reactive(
      viewModelBuilder: () => TradingOfferDetailViewModel(),
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
          backgroundColor: AppTheme.whiteColor,
          body: Container(
            child: SafeArea(
              child: ListView(
                children: [
                  Container(
                    height: 250.h,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 0,
                          child: ImageFiltered(
                            imageFilter:
                                new ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
                            child: ImageBox(
                              width: 1.sw,
                              height: 275.h,
                              url: offerModel.image ?? '',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: ImageFiltered(
                            imageFilter:
                                new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              width: 1.sw,
                              height: 275.h,
                              color: Colors.black.withOpacity(0.08),
                            ),
                          ),
                        ),
                        /*ImageBox(
                          width: 1.sw,
                          height: 250.h,
                          url: offerModel.image ?? '',
                          fit: BoxFit.fitHeight,
                        ),*/
                      ],
                    ),
                  ),
                  CurvedContainer(
                    radius: 20,
                    child: Container(
                      color: AppTheme.whiteColor,
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
                              offerModel: offerModel,
                            ),
                            Container(
                              height: 32.h,
                            ),
                            LikeSection(),
                            Container(
                              height: 8.h,
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Container(
                              height: 8.h,
                            ),
                            Text(
                              offerModel.desc ?? '',
                              style: AppTheme.smallParagraphRegularText,
                            ),
                            Container(
                              height: 45.h,
                            ),
                          ],
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
