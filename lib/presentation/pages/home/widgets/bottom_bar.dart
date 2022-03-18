import 'package:flutter/material.dart';
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
