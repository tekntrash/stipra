import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/loyalty_cards/card_list/card_list_viewmodel.dart';
import 'package:stipra/presentation/pages/loyalty_cards/data/models/custom_credit_card_model.dart';
import 'package:stipra/presentation/widgets/local_image_box.dart';

import '../../../../shared/app_theme.dart';
import '../custom_credit_card_widget.dart';

part 'widgets/card_list_view.dart';

class LoyaltyCardListPage extends StatelessWidget {
  const LoyaltyCardListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CardListViewModel>.reactive(
        viewModelBuilder: () => CardListViewModel(),
        onModelReady: (viewModel) {
          viewModel.init();
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppTheme().whiteColor,
            body: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 12,
              ),
              child: Column(
                children: [
                  topSideBuilder(context, viewModel),
                  Expanded(child: _CardListView()),
                ],
              ),
            ),
          );
        });
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

  Widget topSideBuilder(BuildContext context, CardListViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            //
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.transparent,
            child: Text(
              'Saved cards',
              style: AppTheme().medParagraphRegularText,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            viewModel.routeToCardAdd(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.add,
                  color: AppTheme().greyScale3,
                ),
                Text(
                  'Add a new card',
                  style: AppTheme().smallParagraphMediumText.copyWith(
                        fontSize: 16,
                        color: AppTheme().greyScale3,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
