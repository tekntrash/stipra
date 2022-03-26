import 'dart:ui';

import 'package:flutter/material.dart';

/*
class TestBarcodeScanPage extends StatefulWidget {
  TestBarcodeScanPage({Key? key}) : super(key: key);

  @override
  State<TestBarcodeScanPage> createState() => _TestBarcodeScanPageState();
}

class _TestBarcodeScanPageState extends State<TestBarcodeScanPage> {
  late List<CameraDescription> cameras;
  late final MobileScannerController cameraController;

  CameraController? controller;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    if (cameras.length > 0) {
      log('Camera founded!');
      controller = CameraController(
        cameras[0],
        ResolutionPreset.max,
        enableAudio: false,
      );
    }
    controller?.initialize().then((_) {
      log('Camera inited!');
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    cameraController = MobileScannerController();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          (controller?.value.isInitialized == true)
              ? CameraPreview(
                  controller!,
                )
              : Container(),
          /*MobileScannerFixed(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) async {
              final String? code = barcode.rawValue;
              log('Barcode found! $code');
              await Future.delayed(Duration(seconds: 2));
              /*ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Barcode found: $code'),
                ),
              );*/
              /* await showDialog(
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
              await Future.delayed(Duration(seconds: 2));*/
            },
          ),*/
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  IconButton(
                    color: (controller?.value.isRecordingVideo == true)
                        ? Colors.red
                        : Colors.black,
                    icon: Icon(FontAwesomeIcons.video),
                    iconSize: 24.0,
                    onPressed: () async {
                      log('Hello ${controller}');
                      final Directory extDir =
                          await getApplicationDocumentsDirectory();
                      final String dirPath = '${extDir.path}/scan_videos/';
                      await Directory(dirPath).create(recursive: true);
                      final String filePath = '$dirPath/${timestamp()}.mp4';

                      await controller?.startVideoRecording(filePath);
                      log('Hello 1');
                      setState(() {});
                      log('Hello 2');
                      Future.delayed(Duration(seconds: 5));
                      log('Hello 3');
                      await controller?.stopVideoRecording();
                      log('Hello 4');
                      setState(() {});
                    },
                  ),
                  Text(
                    'Help',
                    style: AppTheme().extraSmallParagraphSemiBoldText.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/

/*
ShapeDecoration(
                  shape: _ScannerOverlayShape(
                    borderColor: Theme.of(context).primaryColor,
                    borderWidth: 3.0,
                  ),
                ),
 */
class _ScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;

  _ScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderWidth = 1.0,
    this.overlayColor = const Color(0x88000000),
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(10.0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return _getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    const lineSize = 30;

    final width = rect.width;
    final borderWidthSize = width * 10 / 100;
    final height = rect.height;
    final borderHeightSize = height - (width - borderWidthSize);
    final borderSize = Size(borderWidthSize / 2, borderHeightSize / 2);

    var paint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    canvas
      ..drawRect(
        Rect.fromLTRB(
            rect.left, rect.top, rect.right, borderSize.height + rect.top),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.bottom - borderSize.height, rect.right,
            rect.bottom),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.top + borderSize.height,
            rect.left + borderSize.width, rect.bottom - borderSize.height),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(
            rect.right - borderSize.width,
            rect.top + borderSize.height,
            rect.right,
            rect.bottom - borderSize.height),
        paint,
      );

    paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final borderOffset = borderWidth / 2;
    final realReact = Rect.fromLTRB(
        borderSize.width + borderOffset,
        borderSize.height + borderOffset + rect.top,
        width - borderSize.width - borderOffset,
        height - borderSize.height - borderOffset + rect.top);

    //Draw top right corner
    canvas
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right - lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.top)],
        paint,
      )

      //Draw top left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left + lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.top)],
        paint,
      )

      //Draw bottom right corner
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right - lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.bottom)],
        paint,
      )

      //Draw bottom left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left + lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.bottom)],
        paint,
      );
  }

  @override
  ShapeBorder scale(double t) {
    return _ScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}

/*
final BarcodeDetector _barcodeDetector =
    FirebaseVision.instance.barcodeDetector();
String data = 'EMPTY DATA';

class ScanScreen extends StatefulWidget {
  static String id = 'scan_screen';
  //final CameraDescription camera = cameras.first;
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  CameraImage? _savedImage;
  bool _cameraInitialized = false;
  void _initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize().then((_) async {
      // Start ImageStream
      await _controller
          .startImageStream((CameraImage image) => _processCameraImage(image));
//      setState(() {
//        _cameraInitialized = true;
//      });
    });
  }

  Future<String> readBarcode(CameraImage image) async {
    FirebaseVisionImageMetadata firebaseVisionImageMetadata =
        FirebaseVisionImageMetadata(
      rawFormat: image.format.raw,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: ImageRotation.rotation0,
      planeData: image.planes
          .map(
            (plane) => FirebaseVisionImagePlaneMetadata(
              bytesPerRow: plane.bytesPerRow,
              height: plane.height,
              width: plane.width,
            ),
          )
          .toList(),
    );
    try {
      var barcode = await _barcodeDetector.detectInImage(
        FirebaseVisionImage.fromBytes(
          _concatenatePlanes(image.planes),
          firebaseVisionImageMetadata,
        ),
      );
      if (barcode != null && barcode.length > 0) {
        print(barcode.toString() + barcode.first.toString());
        return barcode.toString();
      } else {
        print('no barcode');
        return 'no barcode found';
      }
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  void _processCameraImage(CameraImage image) async {
    _savedImage = image;
    await readBarcode(image).then((String result) {
      setState(() {
        print(result);
//data=result;
      });
    });
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    planes.forEach((plane) => allBytes.putUint8List(plane.bytes));
    return allBytes.done().buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    // startBarcodeScanStream();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        ?.listen((barcode) => print(barcode));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Product'),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  MaterialApp(
                    home: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: CameraPreview(_controller),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.deepPurple,
                child: Text(
                  data,
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/