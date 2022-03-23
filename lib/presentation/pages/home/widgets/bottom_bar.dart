import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stipra/shared/app_theme.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);
  final tabController;

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
                  color: AppTheme.primaryColor,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.storefront,
                  size: 28,
                ),
                onPressed: () {}),
            SizedBox(width: 40), // The dummy child
            IconButton(
                icon: Icon(
                  Icons.person_outline_outlined,
                  size: 32,
                ),
                onPressed: () {}),
            InkWell(
              onTap: () {
                //
              },
              child: SvgPicture.asset(
                'assets/images/info.svg',
                width: 24,
                height: 24,
                color: Colors.grey[900],
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
    return Material(
      elevation: 15,
      color: Colors.white,
      shadowColor: Colors.black,
      child: TabBar(
        indicatorColor: Colors.transparent,
        controller: tabController,
        unselectedLabelColor: AppTheme.gray2Color,
        labelColor: AppTheme.secondaryColor,
        tabs: [
          Tab(
            icon: Icon(FontAwesomeIcons.home),
          ),
          Tab(
            icon: Icon(FontAwesomeIcons.bookmark),
          ),
          Tab(
            icon: Icon(FontAwesomeIcons.bell),
          ),
          Tab(
            icon: Icon(FontAwesomeIcons.user),
          ),
        ],
      ),
    );
  }
}
