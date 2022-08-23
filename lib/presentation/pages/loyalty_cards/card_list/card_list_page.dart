import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/loyalty_cards/card_list/card_list_viewmodel.dart';
import 'package:stipra/presentation/widgets/local_image_box.dart';

import '../../../../shared/app_theme.dart';
import '../custom_credit_card_widget.dart';

class LoyaltyCardListPage extends StatelessWidget {
  const LoyaltyCardListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CardListViewModel>.reactive(
        viewModelBuilder: () => CardListViewModel(),
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
                  Expanded(child: cardList()),
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

  Widget cardList() {
    List<_CardModel> cardModels = [
      _CardModel(
        cardHolderName: 'Ramazan Yigit',
        cardIssuer: 'Nectar',
        cardNumber: '5399 4567 8901 3456',
        expiryDate: '11/24',
      ),
      _CardModel(
        cardHolderName: 'Ramazan Yigit',
        cardIssuer: 'STORE-A',
        cardNumber: '5327 1478 2451 1784',
        expiryDate: '07/25',
      ),
    ];
    return ListView.builder(
      itemCount: cardModels.length,
      itemBuilder: (context, index) {
        final cardModel = cardModels[index];
        return CustomCreditCardWidget(
          cardNumber: cardModel.cardNumber,
          expiryDate: cardModel.expiryDate,
          cardHolderName: cardModel.cardHolderName,
          cvvCode: '',
          showBackView: false,
          onCreditCardWidgetChange: (creditCardBrand) {
            //
          },
          customCardTypeIcons: [
            CustomCardTypeIcon(
              cardType: CardType.otherBrand,
              cardImage: cardModel.getIconFromIssuer,
            ),
          ],
          cardType: CardType.otherBrand,
          isSwipeGestureEnabled: false,
          //backgroundImage: 'assets/images/nectar_logo.png',
          isHolderNameVisible: true,
          //glassmorphismConfig: Glassmorphism.defaultConfig(),
          cardBgColor: cardModel.getColorFromIssuer,
          isChipVisible: false,
          obscureCardNumber: false,
          numberTextStyle: AppTheme().smallParagraphRegularText.copyWith(
                fontSize: 18,
                color: AppTheme().whiteColor,
              ),
          textStyle: AppTheme().smallParagraphRegularText.copyWith(
                color: AppTheme().whiteColor,
              ),
          titleTextStyle: AppTheme().extraSmallParagraphRegularText.copyWith(
                color: AppTheme().whiteColor,
                fontSize: 12,
              ),
          borderRadius: 15,
          bankName: cardModel.cardIssuer.toUpperCase(),
        );
      },
    );
  }
}

class _CardModel {
  _CardModel({
    required this.cardHolderName,
    required this.cardIssuer,
    required this.cardNumber,
    required this.expiryDate,
  });
  String cardNumber;
  String cardHolderName;
  String expiryDate;
  String cardIssuer;
}

extension CardExtension on _CardModel {
  Color get getColorFromIssuer {
    if (cardIssuer.toLowerCase() == 'nectar') {
      return Colors.purple[900]!;
    } else if (cardIssuer.toLowerCase() == 'stipra') {
      return AppTheme().darkPrimaryColor;
    } else {
      return Colors.black;
    }
  }

  Widget get getIconFromIssuer {
    late String icon;
    double size = 28;
    if (cardIssuer.toLowerCase() == 'nectar') {
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
