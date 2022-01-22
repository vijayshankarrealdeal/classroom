import 'package:flutter/cupertino.dart';
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
}
