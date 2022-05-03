import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stipra/presentation/widgets/local_image_box.dart';
import 'package:stipra/shared/app_theme.dart';

//* A component for loading images from network with readymade properties.
class ImageBox extends StatelessWidget {
  final double width, height;
  final String url;
  final BorderRadius borderRadius;
  final BoxFit? fit;
  const ImageBox({
    required this.width,
    required this.height,
    required this.url,
    this.borderRadius: BorderRadius.zero,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: width,
        height: height,
        child: Image.network(
          url,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: SvgPicture.asset(
                'assets/images/image_box.svg',
                width: width,
                height: height,
                color: AppTheme().greyScale0,
              ),
            );
          },
        ),
      ),
    );
  }
}
