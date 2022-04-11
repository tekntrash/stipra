part of '../take_picture_page.dart';

class _FlashButton extends StatelessWidget {
  final FlashMode flashMode;
  final Function() changeFlashMode;
  const _FlashButton({
    Key? key,
    required this.flashMode,
    required this.changeFlashMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData = Icons.flash_off;
    Color color = Colors.white;
    if (flashMode == FlashMode.always) {
      iconData = Icons.flash_on;
      color = Colors.white;
    } else if (flashMode == FlashMode.auto) {
      iconData = Icons.flash_auto;
      color = Colors.white;
    }
    return Container(
      height: 80,
      width: 80,
      child: IconButton(
        icon: Icon(iconData),
        color: color,
        onPressed: changeFlashMode,
      ),
    );
  }
}
