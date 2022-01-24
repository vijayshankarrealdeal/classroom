import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorPicker extends ChangeNotifier {
  ColorPicker() {
    _checkformode();
  }
  bool light = false;
  bool onlypins = false;
  void _checkformode() async {
    final _ref = await SharedPreferences.getInstance();
    final _mode = _ref.getBool('mode');
    final _pins = _ref.getBool('pin');
    light = _mode ?? true;
    onlypins = _pins ?? false;
    notifyListeners();
  }

  void switchmode() async {
    final _ref = await SharedPreferences.getInstance();
    if (light) {
      light = false;
      _ref.setBool('mode', false);
    } else {
      light = true;
      _ref.setBool('mode', true);
    }
    notifyListeners();
  }

  void switchpins() async {
    final _ref = await SharedPreferences.getInstance();
    if (onlypins) {
      onlypins = false;
      _ref.setBool('pin', false);
    } else {
      onlypins = true;
      _ref.setBool('pin', true);
    }
    notifyListeners();
  }

  Color cardColor() {
    if (light) {
      return CupertinoColors.lightBackgroundGray;
    } else {
      return CupertinoColors.darkBackgroundGray;
    }
  }

  Color onlyBlue() {
    if (!light) {
      return const Color.fromRGBO(0, 122, 255, 1);
    } else {
      return const Color.fromRGBO(10, 132, 255, 1);
    }
  }

  Color purple() {
    if (!light) {
      return const Color(0xffAF52DE);
    } else {
      return const Color(0xffBF5AF2);
    }
  }

  Color nowarning() {
    if (!light) {
      return const Color.fromRGBO(52, 199, 89, 1);
    } else {
      return const Color.fromRGBO(50, 215, 75, 1);
    }
  }

  Color textColor() {
    if (!light) {
      return CupertinoColors.white;
    } else {
      return CupertinoColors.black;
    }
  }

  Color reverseColor() {
    if (light) {
      return CupertinoColors.white;
    } else {
      return CupertinoColors.black;
    }
  }

  Color onlyWhite() {
    if (!light) {
      return CupertinoColors.white;
    } else {
      return CupertinoColors.white;
    }
  }

  Color onlyBlack() {
    if (!light) {
      return CupertinoColors.black;
    } else {
      return CupertinoColors.black;
    }
  }

  Color yellow() {
    if (!light) {
      return const Color(0xffFFCC00);
    } else {
      return const Color(0xffFFD60A);
    }
  }

  Color orange() {
    if (!light) {
      return const Color(0xffFF9500);
    } else {
      return const Color(0xffFF9F0A);
    }
  }

  Color anotheruser() {
    if (!light) {
      return CupertinoColors.extraLightBackgroundGray;
    } else {
      return const Color(0xffF4E5C2);
    }
  }

  Color red() {
    if (!light) {
      return Colors.red.shade500;
    } else {
      return Colors.red.shade800;
    }
  }
}
