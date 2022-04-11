part of '../take_picture_page.dart';

class _PickFromGalleryButton extends StatelessWidget {
  const _PickFromGalleryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          var pickedMedia = await ImagePicker().pickImage(
            source: ImageSource.gallery,
          );

          Navigator.pop(context, File(pickedMedia!.path));
        } catch (error) {}
      },
      child: Container(
        height: 80,
        width: 80,
        child: Icon(
          Icons.perm_media_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
