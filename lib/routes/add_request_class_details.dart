import 'package:classroom/controllers/data.dart';
import 'package:flutter/cupertino.dart';

class AddClassDetails extends StatelessWidget {
  final ClassDataStudent data;
  final String previoustile;
  const AddClassDetails(
      {Key? key, required this.previoustile, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              previousPageTitle: previoustile,
              largeTitle: Text(data.topic),
              trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Join'),
                  onPressed: () {}),
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
              const Text("Student Enrolled "),
              const SizedBox(height: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.studentenrollUid.map((e) => Text(e)).toList(),
              ),
              Text(
                "Reviews",
                style:
                    CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
