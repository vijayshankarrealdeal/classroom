import 'package:classroom/model/database_users.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/error_dialog.dart';
import 'package:flutter/cupertino.dart';

class UserInfoAdd extends ChangeNotifier {
  String textX = 'Select Your ';
  final TextEditingController name = TextEditingController();
  final TextEditingController classstudy = TextEditingController();

  void change(String text) {
    textX = text;
    notifyListeners();
  }

  bool uploadstart = false;
  void save(Database db, BuildContext context) async {
    try {
      uploadstart = true;
      notifyListeners();
      if (name.text.isEmpty ||
          textX == "Select Your " ||
          classstudy.text.isEmpty) {
        throw "Enter The Fields First";
      } else {
        await db.addUser(
          UserFromDatabase(
            level: "Novice",
            totalclass: 0,
            weekreport: [],
            topicCreated: [],
            topicEnrolled: [],
            name: name.text,
            email: db.email,
            uid: db.uid,
            profilepic: '',
            isMentor: textX.contains("Mentor"),
            classstudy: classstudy.text,
          ),
        );
      }
    } catch (e) {
      uploadstart = false;
      notifyListeners();
      errorAlert(context, e.toString());
    }
  }

  Future<void> showmodelpop(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text("User Action"),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                change("Student");
                Navigator.pop(context);
              },
              child: const Text("Student"),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                change("Mentor");
                Navigator.pop(context);
              },
              child: const Text("Mentor"),
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

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }
}
