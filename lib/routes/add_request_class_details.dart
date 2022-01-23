import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/model/all_topics.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/services/db.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddClassDetails extends StatelessWidget {
  final String previoustile;
  const AddClassDetails({Key? key, required this.previoustile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer5<
        ClassDataStudent,
        UserFromDatabase,
        Database,
        TypoGraphyOfApp,
        ColorPicker>(builder: (context, data, user, db, font, color, _) {
      return CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                previousPageTitle: previoustile,
                largeTitle: Text(data.topic),
                trailing: !user.isMentor
                    ? CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: data.studentenrollUid.contains(db.uid)
                            ? const Text("Remove")
                            : const Text("Join"),
                        onPressed: () {
                          !data.studentenrollUid.contains(db.uid)
                              ? db.enroll(data)
                              : db.unenroll(data);
                        })
                    : null,
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                font.heading6("Mentor " + data.mentorname, color.textColor()),
                const SizedBox(height: 30),
                font.heading6("Subtopics", color.textColor()),
                const SizedBox(height: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.subtpoics
                      .map((e) => font.body1(e, color.textColor()))
                      .toList(),
                ),
                const SizedBox(height: 30),
                font.heading6("Student Enrolled", color.textColor()),
                font.heading5(
                    data.studentenrollUid.length.toString(), color.textColor()),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    font.heading4(
                      "Reviews",
                      color.textColor(),
                    ),
                  ],
                ),
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: data.reviews
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: CupertinoColors.darkBackgroundGray,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.blue.shade900,
                                          child: Text(e['name']
                                              .toString()
                                              .substring(0, 1)
                                              .toUpperCase()),
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          children: [
                                            font.subTitle1(
                                                e['name'], color.textColor()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  font.body1(e['message'], color.textColor()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
