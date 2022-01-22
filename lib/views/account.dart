import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/model/notificaiton_req.dart';
import 'package:classroom/services/auth.dart';
import 'package:classroom/services/db.dart';
import 'package:classroom/widgets/error_dialog.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ClassDiscussionStats {
  final String className;
  final int numberofDiscussion;

  ClassDiscussionStats(
      {required this.className, required this.numberofDiscussion});
}

class TrendsUI extends StatelessWidget {
  const TrendsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final font = Provider.of<FontsForApp>(context);
    final color = Provider.of<ColorPicker>(context);
    final user = Provider.of<UserFromDatabase>(context);

    List<ClassDiscussionStats> p = [
      ClassDiscussionStats(className: "Algebra", numberofDiscussion: 20),
      ClassDiscussionStats(className: "Real Numbers", numberofDiscussion: 40),
      ClassDiscussionStats(className: "Area", numberofDiscussion: 10),
      ClassDiscussionStats(className: "English", numberofDiscussion: 90),
      ClassDiscussionStats(className: "Lines", numberofDiscussion: 120),
    ];

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Notification'),
              trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Logout'),
                  onPressed: () => logout(
                        context,
                        "You Have Sign in again",
                        Provider.of<Auth>(context, listen: false),
                      )),
            )
          ];
        },
        body: ListView(
          children: [
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Text(
                        user.name.substring(0, 1),
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .navLargeTitleTextStyle
                            .copyWith(
                              fontSize: 58,
                            ),
                      ),
                      backgroundColor: CupertinoColors.activeBlue,
                      radius: 50,
                    ),
                    const SizedBox(width: 30),
                    font.headline1(user.name, color),
                    const SizedBox(width: 30),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: font.body1(
                            "Classes Enrolled " +
                                user.topicEnrolled!.length.toString(),
                            color))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: font.headline1(
                  user.isMentor ? "Requests" : "Your Stats", color),
            ),
            user.isMentor
                ? Consumer<Database>(builder: (context, db, _) {
                    return StreamBuilder<List<Request>>(
                        stream: db.mentorNotification(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? ListView.builder(
                                  itemCount: snapshot.data?.length ?? 0,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, index) {
                                    var _data = snapshot.data![index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: CupertinoColors.activeGreen,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("By " + _data.requestemail),
                                              Text(_data.chapter),
                                              Text(_data.request),
                                              Text(_data.discription)
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
                          Text("Weekly Report Of Studying Hr",
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle),
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
                                  border:
                                      Border.all(color: Colors.black, width: 1),
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
                        ],
                      ),
                    ),
                  ),
            SfCircularChart(
              title: ChartTitle(
                text: "Discussion In Each Topic",
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: CupertinoTheme.of(context).primaryColor),
              ),
              legend: Legend(
                isVisible: true,
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: CupertinoTheme.of(context).primaryColor),
              ),
              series: [
                PieSeries(
                  dataSource: p,
                  xValueMapper: (data, _) => data.className,
                  yValueMapper: (data, _) => data.numberofDiscussion,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
