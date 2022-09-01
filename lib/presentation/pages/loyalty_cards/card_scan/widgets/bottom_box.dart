part of '../card_scan_page.dart';

/// Showing buttons on bottom of Barcode Scan Page

class BottomBox extends StatelessWidget {
  final Function(BuildContext context, {bool pop}) stopCapture;
  final Function() startCapture;
  final CameraController? cameraController;

  const BottomBox({
    Key? key,
    required this.startCapture,
    required this.stopCapture,
    required this.cameraController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 15,
      right: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          wrapWithShadowContainer(
            child: Column(
              children: [
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.close_rounded),
                  iconSize: 32.0,
                  onPressed: () async {
                    await stopCapture(context, pop: true);
                  },
                ),
                Text(
                  'Exit',
                  style: AppTheme().extraSmallParagraphSemiBoldText.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
          wrapWithShadowContainer(
            child: Column(
              children: [
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.done),
                  iconSize: 32.0,
                  onPressed: () async {
                    await stopCapture(context);
                  },
                ),
                Text(
                  'Save',
                  style: AppTheme().extraSmallParagraphSemiBoldText.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
          if (cameraController != null)
            wrapWithShadowContainer(
              child: Column(
                children: [
                  IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder<dynamic>(
                      valueListenable: cameraController ?? ValueNotifier(null),
                      builder: (context, state, child) {
                        switch (state.flashMode) {
                          case FlashMode.off:
                            return const Icon(Icons.flash_off,
                                color: Colors.grey);
                          case FlashMode.always:
                            return const Icon(Icons.flash_on,
                                color: Colors.yellow);
                          case FlashMode.auto:
                            return const Icon(Icons.flash_auto,
                                color: Colors.yellow);
                          case FlashMode.torch:
                            return const Icon(Icons.flash_on,
                                color: Colors.yellow);
                          default:
                            return const Icon(Icons.flash_off,
                                color: Colors.grey);
                        }
                      },
                    ),
                    iconSize: 32.0,
                    onPressed: () => cameraController?.setFlashMode(
                      cameraController?.value.flashMode == FlashMode.off
                          ? FlashMode.torch
                          : FlashMode.off,
                    ),
                  ),
                  Text(
                    'Light',
                    style: AppTheme().extraSmallParagraphSemiBoldText.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget wrapWithShadowContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppTheme().greyScale0,
            blurRadius: 75,
          ),
        ],
      ),
      child: child,
    );
  }
}
