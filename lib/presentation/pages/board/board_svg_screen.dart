import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoardSvgScreen extends StatefulWidget {
  BoardSvgScreen({Key? key}) : super(key: key);

  @override
  _BoardSvgScreenState createState() => _BoardSvgScreenState();
}

class _BoardSvgScreenState extends State<BoardSvgScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: SvgPicture.asset(
            'assets/images/image_box.svg',
            width: 196,
            height: 196,
            semanticsLabel: 'Image box',
          ),
        ),
      ),
    );
  }
}
