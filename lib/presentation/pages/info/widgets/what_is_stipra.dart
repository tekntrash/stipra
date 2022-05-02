import 'package:flutter/material.dart';
import 'package:stipra/shared/app_theme.dart';

import '../../../widgets/local_image_box.dart';

/// What is Stipra UI for Info page
/// Includes texts and images

class WhatIsStipraPage extends StatelessWidget {
  const WhatIsStipraPage({Key? key}) : super(key: key);

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
          title: Text('What is Stipra'),
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
                    'Give your trash meaning! Stipra is an innovative system that allows you to receive points for each household consumer product that you normally throw out after you use.\n\nFor that, you download the app, make a video of your garbage as you throw the products in each bin, and receive points after they are recognized.\n\nStipra accepts products you use in your home as long as they have a barcode: a shampoo, a sardine can, a wine bottle, a beer can, a canned food ...\n\nAll products must have been consumed by you and can be thrown in any bin as long as it is located in the geographical area the manufacturer set up.\n\nFor that it is necessary that you have the GPS activated so that the system identifies the location. And, if you can throw them in the correct recycling bin (you know: plastic in yellow, glass in green ...) even better.',
                    style: AppTheme().smallParagraphRegularText,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: LocalImageBox(
                    width: 256,
                    height: 256,
                    imgUrl: 'what_is_stipra_photo.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Each picture or video is immediately analyzed by our Artificial Intelligence system and, once the products are identified, it gives you the corresponding points and you get an email.\n\nAs for the points, you can exchange them for products, trips, gifts, promotions...: in your client area you can see how many points you have and redeem them.',
                    style: AppTheme().smallParagraphRegularText,
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
