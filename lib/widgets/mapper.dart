import 'package:classroom/controllers/color_controllers.dart';
import 'package:flutter/cupertino.dart';

class MapperX {
  final Map<String, Color> _map = {
    "Novice": ColorPicker().nowarning(),
    "Expert": ColorPicker().purple(),
    "Master": ColorPicker().orange(),
    "Super": ColorPicker().textColor(),
    "Mentor": ColorPicker().onlyBlack(),
  };
  Color getMapperX(String s) {
    return _map[s]!;
  }
}
