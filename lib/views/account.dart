import 'dart:ui';
import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/model/notificaiton_req.dart';
import 'package:classroom/services/auth.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/error_dialog.dart';
import 'package:classroom/widgets/mapper.dart';
import 'package:classroom/widgets/text_form.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrendsUI extends StatelessWidget {
  const TrendsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final font = Provider.of<TypoGraphyOfApp>(context);
    final color = Provider.of<ColorPicker>(context);
    final user = Provider.of<UserFromDatabase>(context);
    final db = Provider.of<Database>(context);

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Profile'),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text('Logout'),
                onPressed: () {
                  logout(
                    context,
                    "You Have Sign in again",
                    Provider.of<Auth>(context, listen: false),
                  );
                },
              ),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.28,
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
                    const SizedBox(width: 30),
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
                    const SizedBox(width: 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        font.heading6(
                          "Classes Enrolled: " +
                              user.topicEnrolled!.length.toString(),
                          color.textColor(),
                        ),
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Text("Edit Bio"),
                            onPressed: () async {
                              await editBio(context, db, color);
                            })
                      ],
                    )
                  ],
                ),
              ),
              Divider(color: color.textColor()),
              Consumer<ColorPicker>(builder: (context, color, _) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        font.body1("Dark/Light mode", color.textColor()),
                        CupertinoSwitch(
                          value: color.light,
                          onChanged: (c) => color.switchmode(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        font.body1("View Only Star Chat.", color.textColor()),
                        CupertinoSwitch(
                          value: color.onlypins,
                          onChanged: (c) => color.switchpins(),
                        ),
                      ],
                    ),
                  ],
                );
              }),
              Divider(color: color.textColor()),
              Text(
                user.isMentor ? "Requests" : "Your Stats",
                style: CupertinoTheme.of(context)
                    .textTheme
                    .navLargeTitleTextStyle
                    .copyWith(
                      fontSize: 24,
                    ),
              ),
              const SizedBox(height: 15),
              user.isMentor
                  ? Consumer<Database>(builder: (context, db, _) {
                      return StreamBuilder<List<Request>>(
                          stream: db.mentorNotification(),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? ListView.builder(
                                    itemCount: snapshot.data?.length ?? 0,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, index) {
                                      var _data = snapshot.data![index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: color.cardColor(),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                font.subTitle1(
                                                  "By " + _data.requestemail,
                                                  color.textColor(),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 58.0,
                                                          top: 4,
                                                          bottom: 4),
                                                  child: Divider(
                                                      height: 2,
                                                      color: color.onlyBlack()),
                                                ),
                                                font.heading6(
                                                    "Chapter${_data.chapter}",
                                                    color.textColor()),
                                                font.body1(
                                                  _data.request,
                                                  color.textColor(),
                                                ),
                                                font.body2(
                                                  _data.discription,
                                                  color.textColor(),
                                                )
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
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            font.heading6(
                                "Weekly Studying Hours", color.textColor()),
                            const SizedBox(height: 15),
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
                                          color.onlyBlue(),
                                          color.nowarning(),
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
                                PieSeries(
                                  dataSource: user.circleChart,
                                  xValueMapper: (data, _) => data['class'],
                                  yValueMapper: (data, _) => data['discussion'],
                                  dataLabelSettings: DataLabelSettings(
                                    isVisible:
                                        user.circleChart.first['discussion'] ==
                                                -1
                                            ? false
                                            : true,
                                  ),
                                ),
                              ],
                            ),
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

  Future<void> editBio(
      BuildContext context, Database db, ColorPicker colorPicker) async {
    // ignore: unused_local_variable
    TextEditingController _bioUpdate = TextEditingController();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Dialog(
            backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Update Bio',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .textStyle
                        .copyWith(fontSize: 17, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 4.0),
                    child: FormFeildApp(
                      controller: _bioUpdate,
                      placeholder: "update bio",
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  CupertinoButton.filled(
                      child: Text('Submit',
                          style: TextStyle(color: colorPicker.onlyWhite())),
                      onPressed: () async {
                        try {
                          db.updateBio(_bioUpdate.text);

                          Navigator.pop(context);
                        } catch (e) {
                          await errorAlert(
                            context,
                            "Some Error",
                          );
                          Navigator.pop(context);
                        }
                      }),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CupertinoButton(
                    child: const Text(
                      ' Back ',
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
