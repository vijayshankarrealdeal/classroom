import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/widgets/appbar_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SettingsApp extends StatelessWidget {
  const SettingsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final font = Provider.of<TypoGraphyOfApp>(context);
    final colorPicker = Provider.of<ColorPicker>(context);
    return CupertinoPageScaffold(
      navigationBar: appBarRoute('Topic', "Settings"),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Consumer<ColorPicker>(builder: (context, color, _) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      font.button("Dark/Light mode", color.textColor()),
                      CupertinoSwitch(
                        value: color.light,
                        onChanged: (c) => color.switchmode(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      font.button("View Only Pins", color.textColor()),
                      CupertinoSwitch(
                        value: color.onlypins,
                        onChanged: (c) => color.switchpins(),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
