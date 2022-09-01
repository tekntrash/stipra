import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/loyalty_cards/card_add/card_add_viewmodel.dart';
import 'package:stipra/presentation/pages/loyalty_cards/custom_credit_card_form.dart';
import 'package:stipra/presentation/pages/loyalty_cards/data/enums/card_brand_specs.dart';
import 'package:stipra/presentation/pages/loyalty_cards/data/models/custom_credit_card_model.dart';
import 'package:stipra/presentation/widgets/theme_button.dart';

import '../../../../shared/app_theme.dart';
import '../custom_credit_card_widget.dart';

part 'widgets/card_view.dart';
part 'widgets/card_form.dart';

class LoyaltyCardAddPage extends StatelessWidget {
  final CustomCreditCardModel? oldCardModel;
  const LoyaltyCardAddPage({
    Key? key,
    this.oldCardModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoyaltyCardAddViewModel>.nonReactive(
      viewModelBuilder: () => LoyaltyCardAddViewModel(),
      onModelReady: (model) => model.init(oldCardModel),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: buildAppBar(context),
          backgroundColor: AppTheme().whiteColor,
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: topSideBuilder(),
              ),
              SliverToBoxAdapter(
                child: _CardView(),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () async {
                    viewModel.scanCard(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(
                        left: 16, top: 0, right: 16, bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fullscreen,
                          size: 24,
                          color: AppTheme().greyScale3,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Scan your card',
                          style: AppTheme().smallParagraphMediumText.copyWith(
                                fontSize: 18,
                                color: AppTheme().greyScale3,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _CardForm(),
              ),
              SliverToBoxAdapter(
                child: ThemeButton(
                  borderRadius: BorderRadius.circular(50),
                  width: 50,
                  height: 50,
                  margin:
                      EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
                  onTap: () {
                    viewModel.saveCard(context);
                  },
                  text: 'Save',
                ),
              )
            ],
          ),
        );
      },
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      elevation: 4,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: AppTheme().darkPrimaryColor,
          //gradient: AppTheme().gradientPrimary,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppTheme().whiteColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        'Loyalty Cards',
        style: AppTheme().paragraphSemiBoldText.copyWith(
              color: AppTheme().whiteColor,
            ),
      ),
      centerTitle: true,
      actions: [],
      toolbarHeight: kBottomNavigationBarHeight + 8,
    );
  }

  Widget topSideBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.transparent,
          child: Text(
            'Add new card',
            style: AppTheme().medParagraphRegularText,
          ),
        ),
        /*GestureDetector(
          onTap: () async {
            // viewModel.scanCard(context);
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
            child: Row(
              children: [
                Icon(
                  Icons.fullscreen,
                  size: 22,
                  color: AppTheme().greyScale3,
                ),
                SizedBox(width: 6),
                Text(
                  'Scan your card',
                  style: AppTheme().smallParagraphMediumText.copyWith(
                        fontSize: 16,
                        color: AppTheme().greyScale3,
                      ),
                ),
              ],
            ),
          ),
        ),*/
      ],
    );
  }
}
