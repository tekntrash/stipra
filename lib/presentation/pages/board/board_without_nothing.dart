import 'package:flutter/material.dart';
import 'package:stipra/presentation/pages/board/board_buttons_screen.dart';
import 'package:stipra/presentation/pages/board/board_screen.dart';
import 'package:stipra/presentation/pages/board/board_svg_screen.dart';
import 'package:stipra/shared/app_theme.dart';

class BoardWithoutNothing extends StatelessWidget {
  const BoardWithoutNothing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Scaffold(
                    body: Column(
                      children: [
                        Text('You can leave this page with go back button'),
                        Expanded(child: BoardSvgScreen()),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.green,
                child: Text(
                  'Create svg',
                  style: AppTheme.largeParagraphBoldText.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Scaffold(
                    body: Column(
                      children: [
                        Text('You can leave this page with go back button'),
                        Expanded(child: BoardButtonsScreen()),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.green,
                child: Text(
                  'Create login / register buttons',
                  style: AppTheme.largeParagraphBoldText.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Scaffold(
                    body: Column(
                      children: [
                        Text('You can leave this page with go back button'),
                        Expanded(child: BoardScreen()),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.green,
                child: Text(
                  'Create board screen',
                  style: AppTheme.largeParagraphBoldText.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
