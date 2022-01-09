import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorPicker extends ChangeNotifier {
  ColorPicker() {
    _checkformode();
  }
  bool light = false;
  void _checkformode() async {
    final _ref = await SharedPreferences.getInstance();
    final _mode = _ref.getBool('mode');
    light = _mode ?? true;
    notifyListeners();
  }
}
