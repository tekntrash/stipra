import 'package:flutter/material.dart';

class CurvedContainer extends StatelessWidget {
  final Widget child;
  const CurvedContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: child,
    );
  }
}
