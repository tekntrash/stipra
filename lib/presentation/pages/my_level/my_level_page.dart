import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/my_level/my_level_viewmodel.dart';
import 'package:stipra/presentation/widgets/avatar_image.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../injection_container.dart';
import '../sign/enter_phone_number_page/enter_phone_number_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../sign/otp_verify_page/otp_verify_page.dart';
import '../take_picture/take_picture_page.dart';
import '../../widgets/classic_text.dart';
import '../../widgets/curved_container.dart';
import '../../widgets/local_image_box.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_theme.dart';
import 'package:dartz/dartz.dart' as dartz;

/// Profile Page UI
/// and buttons for profile page UI
/// It is using ViewModelBuilder to handle the state of the page with MyLevelViewModel

class MyLevelPage extends StatefulWidget {
  const MyLevelPage({Key? key}) : super(key: key);

  @override
  State<MyLevelPage> createState() => _MyLevelPageState();
}

class _MyLevelPageState extends State<MyLevelPage> {
  /// Building MyLevelPage ui but it depends on user state
  /// if user is logged in or not
  /// If logged in it will show the profile page ui
  /// If not it will show the sign in page ui
  @override
  Widget build(BuildContext context) {
    final isLogged = locator<LocalDataRepository>().getUser().userid != null;
    final user = locator<LocalDataRepository>().getUser();
    return isLogged
        ? ViewModelBuilder<MyLevelViewModel>.reactive(
            viewModelBuilder: () => MyLevelViewModel(),
            builder: (context, viewModel, child) {
              return Scaffold(
                appBar: PreferredSize(
                  child: AppBar(
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        color: AppTheme().darkPrimaryColor,
                        //gradient: AppTheme().gradientPrimary,
                      ),
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    title: Text('my_level_title'.tr),
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
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 50.h,
                                ),
                                CurvedContainer(
                                  radius: 30,
                                  child: Container(
                                    color: AppTheme().whiteColor,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 80.h,
                                        ),
                                        buildLevelProgress(
                                          currentPoints: user.points,
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Text('my_level_other_levels'.tr,
                                            style: AppTheme()
                                                .smallParagraphSemiBoldText),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        buildLevels(user.points),
                                        Container(
                                          height: 150.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            buildTopBar(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        :

        /// If user is not logged show login page to provide log in or register
        EnterPhoneNumberScreen(
            hideBackButton: true,
            isSignIn: true,
            onLogged: () {
              setState(() {});
            },
            onVerified: () {
              setState(() {});
            },
          );
  }

  Widget getCurrentLevelImage(int points) {
    var imageUrl = '';
    if (points <= 19999) {
      imageUrl = 'grasshopper.jpeg';
    } else if (points <= 59999) {
      imageUrl = 'frog.jpeg';
    } else if (points <= 99999) {
      imageUrl = 'snake.jpeg';
    } else if (points >= 100000) {
      imageUrl = 'eagle.jpeg';
    }
    return LocalImageBox(
      width: 64,
      height: 64,
      imgUrl: '$imageUrl',
      fit: BoxFit.scaleDown,
    );
  }

  String getLevelImageString(int points) {
    var imageUrl = '';
    if (points <= 19999) {
      imageUrl = 'grasshopper.jpeg';
    } else if (points <= 59999) {
      imageUrl = 'frog.jpeg';
    } else if (points <= 99999) {
      imageUrl = 'snake.jpeg';
    } else if (points >= 100000) {
      imageUrl = 'eagle.jpeg';
    }
    return imageUrl;
  }

  Widget getNextLevelImage(int points) {
    var imageUrl = '';
    if (points <= 19999) {
      imageUrl = 'frog.jpeg';
    } else if (points <= 59999) {
      imageUrl = 'snake.jpeg';
    } else if (points <= 99999) {
      imageUrl = 'eagle.jpeg';
    } else if (points >= 100000) {
      imageUrl = 'eagle.jpeg';
    }
    return LocalImageBox(
      width: 64,
      height: 64,
      imgUrl: '$imageUrl',
      fit: BoxFit.scaleDown,
    );
  }

  int getLevelAsInt(int points) {
    if (points < 20000) {
      return 1;
    } else if (points < 59999) {
      return 2;
    } else if (points < 99999) {
      return 3;
    } else {
      if (points >= 100000) {
        return 4;
      }
    }
    return 1;
  }

  int minPointOfLevel(int level) {
    if (level == 1) {
      return 0;
    } else if (level == 2) {
      return 20000;
    } else if (level == 3) {
      return 60000;
    } else if (level == 4) {
      return 100000;
    }
    return 0;
  }

  int maxPointOfLevel(int level) {
    if (level == 1) {
      return 20000;
    } else if (level == 2) {
      return 60000;
    } else if (level == 3) {
      return 100000;
    } else if (level == 4) {
      return 100000;
    }
    return 20000;
  }

  Widget buildLevels(String? points) {
    List<Widget> children = [];
    final point = int.parse(points ?? '0');
    final currentLevel = getLevelAsInt(point);
    if (currentLevel <= 1) {
      final point = 20000;
      children.add(
        buildLevel(
          imageUrl: getLevelImageString(point),
          text: getLevelName(point.toString()),
          points: '$point',
          currentPoints: points,
          isLocked: true,
        ),
      );
    }
    if (currentLevel <= 2) {
      final point = 60000;
      children.add(
        buildLevel(
          imageUrl: getLevelImageString(point),
          text: getLevelName(point.toString()),
          points: '$point',
          currentPoints: points,
          isLocked: true,
        ),
      );
    }
    if (currentLevel <= 3) {
      final point = 100000;
      children.add(
        buildLevel(
          imageUrl: getLevelImageString(point),
          text: getLevelName(point.toString()),
          points: '$point',
          currentPoints: points,
          isLocked: true,
        ),
      );
    }
    return Column(
      children: children,
    );
  }

  Widget buildLevel({
    required String imageUrl,
    required String text,
    required String points,
    required String? currentPoints,
    required bool isLocked,
  }) {
    final maxPoint =
        (maxPointOfLevel(getLevelAsInt(int.parse(points)) - 1)).toInt();
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          /*AppNavigator.push(
            context: context,
            child: MyLevelPage(),
          );*/
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
          'my_level_progression_subtitle_text'.trParams(
            {
              'points': '${maxPoint - int.parse(currentPoints ?? '0')}',
            },
          ),
          //'You have to collect ${maxPoint - int.parse(currentPoints ?? '0')} points to reach this level',
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

  Widget buildLevelProgress({
    required String? currentPoints,
  }) {
    log('${int.parse(currentPoints ?? '0').toDouble()}');
    log('${(minPointOfLevel(getLevelAsInt(int.parse(currentPoints ?? '0')))).toDouble()}');
    log('${(maxPointOfLevel(getLevelAsInt(int.parse(currentPoints ?? '0')))).toDouble()}');
    final maxPoint =
        (maxPointOfLevel(getLevelAsInt(int.parse(currentPoints ?? '0'))))
            .toDouble();
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: getCurrentLevelImage(int.parse(currentPoints ?? '0')),
            ),
            Expanded(
              child: Slider(
                value: int.parse(currentPoints ?? '0').toDouble(),
                min: (minPointOfLevel(
                        getLevelAsInt(int.parse(currentPoints ?? '0'))))
                    .toDouble(),
                max: (maxPointOfLevel(
                        getLevelAsInt(int.parse(currentPoints ?? '0'))))
                    .toDouble(),
                onChanged: (_) {},
                activeColor: AppTheme().primaryColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: getNextLevelImage(int.parse(currentPoints ?? '0')),
            ),
          ],
        ),
        Text(
          'my_level_my_points'.trParams(
            {
              'points': '${int.parse(currentPoints ?? '0')}',
            },
          ),
          //'${int.parse(currentPoints ?? '0')} Points',
          style: AppTheme().smallParagraphRegularText,
        ),
        Text(
          'my_level_next_level_points_description'.trParams(
            {
              'points': '${maxPoint - int.parse(currentPoints ?? '0')}',
              'levelName': '${getLevelName('${maxPoint.toInt()}')}'
            },
          ),
          //'You need ${(maxPoint - int.parse(currentPoints ?? '0')).toInt()} Points to become ${getLevelName('${maxPoint.toInt()}')}',
          style: AppTheme().extraSmallParagraphRegularText,
        ),
      ],
    );
  }

  String getLevelName(String? points) {
    var level = '';
    if (points == null)
      level = 'my_level_level_name_grasshopper'.tr;
    else if (int.parse(points) < 20000)
      level = 'my_level_level_name_grasshopper'.tr;
    else if (int.parse(points) < 59999)
      level = 'my_level_level_name_frog'.tr;
    else if (int.parse(points) < 99999)
      level = 'my_level_level_name_snake'.tr;
    else if (int.parse(points) >= 100000) return 'my_level_level_name_eagle'.tr;
    return level;
  }

  /// Build user avatar photo and the name
  /// When click on the avatar photo, it will route to the TakePicturePage
  /// when select or capture a photo it is sending to backend
  /// after it is changing avatar from profile page with animation
  File? selectedImage;
  bool uploading = false;
  Widget buildTopBar() {
    final user = locator<LocalDataRepository>().getUser();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.circular(50),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () async {
                ///Route to take picture page and get the image then send it to backend
                final result = await AppNavigator.push(
                  context: context,
                  child: TakePicturePage(),
                );
                if (result != null) {
                  uploading = true;
                  setState(() {});
                  final uploadResult = await locator<DataRepository>()
                      .changeProfilePicture(result.path);
                  log('Result of upload: $uploadResult');
                  if (uploadResult is dartz.Right) {
                    selectedImage = result;
                    //locator<LocalDataRepository>().getUser().image = result;
                    //await locator<LocalDataRepository>().getUser().save();
                  }
                  uploading = false;
                  setState(() {});
                  log('File found lets change avatar!');
                } else {
                  //do nothing
                }
              },
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: uploading
                    ? Ink(
                        key: GlobalKey(),
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme().greyScale5,
                        ),
                        child: Center(
                          child: Container(
                            width: 48,
                            height: 48,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme().darkPrimaryColor,
                              ),
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                      )
                    : Ink(
                        child: AvatarImage(user: user),
                        width: 96,
                        height: 96,
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          ClassicText(
            text: getLevelName(locator<LocalDataRepository>().getUser().points),
            style: AppTheme().smallParagraphSemiBoldText,
          ),
        ],
      ),
    );
  }

  /// Builds a button with a title and an onTap callback
  /// Using for buttons as a general structure
  Widget buildProfileButton(String buttonName, {Function()? onTap}) {
    return Container(
      margin: EdgeInsets.only(left: 20.w),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme().greyScale2,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  buttonName,
                  style: AppTheme().smallParagraphRegularText,
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.w),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: AppTheme().greyScale2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
