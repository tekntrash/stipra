import 'package:flutter/material.dart';

import '../../../shared/app_images.dart';

class ClassicLoadingOverlay extends StatelessWidget {
  final ValueNotifier<OverlayEntry?> overlayEntry;
  ClassicLoadingOverlay({
    required this.overlayEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      right: 0,
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Center(
              child: buildImage(
                width: 96,
                height: 96,
                imgUrl: AppImages.loading,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage(
      {required double width,
      required double height,
      EdgeInsets margin = EdgeInsets.zero,
      required String imgUrl}) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: Image.asset(
        'assets/images/$imgUrl',
        fit: BoxFit.cover,
      ),
    );
  }
}
