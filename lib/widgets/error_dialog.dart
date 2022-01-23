import 'package:classroom/services/auth.dart';
import 'package:classroom/services/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_star/custom_rating.dart';
import 'package:flutter_star/star.dart';

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

Future<void> addRating(BuildContext context, Database db, String classID,
    String chapterId, double rating) async {
  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text("Ratings"),
        content: Center(
          child: CustomRating(
            max: 5,
            score: 0.5,
            star: Star(
                num: 5,
                fillColor: CupertinoColors.systemYellow,
                fat: 0.6,
                emptyColor: CupertinoColors.systemGrey.withAlpha(88)),
            onRating: (s) {
              if (rating > 4) {
                rating = (rating - 2) ;
              }
              if (rating + s > 4.2) {
                rating = (rating - s) / 5;
              }

              db.addRating(db, classID, chapterId, rating + s);
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          CupertinoButton(
            child: const Text("Back"),
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
