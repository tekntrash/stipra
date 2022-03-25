import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/presentation/pages/splash/splash_page.dart';
import 'package:stipra/shared/app_theme.dart';

import 'core/utils/router/app_router.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  /*FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    ScaffoldMessenger.of(
      AppRouter().mainNavigatorKey!.currentState!.context,
    ).showSnackBar(
      SnackBar(
        content: Text('Error: $details'),
      ),
    );
  };*/
  runApp(
    StipraApplication(),
  );
}

class StipraApplication extends StatelessWidget {
  StipraApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        navigatorKey: AppRouter().mainNavigatorKey,
        //onGenerateRoute: AppRouter().onGenerateRoute,
        theme: ThemeData(
          primaryColor: AppTheme().primaryColor,
          secondaryHeaderColor: AppTheme().secondaryColor,
          accentColor: AppTheme().primaryColor,
        ),
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
      ),
      //routes: AppRouter().routes,
    );
  }
}
