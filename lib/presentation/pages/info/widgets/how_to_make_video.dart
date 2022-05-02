import 'package:flutter/material.dart';
import 'package:stipra/shared/app_theme.dart';

import '../../../widgets/local_image_box.dart';
import 'video_widget.dart';

/// How to make video screen UI
/// Showing texts and a video player

class HowToMakeVideoPage extends StatelessWidget {
  const HowToMakeVideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              //color: AppTheme().darkPrimaryColor,
              gradient: AppTheme().gradientPrimary,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('How to make a video'),
          centerTitle: true,
          actions: [],
        ),
        preferredSize: Size.fromHeight(kBottomNavigationBarHeight),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme().gradientPrimary,
        ),
        child: SafeArea(
          bottom: false,
          child: Container(
            color: Colors.white,
            child: ListView(
              children: [
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Text(
                    'To make a video of your general household trash, click on "Make Video" from the app and show the products as you dispose them in the recycling bins.\n\nYou can also do a video of just one product by clicking on the link at that product.\n\nThe video will start in 3 seconds and will run for up to 60 seconds. You can stop it at any time and choose whether or not you want to send it.\n\nEnsure you show the barcodes! Each time a barcode is seen, the app will tell you and will vibrate, then you can show the next product.\n\nThe video will only be sent for analysis when you reach a wifi: that way we will not spend your mobile data. \n\nOnce the video reaches our servers, it is analyzed and you will receive in minutes an email with your points.\n\nSee below an example of a video.',
                    style: AppTheme().smallParagraphRegularText,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Container(
                    child: VideoWidget(
                      fileLink: 'https://api.stipra.com/newapp/example.mp4',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
