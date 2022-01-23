import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/routes/settings.dart';
import 'package:classroom/services/auth.dart';
import 'package:classroom/widgets/error_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Future<void> showmodelpop(
  BuildContext context,
) async {
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      final font = Provider.of<TypoGraphyOfApp>(context);
      final colorPicker = Provider.of<ColorPicker>(context);
      return CupertinoActionSheet(
        title: font.subTitle1("User Action", colorPicker.textColor()),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const SettingsApp(),
                ),
              );
            },
            child: const Text("Settings"),
          ),
          CupertinoActionSheetAction(
              onPressed: () {
                logout(
                  context,
                  "You Have Sign in again",
                  Provider.of<Auth>(context, listen: false),
                );
              },
              child: const Text('Logout')),
        ],
        cancelButton: CupertinoButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    },
  );
}
