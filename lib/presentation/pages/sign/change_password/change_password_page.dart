import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import '../forgot_password/forgot_password_viewmodel.dart';
import '../../../widgets/custom_button.dart';

import '../../../../shared/app_theme.dart';
import '../../../widgets/field_builder_auto.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'change_password_viewmodel.dart';

part 'widgets/confirm_button.dart';
part 'widgets/topbar_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  bool isSignIn;
  final Function()? onLogged;
  ChangePasswordPage({
    Key? key,
    this.isSignIn = false,
    this.onLogged,
  }) : super(key: key);

  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
      viewModelBuilder: () => ChangePasswordViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppTheme().whiteColor,
          body: SafeArea(
            child: Form(
              key: viewModel.formKey,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        TopBarWidget(),
                        SizedBox(
                          height: 20.h,
                        ),
                        FieldBuilderAuto(
                          controller: viewModel.oldPassword.textController,
                          validator: viewModel.oldPassword.validate,
                          text: 'Old Password',
                          hint: 'Old Password',
                          obscureVisibility: true,
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
                        SizedBox(
                          height: 20.h,
                        ),
                        FieldBuilderAuto(
                          controller: viewModel.newPassword.textController,
                          validator: viewModel.newPassword.validate,
                          obscureVisibility: true,
                          text: 'New Password',
                          hint: 'New Password',
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
                        SizedBox(
                          height: 20.h,
                        ),
                        ConfirmButton(viewModel: viewModel),
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
                      children: [],
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
