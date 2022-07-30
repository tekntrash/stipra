import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/presentation/pages/my_level/my_level_page.dart';
import 'package:stipra/shared/app_theme.dart';

import '../../../../domain/repositories/local_data_repository.dart';
import '../../../../injection_container.dart';
import '../../../widgets/local_image_box.dart';

/// What is Stipra UI for Info page
/// Includes texts and images

class PointsAndLevels extends StatefulWidget {
  const PointsAndLevels({Key? key}) : super(key: key);

  @override
  State<PointsAndLevels> createState() => _PointsAndLevelsState();
}

class _PointsAndLevelsState extends State<PointsAndLevels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              //color: AppTheme().darkPrimaryColor,
              gradient: AppTheme().gradientPrimary,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('points_and_levels_title'.tr),
          centerTitle: true,
          actions: [],
        ),
        preferredSize: Size.fromHeight(kBottomNavigationBarHeight),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme().gradientPrimary,
        ),
        child: SafeArea(
          bottom: false,
          child: Container(
            color: Colors.white,
            child: ListView(
              children: [
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Text(
                    'points_and_levels_text'.tr,
                    style: AppTheme().smallParagraphRegularText,
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(
                    top: 0,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    'points_and_levels_sub_text'.tr,
                    style: AppTheme().smallParagraphRegularText,
                  ),
                ),
                buildLevel(
                  points: '0',
                  imageUrl: 'grasshopper.jpeg',
                  text: 'my_level_level_name_grasshopper'.tr,
                ),
                buildLevel(
                  points: '20.000',
                  imageUrl: 'frog.jpeg',
                  text: 'my_level_level_name_frog'.tr,
                ),
                buildLevel(
                  points: '60.000',
                  imageUrl: 'snake.jpeg',
                  text: 'my_level_level_name_snake'.tr,
                ),
                buildLevel(
                  points: '100.000',
                  imageUrl: 'eagle.jpeg',
                  text: 'my_level_level_name_eagle'.tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLevel({
    required String imageUrl,
    required String text,
    required String points,
  }) {
    bool isLocked = false;
    final user = locator<LocalDataRepository>().getUser();
    if (user.alogin == null) {
      isLocked = true;
    } else {
      if (int.parse(user.points ?? '0') <
          int.parse(points.replaceAll('.', ''))) {
        isLocked = true;
      }
    }
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          AppNavigator.push(
            context: context,
            child: MyLevelPage(),
          );
        },
        leading: LocalImageBox(
          width: 64,
          height: 64,
          imgUrl: '$imageUrl',
          fit: BoxFit.scaleDown,
        ),
        title: Text(
          '$text',
          style: AppTheme().smallParagraphRegularText,
        ),
        subtitle: Text(
          'points_and_levels_collected'.trParams({
            'points': points,
          }),
          style: AppTheme().extraSmallParagraphRegularText,
        ),
        trailing: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppTheme().greyScale5,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(
              isLocked ? Icons.lock : Icons.lock_open,
              color: AppTheme().greyScale2,
            ),
          ),
        ),
      ),
    );
  }
}
