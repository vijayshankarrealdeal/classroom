import 'package:classroom/model/database_users.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/error_dialog.dart';
import 'package:flutter/cupertino.dart';

class UserInfoAdd extends ChangeNotifier {
  String textX = "Select Mentor/Student";
  String classX = "Select Your Class";
  final TextEditingController name = TextEditingController();
  final TextEditingController bio = TextEditingController();
  int value = -1;
  final List<String> _classList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "B-Tech"
  ];

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
          textX == "Select Mentor/Student" ||
          classX == "Select Your Class") {
        throw "Enter The Fields First";
      } else {
        await db.addUser(
          UserFromDatabase(
            bio: bio.text,
            circleChart: [],
            level: textX.contains("Mentor") ? "Mentor" : "Novice",
            totalclass: 0,
            weekreport: [],
            topicCreated: [],
            topicEnrolled: [],
            name: name.text,
            email: db.email,
            uid: db.uid,
            profilepic: '',
            isMentor: textX.contains("Mentor"),
            classstudy: classX,
          ),
        );
      }
    } catch (e) {
      uploadstart = false;
      notifyListeners();
      errorAlert(context, e.toString());
    }
  }

  Future<void> showClassPop(BuildContext context) async {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text("Done"),
                    onPressed: () {
                      classX = (value + 1).toString();
                      notifyListeners();

                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CupertinoPicker(
                    onSelectedItemChanged: (val) {
                      value = val;
                      notifyListeners();
                    },
                    itemExtent: 38.0,
                    children: _classList
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.toString()),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        });
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
