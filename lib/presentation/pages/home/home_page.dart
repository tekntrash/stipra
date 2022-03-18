import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/home/widgets/trading_point_offer_card.dart';
import 'package:stipra/presentation/widgets/curved_container.dart';

import 'home_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.green,
          body: SafeArea(
            child: CurvedContainer(
              child: Column(
                children: [
                  TradingPointOfferCard(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
