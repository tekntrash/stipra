import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../injection_container.dart';
import 'info_viewmodel.dart';
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

/// Shows the info page UI
/// and buttons for info page UI

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InfoViewModel>.reactive(
      viewModelBuilder: () => InfoViewModel(),
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
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 40.h,
                    ),
                  ),
                  SliverFillRemaining(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: CurvedContainer(
                                radius: 30,
                                child: Container(
                                  color: AppTheme().whiteColor,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      buildButtonTitle('Info'),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      buildProfileButton(
                                        'What is Stipra',
                                        onTap: () {
                                          viewModel
                                              .routeToWhatIsStipra(context);
                                        },
                                      ),
                                      buildProfileButton(
                                        'How to make a Video',
                                        onTap: () {
                                          viewModel
                                              .routeToHowToMakeVideo(context);
                                        },
                                      ),
                                      buildProfileButton(
                                        'Contact',
                                        onTap: () {
                                          viewModel.routeToContact(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
