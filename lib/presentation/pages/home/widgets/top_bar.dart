import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import '../../../../core/utils/router/app_navigator.dart';
import '../../search/search_page.dart';
import '../../../widgets/image_box.dart';
import '../../../../shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBar extends StatelessWidget {
  final bool hideSearchBar, replaceSideBarWithBack;
  const TopBar({
    Key? key,
    this.replaceSideBarWithBack: false,
    this.hideSearchBar: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (replaceSideBarWithBack)
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              if (!replaceSideBarWithBack)
                Container(
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme().lightBlueColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        if (!hideSearchBar)
          InkWell(
            onTap: () {
              AppNavigator.pushWithFadeIn(
                context: context,
                child: SearchPage(),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppTheme().greyScale5,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.search_sharp,
                    color: AppTheme().greyScale1,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Search deal',
                    style: AppTheme().extraSmallParagraphRegularText.copyWith(
                          color: AppTheme().greyScale2,
                        ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
