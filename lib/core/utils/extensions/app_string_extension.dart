import 'package:flutter/material.dart';

extension AppStringExtension on String? {
  String convertBase64ToImageUrl() {
    return 'https://api.stipra.com/newapp/showpic.php?image=$this';
  }

  Color getBinColor() {
    if (this == '1') {
      return Colors.blue;
    } else if (this == '2') {
      return Colors.green;
    } else if (this == '3') {
      return Colors.yellow;
    } else if (this == '4') {
      return Colors.red;
    }
    return Colors.transparent;
  }
}
