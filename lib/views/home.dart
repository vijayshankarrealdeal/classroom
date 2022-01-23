import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/controllers/home_controllers.dart';
import 'package:classroom/model/all_topics.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/routes/add_review.dart';
import 'package:classroom/routes/see_discussion.dart';
import 'package:classroom/services/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/star.dart';
import 'package:flutter_star/star_score.dart';
import 'package:provider/provider.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    final user = Provider.of<UserFromDatabase>(context);

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(user.isMentor ? "Active Classes" : 'Classes'),
             
            )
          ];
        },
        body: ChangeNotifierProvider<HomeController>(
          create: (ctx) => HomeController(db, context),
          child: Consumer3<HomeController, ColorPicker, TypoGraphyOfApp>(
            builder: (context, data, color, font, _) {
              return CustomScrollView(
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () {
                      return Future.delayed(
                        const Duration(seconds: 2),
                      );
                    },
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var _metadata = data.listdata[index];
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                              builder: (context) => DiscussionText(
                                classid: data.listdata[index].id,
                                user: user,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: CupertinoColors.tertiarySystemFill,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    font.heading2(
                                        _metadata.topic, color.textColor()),
                                    font.heading6(
                                        "Mentor " + _metadata.mentorname,
                                        color.textColor()),
                                    font.subTitle1(
                                        "Subtopics", color.textColor()),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _metadata.subtpoics
                                          .map((e) =>
                                              font.body1(e, color.textColor()))
                                          .toList(),
                                    ),
                                    Row(
                                      children: [
                                        font.heading6("Student Enrolled",
                                            color.textColor()),
                                        const SizedBox(width: 5),
                                        font.heading5(
                                            _metadata.studentenrollUid.length
                                                .toString(),
                                            color.textColor()),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        font.subTitle1(
                                            "Members ${_metadata.studentenrollUid.length}",
                                            color.textColor()),
                                        CupertinoButton(
                                            child: font.button(
                                                "Reviews", color.onlyBlue()),
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .push(
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      ChangeNotifierProvider<
                                                          ClassDataStudent>.value(
                                                    value: _metadata,
                                                    child: AddReview(
                                                      user: user,
                                                      index: _metadata,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                    StarScore(
                                      score: _metadata.rating,
                                      star: Star(
                                          fillColor: color.yellow(),
                                          emptyColor:
                                              Colors.grey.withAlpha(88)),
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: data.listdata.length,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
