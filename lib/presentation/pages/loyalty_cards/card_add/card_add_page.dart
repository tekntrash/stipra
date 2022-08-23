import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/loyalty_cards/card_add/card_add_viewmodel.dart';
import 'package:stipra/presentation/pages/loyalty_cards/custom_credit_card_form.dart';
import 'package:stipra/presentation/widgets/local_image_box.dart';

import '../../../../shared/app_theme.dart';
import '../../../widgets/field_builder_auto.dart';
import '../custom_credit_card_widget.dart';

part 'widgets/card_view.dart';
part 'widgets/card_form.dart';

class LoyaltyCardAddPage extends StatelessWidget {
  const LoyaltyCardAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoyaltyCardAddViewModel>.nonReactive(
      viewModelBuilder: () => LoyaltyCardAddViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: buildAppBar(context),
          backgroundColor: AppTheme().whiteColor,
          body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 12,
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: topSideBuilder(),
                ),
                SliverToBoxAdapter(
                  child: _CardView(),
                ),
                SliverToBoxAdapter(
                  child: _CardForm(),
                ),
              ],
            ),
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
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.transparent,
          child: Text(
            'Add new card',
            style: AppTheme().medParagraphRegularText,
          ),
        ),
      ],
    );
  }
}

extension CardExtension on String? {
  Color get getColorFromIssuer {
    if (this?.toLowerCase() == 'nectar') {
      return Colors.purple[900]!;
    } else if (this?.toLowerCase() == 'stipra') {
      return AppTheme().darkPrimaryColor;
    } else {
      return Colors.black;
    }
  }

  Widget get getIconFromIssuer {
    late String icon;
    double size = 28;
    if (this?.toLowerCase() == 'nectar') {
      icon = 'nectar_logo.png';
      size = 64;
    } else {
      icon = 'wireless.png';
    }
    return Container(
      height: 64,
      child: LocalImageBox(
        width: size,
        height: size,
        imgUrl: icon,
        fit: BoxFit.contain,
      ),
    );
  }
}
