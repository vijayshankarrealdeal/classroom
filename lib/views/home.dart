import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Topic'),
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
                      Duration(seconds: 1),
                    );
                  },
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return GestureDetector(
                        onTap: () => {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: CupertinoColors.darkBackgroundGray,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor:
                                        CupertinoColors.black.withOpacity(0.45),
                                    child: const Center(
                                      child: Icon(
                                        CupertinoIcons.play,
                                        size: 35,
                                      ),
                                    ),
                                    radius: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: 10,
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
