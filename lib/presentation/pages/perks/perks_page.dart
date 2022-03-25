import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/presentation/pages/barcode_scan/barcode_scan_page.dart';
import 'package:stipra/presentation/pages/home/widgets/bottom_bar.dart';
import 'package:stipra/presentation/pages/home/widgets/top_bar.dart';
import 'package:stipra/presentation/pages/perks/widgets/perks_list.dart';
import 'package:stipra/presentation/widgets/local_image_box.dart';

import '../../../shared/app_theme.dart';
import '../../widgets/curved_container.dart';
import 'perks_viewmodel.dart';

class PerksPage extends StatefulWidget {
  const PerksPage({Key? key}) : super(key: key);

  @override
  State<PerksPage> createState() => _PerksPageState();
}

class _PerksPageState extends State<PerksPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<PerksViewModel>.reactive(
      viewModelBuilder: () => PerksViewModel(),
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
                          ? Center(
                              child: Container(
                                width: 64.w,
                                height: 64.w,
                                child: CircularProgressIndicator.adaptive(),
                              ),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 25.h,
                                ),
                                PerksList(
                                  offers: viewModel.offers,
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
