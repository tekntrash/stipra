import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/app_theme.dart';
import '../classic_text.dart';

//* Using this with custom input components so we can show error messages with animation.
//* ListenableErorText listens a notifier for handle.
//* It is showing a red text like normal 'text field' but with custom animation.

class ListenableErrorText extends StatelessWidget {
  final ValueNotifier<String?> notifier;
  final bool showErrorOnlyIfTrue;
  final EdgeInsets margin;
  const ListenableErrorText({
    Key? key,
    required this.notifier,
    this.margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    this.showErrorOnlyIfTrue: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, String? error, child) {
          if (showErrorOnlyIfTrue && error == null) return Container();
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 200),
            builder: (BuildContext context, double size, Widget? child) {
              return Opacity(
                opacity: size,
                child: Transform.translate(
                  offset: Offset(
                    0,
                    (1.0 - size) * -2.0,
                  ),
                  child: /*Transform.scale(
                        scale: size,
                        child: */
                      Container(
                    padding: EdgeInsets.only(bottom: 0, left: 11.w, top: 5),
                    child: ClassicText(
                      text: error ?? '',
                      style: AppTheme().smallParagraphRegularText.copyWith(
                            color: Colors.red[400],
                          ),
                    ),
                  ),
                  //),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
