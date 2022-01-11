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
        body: Consumer<HomeController>(
          builder: (context, data, _) {
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
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const DiscussionText(),
                          ),
                        ),
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
                                  Text(
                                    _metadata.topic,
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .apply(fontSizeFactor: 2.5),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Members ${_metadata.studentenrollUid.length}",
                                        style: CupertinoTheme.of(context)
                                            .textTheme
                                            .pickerTextStyle,
                                      ),
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
