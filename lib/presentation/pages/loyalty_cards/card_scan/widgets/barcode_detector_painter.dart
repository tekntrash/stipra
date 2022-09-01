import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/barcode_scanner.dart';
import 'package:google_mlkit_commons/commons.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'coordinates_translator.dart';

/// This component was using for test barcodes it is trying to show barcodes inside a rectangle on camera UI
/// Currently not using.

class BarcodeDetectorPainter extends CustomPainter {
  BarcodeDetectorPainter(
      this.textBlocks, this.absoluteImageSize, this.rotation);

  final List<TextBlock> textBlocks;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint background = Paint()..color = Color(0x99000000);

    for (final TextBlock textBlock in textBlocks) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(
          ui.TextStyle(color: Colors.lightGreenAccent, background: background));
      builder.addText('${textBlock.text}');
      builder.pop();

      final left = translateX(
          textBlock.boundingBox.left, rotation, size, absoluteImageSize);
      final top = translateY(
          textBlock.boundingBox.top, rotation, size, absoluteImageSize);
      final right = translateX(
          textBlock.boundingBox.right, rotation, size, absoluteImageSize);
      final bottom = translateY(
          textBlock.boundingBox.bottom, rotation, size, absoluteImageSize);

      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
            width: right - left,
          )),
        Offset(left, top),
      );

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.textBlocks != textBlocks;
  }
}
