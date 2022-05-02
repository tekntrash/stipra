part of '../take_picture_page.dart';

/// Camera flip button component for take_picture_page
/// It is calling [flipCamera] from parameter
/// and that function is coming from TakePictureViewModel.dart via TakePicturePage.dart

class _CameraFlipButton extends StatelessWidget {
  final Function() flipCamera;
  const _CameraFlipButton({
    Key? key,
    required this.flipCamera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: flipCamera,
      child: Container(
        height: 80,
        width: 80,
        child: Icon(
          Icons.flip_camera_ios,
          color: Colors.white,
        ),
      ),
    );
  }
}
