import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/controllers/trends_controller.dart';
import 'package:classroom/model/database_users.dart';
import 'package:classroom/routes/add_request.dart';
import 'package:classroom/routes/add_request_class_details.dart';
import 'package:classroom/services/db.dart';
import 'package:flutter/cupertino.dart';
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
                      : const Icon(CupertinoIcons.add),
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
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoSearchTextField(
                    onChanged: (s) => trendsdata.searchFor(user, db),
                    controller: trendsdata.search,
                  ),
                ),
                trendsdata.listdata.isEmpty
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : ListView.builder(
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
                                      previoustile: "Trends",
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      fonts.heading2(
                                          _metadata.topic, color.textColor()),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _metadata.studentenrollUid.isEmpty
                                              ? fonts.body1(
                                                  "Be The First to enroll",
                                                  color.textColor())
                                              : fonts.subTitle1(
                                                  "${_metadata.studentenrollUid.length} Members already in",
                                                  color.textColor()),
                                          const Icon(
                                              CupertinoIcons.checkmark_seal),
                                        ],
                                      )
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
