import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/country_selector/country_selector_button.dart';
import '../../widgets/date_field.dart';

import '../../../../shared/app_theme.dart';
import '../../../data/models/auto_validator_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/field_builder_auto.dart';
import '../../widgets/selector_buttons/dropdown_selector_button.dart';
import 'edit_profile_viewmodel.dart';

part 'widgets/confirm_button.dart';
part 'widgets/topbar_widget.dart';
part 'widgets/appbar_widget.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: PreferredSize(
            child: _buildTopBar(context),
            preferredSize: Size.fromHeight(kBottomNavigationBarHeight),
          ),
          backgroundColor: AppTheme().whiteColor,
          body: SafeArea(
            child: Form(
              key: viewModel.formKey,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        //TopBarWidget(),
                        SizedBox(
                          height: 20.h,
                        ),
                        fieldBuilder(
                          validatorModel: viewModel.address,
                          text: 'Address',
                          hintText: 'Enter your address',
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                          child: CountrySelectorButton(
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              showFlags: true,
                              trailingSpace: false,
                              useEmoji: true,
                              setSelectorButtonAsPrefixIcon: false,
                            ),
                            onCountryChanged: (String country) {
                              viewModel.countryValidator.errorNotifier.value =
                                  null;
                              print(country);
                            },
                            initialValue:
                                viewModel.countryValidator.textController.text,
                            countryValidator: viewModel.countryValidator,
                            textStyle: AppTheme().smallParagraphRegularText,
                            selectorTextStyle: AppTheme()
                                .smallParagraphMediumText
                                .copyWith(
                                  fontSize:
                                      AppTheme().paragraphSemiBoldText.fontSize,
                                ),
                            hintText: 'Select a country',
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        fieldBuilder(
                          validatorModel: viewModel.city,
                          text: 'City',
                          hintText: 'Enter your city',
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        fieldBuilder(
                          validatorModel: viewModel.zipcode,
                          text: 'Zipcode',
                          hintText: 'Enter your zipcode',
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        DropdownSelectorButton(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                          },
                          title: 'Gender',
                          unSelectedTitle: 'Select your gender',
                          selected: viewModel.gender.textController.text,
                          onChanged: (value) {
                            viewModel.gender.textController.text = value;
                            viewModel.gender.validate();
                          },
                          items: ['Male', 'Female'],
                          errorNotifier: viewModel.gender.errorNotifier,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        DateField(
                          title: 'Date of birth',
                          initialDate: viewModel.convertStringToDate(
                              viewModel.dateofbirth.textController.text),
                          onDateChange: (p0) {
                            viewModel.dateofbirth.errorNotifier.value = null;
                            viewModel.dateofbirth.textController.text =
                                p0.toString();
                          },
                          notifier: viewModel.dateofbirth.errorNotifier,
                          minAge: 18,
                          showErrorOnlyIfTrue: true,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ConfirmButton(viewModel: viewModel),
                        SizedBox(
                          height: 20.h,
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

  Widget fieldBuilder({
    required AutoValidatorModel validatorModel,
    required String text,
    String? hintText,
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
    );
  }
}
