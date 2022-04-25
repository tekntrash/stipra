import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../core/utils/router/app_navigator.dart';
import '../../../../core/utils/router/app_router.dart';
import '../../../../shared/app_theme.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    AppRouter().tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      notchMargin: 3,
      child: Container(
        //color: Colors.transparent,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: IconButton(
                  padding: EdgeInsets.only(top: 3),
                  icon: Column(
                    children: [
                      Icon(
                        Icons.sell_outlined,
                        size: 28,
                        color: getSelectedColor(0),
                      ),
                      Expanded(
                        child: Text(
                          'Products',
                          style: AppTheme()
                              .extraSmallParagraphRegularText
                              .copyWith(
                                color: getSelectedColor(0),
                                fontSize: 12,
                              ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    AppRouter().tabController.index = 0;
                    print('Current index: ${AppRouter().tabController.index} ');
                    setState(() {});
                  }),
            ),
            Expanded(
              child: IconButton(
                  padding: EdgeInsets.only(top: 3),
                  icon: Column(
                    children: [
                      Icon(
                        Icons.storefront,
                        size: 28,
                        color: getSelectedColor(1),
                      ),
                      Expanded(
                        child: Text(
                          'Perks',
                          style: AppTheme()
                              .extraSmallParagraphRegularText
                              .copyWith(
                                color: getSelectedColor(1),
                                fontSize: 12,
                              ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    AppRouter().tabController.index = 1;
                    setState(() {});
                  }),
            ),
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(top: 18),
                  child: Text(
                    'Make video',
                    style: AppTheme().extraSmallParagraphRegularText.copyWith(
                          color: AppTheme().darkPrimaryColor,
                          letterSpacing: 0.25,
                          fontSize: 12,
                        ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                  padding: EdgeInsets.only(top: 3),
                  icon: Column(
                    children: [
                      Icon(
                        Icons.person_outline_outlined,
                        size: 28,
                        color: getSelectedColor(2),
                      ),
                      Expanded(
                        child: Text(
                          'Profile',
                          style: AppTheme()
                              .extraSmallParagraphRegularText
                              .copyWith(
                                color: getSelectedColor(2),
                                fontSize: 12,
                              ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    AppRouter().tabController.index = 2;
                    setState(() {});
                  }),
            ),
            Expanded(
              child: IconButton(
                padding: EdgeInsets.only(top: 3),
                onPressed: () {
                  AppRouter().tabController.index = 3;
                  setState(() {});
                },
                icon: Column(
                  children: [
                    Icon(
                      Ionicons.information,
                      size: 28,
                      color: getSelectedColor(3),
                    ),
                    Expanded(
                      child: Text(
                        'Info',
                        style:
                            AppTheme().extraSmallParagraphRegularText.copyWith(
                                  color: getSelectedColor(3),
                                  fontSize: 12,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /* IconButton(
                icon: Icon(
                  Icons.image,
                  size: 28,
                ),
                onPressed: () {}),*/
          ],
        ),
      ),
    );
  }

  Color getSelectedColor(int index) {
    return AppRouter().tabController.index == index
        ? AppTheme().primaryColor
        : AppTheme().greyScale2;
  }
}
