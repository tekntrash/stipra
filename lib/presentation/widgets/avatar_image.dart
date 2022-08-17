import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stipra/data/models/user_model.dart';
import 'package:stipra/shared/app_images.dart';
import 'package:stipra/shared/app_theme.dart';

class AvatarImage extends StatelessWidget {
  final UserModel? user;
  const AvatarImage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nowParam = DateTime.now();
    return ClipOval(
      child: Image.network(
        'https://api.stipra.com/newapp/avatar.php?action=getavatar&alogin=${user?.alogin}&userid=${user?.userid}' +
            '#' +
            '$nowParam',
        key: GlobalKey(),
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return Center(
            child: Container(
              color: AppTheme().greyLight,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return SvgPicture.asset(
            AppImages.avatar.imagePath,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
