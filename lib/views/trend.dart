import 'package:classroom/routes/add_request.dart';
import 'package:classroom/routes/class_details.dart';
import 'package:flutter/cupertino.dart';

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
        body: CustomScrollView(
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
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   CupertinoPageRoute(
                      //     builder: (context) => ClassDetails(),
                      //   ),
                      // );
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Chapters",
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .apply(fontSizeFactor: 2.5),
                                  ),
                                  const Icon(CupertinoIcons.checkmark_seal)
                                ],
                              ),
                              Text(
                                "25 Members already in",
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .pickerTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
