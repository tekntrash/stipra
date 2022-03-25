import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stipra/presentation/widgets/mobile_scanner_fixed.dart';
import 'package:stipra/shared/app_theme.dart';

class BarcodeScanPage extends StatelessWidget {
  BarcodeScanPage({Key? key}) : super(key: key);

  final MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScannerFixed(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) async {
              final String? code = barcode.rawValue;
              debugPrint('Barcode found! $code');
              /*ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Barcode found: $code'),
                ),
              );*/
              await showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        decoration: BoxDecoration(
                          color: AppTheme().greyScale3,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'Barcode found: $code',
                          style: AppTheme().smallParagraphRegularText.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  );
                },
              );
              await Future.delayed(Duration(seconds: 2));
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
                        //open help
                      },
                    ),
                    Text(
                      'Help',
                      style:
                          AppTheme().extraSmallParagraphSemiBoldText.copyWith(
                                color: Colors.white,
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 15,
            right: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                wrapWithShadowContainer(
                  child: Column(
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.close_rounded),
                        iconSize: 32.0,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        'Exit',
                        style:
                            AppTheme().extraSmallParagraphSemiBoldText.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ],
                  ),
                ),
                wrapWithShadowContainer(
                  child: Column(
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: cameraController.cameraFacingState,
                          builder: (context, state, child) {
                            switch (state as CameraFacing) {
                              case CameraFacing.front:
                                return const Icon(Icons.camera_front);
                              case CameraFacing.back:
                                return const Icon(Icons.camera_rear);
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => cameraController.switchCamera(),
                      ),
                      Text(
                        'Switch',
                        style:
                            AppTheme().extraSmallParagraphSemiBoldText.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ],
                  ),
                ),
                wrapWithShadowContainer(
                  child: Column(
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: cameraController.torchState,
                          builder: (context, state, child) {
                            switch (state as TorchState) {
                              case TorchState.off:
                                return const Icon(Icons.flash_off,
                                    color: Colors.grey);
                              case TorchState.on:
                                return const Icon(Icons.flash_on,
                                    color: Colors.yellow);
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => cameraController.toggleTorch(),
                      ),
                      Text(
                        'Light',
                        style:
                            AppTheme().extraSmallParagraphSemiBoldText.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
