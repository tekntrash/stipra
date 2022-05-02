import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'domain/repositories/local_data_repository.dart';
import 'presentation/pages/splash/splash_page.dart';
import 'shared/app_theme.dart';

import 'core/utils/router/app_router.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

//* This class opens application and control the start flow

//* This is the main entry point of the application.
Future<void> main() async {
  //* Ensure the app initalized
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    StipraApplication(),
  );
}

class StipraApplication extends StatelessWidget {
  StipraApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* Initialize the screen util (using this for responsive thing)
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        navigatorKey: AppRouter().mainNavigatorKey,
        theme: ThemeData(
          primaryColor: AppTheme().primaryColor,
          secondaryHeaderColor: AppTheme().secondaryColor,
          accentColor: AppTheme().primaryColor,
        ),
        builder: (context, widget) {
          //* Add screen util to the current context so we can use it in components
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
      ),
    );
  }
}
