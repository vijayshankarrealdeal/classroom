import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/model/all_topics.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/loading_spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AddClassDetails extends StatelessWidget {
  final String previoustile;
  const AddClassDetails({Key? key, required this.previoustile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    final user = Provider.of<UserFromDatabase>(context);
    return Consumer3<ClassDataStudent, FontsForApp, ColorPicker>(
        builder: (context, data, font, color, _) {
      return CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                previousPageTitle: previoustile,
                largeTitle: Text(data.topic),
                trailing: user.isMentor
                    ? null
                    : db.load
                        ? loadingSpinner()
                        : CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: data.studentenrollUid.contains(db.uid)
                                ? font.body1("Remove", color)
                                : font.body1("Join", color),
                            onPressed: () async {
                              if (data.studentenrollUid.contains(db.uid)) {
                                await db.unenroll(data);
                              } else {
                                await db.enroll(data);
                              }
                            },
                          ),
              )
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Mentor " + data.mentorname),
                const SizedBox(height: 30),
                const Text("Subtopics"),
                const SizedBox(height: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.subtpoics.map((e) => Text(e)).toList(),
                ),
                const SizedBox(height: 30),
            const  Text("Student Enrolled"),
                font.headline1(data.studentenrollUid.length.toString(), color),
                const SizedBox(height: 5),
                Text(
                  "Reviews",
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navLargeTitleTextStyle,
                ),
                Column(
                  children: data.reviews
                      .map(
                        (e) => Container(
                          width: double.infinity,
                          height: 50,
                          color: CupertinoColors.systemPink,
                          child: font.headline1(e, color),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
