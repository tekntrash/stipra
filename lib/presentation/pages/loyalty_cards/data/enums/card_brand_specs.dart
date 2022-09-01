import 'package:flutter/material.dart';

import '../../../../../shared/app_theme.dart';
import '../../../../widgets/local_image_box.dart';
import 'card_brand_enum.dart';

extension CardBrandSpecs on String? {
  Color get getColorFromIssuer {
    if (this?.toLowerCase() == CardBrands.NECTAR.lowerName) {
      return Colors.purple[900]!;
    } else if (this?.toLowerCase() == CardBrands.STIPRA.lowerName) {
      return AppTheme().darkPrimaryColor;
    } else {
      return Colors.black;
    }
  }

  Widget get getIconFromIssuer {
    late String icon;
    double size = 28;
    if (this?.toLowerCase() == CardBrands.NECTAR.lowerName) {
      icon = 'nectar_logo.png';
      size = 64;
    } else {
      icon = 'wireless.png';
    }
    return Container(
      height: 64,
      child: LocalImageBox(
        width: size,
        height: size,
        imgUrl: icon,
        fit: BoxFit.contain,
      ),
    );
  }
}
