import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../injection_container.dart';
import '../contact/contact_page.dart';
import 'widgets/how_to_make_video.dart';
import 'widgets/what_is_stipra.dart';

class ProfileViewModel extends BaseViewModel {
  routeToContact(BuildContext context) {
    AppNavigator.push(
      context: context,
      child: ContactPage(),
    );
  }

  routeToHowToMakeVideo(BuildContext context) {
    AppNavigator.push(
      context: context,
      child: HowToMakeVideoPage(),
    );
  }

  routeToWhatIsStipra(BuildContext context) {
    AppNavigator.push(
      context: context,
      child: WhatIsStipraPage(),
    );
  }
}
