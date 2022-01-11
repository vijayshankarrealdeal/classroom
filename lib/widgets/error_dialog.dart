import 'package:classroom/services/auth.dart';
import 'package:flutter/cupertino.dart';

Future<void> errorAlert(BuildContext context, String message) async {
  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text("Alert"),
        content: Text(message),
        actions: [
          CupertinoButton(
            child: const Text("Okay"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}

Future<void> logout(BuildContext context, String message, Auth auth) async {
  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text("Logout"),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context)),
          CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("Okay"),
              onPressed: () => auth.signOut()),
        ],
      );
    },
  );
}
