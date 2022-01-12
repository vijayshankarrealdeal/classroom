import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/routes/class_details.dart';
import 'package:classroom/routes/see_discussion.dart';
import 'package:classroom/widgets/model_popups.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:classroom/controllers/home_controllers.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Classes'),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.settings),
                onPressed: () => showmodelpop(
                  context,
                ),
              ),
            )
          ];
        },
        body: Consumer3<HomeController, ColorPicker, FontsForApp>(
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
                            builder: (context) => const DiscussionText(),
                          ),
                        ),

                        // Navigator.push(
                        //   context,
                        //   CupertinoPageRoute(
                        //     builder: (context) => const DiscussionText(),
                        //   ),
                        // ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                              color: CupertinoColors.tertiarySystemFill,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  font.headline1(_metadata.topic, color),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      font.body1(
                                          "Members ${_metadata.studentenrollUid.length}",
                                          color),
                                      CupertinoButton(
                                        child: Icon(CupertinoIcons.info_circle),
                                        onPressed: () => Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => ClassDetails(
                                              previoustile: "Classes",
                                              data: _metadata,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
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
    );
  }
}
