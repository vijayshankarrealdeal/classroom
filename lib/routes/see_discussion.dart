import 'package:flutter/cupertino.dart';

class DiscussionText extends StatelessWidget {
  const DiscussionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              previousPageTitle: "Classes",
              largeTitle: const Text('Talk'),
              trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.video_camera),
                  onPressed: () {}),
            )
          ];
        },
        body: Center(),
      ),
    );
  }
}
