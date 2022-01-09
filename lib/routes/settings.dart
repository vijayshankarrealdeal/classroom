import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/widgets/appbar_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SettingsApp extends StatelessWidget {
  const SettingsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: appBarRoute('Topic', "Settings"),
      child: Center(
        child: Consumer<ColorPicker>(builder: (context, color, _) {
          return CupertinoSwitch(
            value: color.light,
            onChanged: (c) => color.switchmode(),
          );
        }),
      ),
    );
  }
}
