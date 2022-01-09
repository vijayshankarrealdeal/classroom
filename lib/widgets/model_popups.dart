import 'package:classroom/routes/settings.dart';
import 'package:flutter/cupertino.dart';

Future<void> showmodelpop(BuildContext context) async {
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        title: const Text("User Action"),
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
          )
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
