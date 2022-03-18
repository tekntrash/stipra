import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/splash/splash_viewmodel.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => model.loadApp(context),
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Center(
              child: Text('Loading'),
            ),
          ),
        );
      },
    );
  }
}
