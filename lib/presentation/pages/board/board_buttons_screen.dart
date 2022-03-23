import 'package:flutter/material.dart';

import '../../../core/utils/router/app_navigator.dart';
import '../../widgets/theme_button.dart';
import '../sign/enter_phone_number_page/enter_phone_number_page.dart';

class BoardButtonsScreen extends StatefulWidget {
  BoardButtonsScreen({Key? key}) : super(key: key);

  @override
  _BoardButtonsScreenState createState() => _BoardButtonsScreenState();
}

class _BoardButtonsScreenState extends State<BoardButtonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              ThemeButton(
                  text: 'Login',
                  onTap: () {
                    AppNavigator.push(
                      context: context,
                      child: EnterPhoneNumberScreen(isSignIn: true),
                    );
                  }),
              SizedBox(
                height: 5,
              ),
              ThemeButton(
                  text: 'Register',
                  onTap: () {
                    AppNavigator.push(
                      context: context,
                      child: EnterPhoneNumberScreen(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
