part of '../barcode_scan_page.dart';

class BottomBox extends StatelessWidget {
  final bool? isStarted;
  final bool? isStopped;
  final Function(BuildContext context, {bool pop}) stopCapture;
  final Function() startCapture;
  final CameraController? cameraController;

  const BottomBox({
    Key? key,
    required this.startCapture,
    required this.stopCapture,
    required this.cameraController,
    required this.isStarted,
    required this.isStopped,
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
                  icon: Icon((isStarted == true)
                      ? Icons.stop
                      : Icons.play_arrow_rounded),
                  iconSize: 32.0,
                  onPressed: () async {
                    if (isStarted == false) {
                      await startCapture();
                    } else if (isStarted == true) {
                      await stopCapture(context);
                    }
                  },
                ),
                Text(
                  (isStarted == true)
                      ? 'Stop Record'
                      : (isStarted == false)
                          ? 'Start Record'
                          : 'Record Starting',
                  style: AppTheme().extraSmallParagraphSemiBoldText.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
          if (cameraController != null && isStopped != true)
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
                          ? FlashMode.always
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
