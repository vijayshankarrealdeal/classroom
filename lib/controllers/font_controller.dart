import 'package:classroom/controllers/color_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FontsForApp {
  static const TextTheme blackCupertino = TextTheme(
    headline1: TextStyle(
        fontFamily: '.SF UI Display',
        color: CupertinoColors.black,
        fontWeight: FontWeight.bold,
        fontSize: 34,
        decoration: TextDecoration.none),
    headline2: TextStyle(
        debugLabel: 'blackCupertino headline2',
        fontFamily: '.SF UI Display',
        color: Colors.black54,
        fontSize: 45,
        decoration: TextDecoration.none),
    headline3: TextStyle(
        debugLabel: 'blackCupertino headline3',
        fontFamily: '.SF UI Display',
        color: Colors.black54,
        decoration: TextDecoration.none),
    headline4: TextStyle(
        debugLabel: 'blackCupertino headline4',
        fontFamily: '.SF UI Display',
        color: Colors.black54,
        decoration: TextDecoration.none),
    headline5: TextStyle(
        debugLabel: 'blackCupertino headline5',
        fontFamily: '.SF UI Display',
        color: Colors.black87,
        decoration: TextDecoration.none),
    headline6: TextStyle(
        debugLabel: 'blackCupertino headline6',
        fontFamily: '.SF UI Display',
        color: Colors.black87,
        decoration: TextDecoration.none),
    bodyText1: TextStyle(
        debugLabel: 'blackCupertino bodyText1',
        fontFamily: '.SF UI Text',
        color: Colors.black87,
        decoration: TextDecoration.none),
    bodyText2: TextStyle(
        debugLabel: 'blackCupertino bodyText2',
        fontFamily: '.SF UI Text',
        color: Colors.black87,
        decoration: TextDecoration.none),
    subtitle1: TextStyle(
        debugLabel: 'blackCupertino subtitle1',
        fontFamily: '.SF UI Text',
        color: Colors.black87,
        decoration: TextDecoration.none),
    subtitle2: TextStyle(
        debugLabel: 'blackCupertino subtitle2',
        fontFamily: '.SF UI Text',
        color: Colors.black,
        decoration: TextDecoration.none),
    caption: TextStyle(
        debugLabel: 'blackCupertino caption',
        fontFamily: '.SF UI Text',
        color: Colors.black54,
        decoration: TextDecoration.none),
    button: TextStyle(
        debugLabel: 'blackCupertino button',
        fontFamily: '.SF UI Text',
        color: Colors.black87,
        decoration: TextDecoration.none),
    overline: TextStyle(
        debugLabel: 'blackCupertino overline',
        fontFamily: '.SF UI Text',
        color: Colors.black,
        decoration: TextDecoration.none),
  );

  /// A material design text theme with light glyphs based on San Francisco.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  ///
  /// This theme uses the iOS version of the font names.
  static const TextTheme whiteCupertino = TextTheme(
    headline1: TextStyle(
        debugLabel: 'whiteCupertino headline1',
        fontFamily: '.SF UI Display',
        color: CupertinoColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 34,
        decoration: TextDecoration.none),
    headline2: TextStyle(
        debugLabel: 'whiteCupertino headline2',
        fontFamily: '.SF UI Display',
        color: Colors.white70,
        fontSize: 45,
        decoration: TextDecoration.none),
    headline3: TextStyle(
        debugLabel: 'whiteCupertino headline3',
        fontFamily: '.SF UI Display',
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline4: TextStyle(
        debugLabel: 'whiteCupertino headline4',
        fontFamily: '.SF UI Display',
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline5: TextStyle(
        debugLabel: 'whiteCupertino headline5',
        fontFamily: '.SF UI Display',
        color: Colors.white,
        decoration: TextDecoration.none),
    headline6: TextStyle(
        debugLabel: 'whiteCupertino headline6',
        fontFamily: '.SF UI Display',
        color: Colors.white,
        decoration: TextDecoration.none),
    subtitle1: TextStyle(
        debugLabel: 'whiteCupertino subtitle1',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
    bodyText1: TextStyle(
        debugLabel: 'whiteCupertino bodyText1',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
    bodyText2: TextStyle(
        debugLabel: 'whiteCupertino bodyText2',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
    caption: TextStyle(
        debugLabel: 'whiteCupertino caption',
        fontFamily: '.SF UI Text',
        color: Colors.white70,
        decoration: TextDecoration.none),
    button: TextStyle(
        debugLabel: 'whiteCupertino button',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
    subtitle2: TextStyle(
        debugLabel: 'whiteCupertino subtitle2',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
    overline: TextStyle(
        debugLabel: 'whiteCupertino overline',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
  );

  Text body1(String text, ColorPicker picker) {
    if (picker.light) {
      return Text(
        text,
        style: blackCupertino.bodyText1,
      );
    } else {
      return Text(
        text,
        style: whiteCupertino.bodyText1,
      );
    }
  }

  Text headline1(String text, ColorPicker picker) {
    if (picker.light) {
      return Text(
        text,
        style: blackCupertino.headline1,
      );
    } else {
      return Text(
        text,
        style: whiteCupertino.headline1,
      );
    }
  }

  Text headline2(String text, ColorPicker picker) {
    if (picker.light) {
      return Text(
        text,
        style: blackCupertino.headline2,
      );
    } else {
      return Text(
        text,
        style: whiteCupertino.headline2,
      );
    }
  }

  Text headline3(String text, ColorPicker picker) {
    if (picker.light) {
      return Text(
        text,
        style: blackCupertino.headline3,
      );
    } else {
      return Text(
        text,
        style: whiteCupertino.headline3,
      );
    }
  }

  Text headline4(String text, ColorPicker picker) {
    if (picker.light) {
      return Text(
        text,
        style: blackCupertino.headline4,
      );
    } else {
      return Text(
        text,
        style: whiteCupertino.headline4,
      );
    }
  }

  Text headline5(String text, ColorPicker picker) {
    if (picker.light) {
      return Text(
        text,
        style: blackCupertino.headline5,
      );
    } else {
      return Text(
        text,
        style: whiteCupertino.headline5,
      );
    }
  }

  Text headline6(String text, ColorPicker picker) {
    if (picker.light) {
      return Text(
        text,
        style: blackCupertino.headline6,
      );
    } else {
      return Text(
        text,
        style: whiteCupertino.headline6,
      );
    }
  }
}
