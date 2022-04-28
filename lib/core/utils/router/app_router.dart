import 'package:flutter/material.dart';

typedef AppRoute = Route Function(
  RouteSettings routeSettings,
);

class AppRouter {
  static AppRouter _instance = AppRouter._();

  AppRouter._();

  factory AppRouter() => _instance;
/*
  final Map<String, Widget> routes = {
    AppRoutes.splash: SplashPage(),
    AppRoutes.home: HomePage(),
    AppRoutes.board: BoardScreen(),
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
  }*/

  late TabController tabController;
  GlobalKey<NavigatorState>? mainNavigatorKey = GlobalKey();
}
