import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stipra/data/models/user_model.dart';
import 'package:stipra/domain/repositories/data_repository.dart';
import 'package:stipra/injection_container.dart';
import 'package:stipra/presentation/widgets/avatar_image.dart';
import 'package:stipra/shared/app_images.dart';
import '../../../../core/utils/router/app_navigator.dart';
import '../../../../core/utils/router/app_router.dart';
import '../../../../domain/repositories/local_data_repository.dart';
import '../../../widgets/local_image_box.dart';
import '../../my_trades/my_trades_page.dart';
import '../../search/search_page.dart';
import '../../../widgets/image_box.dart';
import '../../../../shared/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//* Top bar for use in products & perks page
//* Its has a search bar and a back button

class TopBar extends StatefulWidget {
  final bool hideSearchBar, replaceSideBarWithBack, hideBack;
  const TopBar({
    Key? key,
    this.replaceSideBarWithBack: false,
    this.hideSearchBar: false,
    this.hideBack: false,
  }) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  void initState() {
    super.initState();
    locator<DataRepository>().getPoints();
  }

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
              if (widget.replaceSideBarWithBack && !widget.hideBack)
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
              if (widget.replaceSideBarWithBack && widget.hideBack) Container(),
              if (!widget.replaceSideBarWithBack)
                GestureDetector(
                  onTap: () {
                    AppNavigator.push(
                      context: context,
                      child: MyTradesPage(),
                    );
                  },
                  child: Container(
                    child: IntrinsicWidth(
                      child: Column(
                        children: [
                          LocalImageBox(
                            width: 32,
                            height: 32,
                            imgUrl: 'logo.png',
                            //fit: BoxFit.scaleDown,
                          ),
                          StreamBuilder<UserModel>(
                            stream: locator<LocalDataRepository>().userStream,
                            initialData:
                                locator<LocalDataRepository>().getUser(),
                            builder: (context, snapshot) {
                              log('Snapshot data: ${snapshot.data}');
                              if (snapshot.hasData &&
                                  snapshot.data?.userid != null) {
                                if (snapshot.data?.points != null) {
                                  return Text(
                                    '${snapshot.data?.points} Points',
                                    style: AppTheme()
                                        .extraSmallParagraphRegularText
                                        .copyWith(
                                          color: AppTheme().greyScale1,
                                        ),
                                  );
                                } else {
                                  return Text(
                                    '0 Points',
                                    style: AppTheme()
                                        .extraSmallParagraphRegularText
                                        .copyWith(
                                          color: AppTheme().greyScale1,
                                        ),
                                  );
                                }
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              StreamBuilder<UserModel>(
                  stream: locator<LocalDataRepository>().userStream,
                  initialData: locator<LocalDataRepository>().getUser(),
                  builder: (context, snapshot) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(500),
                      onTap: () {
                        if (snapshot.data?.userid == null) {
                          AppRouter().tabController.index = 2;
                        }
                      },
                      child: Ink(
                        width: 48,
                        height: 48,
                        /* decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme().primaryColor.withOpacity(0.80),
                          image: snapshot.data?.userid != null
                              ? 
                              DecorationImage(
                                  image: NetworkImage(
                                    'https://api.stipra.com/newapp/avatar.php?action=getavatar&alogin=${snapshot.data?.alogin}&userid=${snapshot.data?.userid}',
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),*/
                        child: snapshot.data?.userid == null
                            ? Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    'Sign in',
                                    style: AppTheme()
                                        .extraSmallParagraphRegularText
                                        .copyWith(
                                          //color: Colors.white,
                                          fontSize: 12,
                                        ),
                                  ),
                                ),
                              )
                            : AvatarImage(user: snapshot.data),
                      ),
                    );
                  }),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        if (!widget.hideSearchBar)
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
