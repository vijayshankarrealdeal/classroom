import 'package:classroom/controllers/color_controllers.dart';
import 'package:classroom/controllers/font_controller.dart';
import 'package:classroom/model/all_topics.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ClassDetails extends StatelessWidget {
  final ClassDataStudent data;
  final String previoustile;
  const ClassDetails({Key? key, required this.previoustile, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final font = Provider.of<FontsForApp>(context);
    final color = Provider.of<ColorPicker>(context);
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
            const  Text("Student Enrolled"),
              font.headline1(data.studentenrollUid.length.toString(), color),
              const SizedBox(height: 5),
              Text(
                "Reviews",
                style:
                    CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.reviews.map((e) => Text(e)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
