import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/domain/repositories/local_data_repository.dart';
import 'package:stipra/presentation/pages/loyalty_cards/card_scan/card_scan_viewmodel.dart';
import 'package:stipra/presentation/pages/sign/enter_phone_number_page/enter_phone_number_page.dart';

import '../../../../shared/app_theme.dart';

part 'widgets/bottom_box.dart';

/// Create a UI for camera to scan barcodes and buttons to cancel and open flash

class LoyaltyCardScanPage extends StatelessWidget {
  final int? maxBarcodeLength;
  final String? findBarcode;
  LoyaltyCardScanPage({
    Key? key,
    this.maxBarcodeLength,
    this.findBarcode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoyaltyCardScanViewModel>.reactive(
        viewModelBuilder: () => LoyaltyCardScanViewModel(),
        onModelReady: (model) => model.init(context),
        onDispose: (model) => model.dispose(),
        builder: (context, viewModel, child) {
          //final size = MediaQuery.of(context).size;

          return Scaffold(
            body: Stack(
              children: <Widget>[
                IgnorePointer(
                  ignoring: true,
                  child: viewModel.controller == null
                      ? Container()
                      : Container(
                          color: Colors.black,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Center(
                                child: CameraPreview(viewModel.controller!),
                              ),
                              if (viewModel.customPaint != null)
                                viewModel.customPaint!,
                              /*Positioned(
                              bottom: 100,
                              left: 50,
                              right: 50,
                              child: Slider(
                                value: viewModel.zoomLevel,
                                min: viewModel.minZoomLevel,
                                max: viewModel.maxZoomLevel,
                                onChanged: (newSliderValue) {
                                  viewModel.zoomLevel = newSliderValue;
                                  viewModel.controller!
                                      .setZoomLevel(viewModel.zoomLevel);
                                  viewModel.notifyListeners();
                                },
                                divisions:
                                    (viewModel.maxZoomLevel - 1).toInt() < 1
                                        ? null
                                        : (viewModel.maxZoomLevel - 1).toInt(),
                              ),
                            )*/
                            ],
                          ),
                        ),
                ),
                BottomBox(
                  startCapture: viewModel.startCapture,
                  stopCapture: viewModel.stopCapture,
                  cameraController: viewModel.controller,
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
