import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import '../sign/forgot_password/forgot_password_viewmodel.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/field_builder_auto.dart';

import '../../../../shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'change_email_viewmodel.dart';

part 'widgets/confirm_button.dart';
part 'widgets/topbar_widget.dart';

/// UI for change email page
/// Have button and 2 text field
class ChangeEmailPage extends StatefulWidget {
  final Function()? onLogged;
  ChangeEmailPage({
    Key? key,
    this.onLogged,
  }) : super(key: key);

  @override
  ChangeEmailPageState createState() => ChangeEmailPageState();
}

class ChangeEmailPageState extends State<ChangeEmailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangeEmailViewModel>.reactive(
      viewModelBuilder: () => ChangeEmailViewModel(),
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
                          controller: viewModel.oldEmail.textController,
                          validator: viewModel.oldEmail.validate,
                          text: 'change_email_current_email_title'.tr,
                          hint: 'change_email_current_email_title'.tr,
                          isEnabled: false,
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
                          controller: viewModel.newEmail.textController,
                          validator: viewModel.newEmail.validate,
                          text: 'change_email_new_email_title'.tr,
                          hint: 'change_email_new_email_hint'.tr,
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
