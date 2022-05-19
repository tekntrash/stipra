import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/delete_account/delete_account_viewmodel.dart';
import 'package:stipra/presentation/widgets/custom_button.dart';
import 'package:stipra/presentation/widgets/field_builder_auto.dart';

import '../../../../shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'widgets/confirm_button.dart';
part 'widgets/topbar_widget.dart';

class DeleteAccountPage extends StatefulWidget {
  bool isSignIn;
  final Function()? onLogged;
  DeleteAccountPage({
    Key? key,
    this.isSignIn = false,
    this.onLogged,
  }) : super(key: key);

  @override
  DeleteAccountPageState createState() => DeleteAccountPageState();
}

class DeleteAccountPageState extends State<DeleteAccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeleteAccountViewModel>.reactive(
      viewModelBuilder: () => DeleteAccountViewModel(),
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
                        _TopBarWidget(),
                        SizedBox(
                          height: 20.h,
                        ),
                        FieldBuilderAuto(
                          controller: viewModel.oldPassword.textController,
                          validator: viewModel.oldPassword.validate,
                          text: 'Current Password',
                          hint: 'Password',
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
                        SizedBox(
                          height: 20.h,
                        ),
                        _ConfirmButton(viewModel: viewModel),
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
