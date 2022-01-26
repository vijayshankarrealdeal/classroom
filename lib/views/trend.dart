import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/data.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/controllers/trends_controller.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/routes/add_request.dart';
import 'package:classroom/routes/add_request_class_details.dart';
import 'package:classroom/services/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/star.dart';
import 'package:flutter_star/star_score.dart';
import 'package:provider/provider.dart';

class PlayListUI extends StatelessWidget {
  const PlayListUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFromDatabase>(context);
    final db = Provider.of<Database>(context);

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Trending'),
              trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: user.isMentor
                      ? const Text("Create a room")
                      : const Text("Request for a class"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const MakeARequest(),
                      ),
                    );
                  }),
            )
          ];
        },
        body: ChangeNotifierProvider<TrendsController>(
          create: (context) => TrendsController(context, user, db),
          child: Consumer3<TrendsController, TypoGraphyOfApp, ColorPicker>(
              builder: (context, trendsdata, fonts, color, _) {
            return ListView(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 18),
              children: [
                CupertinoSearchTextField(
                  onChanged: (s) => trendsdata.searchFor(user, db),
                  controller: trendsdata.search,
                ),
                trendsdata.listdata.isEmpty
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 13),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var _metadata = trendsdata.search.text.isEmpty
                              ? trendsdata.listdata[index]
                              : trendsdata.tmpsearch[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider.value(
                                    value: _metadata,
                                    child: const AddClassDetails(
                                      previoustile: "Trending",
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _metadata.topic.toCapitalized(),
                                        style: CupertinoTheme.of(context)
                                            .textTheme
                                            .navLargeTitleTextStyle
                                            .copyWith(
                                              fontSize: 28,
                                            ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          fonts.heading6(
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
                                      fonts.subTitle1(
                                          "Subtopics:", color.textColor()),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: _metadata.subtpoics
                                            .map(
                                              (e) => fonts.body1(
                                                "  ${_metadata.subtpoics.indexOf(e) + 1}) " +
                                                    e
                                                        .toString()
                                                        .toCapitalized(),
                                                color.textColor(),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              _metadata.studentenrollUid.isEmpty
                                                  ? fonts.body1(
                                                      "Be The First to enroll:",
                                                      color.textColor())
                                                  : Icon(
                                                      CupertinoIcons.person_2,
                                                      color: color.onlyBlue(),
                                                    ),
                                              const SizedBox(width: 5),
                                              fonts.subTitle1(
                                                  "${_metadata.studentenrollUid.length} / 50",
                                                  color.textColor()),
                                            ],
                                          ),
                                          Icon(
                                            _metadata.studentenrollUid
                                                    .contains(db.uid)
                                                ? CupertinoIcons.circle_fill
                                                : CupertinoIcons.circle,
                                            color: _metadata.studentenrollUid
                                                    .contains(db.uid)
                                                ? color.nowarning()
                                                : color.onlyBlue(),
                                          ),
                                        ],
                                      ),
                                      
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: trendsdata.search.text.isEmpty
                            ? trendsdata.listdata.length
                            : trendsdata.tmpsearch.length,
                      )
              ],
            );
          }),
        ),
      ),
    );
  }
}
