import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/sign/forgot_password/forgot_password_viewmodel.dart';
import 'package:stipra/presentation/widgets/custom_button.dart';

import '../../../../shared/app_theme.dart';
import '../../../widgets/field_builder_auto.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'widgets/confirm_button.dart';
part 'widgets/topbar_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  bool isSignIn;
  final Function()? onLogged;
  ForgotPasswordPage({
    Key? key,
    this.isSignIn = false,
    this.onLogged,
  }) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
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
