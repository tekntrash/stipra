import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:path/path.dart' as path;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/services/image_service.dart';
import 'package:stipra/core/services/path_service.dart';
import 'package:stipra/core/utils/time_converter/time_converter.dart';
import 'package:stipra/presentation/pages/take_picture/take_picture_viewmodel.dart';
part 'widgets/camera_flip_button.dart';
part 'widgets/camera_preview_widget.dart';
part 'widgets/capture_button.dart';
part 'widgets/flash_button.dart';
part 'widgets/go_back_button.dart';
part 'widgets/pick_from_gallery_button.dart';
part 'widgets/zoomable_widget.dart';

class TakePicturePage extends StatefulWidget {
  const TakePicturePage({Key? key}) : super(key: key);

  @override
  State<TakePicturePage> createState() => _TakePicturePageState();

  //Get takepicturepage from context
  static _TakePicturePageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_TakePicturePageState>();
}

class _TakePicturePageState extends State<TakePicturePage>
    with WidgetsBindingObserver {
  TakePictureViewModel? _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (_viewModel?.customCameraController == null ||
        !(_viewModel?.customCameraController?.value.isInitialized == true)) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _viewModel?.customCameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_viewModel?.customCameraController != null) {
        _viewModel?.onNewCameraSelected(
            _viewModel!.customCameraController!.description);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TakePictureViewModel>.reactive(
      viewModelBuilder: () => TakePictureViewModel(),
      onModelReady: (TakePictureViewModel viewModel) {
        _viewModel = viewModel;
        availableCameras().then((value) {
          viewModel.cameraDescriptionList = value;
          viewModel.onNewCameraSelected(value.first);
        });
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  color: Colors.transparent,
                  child: ZoomableWidget(
                    child: _CameraPreviewWidget(
                      controller: viewModel.customCameraController,
                    ),
                    onZoom: (zoom) {
                      if (zoom < 11) {
                        viewModel.customCameraController?.setZoomLevel(zoom);
                      }
                    },
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _FlashButton(
                                flashMode: viewModel.flashMode,
                                changeFlashMode: viewModel.changeFlashMode,
                              ),
                              _CaptureButton(
                                onCapture: viewModel.onTakePictureButtonPressed,
                              ),
                              _CameraFlipButton(
                                flipCamera: viewModel.flipCamera,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: _PickFromGalleryButton(),
                        ),
                      ],
                    ),
                  )),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
