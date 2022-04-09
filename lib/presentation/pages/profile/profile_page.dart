import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/data/models/user_model.dart';
import 'package:stipra/domain/repositories/local_data_repository.dart';
import 'package:stipra/injection_container.dart';
import 'package:stipra/presentation/pages/profile/profile_viewmodel.dart';
import 'package:stipra/presentation/pages/sign/enter_phone_number_page/enter_phone_number_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/presentation/pages/sign/otp_verify_page/otp_verify_page.dart';
import 'package:stipra/presentation/widgets/classic_text.dart';
import 'package:stipra/presentation/widgets/curved_container.dart';
import 'package:stipra/presentation/widgets/local_image_box.dart';
import 'package:stipra/shared/app_images.dart';
import 'package:stipra/shared/app_theme.dart';

part 'widgets/top_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final isLogged = locator<LocalDataRepository>().getUser().userid != null;
    return isLogged
        ? ViewModelBuilder<ProfileViewModel>.reactive(
            viewModelBuilder: () => ProfileViewModel(),
            onModelReady: (viewModel) => viewModel.init(),
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
                                    child: (!viewModel.isInited)
                                        ? Container(
                                            height: 0.75.sh,
                                            child: Center(
                                              child: Container(
                                                width: 48.w,
                                                height: 48.w,
                                                child: CircularProgressIndicator
                                                    .adaptive(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    AppTheme().darkPrimaryColor,
                                                  ),
                                                  strokeWidth: 3,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: 80.h,
                                              ),
                                              buildButtonTitle('Profile'),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              buildProfileButton(
                                                'Edit Profile',
                                              ),
                                              buildProfileButton(
                                                'Your Email',
                                              ),
                                              buildProfileButton(
                                                'Change Password',
                                                onTap: () {
                                                  viewModel
                                                      .routeToChangePassword(
                                                          context);
                                                },
                                              ),
                                              SizedBox(
                                                height: 30.h,
                                              ),
                                              buildButtonTitle('Support'),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              buildProfileButton(
                                                'Terms and Conditions',
                                              ),
                                              buildProfileButton(
                                                'Privacy Policy',
                                              ),
                                              Container(
                                                height: 40.h,
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
        : EnterPhoneNumberScreen(
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

  Widget buildTopBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.circular(50),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                //
              },
              child: Ink(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/roblox.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                width: 96,
                height: 96,
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

  Widget buildButtonTitle(String title) {
    return Container(
      margin: EdgeInsets.only(left: 20.w),
      width: double.infinity,
      child: Text(
        title,
        style: AppTheme().smallParagraphMediumText,
      ),
    );
  }

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
