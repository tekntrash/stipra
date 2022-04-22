import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stipra/domain/repositories/data_repository.dart';
import 'package:stipra/injection_container.dart';
import '../../../../core/utils/router/app_navigator.dart';
import '../../../../domain/repositories/local_data_repository.dart';
import '../../../widgets/local_image_box.dart';
import '../../search/search_page.dart';
import '../../../widgets/image_box.dart';
import '../../../../shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBar extends StatelessWidget {
  final bool hideSearchBar, replaceSideBarWithBack, hideBack;
  const TopBar({
    Key? key,
    this.replaceSideBarWithBack: false,
    this.hideSearchBar: false,
    this.hideBack: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20, left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (replaceSideBarWithBack && !hideBack)
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
              if (replaceSideBarWithBack && hideBack) Container(),
              if (!replaceSideBarWithBack)
                Container(
                  child: IntrinsicWidth(
                    child: Column(
                      children: [
                        LocalImageBox(
                          width: 32,
                          height: 32,
                          imgUrl: 'logo.png',
                          fit: BoxFit.scaleDown,
                        ),
                        if (locator<LocalDataRepository>().getUser().userid !=
                            null)
                          FutureBuilder(
                            future: locator<DataRepository>().getPoints(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text(
                                  '${(snapshot.data as dynamic).value} Points',
                                  style: AppTheme()
                                      .extraSmallParagraphRegularText
                                      .copyWith(
                                        color: AppTheme().greyScale1,
                                      ),
                                );
                              } else {
                                return Text(
                                  'X Points',
                                  style: AppTheme()
                                      .extraSmallParagraphRegularText
                                      .copyWith(
                                        color: AppTheme().greyScale1,
                                      ),
                                );
                              }
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme().lightBlueColor,
                  image: locator<LocalDataRepository>().getUser().userid != null
                      ? DecorationImage(
                          image: NetworkImage(
                              'https://api.stipra.com/newapp/avatar.php?action=getavatar&alogin=${locator<LocalDataRepository>().getUser().alogin}&userid=${locator<LocalDataRepository>().getUser().userid}'),
                          fit: BoxFit.cover,
                        )
                      : null,
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
                    'Search',
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
