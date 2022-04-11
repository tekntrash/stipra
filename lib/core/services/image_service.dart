import 'dart:io';

import 'dart:typed_data';

import 'package:path/path.dart' as path;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:stipra/core/services/path_service.dart';
import 'package:stipra/core/utils/time_converter/time_converter.dart';

class ImageService {
  static Future<File> fixExifRotation(File image,
      {deleteOriginal: false}) async {
    List<int> imageBytes = await image.readAsBytes();

    List<int> result = await FlutterImageCompress.compressWithList(
      Uint8List.fromList(imageBytes),
      quality: 80,
      rotate: 0,
    );

    final String processedImageUuid = timestamp();
    String imageExtension = path.basename(image.path);

    final tempPath = await PathService.getTempPath();

    File fixedImage = File('$tempPath/$processedImageUuid$imageExtension');

    await fixedImage.writeAsBytes(result);

    if (deleteOriginal) await image.delete();

    return fixedImage;
  }
}
