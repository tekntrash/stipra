import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';
import '../../../../domain/repositories/data_repository.dart';
import '../../../../injection_container.dart';
import '../../../widgets/classic_text.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/overlay/lock_overlay.dart';
import '../../../widgets/square_checkbox.dart';

import '../../../../data/provider/data_provider.dart';
import '../../../../domain/repositories/local_data_repository.dart';
import '../../../../shared/app_theme.dart';
import '../../../widgets/field_builder_auto.dart';
import '../phone_number_input_field.dart';
import 'enter_phone_number_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'widgets/phone_number_field.dart';
part 'widgets/topbar_widget.dart';
part 'widgets/verify_number_button.dart';
part 'widgets/keep_signed_button.dart';

class EnterPhoneNumberScreen extends StatefulWidget {
  final bool isSignIn;
  final Function()? onLogged, onVerified;
  final bool hideBackButton;
  EnterPhoneNumberScreen({
    Key? key,
    this.isSignIn = false,
    this.onLogged,
    this.onVerified,
    this.hideBackButton: false,
  }) : super(key: key);

  @override
  _EnterPhoneNumberScreenState createState() => _EnterPhoneNumberScreenState();
}

class _EnterPhoneNumberScreenState extends State<EnterPhoneNumberScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EnterPhoneNumberViewModel>.reactive(
      viewModelBuilder: () => EnterPhoneNumberViewModel(
        isSignIn: widget.isSignIn,
        onLogged: widget.onLogged,
        onVerified: widget.onVerified,
      ),
      onModelReady: (model) => model.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppTheme().whiteColor,
          body: SafeArea(
            child: Form(
              key: viewModel.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        TopBarWidget(
                            isSignIn: viewModel.isSignIn,
                            hideBackButton: widget.hideBackButton),
                        if (viewModel.isSignIn != true)
                          FieldBuilderAuto(
                            key: GlobalKey(),
                            controller: viewModel.name.textController,
                            validator: viewModel.name.validate,
                            text: 'Name',
                            hint: 'Your name',
                            margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                            autovalidateMode: true,
                            style: AppTheme().smallParagraphRegularText,
                            keyboardType: TextInputType.name,
                            titleStyle: AppTheme()
                                .smallParagraphMediumText
                                .copyWith(
                                  fontSize:
                                      AppTheme().paragraphSemiBoldText.fontSize,
                                ),
                          ),
                        if (viewModel.isSignIn != true)
                          SizedBox(
                            height: 15.h,
                          ),
                        FieldBuilderAuto(
                          controller: viewModel.email.textController,
                          validator: viewModel.email.validate,
                          text: 'Email Address',
                          hint: 'Email address',
                          margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                          autovalidateMode: true,
                          style: AppTheme().smallParagraphRegularText,
                          keyboardType: TextInputType.emailAddress,
                          titleStyle: AppTheme()
                              .smallParagraphMediumText
                              .copyWith(
                                fontSize:
                                    AppTheme().paragraphSemiBoldText.fontSize,
                              ),
                        ),
                        SizedBox(height: 15.h),
                        FieldBuilderAuto(
                          controller: viewModel.password.textController,
                          validator: viewModel.password.validate,
                          obscureVisibility: true,
                          text: 'Password',
                          hint: 'Your password',
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
                            style: AppTheme().extraSmallParagraphRegularText,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        if (viewModel.isSignIn != true)
                          PhoneNumberField(
                            viewModel: viewModel,
                          ),
                        if (viewModel.isSignIn != true)
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                            child: Text(
                              '* You will receive a confirmation code.',
                              style: AppTheme().smallParagraphRegularText,
                            ),
                          ),
                        if (viewModel.isSignIn != true)
                          SizedBox(
                            height: 15.h,
                          ),
                        KeepSignedButton(onTap: () {
                          setState(() {});
                        }),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: VerifyNumberButton(
                            viewModel: viewModel,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            viewModel.changeSignPage();
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(bottom: 10.h, top: 15.h),
                            alignment: Alignment.bottomCenter,
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: viewModel.isSignIn
                                      ? 'Don\' have an account? '
                                      : 'Already have an account? ',
                                  style: AppTheme()
                                      .smallParagraphMediumText
                                      .copyWith(color: Colors.black),
                                ),
                                TextSpan(
                                  text: viewModel.isSignIn
                                      ? 'Create one'
                                      : 'Sign in',
                                  style: AppTheme()
                                      .smallParagraphMediumText
                                      .copyWith(
                                        color: AppTheme().primaryColor,
                                      ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            viewModel.onForgotPassword(context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            margin: EdgeInsets.only(top: 0.h),
                            padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
                            alignment: Alignment.bottomCenter,
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Forgot password? ',
                                  style: AppTheme()
                                      .smallParagraphMediumText
                                      .copyWith(color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Reset it now',
                                  style: AppTheme()
                                      .smallParagraphMediumText
                                      .copyWith(
                                        color: AppTheme().primaryColor,
                                      ),
                                ),
                              ]),
                            ),
                          ),
                        )
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
}
