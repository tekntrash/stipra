import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/core/utils/router/app_router.dart';
import 'package:stipra/shared/app_theme.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      notchMargin: 3,
      child: Container(
        //color: Colors.transparent,
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.sell_outlined,
                  size: 28,
                  color: getSelectedColor(0),
                ),
                onPressed: () {
                  AppRouter().tabController.index = 0;
                  print('Current index: ${AppRouter().tabController.index} ');
                  setState(() {});
                }),
            IconButton(
                icon: Icon(
                  Icons.storefront,
                  size: 28,
                  color: getSelectedColor(1),
                ),
                onPressed: () {
                  AppRouter().tabController.index = 1;
                  setState(() {});
                }),
            SizedBox(width: 40), // The dummy child
            IconButton(
                icon: Icon(
                  Icons.person_outline_outlined,
                  size: 32,
                  color: getSelectedColor(2),
                ),
                onPressed: () {
                  AppRouter().tabController.index = 2;
                  setState(() {});
                }),
            InkWell(
              onTap: () {
                //
              },
              child: SvgPicture.asset(
                'assets/images/info.svg',
                width: 24,
                height: 24,
                color: getSelectedColor(3),
                semanticsLabel: 'Info box',
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
