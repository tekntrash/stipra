import 'package:flutter/material.dart';

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
    'AppRoutes.otpVerify': routeOtpVerifyPage,
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

  Route routeOtpVerifyPage(RouteSettings routeSettings) {
    var phoneNumber;
    if (routeSettings.arguments is String) {
      phoneNumber = routeSettings.arguments as String;
    }
    if (phoneNumber != null) {
      return MaterialPageRoute(
        builder: (context) => Container(
            //phoneNumber: phoneNumber,
            ),
      );
    } else {
      return MaterialPageRoute(builder: (context) => Container());
    }
  }

  GlobalKey<NavigatorState>? mainNavigatorKey = GlobalKey();
}
