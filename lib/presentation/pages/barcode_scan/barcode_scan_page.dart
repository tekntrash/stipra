import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stipra/domain/repositories/data_repository.dart';
import 'package:stipra/injection_container.dart';
import 'package:stipra/presentation/widgets/mobile_scanner_fixed.dart';
import 'package:stipra/presentation/widgets/overlay/lock_overlay.dart';
import 'package:stipra/shared/app_theme.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class BarcodeScanPage extends StatefulWidget {
  BarcodeScanPage({Key? key}) : super(key: key);

  @override
  State<BarcodeScanPage> createState() => _BarcodeScanPageState();
}

class _BarcodeScanPageState extends State<BarcodeScanPage> {
  MobileScannerController? cameraController;
  late bool? isStarted;

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  late List<BarcodeTimeStampModel> barcodeTimeStamps;

  @override
  void initState() {
    isStarted = false;
    barcodeTimeStamps = [];
    cameraController = MobileScannerController();
    requestPermissions();

    super.initState();
  }

  requestPermissions() async {
    if (await Permission.camera.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }

    if (await Permission.storage.request().isGranted) {
      //
      print('Record started $isStarted');
    }
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 3));
      isStarted = await FlutterScreenRecording.startRecordScreen(
        'testname${Random().nextInt(9999999) + 50000}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          (cameraController != null)
              ? MobileScannerFixed(
                  allowDuplicates: false,
                  controller: cameraController,
                  onDetect: (barcode, args) async {
                    if (isStarted != true) {
                      return;
                    }
                    final String? code = barcode.rawValue;
                    if (code != null) {
                      barcodeTimeStamps.add(
                        BarcodeTimeStampModel(
                            timeStamp: timestamp(), barcode: code),
                      );
                      locator<DataRepository>().sendBarcode(code);
                      debugPrint('Barcode found! $code sent');
                    }
                    /*ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Barcode found: $code'),
                ),
              );*/
                    /*await showDialog(
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
              );*/
                    await Future.delayed(Duration(seconds: 1));
                  },
                )
              : Container(),
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
                        onPressed: () async {
                          await stopCapture(pop: true);
                        },
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
                        icon: Icon(Icons.stop),
                        /*ValueListenableBuilder(
                          valueListenable: cameraController.cameraFacingState,
                          builder: (context, state, child) {
                            switch (state as CameraFacing) {
                              case CameraFacing.front:
                                return const Icon(Icons.camera_front);
                              case CameraFacing.back:
                                return const Icon(Icons.camera_rear);
                            }
                          },
                        ),*/
                        iconSize: 32.0,
                        onPressed: () async {
                          await stopCapture();
                        }, //cameraController.switchCamera(),
                      ),
                      Text(
                        'Stop Record',
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
                        icon: ValueListenableBuilder<TorchState>(
                          valueListenable: cameraController?.torchState ??
                              ValueNotifier(TorchState.off),
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
                        onPressed: () => cameraController?.toggleTorch(),
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

  Future<void> stopCapture({bool pop: false}) async {
    final _lastStart = isStarted;
    isStarted = false;
    if (_lastStart == true) {
      LockOverlay().showClassicLoadingOverlay(buildAfterRebuild: true);
      final path = await FlutterScreenRecording.stopRecordScreen;
      LockOverlay().closeOverlay();
      await showDialog(
        context: context,
        builder: (context) {
          return VideoApp(path, barcodeTimeStamps);
        },
      );
      Navigator.of(context).pop();
    } else {
      if (pop) {
        Navigator.pop(context);
      }
    }
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

class VideoApp extends StatefulWidget {
  final String path;
  final List<BarcodeTimeStampModel> barcodeTimeStamps;
  VideoApp(this.path, this.barcodeTimeStamps);
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      })
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Positioned(
            bottom: 0,
            child: Material(
              elevation: 5,
              color: AppTheme().greyScale1.withOpacity(0.55),
              child: Container(
                margin: EdgeInsets.only(left: 15, top: 10),
                width: 1.sw,
                height: 100,
                child: ListView(
                  children: [
                    Text(
                      'Barcode TimeStamps',
                      style: AppTheme()
                          .smallParagraphSemiBoldText
                          .copyWith(color: Colors.white),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.barcodeTimeStamps.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Text(
                          '${widget.barcodeTimeStamps[index].barcode} - ${widget.barcodeTimeStamps[index].timeStamp}',
                          style: AppTheme()
                              .smallParagraphRegularText
                              .copyWith(color: Colors.white),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme().primaryColor,
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class BarcodeTimeStampModel {
  String timeStamp;
  String barcode;
  BarcodeTimeStampModel({required this.timeStamp, required this.barcode});
}
