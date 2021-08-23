import 'package:flutter/material.dart';

class Styles {
  static TextStyle copyStyle({
    Color color = Colors.white,
    FontWeight fontWeight = FontWeight.normal,
    double fontSize = 14.0,
    TextDecoration decoration = TextDecoration.none,
    FontStyle fontStyle = FontStyle.normal,
    double height = 1.0,
  }) =>
      TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
        fontStyle: fontStyle,
        height: height,
      );

  static TextStyle appBar({Color color = colorMain}) =>
      copyStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold);

  static TextStyle cusText({Color color = colorWhile, double size = 14}) =>
      copyStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.w500,
      );

  static TextStyle txtBold({Color color = colorWhile, double size = 14}) =>
      copyStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.bold,
      );

  static TextStyle txtBlack(
          {Color color = colorB2, double size = 14, double height = 1}) =>
      copyStyle(
        fontSize: size,
        color: color,
        height: height,
      );

  //Color Main.
  static const Color colorMain = Color(0xFFFA6500);
  static const Color colorTv1 = Color(0xff222222);

  //Color While.
  static const Color colorWhile = Color(0xFFFFFFFF);

  //Color Grey.
  static const Color colorG1 = Color(0xFF8D94A3);
  static const Color colorG2 = Color(0xFF808080);
  static const Color colorG3 = Color(0xFFDADADA);
  static const Color colorG4 = Color(0xFF999999);
  static const Color colorG5 = Color(0xFFB3B3B3);
  static const Color colorG6 = Color(0xFFCCCCCC);
  static const Color colorG7 = Color(0xFFF3F3F3);
  static const Color colorG8 = Color(0xFFF2F2F2);
  static const Color colorG9 = Color(0xFFA9A9A9);
  static const Color colorG10 = Color(0xFFE6E6E6);
  static const Color colorG11 = Color(0xFFC0C0C0);
  static const Color colorG12 = Color(0xFFFAFAFA);
  static const Color colorG13 = Color(0xFF838DA8);
  static const Color colorG14 = Color(0xfff3f5f4);
  static const Color colorG15 = Color(0xFFF8F8F8);
  static const Color colorG16 = Color(0xFF808184);

  //Color Black.
  static const Color colorB1 = Color(0xFF000000);
  static const Color colorB2 = Color(0xFF333333);
  static const Color colorB3 = Color(0xFF3C3C3C);
  static const Color colorB4 = Color(0xff474a54);
  static const Color colorB5 = Color(0xff778396);

  //Color Red.
  static const Color colorRed1 = Color(0xFFD64F50);
  static const Color colorRed2 = Color(0xFFE04C5A);
  static const Color colorRed3 = Color(0xFFEF4136);

  //Color Green.
  static const Color colorGreen1 = Color(0xFF00A853);
  static const Color colorGreen2 = Color(0xFF026E54);

  //Color Blue.
  static const Color colorBlue1 = Color(0xFF228686);
  static const Color colorBlue2 = Color(0xFF0F6899);
  static const Color colorBlue3 = Color(0xFF25379B);
  static const Color colorBlue4 = Color(0xFF0097CC);
  static const Color colorBlue5 = Color(0xFF007BFF);
  static Color colorBlue6 = const Color(0xFFC2EBF1).withOpacity(0.6);
  static const Color colorBlue7 = Color(0xFF43999C);
  static const Color colorBlue8 = Color(0xFF147BD4);

  //Color Orange.
  static const Color colorOr1 = Color(0xFFEE8738);
  static Color colorOr2 = const Color(0xFFFA6500).withOpacity(0.4);
  static const Color colorOr3 = Color(0xFFFF8C00);
  static const Color colorOr4 = Color(0xFFFF6700);
  static const Color colorOr5 = Color(0xFFF15A24);

  //Color Yellow.
  static const Color colorY1 = Color(0xFFFFF171);
  static const Color colorY2 = Color(0xFFFFFF00);
  static const Color colorY3 = Color(0xFFFFC703);
  static const Color colorY4 = Color(0xFFFFD700);

  //Color Pink.
  static const Color colorP1 = Color(0xFFFD7C76);
  static const Color colorP2 = Color(0xFFB31C91);
  static const Color colorP3 = Color(0xFF5C239B);

  //Color Note.
  static const Color colorNote1 = Color(0xFFFDC199);
  static const Color colorNote2 = Color(0xFF9FD09B);
  static const Color colorNote3 = Color(0xFFE1A4D3);
  static const Color colorNote4 = Color(0xFFBEA7D7);
  static const Color colorNote5 = Color(0xFFA1CAEE);
  static const Color colorNote6 = Color(0xFFC8C8C8);

  //Other.
}
