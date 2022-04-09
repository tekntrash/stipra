import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/models/user_model.dart';
import 'package:stipra/presentation/pages/sign/otp_verify_page/forgot_password_otp_viewmodel.dart';
import 'package:stipra/presentation/widgets/custom_button.dart';
import 'package:stipra/presentation/widgets/field_builder_auto.dart';
import 'package:stipra/presentation/widgets/overlay/lock_overlay.dart';

import '../../../../shared/app_theme.dart';
import 'otp_verify_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'otp_verify_page.dart';

class ForgotPasswordOtpPage extends StatelessWidget {
  final String otp;
  final String emailAddress;
  ForgotPasswordOtpPage({
    required this.otp,
    required this.emailAddress,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordOtpViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordOtpViewModel(
        otp: otp,
        emailAddress: emailAddress,
      ),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppTheme().whiteColor,
          body: Form(
            key: viewModel.formKey,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {},
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TopBarWidget(),
                          TitleWidget(),
                          SizedBox(height: 50.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0.h, horizontal: 50.w),
                            child: PinCodeWidget(
                              viewModel: viewModel,
                            ),
                          ),
                          FieldBuilderAuto(
                            controller: viewModel.password.textController,
                            validator: viewModel.password.validate,
                            obscureVisibility: true,
                            text: 'New Password',
                            hint: 'Type a new password',
                            margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                            autovalidateMode: true,
                            style: AppTheme().smallParagraphRegularText,
                            titleStyle: AppTheme()
                                .smallParagraphMediumText
                                .copyWith(
                                  fontSize:
                                      AppTheme().paragraphSemiBoldText.fontSize,
                                ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                            child: Text(
                              '* Password must contain 1 uppercase, 1 lowercase and 1 number.',
                              style: AppTheme().smallParagraphRegularText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(),
                          InkWell(
                            onTap: () {
                              viewModel.resendOtp();
                            },
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              child: (viewModel.resendingOtp != true)
                                  ? Ink(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 13.h),
                                      child: (viewModel
                                                  .waitBeforeResend.value <=
                                              0)
                                          ? RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'Didn\'t receive the code? ',
                                                    style: TextStyle(
                                                      color:
                                                          AppTheme().blackColor,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'RESEND',
                                                    style: TextStyle(
                                                      color: AppTheme()
                                                          .primaryColor,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : ValueListenableBuilder(
                                              valueListenable:
                                                  viewModel.waitBeforeResend,
                                              builder: (context, value, child) {
                                                return RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            'Please wait before resending the code ',
                                                        style: TextStyle(
                                                          color: AppTheme()
                                                              .blackColor,
                                                          fontSize: 16.sp,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            '${viewModel.waitBeforeResend.value}',
                                                        style: TextStyle(
                                                          color: AppTheme()
                                                              .primaryColor,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 5.h),
                                      child: Center(
                                        child:
                                            CircularProgressIndicator.adaptive(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            AppTheme().primaryColor,
                                          ),
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.h, bottom: 60.h),
                            child: ConfirmButton(
                              viewModel: viewModel,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            alignment: Alignment.bottomCenter,
                            child: Text('Stipra all rights reserved'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 30.h, 10.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                'Recover your password',
                style: AppTheme().paragraphRegularText.copyWith(
                      fontSize: 27,
                      color: Colors.black,
                    ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  'Enter the four-digit code that was sent to the email you provided.',
                  style: AppTheme().paragraphRegularText.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
