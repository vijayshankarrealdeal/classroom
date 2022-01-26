import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/data.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/model/all_topics.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/services/db.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/star.dart';
import 'package:flutter_star/star_score.dart';
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
                largeTitle: const Text("Details"),
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
                Text(
                  data.topic.toCapitalized(),
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navLargeTitleTextStyle
                      .copyWith(
                        fontSize: 28,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    font.heading6("Mentor: " + data.mentorname.toCapitalized(),
                        color.textColor()),
                    StarScore(
                      score: data.rating,
                      star: Star(
                          fillColor: color.yellow(),
                          emptyColor: Colors.grey.withAlpha(88)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Divider(
                    height: 1,
                    color: color.textColor(),
                  ),
                ),
                font.subTitle1("Subtopics:", color.textColor()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.subtpoics
                      .map(
                        (e) => font.body1(
                          "  ${data.subtpoics.indexOf(e) + 1}) " +
                              e.toString().toCapitalized(),
                          color.textColor(),
                        ),
                      )
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Divider(
                    height: 0.3,
                    color: color.textColor(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reviews",
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navLargeTitleTextStyle
                          .copyWith(
                            fontSize: 28,
                          ),
                    ),
                  ],
                ),
                ListView.builder(
                  itemCount: data.reviews.length,
                  itemBuilder: (context, index) {
                    var _data = data.reviews[index];

                    return data.reviews.isEmpty
                        ? Text("No Reviews Yet",
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .navLargeTitleTextStyle)
                        : Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: color.cardColor(), width: 1),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    Colors.blue.shade900,
                                                child: Text(_data['name']
                                                    .toString()
                                                    .toCapitalized()
                                                    .substring(0, 1)
                                                    .toUpperCase()),
                                              ),
                                              const SizedBox(width: 15),
                                              Column(
                                                children: [
                                                  font.body1(
                                                    _data['name']
                                                        .toString()
                                                        .toCapitalized(),
                                                    color.textColor(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: font.body1(_data['message'],
                                              color.textColor()),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
