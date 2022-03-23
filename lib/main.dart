import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/shared/app_theme.dart';

import 'core/utils/router/app_router.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    ScaffoldMessenger.of(
      AppRouter().mainNavigatorKey!.currentState!.context,
    ).showSnackBar(
      SnackBar(
        content: Text('Error: $details'),
      ),
    );
  };
  runApp(
    ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => StipraApplication(),
    ),
  );
}

class StipraApplication extends StatelessWidget {
  StipraApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: Container(),
        navigatorKey: AppRouter().mainNavigatorKey,
        onGenerateRoute: AppRouter().onGenerateRoute,
        theme: ThemeData(
          primaryColor: AppTheme.primaryColor,
          secondaryHeaderColor: AppTheme.secondaryColor,
        ),
        //routes: AppRouter().routes,
      );
}
