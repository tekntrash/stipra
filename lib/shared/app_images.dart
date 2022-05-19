//* General shared image paths

class AppImages {
  static final loading = 'loading.gif';
  static final logo = 'logo1.png';
  static final avatar = 'avatar.svg';
  static final uploadComplete = 'upload-complete.json';
  static final goodBye = 'good_bye.json';
}

extension AppImagesExtension on String {
  String get imagePath {
    return 'assets/images/$this';
  }

  String get lottiePath {
    return 'assets/lotties/$this';
  }
}
