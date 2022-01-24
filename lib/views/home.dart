import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/data.dart';
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
              largeTitle: Text(user.isMentor
                  ? "Active Classes"
                  : 'Hi, ' + user.name.toString().toCapitalized()),
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
                                horizontal: 8.0, vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: CupertinoColors.tertiarySystemFill,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_metadata.topic.toCapitalized(),
                                        style: CupertinoTheme.of(context)
                                            .textTheme
                                            .navLargeTitleTextStyle),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        font.heading6(
                                            "Mentor: " +
                                                _metadata.mentorname
                                                    .toCapitalized(),
                                            color.textColor()),
                                        StarScore(
                                          score: _metadata.rating,
                                          star: Star(
                                              fillColor: color.yellow(),
                                              emptyColor:
                                                  Colors.grey.withAlpha(88)),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Divider(
                                        height: 1,
                                        color: color.textColor(),
                                      ),
                                    ),
                                    font.subTitle1(
                                        "Subtopics:", color.textColor()),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _metadata.subtpoics
                                          .map(
                                            (e) => font.body1(
                                              "  ${_metadata.subtpoics.indexOf(e) + 1}) " +
                                                  e.toString().toCapitalized(),
                                              color.textColor(),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.person_2,
                                              color: color.onlyBlue(),
                                            ),
                                            const SizedBox(width: 5),
                                            font.subTitle1(
                                                "${_metadata.studentenrollUid.length} / 50",
                                                color.textColor()),
                                          ],
                                        ),
                                        CupertinoButton(
                                            child: font.body1(
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
