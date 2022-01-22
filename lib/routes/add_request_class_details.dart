import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/model/all_topics.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddClassDetails extends StatelessWidget {
  final String previoustile;
  const AddClassDetails({Key? key, required this.previoustile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer3<ClassDataStudent, FontsForApp, ColorPicker>(
        builder: (context, data, font, color, _) {
      return CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                previousPageTitle: previoustile,
                largeTitle: Text(data.topic),
              )
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Text("Mentor " + data.mentorname),
                const SizedBox(height: 30),
                const Text("Subtopics"),
                const SizedBox(height: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.subtpoics.map((e) => Text(e)).toList(),
                ),
                const SizedBox(height: 30),
                const Text("Student Enrolled"),
                font.headline1(data.studentenrollUid.length.toString(), color),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reviews",
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navLargeTitleTextStyle,
                    ),
                  ],
                ),
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: data.reviews
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: CupertinoColors.darkBackgroundGray,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.blue.shade900,
                                          child: Text(e['name']
                                              .toString()
                                              .substring(0, 1)
                                              .toUpperCase()),
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          children: [
                                            Text(e['name']),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(e['message']),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
