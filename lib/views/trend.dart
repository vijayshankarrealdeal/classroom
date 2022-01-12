import 'package:classroom/controllers/trends_controller.dart';
import 'package:classroom/routes/add_request.dart';
import 'package:classroom/routes/add_request_class_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayListUI extends StatelessWidget {
  const PlayListUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Trends'),
              trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.add),
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
        body: Consumer<TrendsController>(builder: (context, trendsdata, _) {
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
                    var _metadata = trendsdata.listdata[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => AddClassDetails(
                              previoustile: "Trends",
                              data: _metadata,
                            ),
                          ),
                        );
                      },
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  children: [
                                    Text(
                                      "${_metadata.studentenrollUid.length} Members already in",
                                      style: CupertinoTheme.of(context)
                                          .textTheme
                                          .pickerTextStyle,
                                    ),
                                    const Icon(CupertinoIcons.checkmark_seal),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: trendsdata.listdata.length,
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
