import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          title: Text('how_to_make_a_video_title'.tr),
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
                    'how_to_make_a_video_text'.tr,
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
