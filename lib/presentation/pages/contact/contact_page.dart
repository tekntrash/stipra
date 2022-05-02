import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/contact/contact_viewmodel.dart';

import '../../../data/models/auto_validator_model.dart';
import '../../../shared/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/field_builder_auto.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'widgets/confirm_button.dart';

/// This page shows contact page's ui
/// with 3 text field and a button

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactViewModel>.reactive(
      viewModelBuilder: () => ContactViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: PreferredSize(
            child: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  //color: AppTheme().darkPrimaryColor,
                  gradient: AppTheme().gradientPrimary,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text('Contact'),
              centerTitle: true,
              actions: [],
            ),
            preferredSize: Size.fromHeight(kBottomNavigationBarHeight),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: AppTheme().gradientPrimary,
            ),
            child: Form(
              key: viewModel.formKey,
              child: SafeArea(
                bottom: false,
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      fieldBuilder(
                        validatorModel: viewModel.name,
                        text: 'Name',
                        hintText: 'Enter your name',
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      fieldBuilder(
                        validatorModel: viewModel.email,
                        text: 'Email',
                        hintText: 'Enter your email',
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      fieldBuilder(
                        validatorModel: viewModel.content,
                        text: 'Message',
                        hintText: 'Enter your message',
                        maxLines: null,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      _SendButton(viewModel: viewModel),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget fieldBuilder({
    required AutoValidatorModel validatorModel,
    required String text,
    String? hintText,
    int? maxLines = 1,
  }) {
    return FieldBuilderAuto(
      controller: validatorModel.textController,
      validator: validatorModel.validate,
      text: text,
      hint: hintText ?? text,
      margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
      autovalidateMode: true,
      style: AppTheme().smallParagraphRegularText,
      keyboardType: TextInputType.emailAddress,
      titleStyle: AppTheme().smallParagraphMediumText.copyWith(
            fontSize: AppTheme().paragraphSemiBoldText.fontSize,
          ),
      maxLines: maxLines,
    );
  }
}
