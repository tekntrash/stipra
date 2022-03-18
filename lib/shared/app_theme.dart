import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryColor = const Color.fromARGB(255, 23, 198, 144);
  static const secondaryColor = const Color.fromARGB(255, 252, 134, 90);
  static const accentFirstColor = const Color.fromARGB(255, 17, 76, 58);
  static const accentSecondColor = const Color.fromARGB(255, 77, 99, 34);
  static const blackColor = const Color.fromARGB(255, 55, 59, 66);
  static const gray1Color = const Color.fromARGB(255, 80, 85, 92);
  static const gray2Color = const Color.fromARGB(255, 168, 173, 180);
  static const gray3Color = const Color.fromARGB(255, 221, 221, 221);
  static const gray4Color = const Color.fromARGB(255, 245, 245, 245);
  static const whiteColor = const Color.fromARGB(255, 255, 255, 255);
  static const bgColor = const Color.fromARGB(255, 248, 248, 236);

  static final headingText = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static final largeParagraphBoldText = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static final paragraphBoldText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final paragraphSemiBoldText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static final paragraphRegularText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static final buttonText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static final smallParagraphSemiBoldText = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static final smallParagraphRegularText = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static final smallParagraphMediumText = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static final extraSmallParagraphSemiBoldText = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static final extraSmallParagraphRegularText = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static final extraSmallParagraphMediumText = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
