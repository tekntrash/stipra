part of '../take_picture_page.dart';

/// A button component for capture image from camera
/// It is calling [onCapture] from parameter
/// and that function is coming from TakePictureViewModel.dart via TakePicturePage.dart

class _CaptureButton extends StatelessWidget {
  final Function(BuildContext context) onCapture;
  const _CaptureButton({
    Key? key,
    required this.onCapture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCapture(context);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              border: Border.all(
                width: 3,
                color: Colors.white,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
