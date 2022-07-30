part of '../my_profile_page.dart';

/// A component for showing a text and go back button in edit profile page

AppBar _buildTopBar(BuildContext context) {
  return AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(
        color: AppTheme().darkPrimaryColor,
        //gradient: AppTheme().gradientPrimary,
      ),
    ),
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    title: Text(
      'my_profile_page_title'.tr,
      style: AppTheme().paragraphSemiBoldText.copyWith(
            color: Colors.white,
          ),
    ),
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
