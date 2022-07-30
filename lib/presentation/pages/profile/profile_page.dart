import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/widgets/avatar_image.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../injection_container.dart';
import 'profile_viewmodel.dart';
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

part 'widgets/top_bar.dart';

/// Profile Page UI
/// and buttons for profile page UI
/// It is using ViewModelBuilder to handle the state of the page with ProfileViewModel

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /// Building ProfilePage ui but it depends on user state
  /// if user is logged in or not
  /// If logged in it will show the profile page ui
  /// If not it will show the sign in page ui
  @override
  Widget build(BuildContext context) {
    final isLogged = locator<LocalDataRepository>().getUser().userid != null;
    return isLogged
        ? ViewModelBuilder<ProfileViewModel>.reactive(
            viewModelBuilder: () => ProfileViewModel(),
            builder: (context, viewModel, child) {
              return Scaffold(
                appBar: PreferredSize(
                  child: _buildTopBar(context),
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
                                        buildProfileButton(
                                          'profile_page_my_profile_button_text'
                                              .tr,
                                          onTap: () {
                                            viewModel.routeToMyProfile(context);
                                          },
                                        ),
                                        buildProfileButton(
                                          'profile_page_privacy_button_text'.tr,
                                          onTap: () {
                                            viewModel.routeToPrivacy(context);
                                          },
                                        ),
                                        buildProfileButton(
                                          'profile_page_my_earnings_button_text'
                                              .tr,
                                          onTap: () {
                                            viewModel.routeToProductsConsumed(
                                                context);
                                          },
                                        ),
                                        buildProfileButton(
                                          'profile_page_my_level_button_text'
                                              .tr,
                                          onTap: () {
                                            viewModel.routeToLevelPage(context);
                                          },
                                        ),
                                        buildProfileButton(
                                          'profile_page_my_redeems_button_text'
                                              .tr,
                                          onTap: () {
                                            viewModel.routeToMyTrades(context);
                                          },
                                        ),
                                        buildProfileButton(
                                          'profile_page_videos_waiting_button_text'
                                              .tr,
                                          onTap: () {
                                            viewModel
                                                .routeToVideosWaiting(context);
                                          },
                                        ),
                                        /*buildProfileButton(
                                          'Configuration',
                                          onTap: () {},
                                        ),*/
                                        buildProfileButton(
                                          'profile_page_logout_button_text'.tr,
                                          onTap: () {
                                            viewModel.logout(context);
                                            setState(() {});
                                          },
                                        ),
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
            text: locator<LocalDataRepository>().getUser().name ?? '',
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
