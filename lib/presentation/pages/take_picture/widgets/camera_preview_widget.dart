part of '../take_picture_page.dart';

class _CameraPreviewWidget extends StatelessWidget {
  final CameraController? controller;
  const _CameraPreviewWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller == null || !(controller?.value.isInitialized == true)) {
      return const Text(
        '',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return CameraPreview(controller!);
    }
  }
}