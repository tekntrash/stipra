import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/models/user_model.dart';
import 'package:stipra/presentation/widgets/custom_button.dart';
import 'package:stipra/presentation/widgets/overlay/lock_overlay.dart';

import '../../../../shared/app_theme.dart';
import 'otp_verify_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'widgets/bottom_info_widget.dart';
part 'widgets/confirm_button.dart';
part 'widgets/pincode_text_field.dart';
part 'widgets/title_widget.dart';
part 'widgets/topbar_widget.dart';

class OtpVerifyPage extends StatelessWidget {
  final String? phoneNumber;
  final UserModel userModel;

  OtpVerifyPage({
    this.phoneNumber,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpVerifyViewModel>.reactive(
      viewModelBuilder: () => OtpVerifyViewModel(otp: userModel.otp ?? ''),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppTheme().whiteColor,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TopBarWidget(),
                        TitleWidget(),
                        SizedBox(height: 50.h),
                        Form(
                          key: viewModel.formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0.h, horizontal: 50.w),
                            child: PinCodeWidget(
                              viewModel: viewModel,
                            ),
                          ),
                        ),
                        Expanded(
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
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
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
                                                          color: AppTheme()
                                                              .blackColor,
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
                                                  valueListenable: viewModel
                                                      .waitBeforeResend,
                                                  builder:
                                                      (context, value, child) {
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
                                                                  FontWeight
                                                                      .bold,
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
                                            child: CircularProgressIndicator
                                                .adaptive(
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
                                padding:
                                    EdgeInsets.only(top: 5.h, bottom: 100.h),
                                child: ConfirmButton(
                                  viewModel: viewModel,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 25.h),
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
            ),
          ),
        );
      },
    );
  }
}
