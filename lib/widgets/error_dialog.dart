import 'package:flutter/cupertino.dart';

Future<void> errorAlert(BuildContext context, String message) async {
  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title:const Text("Alert"),
        content: Text(message),
        actions: [
          CupertinoButton(
            child:const Text("Okay"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}
