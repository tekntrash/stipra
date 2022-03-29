import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stacked/stacked.dart';

import '../../../data/models/barcode_timestamp_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';
import '../../../shared/app_theme.dart';
import '../../widgets/mobile_scanner_fixed.dart';
import 'barcode_scan_viewmodel.dart';

part 'widgets/bottom_box.dart';

class BarcodeScanPage extends StatelessWidget {
  BarcodeScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BarcodeScanViewModel>.reactive(
        viewModelBuilder: () => BarcodeScanViewModel(),
        onModelReady: (model) => model.init(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                MobileScannerFixed(
                  allowDuplicates: false,
                  controller: viewModel.cameraController,
                  onDetect: (barcode, args) async {
                    viewModel.onDetect(barcode, args);
                  },
                ),
                Positioned(
                  top: 5,
                  right: 15,
                  child: SafeArea(
                    child: wrapWithShadowContainer(
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            icon: Icon(FontAwesomeIcons.question),
                            iconSize: 24.0,
                            onPressed: () {
                              //
                            },
                          ),
                          Text(
                            'Help',
                            style: AppTheme()
                                .extraSmallParagraphSemiBoldText
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BottomBox(
                  stopCapture: viewModel.stopCapture,
                  cameraController: viewModel.cameraController,
                ),
              ],
            ),
          );
        });
  }

  Widget wrapWithShadowContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppTheme().greyScale0,
            blurRadius: 75,
          ),
        ],
      ),
      child: child,
    );
  }
}
