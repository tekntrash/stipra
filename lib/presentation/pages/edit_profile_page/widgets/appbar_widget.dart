part of '../edit_profile_page.dart';

/// A component for showing a text and go back button in edit profile page

AppBar _buildTopBar(BuildContext context) {
  return AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(
        color: AppTheme().whiteColor,
        //gradient: AppTheme().gradientPrimary,
      ),
    ),
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    title: Text(
      'Change your profile',
      style: AppTheme().paragraphSemiBoldText.copyWith(
            color: Colors.black,
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
