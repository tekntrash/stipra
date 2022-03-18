import 'package:flutter/material.dart';
import 'package:stipra/presentation/widgets/image_box.dart';
import 'package:stipra/shared/app_paths.dart';
import 'package:stipra/shared/app_theme.dart';

class TradingPointOfferCard extends StatelessWidget {
  const TradingPointOfferCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageBox(
            width: 160,
            height: 160,
            url: AppPaths.robloxImg,
            borderRadius: BorderRadius.circular(15),
            fit: BoxFit.cover,
          ),
          Text(
            'Roblox',
            style: AppTheme.paragraphBoldText,
          ),
        ],
      ),
    );
  }
}
