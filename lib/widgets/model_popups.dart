import 'package:classroom/routes/settings.dart';
import 'package:classroom/services/auth.dart';
import 'package:classroom/widgets/error_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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
