import 'package:flutter/material.dart';

class LocalImageBox extends StatelessWidget {
  final double width, height;
  final EdgeInsets margin;
  final String imgUrl;
  const LocalImageBox({
    Key? key,
    required this.width,
    required this.height,
    required this.imgUrl,
    this.margin: EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: Image.asset(
        'assets/images/$imgUrl',
        fit: BoxFit.cover,
      ),
    );
  }
}
