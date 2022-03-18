import 'package:flutter/material.dart';

class AppNavigator {
  static Future<T> push<T>({
    required BuildContext context,
    required Widget child,
  }) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => child,
    ));
    return result;
  }

  static Future<T> pushWithOutAnim<T>({
    required BuildContext context,
    required Widget child,
  }) async {
    final result = await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => child,
        transitionDuration: Duration.zero,
      ),
    );
    return result;
  }

  static Future<T> pushReplacement<T>({
    required BuildContext context,
    required Widget child,
  }) async {
    final result =
        await Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => child,
    ));
    return result;
  }

  static Future<T> pushAndRemoveUntil<T>({
    required BuildContext context,
    required Widget child,
  }) async {
    final result = await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => child,
        ),
        (route) => false);
    return result;
  }

  static Future<Object?> pushNamed<T>({
    required BuildContext context,
    required String routeName,
    Object? arguments,
  }) async {
    final result =
        await Navigator.of(context).pushNamed(routeName, arguments: arguments);
    return result;
  }

  static Future<Object?> pushReplacementNamed<T>({
    required BuildContext context,
    required String routeName,
    Object? result,
    Object? arguments,
  }) async {
    final navresult = await Navigator.of(context).pushReplacementNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
    return navresult;
  }

  static Future<Object?> pushAndRemoveUntilNamed<T>({
    required BuildContext context,
    required String routeName,
    required bool Function(Route<dynamic>) predicate,
    Object? arguments,
  }) async {
    final result = await Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      predicate,
    );
    return result;
  }
}
