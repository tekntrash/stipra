import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/widgets/classic_text.dart';
import 'package:stipra/presentation/widgets/custom_button.dart';
import 'package:stipra/presentation/widgets/square_checkbox.dart';

import '../../../../shared/app_theme.dart';
import '../../../widgets/field_builder_auto.dart';
import '../phone_number_input_field.dart';
import 'enter_phone_number_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'widgets/phone_number_field.dart';
part 'widgets/topbar_widget.dart';
part 'widgets/verify_number_button.dart';

class EnterPhoneNumberScreen extends StatefulWidget {
  final bool? isSignIn;
  EnterPhoneNumberScreen({
    Key? key,
    this.isSignIn,
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
      viewModelBuilder: () =>
          EnterPhoneNumberViewModel(isSignIn: widget.isSignIn),
      onModelReady: (model) => model.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppTheme.whiteColor,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TopBarWidget(isSignIn: widget.isSignIn),
                        SizedBox(height: 30.h),
                        /*if (widget.isSignIn != true)
                          FieldBuilderAuto(
                            controller: viewModel.taxId.textController,
                            validator: viewModel.taxId.validate,
                            text: 'Tax ID Number (NINEA):',
                            hint: 'Tax ID',
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            autovalidateMode: true,
                            style: AppTheme.paragraphBoldText,
                          ),*/
                        SizedBox(
                          height: 20.h,
                        ),
                        PhoneNumberField(
                          viewModel: viewModel,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            /*HiveService().getLocalInfo().keepSigned =
                                !HiveService().getLocalInfo().keepSigned;
                            await HiveService().getLocalInfo().save();*/
                            setState(() {});
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.w),
                                  child: SquareCheckbox(
                                      value:
                                          true /*HiveService()
                                          .getLocalInfo()
                                          .keepSigned*/
                                      ,
                                      onChange: (val) async {
                                        /*HiveService()
                                            .getLocalInfo()
                                            .keepSigned = val;
                                        await HiveService()
                                            .getLocalInfo()
                                            .save();*/
                                        setState(() {});
                                      },
                                      color: AppTheme.accentFirstColor,
                                      glowColor: AppTheme.accentFirstColor),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.w, horizontal: 20.h),
                                  child: ClassicText(
                                    text: 'Keep signed',
                                    style: AppTheme.smallParagraphMediumText
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 80.h),
                                child: VerifyNumberButton(
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
