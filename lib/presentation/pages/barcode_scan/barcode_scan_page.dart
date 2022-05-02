import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/domain/repositories/local_data_repository.dart';
import 'package:stipra/presentation/pages/sign/enter_phone_number_page/enter_phone_number_page.dart';
import '../../widgets/overlay/lock_overlay.dart';

import '../../../data/models/barcode_timestamp_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';
import '../../../shared/app_theme.dart';
import 'barcode_scan_viewmodel.dart';

part 'widgets/bottom_box.dart';

/// Create a UI for camera to scan barcodes and buttons to cancel and open flash

class BarcodeScanPage extends StatelessWidget {
  final int? maxBarcodeLength;
  final String? findBarcode;
  BarcodeScanPage({
    Key? key,
    this.maxBarcodeLength,
    this.findBarcode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BarcodeScanViewModel>.reactive(
        viewModelBuilder: () => BarcodeScanViewModel(
              maxBarcodeLength: maxBarcodeLength,
              findBarcode: findBarcode,
            ),
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
                Positioned.fill(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: wrapWithShadowContainer(
                      child: ValueListenableBuilder(
                          valueListenable: viewModel.countDownDuration,
                          builder: (context, value, child) {
                            if (viewModel.countDownDuration.value == 0) {
                              return Container(
                                height: 0,
                              );
                            }
                            return AnimatedSwitcher(
                              duration: Duration(milliseconds: 250),
                              child: Container(
                                key: GlobalKey(),
                                child: Text(
                                  '${viewModel.countDownDuration.value}',
                                  style: AppTheme().headingText.copyWith(
                                        fontSize: 64,
                                        color: Colors.red,
                                      ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 15,
                  child: SafeArea(
                    child: wrapWithShadowContainer(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            color: Colors.white,
                            icon: Icon(FontAwesomeIcons.clock),
                            iconSize: 24.0,
                            onPressed: () {
                              //
                            },
                          ),
                          ValueListenableBuilder(
                              valueListenable: viewModel.timeDuration,
                              builder: (context, value, child) {
                                return Text(
                                  '${viewModel.timeDuration.value}',
                                  style: AppTheme()
                                      .smallParagraphSemiBoldText
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 15,
                  child: SafeArea(
                    child: wrapWithShadowContainer(
                      child: GestureDetector(
                        onTap: () {
                          if (locator<LocalDataRepository>().getUser().alogin ==
                              null)
                            AppNavigator.pushReplacement(
                                context: context,
                                child: EnterPhoneNumberScreen(
                                  isSignIn: true,
                                ));
                        },
                        child: Column(
                          children: [
                            IconButton(
                              color: Colors.white,
                              icon: Icon(FontAwesomeIcons.user),
                              iconSize: 24.0,
                              onPressed: () {
                                if (locator<LocalDataRepository>()
                                        .getUser()
                                        .alogin ==
                                    null)
                                  AppNavigator.pushReplacement(
                                      context: context,
                                      child: EnterPhoneNumberScreen(
                                        isSignIn: true,
                                      ));
                              },
                            ),
                            Text(
                              locator<LocalDataRepository>().getUser().name ??
                                  'Not logged in',
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
                ),
                BottomBox(
                  startCapture: viewModel.startCapture,
                  stopCapture: viewModel.stopCapture,
                  cameraController: viewModel.controller,
                  isStarted: viewModel.isStarted,
                  isStopped: viewModel.isStopped,
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
