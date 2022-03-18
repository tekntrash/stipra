import 'package:flutter/material.dart';
import 'package:stipra/data/models/offer_model.dart';
import 'package:stipra/data/models/product_model.dart';
import 'package:stipra/presentation/pages/product_detail/product_detail_page.dart';
import 'package:stipra/presentation/pages/trading_offer_detail/trading_offer_detail_page.dart';

import '../../../presentation/pages/home/home_page.dart';
import '../../../presentation/pages/splash/splash_page.dart';
import 'app_routes.dart';

typedef AppRoute = Route Function(
  RouteSettings routeSettings,
);

class AppRouter {
  static AppRouter _instance = AppRouter._();

  AppRouter._();

  factory AppRouter() => _instance;

  final Map<String, Widget> routes = {
    AppRoutes.splash: SplashPage(),
    AppRoutes.home: HomePage(),
  };

  late final Map<String, AppRoute> routeBuilders = {
    AppRoutes.productDetail: _routeProductDetailPage,
    AppRoutes.tradingOfferDetail: _routeTradingOfferDetailPage,
  };

  Route? onGenerateRoute(RouteSettings routeSettings) {
    final routeBuilder = routeBuilders[routeSettings.name];
    if (routeBuilder != null) {
      return routeBuilder(routeSettings);
    } else {
      final page = routes[routeSettings.name];
      if (page != null) {
        return MaterialPageRoute(builder: (context) => page);
      } else {
        return null;
      }
    }
  }

  Route _routeProductDetailPage(RouteSettings routeSettings) {
    final data = routeSettings.arguments;

    if (data != null) {
      return MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          productModel: data as ProductModel,
        ),
      );
    } else {
      return MaterialPageRoute(builder: (context) => Container());
    }
  }

  Route _routeTradingOfferDetailPage(RouteSettings routeSettings) {
    final data = routeSettings.arguments;

    if (data != null) {
      return MaterialPageRoute(
        builder: (context) => TradingOfferDetailPage(
          offerModel: data as OfferModel,
        ),
      );
    } else {
      return MaterialPageRoute(builder: (context) => Container());
    }
  }

  GlobalKey<NavigatorState>? mainNavigatorKey = GlobalKey();
}
