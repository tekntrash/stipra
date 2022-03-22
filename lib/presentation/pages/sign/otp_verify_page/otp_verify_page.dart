import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/widgets/custom_button.dart';

import '../../../../shared/app_theme.dart';
import 'otp_verify_viewmodel.dart';

part 'widgets/bottom_info_widget.dart';
part 'widgets/confirm_button.dart';
part 'widgets/pincode_text_field.dart';
part 'widgets/title_widget.dart';
part 'widgets/topbar_widget.dart';

class OtpVerifyPage extends StatelessWidget {
  final String? phoneNumber;

  OtpVerifyPage({
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpVerifyViewModel>.reactive(
      viewModelBuilder: () => OtpVerifyViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppTheme.whiteColor,
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
                        SizedBox(height: 50),
                        Form(
                          key: viewModel.formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30),
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
                              Container(
                                padding: EdgeInsets.only(bottom: 100),
                                child: ConfirmButton(
                                  viewModel: viewModel,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 25),
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
