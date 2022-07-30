part of '../info_page.dart';

/// Uses for top bar of Info Page with logo and 'Info' title

AppBar _buildTopBar(BuildContext context) {
  final userModel = locator<LocalDataRepository>().getUser();
  return AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(
        color: AppTheme().darkPrimaryColor,
        //gradient: AppTheme().gradientPrimary,
      ),
    ),
    leading: IconButton(
      icon: LocalImageBox(
        width: 48,
        height: 48,
        imgUrl: 'logo.png',
        fit: BoxFit.scaleDown,
      ),
      onPressed: () {
        //Navigator.of(context).pop();
      },
    ),
    title: Text('info_page_title'.tr),
    centerTitle: true,
    actions: [
      /*Container(
        margin: EdgeInsets.only(right: 5),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: IconButton(
          icon: Icon(
            Icons.favorite,
            color: Colors.redAccent[400],
            size: 26,
          ),
          onPressed: () {
            //Navigator.of(context).pop();
          },
        ),
      ),*/
    ],
  );
}
