import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/data.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/model/all_topics.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/mapper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/star.dart';
import 'package:flutter_star/star_score.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserInfoX extends StatelessWidget {
  final UserFromDatabase user;
  const UserInfoX({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final font = Provider.of<TypoGraphyOfApp>(context);
    final color = Provider.of<ColorPicker>(context);

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
              largeTitle: Text(user.name.toCapitalized()),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: user.isMentor
                          ? MapperX().getMapperX("Mentor")
                          : MapperX().getMapperX(user.level),
                      child: Center(
                        child: font.heading2(
                            user.name.substring(0, 1), color.onlyWhite()),
                      ),
                      radius: 45,
                    ),
                    Column(
                      children: [
                        Text(user.level,
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .navLargeTitleTextStyle),
                        font.body1(
                          user.bio,
                          color.textColor(),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: user.isMentor
                              ? font.heading6(
                                  "Classes Taken: " +
                                      user.topicCreated.length.toString(),
                                  color.textColor())
                              : font.heading6(
                                  "Classes Enrolled: " +
                                      user.topicEnrolled!.length.toString(),
                                  color.textColor(),
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(color: color.textColor()),
              Text(
                user.isMentor ? "All Classes" : "Your Stats",
                style: CupertinoTheme.of(context)
                    .textTheme
                    .navLargeTitleTextStyle
                    .copyWith(
                      fontSize: 24,
                    ),
              ),
              user.isMentor
                  ? Consumer<Database>(builder: (context, db, _) {
                      return StreamBuilder<List<ClassDataStudent>>(
                          stream: db.getClassesOfUser(user.classstudy, user),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? ListView.builder(
                                    itemCount: snapshot.data?.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, index) {
                                      var _metadata = snapshot.data![index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: CupertinoColors
                                                .tertiarySystemFill,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    _metadata.topic
                                                        .toCapitalized(),
                                                    style: CupertinoTheme.of(
                                                            context)
                                                        .textTheme
                                                        .navLargeTitleTextStyle),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                          fillColor:
                                                              color.yellow(),
                                                          emptyColor: Colors
                                                              .grey
                                                              .withAlpha(88)),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0,
                                                          bottom: 8.0),
                                                  child: Divider(
                                                    height: 1,
                                                    color: color.textColor(),
                                                  ),
                                                ),
                                                font.subTitle1("Subtopics:",
                                                    color.textColor()),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: _metadata.subtpoics
                                                      .map(
                                                        (e) => font.body1(
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons
                                                              .person_2,
                                                          color:
                                                              color.onlyBlue(),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        font.subTitle1(
                                                            "${_metadata.studentenrollUid.length} / 50",
                                                            color.textColor()),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const CupertinoActivityIndicator();
                          });
                    })
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            font.heading6("Weekly Report Of Studying Hr",
                                color.textColor()),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 400,
                              child: LineChart(
                                LineChartData(
                                  minX: 0,
                                  maxX: 7,
                                  minY: 0,
                                  maxY: 8,
                                  titlesData: FlTitlesData(
                                    show: true,
                                    leftTitles: SideTitles(showTitles: true),
                                    rightTitles: SideTitles(showTitles: false),
                                    topTitles: SideTitles(showTitles: false),
                                    bottomTitles: SideTitles(showTitles: true),
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                        barWidth: 2,
                                        colors: [
                                          CupertinoColors.activeBlue,
                                          CupertinoColors.activeGreen
                                        ],
                                        isCurved: true,
                                        spots: List.generate(
                                          user.weekreport.length,
                                          (index) => FlSpot(
                                            index.toDouble(),
                                            user.weekreport[index].toDouble(),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SfCircularChart(
                              title: ChartTitle(
                                text: "Discussion In Each Topic",
                                textStyle: GoogleFonts.sourceSansPro(
                                    decoration: TextDecoration.none,
                                    color: color.textColor(),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.15),
                              ),
                              legend: Legend(
                                isVisible: true,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: color.textColor()),
                              ),
                              series: [
                                user.circleChart.isEmpty
                                    ? PieSeries(
                                        dataSource: [
                                          {
                                            'class': "No Data",
                                            'discussion': -1
                                          },
                                        ],
                                        xValueMapper: (data, _) =>
                                            data['class'],
                                        yValueMapper: (data, _) =>
                                            data['discussion'],
                                        dataLabelSettings: DataLabelSettings(
                                          isVisible: user.circleChart.isEmpty
                                              ? false
                                              : true,
                                        ),
                                      )
                                    : PieSeries(
                                        dataSource: user.circleChart,
                                        xValueMapper: (data, _) =>
                                            data['class'],
                                        yValueMapper: (data, _) =>
                                            data['discussion'],
                                        dataLabelSettings: DataLabelSettings(
                                          isVisible: user.circleChart.isEmpty
                                              ? false
                                              : true,
                                        ),
                                      ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Enrolled In",
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .navLargeTitleTextStyle
                                    .copyWith(
                                      fontSize: 24,
                                    ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: color.textColor(),
                            ),
                            Consumer<Database>(builder: (context, db, _) {
                              return StreamBuilder<List<ClassDataStudent>>(
                                  stream: db.getClassesOfUser(
                                      user.classstudy, user),
                                  builder: (context, snapshot) {
                                    return snapshot.hasData
                                        ? ListView.builder(
                                            itemCount: snapshot.data?.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (ctx, index) {
                                              var _metadata =
                                                  snapshot.data![index];
                                              return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 8.0),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        color: CupertinoColors
                                                            .tertiarySystemFill,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0,
                                                                horizontal:
                                                                    12.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              _metadata.topic
                                                                  .toCapitalized(),
                                                              style: CupertinoTheme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .navLargeTitleTextStyle
                                                                  .copyWith(
                                                                    fontSize:
                                                                        28,
                                                                  ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                font.heading6(
                                                                    "Mentor: " +
                                                                        _metadata
                                                                            .mentorname
                                                                            .toCapitalized(),
                                                                    color
                                                                        .textColor()),
                                                                StarScore(
                                                                  score: _metadata
                                                                      .rating,
                                                                  star: Star(
                                                                      fillColor:
                                                                          color
                                                                              .yellow(),
                                                                      emptyColor: Colors
                                                                          .grey
                                                                          .withAlpha(
                                                                              88)),
                                                                ),
                                                              ],
                                                            ),
                                                            // Padding(
                                                            //   padding:
                                                            //       const EdgeInsets
                                                            //               .only(
                                                            //           top: 8.0,
                                                            //           bottom:
                                                            //               8.0),
                                                            //   child: Divider(
                                                            //     height: 1,
                                                            //     color: color
                                                            //         .textColor(),
                                                            //   ),
                                                            //   ),
                                                            // font.subTitle1(
                                                            //     "Subtopics:",
                                                            //     color
                                                            //         .textColor()),
                                                            // Column(
                                                            //   mainAxisAlignment:
                                                            //       MainAxisAlignment
                                                            //           .start,
                                                            //   crossAxisAlignment:
                                                            //       CrossAxisAlignment
                                                            //           .start,
                                                            //   children:
                                                            //       _metadata
                                                            //           .subtpoics
                                                            //           .map(
                                                            //             (e) => font
                                                            //                 .body1(
                                                            //               "  ${_metadata.subtpoics.indexOf(e) + 1}) " +
                                                            //                   e.toString().toCapitalized(),
                                                            //               color
                                                            //                   .textColor(),
                                                            //             ),
                                                            //           )
                                                            //           .toList(),
                                                            // ),
                                                            // Row(
                                                            //   mainAxisAlignment:
                                                            //       MainAxisAlignment
                                                            //           .spaceBetween,
                                                            //   crossAxisAlignment:
                                                            //       CrossAxisAlignment
                                                            //           .center,
                                                            //   children: [
                                                            //     Row(
                                                            //       children: [
                                                            //         Icon(
                                                            //           CupertinoIcons
                                                            //               .person_2,
                                                            //           color: color
                                                            //               .onlyBlue(),
                                                            //         ),
                                                            //         const SizedBox(
                                                            //             width:
                                                            //                 5),
                                                            //         font.subTitle1(
                                                            //             "${_metadata.studentenrollUid.length} / 50",
                                                            //             color
                                                            //                 .textColor()),
                                                            //       ],
                                                            //     ),
                                                            //   ],
                                                            // ),
                                                          ],
                                                        ),
                                                      )));
                                            },
                                          )
                                        : const CupertinoActivityIndicator();
                                  });
                            })
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
