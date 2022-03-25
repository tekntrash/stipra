import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

enum Ratio { ratio_4_3, ratio_16_9 }

/// A widget showing a live camera preview.
class MobileScannerFixed extends StatefulWidget {
  /// The controller of the camera.
  final MobileScannerController? controller;

  /// Function that gets called when a Barcode is detected.
  ///
  /// [barcode] The barcode object with all information about the scanned code.
  /// [args] Information about the state of the MobileScannerFixed widget
  final Future<void> Function(Barcode barcode, MobileScannerArguments? args)?
      onDetect;

  /// TODO: Function that gets called when the Widget is initialized. Can be usefull
  /// to check wether the device has a torch(flash) or not.
  ///
  /// [args] Information about the state of the MobileScannerFixed widget
  // final Function(MobileScannerArguments args)? onInitialize;

  /// Handles how the widget should fit the screen.
  final BoxFit fit;

  /// Set to false if you don't want duplicate scans.
  final bool allowDuplicates;

  /// Create a [MobileScannerFixed] with a [controller], the [controller] must has been initialized.
  const MobileScannerFixed(
      {Key? key,
      this.onDetect,
      this.controller,
      this.fit = BoxFit.cover,
      this.allowDuplicates = false})
      : super(key: key);

  @override
  State<MobileScannerFixed> createState() => _MobileScannerFixedState();
}

class _MobileScannerFixedState extends State<MobileScannerFixed>
    with WidgetsBindingObserver {
  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    controller = widget.controller ?? MobileScannerController();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!controller.isStarting) controller.start();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        controller.stop();
        break;
    }
  }

  String? lastScanned;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return ValueListenableBuilder(
          valueListenable: controller.args,
          builder: (context, value, child) {
            value = value as MobileScannerArguments?;
            if (value == null) {
              return Container(color: Colors.black);
            } else {
              controller.barcodes.listen((barcode) {
                if (!widget.allowDuplicates) {
                  if (lastScanned != barcode.rawValue) {
                    lastScanned = barcode.rawValue;
                    Future.microtask(() async {
                      await widget.onDetect!(
                          barcode, value as MobileScannerArguments);
                      lastScanned = null;
                    });
                  }
                } else {
                  widget.onDetect!(barcode, value as MobileScannerArguments);
                }
              });
              return ClipRect(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FittedBox(
                    fit: widget.fit,
                    child: SizedBox(
                      width: value.size.width,
                      height: value.size.height,
                      child: kIsWeb
                          ? HtmlElementView(viewType: value.webId!)
                          : Texture(textureId: value.textureId!),
                    ),
                  ),
                ),
              );
            }
          });
    });
  }

  @override
  void didUpdateWidget(covariant MobileScannerFixed oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller == null) {
      if (widget.controller != null) {
        controller.dispose();
        controller = widget.controller!;
      }
    } else {
      if (widget.controller == null) {
        controller = MobileScannerController();
      } else if (oldWidget.controller != widget.controller) {
        controller = widget.controller!;
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}
